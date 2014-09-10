Evaluating Mapping Solutions - Simple Map D3
============================================

Moving on from the [previous post about Datamaps](#!markdown /posts/2014-09-05-Evaluating-Mapping-Solutions-Datamaps.md), my hunt continues for the right  mapping solution that will abstract the challenges of mapping and allow me to focus on integration. The target behavior is an interactive "rotating" mercator projection to be used as a "hitmap" for website hits.

In this post we're continuing our look at solutions based on d3 choropleths with [MinnPost](http://www.minnpost.com/)'s [simple-map-d3](https://github.com/MinnPost/simple-map-d3). What's interesting about this project is its association with MinnPost, a "nonprofit, nonpartisan" news organization who [clearly cares about data-driven journalism](http://www.minnpost.com/data). Simple-map-d3 is a dependency for another of their mapping projects, Tulip, which aims to bring map data visualization even further into the publics reach with a simple interface for binding data to regions.

Not to make the mistake of the last post, I'm going to jump straight into the project source.

Initial impressions
-------------------

It appears that this library expects your data to be embedded into the GeoJSON object to be rendered, and that most of the functionality it provides is based on that concept. This is a smart API design choice because it simplifies the logic needed to render/update the map while leaving responsibility to the user to generate that dataset using whatever tools they like. This is also true to the GeoJSON data specification. In that regard, MinnPost is not blazing new trails here, they're standing on the shoulders of giants. So let's hop into the real question: Can we interactively rotate our choropleth?

### Code diving observations

  * Starts as any good API should, with an exhaustive list of configuration options and their defaults.
  * As noted in the API docs, instances of `SimpleMapD3` emit important events via D3's event dispatcher.
  * Supports passing GeoJSON data in directly instead of requiring an ajax call. Awesome.
  * Looks like you need to load in an additional CSS file. :/
    * I suppose this is a reasonable alternative to appending css to the document head dynamically
    * For applications like this, I prefer to use inline styles, but that's a personal preference.

After reading the source, it appears that all I need to do to get my desired result is update the instance's rotate property, invoke projection() and then drawMap(). Easy peasy. Let's give it a shot...

```coffeescript
_renderMap: -> _.defer =>
  # Render a simple map using a test dataset
  @map = new SimpleMapD3
    colorOn: true
    legendOn: false
    container: @el
    tooltipOn: false
    datasource: '/bower_components/simple-map-d3/example-data/europe-population-density-geocommons.geo.json'
    projection: 'equirectangular'
    graticuleOn: true
    colorProperty: 'population'
  # wait a couple seconds, then try to update the projection's rotation
  setTimeout (=>
    @map.options.rotation = [0, 0, 180]
    @map.projection().drawMap()
  ), 2000
```

This yields an exception: `Uncaught TypeError: Cannot read property '0' of undefined d3.min.js:1t d3.min.js:1(anonymous function) coffee/views/hitmap.coffee:29`.

Debugging this error reveals that `@map.projection()` is no longer the same projection method defined on the prototype, it is instead now a d3 projection function. Diving deeper we can see that the `projection` method overwrites itself with a d3 projection at initialization:

```javascript
// Create projection
smd.projection = function() {
  var projFunc = smd.options.projection;

  if (typeof projFunc == 'undefined' ||
    typeof d3.geo[projFunc] != 'function') {
    projFunc = 'albersUsa';
  }

  smd.centroid = d3.geo.centroid(smd.data);
  smd.projection = d3.geo[projFunc]()
    .scale(1000)
    .translate([smd.width / 2, smd.height / 2]);

  // Center if available
  if (typeof smd.projection.center === 'function') {
    smd.projection.center(smd.centroid);
  }

  // Rotate if needed
  if (typeof smd.options.rotation != 'undefined' &&
    smd.options.rotation.length > 0 &&
    typeof smd.projection.rotate === 'function') {
    smd.projection.rotate(smd.options.rotation);
  }

  smd.projPath = d3.geo.path()
    .projection(smd.projection);

  return smd;
};
```

This shoudln't be too much of a problem - Let's overwrite `@map.projection` with our rotated version and try to redraw.

```coffeescript
_renderMap: -> _.defer =>
  @map = new SimpleMapD3
    colorOn: true
    legendOn: false
    container: @el
    tooltipOn: false
    datasource: '/bower_components/simple-map-d3/example-data/europe-population-density-geocommons.geo.json'
    projection: 'equirectangular'
    graticuleOn: true
    colorProperty: 'population'
  setTimeout (=>
    @map.projection = @map.projection.rotate [180, 180]
    @map.projPath = d3.geo.path().projection @map.projection
    @map.drawMap()
  ), 2000
```

This change fixes the exception, however the map does not appear to update. Debugging the issue reveals that the map does not update because due to the fact that the `drawMap` method is using a d3 join on `smd.data.features` using d3's `enter()` function, which has nothing new to render. The fact that the projection/path has changed is irrelevant because this visualization is data-driven. I wouldn't characterize this as a flaw, this is actually the correct way to handle dynamic data in d3 when combined with `exit()`. While, like with Datamaps, it is still possible to implement our rotation feature by wrangling the internals of the SimpleMapD3 instance, for now I'm going to move on and take a look at [d3-carto-map](https://github.com/emeeks/d3-carto-map).
