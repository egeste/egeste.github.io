define [
  'd3'
  'oraculum'
  'oraculum/libs'
  'oraculum/mixins/listener'
  'oraculum/mixins/disposable'
  'oraculum/views/mixins/auto-render'
  'oraculum/views/mixins/region-attach'
  'oraculum/views/mixins/static-classes'
  'oraculum/views/mixins/remove-disposed'
], (d3, Oraculum) ->
  'use strict'

  _ = Oraculum.get 'underscore'

  Oraculum.extend 'View', 'Background.View', {

    mixinOptions:
      staticClasses: ['background-view']
      listen:
        'renderComplete this': 'animate'

    render: ->
      paths = @collection.pluck 'path'
      image = _.chain(paths).filter((path) ->
        return /^img\/backgrounds\/.+\.svg$/i.test path
      ).sample().value()
      require ["text!../#{image}"], (svg) =>
        @$el.html svg
        @trigger 'renderComplete'
      return this

    animate: ->
      # @traceLines()
      # @pulseColors()

    pulseColors: ->
      colors = ['#f00', '#0f0', '#00f', '#ff0', '#0ff', '#fff', '#000']
      paths = d3.select(@el).selectAll('path')
      repeat = ->
        paths.transition().duration(2000).ease('linear')
          .attr('fill', -> _.sample colors)
          .each('end', repeat)
      repeat()

    traceLines: ->
      paths = d3.select(@el).selectAll('path')
      paths.attr 'stroke', 'black'
      paths.attr 'stroke-dasharray', ->
        path = d3.select(this)
        length = path.node().getTotalLength()
        return "#{length} #{length}"
      paths.each ->
        path = d3.select(this)
        length = path.node().getTotalLength()
        repeat = ->
          path.attr("stroke-dashoffset", length)
            .transition()
            .duration(2000)
            .ease('linear')
            .attr('stroke-dashoffset', -length)
            .each('end', repeat)
        repeat()

  }, mixins: [
    'Listener.Mixin'
    'Disposable.Mixin'
    'RegionAttach.ViewMixin'
    'StaticClasses.ViewMixin'
    'RemoveDisposed.ViewMixin'
    'AutoRender.ViewMixin'
  ]
