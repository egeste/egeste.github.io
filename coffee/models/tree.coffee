define [
  'oraculum'
  'json!config'
  'cs!models/mixins/jsonp'
  'oraculum/models/mixins/sync-machine'
], (Oraculum, config) ->
  'use strict'

  Oraculum.extend 'Collection', 'Tree.Collection', {
    url: "#{config.api}/#{config.repo}/git/trees/master?recursive=1"

    parse: (response) ->
      return response.data.tree

  }, {
    singleton: true
    mixins: [
      'JSONP.ModelMixin'
      'SyncMachine.ModelMixin'
    ]
  }
