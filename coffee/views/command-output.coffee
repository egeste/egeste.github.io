define [
  'oraculum'
  'oraculum/abstract/polymorphactory'
  'cs!views/output/files'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'PolymorPhactory', 'STDOut.PolymorPhactory',
    getTypeString: ({model, collection}) ->
      return 'Files.View' if 'ls' is model.get 'cmd'
