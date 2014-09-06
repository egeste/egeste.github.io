define [
  'oraculum'

  'd3'
  'topojson'
  'datamaps'

  'marked'
  'highlight'

  # 'disqus'
], (Oraculum, d3, topojson, Datamap, marked, hljs, disqus) ->
  'use strict'

  Oraculum.define 'd3', (-> d3), singleton: true
  Oraculum.define 'topojson', (-> topojson), singleton: true
  Oraculum.define 'Datamap', (-> Datamap), singleton: true

  marked.setOptions highlight: (code) -> hljs.highlightAuto(code).value
  Oraculum.define 'marked', (-> marked), singleton: true

  Oraculum.define 'disqus', (-> disqus), singleton: true
