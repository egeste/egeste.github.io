define [
  'oraculum'

  'd3'
  'topojson'
  'datamaps'

  'disqus'
  'marked'
], (Oraculum, d3, topojson, Datamap, disqus, marked) ->
  'use strict'

  Oraculum.define 'd3', (-> d3), singleton: true
  Oraculum.define 'topojson', (-> topojson), singleton: true
  Oraculum.define 'Datamap', (-> Datamap), singleton: true

  Oraculum.define 'marked', (-> marked), singleton: true
  Oraculum.define 'disqus', (-> disqus), singleton: true
