define [
  'oraculum'

  'd3'
  'topojson'
  'simple-map-d3'

  'marked'
  'highlight'

  'disqus'
], (Oraculum, d3, topojson, SimpleMapD3, marked, hljs, disqus) ->
  'use strict'

  Oraculum.define 'd3', (-> d3), singleton: true
  Oraculum.define 'topojson', (-> topojson), singleton: true
  Oraculum.define 'SimpleMapD3', (-> SimpleMapD3), singleton: true

  marked.setOptions highlight: (code) -> hljs.highlightAuto(code).value
  Oraculum.define 'marked', (-> marked), singleton: true

  Oraculum.define 'disqus', (-> disqus), singleton: true
