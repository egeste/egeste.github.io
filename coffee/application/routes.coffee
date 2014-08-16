define [
  'oraculum'
  'cs!controllers/index'
], (Oraculum) ->
  'use strict'

  Oraculum.define 'routes', -> (match) ->
    match '*url', 'Index.Controller#index'
