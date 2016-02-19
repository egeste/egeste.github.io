---
title:  "Evaluating Mapping Solutions - Datamaps"
date:   2014-09-05 00:00:00
categories: [programming]
tags: [oraculum, factoryjs, javascript, maps]
---

One of the more difficult tasks in data visualization is dealing with maps. Not having the mathematical background in calculus and trigonometry can make this task seem almost impossible, and while there are are tons of fantastic libraries that make it easier, doing anything custom requires some serious brain strain.

In this post I will be looking at [Datamaps](http://datamaps.github.io/), a choropleth rendering utility based on the beautiful d3 library. The goal is to create a "hitmap" to display the current user's inferred location as well as update to show the location of new visitors in real time. I have not yet found an analytics API suitable for this task, but first thing's first - we need a map.

Getting things off the ground
-----------------------------

First, let's load all our libs into the Oraculum container to make them easily accessible in the same fashion we do in Oraculum-core:

```coffeescript
define [
  'oraculum'

  'd3'
  'topojson'
  'datamaps'
  'cs!plugins/datamaps-rotate'

  'marked'
  'highlight'

  # 'disqus'
], (Oraculum, d3, topojson, Datamap, rotatePlugin, marked, hljs, disqus) ->
  'use strict'

  Oraculum.define 'd3', (-> d3), singleton: true
  Oraculum.define 'topojson', (-> topojson), singleton: true

  Oraculum.define 'Datamap', (-> Datamap), singleton: true
  Oraculum.define 'rotatePlugin', (-> rotatePlugin), singleton: true

  marked.setOptions highlight: (code) -> hljs.highlightAuto(code).value
  Oraculum.define 'marked', (-> marked), singleton: true

  Oraculum.define 'disqus', (-> disqus), singleton: true
```

To render the map, we'll create `HitmapComposer.ControllerMixin` to compose `Hitmap.View` after the `beforeAction` of our `Index.Controller`, as can be seen here:

```coffeescript
define [
  'oraculum'
  'oraculum/libs'

  'cs!views/session'
  'cs!models/session'

  'cs!controllers/mixins/disqus-composer'
  'cs!controllers/mixins/hitmap-composer'
  'cs!controllers/mixins/background-composer'

  'oraculum/mixins/evented'
  'oraculum/application/controller'
], (disqus, Oraculum) ->
  'use strict'

  $ = Oraculum.get 'jQuery'

  Oraculum.extend 'Controller', 'Index.Controller', {

    constructed: ->
      @session = @__factory().get 'Session.Model'
      @listenTo @session.get('stdout'), 'add', (model) =>
        return unless input = model.get 'input'
        @redirectTo 'Index.Controller#execute', {
          input: encodeURIComponent input
        }, redirected: true

    beforeAction: ->
      tree = @session.get 'tree'
      unless tree.isSynced()
        return tree.fetch().then ->
          $('#github-is-slow').remove()

    hashbang: ({input}) ->
      @redirectTo 'Index.Controller#execute', {input}

    execute: ({input}, route, {redirected}) ->
      console.log arguments

      @reuse 'session', 'Session.View',
        model: @session
        container: '#session'
        className: 'panel black full-height'
        collection: @session.get 'stdout'

      if input
        @session.run decodeURIComponent input unless redirected
      else
        @session.run 'markdown /posts/welcome.md' unless redirected

  }, {
    inheritMixins: true
    mixins: [
      'Evented.Mixin'
      'DisqusComposer.ControllerMixin'
      'HitmapComposer.ControllerMixin'
      'BackgroundComposer.ControllerMixin'
    ]
  }
```

And finally, we'll create the actual `Hitmap.View` implementation as seen here:

```coffeescript
define [
  'oraculum'
  'cs!libs'

  'oraculum/mixins/listener'
  'oraculum/mixins/disposable'
  'oraculum/views/mixins/attach'
  'oraculum/views/mixins/auto-render'
  'oraculum/views/mixins/static-classes'
], (Oraculum) ->
  'use strict'

  Datamap = Oraculum.get 'Datamap'
  rotate = Oraculum.get 'rotatePlugin'

  Oraculum.extend 'View', 'Hitmap.View', {

    mixinOptions:
      staticClasses: ['hitmap-view']
      listen:
        'addedToParent this': '_renderDatamaps'

    _renderDatamaps: -> _.defer =>
      @map = new Datamap
        width: @$el.innerWidth()
        height: @$el.innerHeight()
        element: @el
        geographyConfig:
          popupOnHover: false
        setProjection: (element) ->
          projection = d3.geo.mercator()
            .rotate([0, 0])
            .precision(.5)
            .translate([element.offsetWidth / 2, element.offsetHeight / 1.45])
            .scale((element.offsetWidth + 1) / 2 / Math.PI)
          path = d3.geo.path().projection(projection)
          return {path, projection}

  }, mixins: [
    'Listener.Mixin'
    'Disposable.Mixin'
    'Attach.ViewMixin'
    'StaticClasses.ViewMixin'
    'AutoRender.ViewMixin'
  ]
```

Initial impressions
-------------------

So far I really like how dead simple it is to get a map off the ground. When building a choropleth in d3, there's a lot to do before you even write a single line of code (getting data from [Natural Earth](http://www.naturalearthdata.com/), compiling it into GeoJSON, converting GeoJSON to TopoJSON... etc). If you'd like to read about what it takes to get a simple map with d3 alone, checkout Mike Bostock's fantastic blog aptly titled [Let's Make a Map](http://bost.ocks.org/mike/map/). The fact that Datamaps provides a simple constructor with a ton of baked-in configuration options makes life super easy for those of us who aren't professional cartogrophers. For now, it's fun to play with some of the configuration settings and tweak the basic example provided for `setProjection`, but ultimately I need to be able to rotate my projection based on some geospatial data. [Luckily, Datamaps provides an interface for injecting behaviors via the `addPlugin` method.](http://datamaps.markmarkoh.com/creating-a-datamaps-plugin/). With that in mind, let's see if we can implement a plugin that allows dynamic projection rotation [like in this example](http://www.jasondavies.com/maps/rotate/).

Creating a plugin
-----------------

Interestingly, Datamaps plugins aren't registered on the global Datamaps object. They're actually defined and initialized directly on an instance of Datamaps. My initial reaction to this is that it's a strange design choice, but I'll reserve judgement until after I've actually used it.

I really like that as soon as you add a plugin to your map, you're automically given a new layer to render on as a function argument. In the case of our plugin, I think I'll use this layer as a surface for receiving mouse events on the map. It is interesting to note that the plugin API is actually the instance scope, exposing the map, svg, path, projection, options and a helper method `latLngToXY` in the plugin context. This leads me to think that I should examine the source of Datamaps to see what other internals I may have access to within the plugin context (for example, a render method for redrawing my projection after modifying it).

### Code diving observations

  * `Datamap.prototype.draw` looks useful
  * `Datamap.prototype.latLngToXY`... Looks like I have access to the entire instance from a plugin scope! :D
  * `Datamap.prototype.updateChoropleth` looks useful.
  * `Datamap.prototype.worldTopo` is the baked in world topography.
    * `objects.world` polygon namespace
    * Appears to use [ISO 3166-1 a3](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) as country IDs
      * Would be problematic for datasets that use ISO 3166-1 a2/numeric
      * We (Lookout) should open source our NaturalEarth TopoJSON scripts.
    * Contains `properties.name` for country name (English only)
  * Grepping for `this.options` reveals several undocumented configuration options.

After diving into the rendering strategy used by Datamaps, I don't feel like it's the right solution for what I'm trying to achieve. The `drawSubunits` method does not expose much control over how the choropleth is rendered, and the `setProjection` configurable method does not expose an interface that lends itself well to dynamic projection values (eg, changing the rotate values). Datamaps is well suited to get a map off the ground quickly, and is "extensible" in the sense that it provides an interface for creating new layers, but is not a good solution if you want to modify the behavior of the underlying geography rendering mechanisms.

Thus concludes my evaluation of Datamaps. Think I was too harsh? Incorrect? Tell me in the comments below.
