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

  SimpleMapD3 = Oraculum.get 'SimpleMapD3'

  Oraculum.extend 'View', 'Hitmap.View', {

    mixinOptions:
      staticClasses: ['hitmap-view']
      listen:
        'addedToParent this': '_renderMap'

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
      # setTimeout (=>
      #   @map.projection = @map.projection.rotate [180, 180]
      #   @map.projPath = d3.geo.path().projection @map.projection
      #   @map.drawMap()
      # ), 2000

  }, mixins: [
    'Listener.Mixin'
    'Disposable.Mixin'
    'Attach.ViewMixin'
    'StaticClasses.ViewMixin'
    'AutoRender.ViewMixin'
  ]
