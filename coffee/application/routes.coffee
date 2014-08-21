define [
  'oraculum'
  'cs!controllers/index'
], (Oraculum) ->
  'use strict'

  Oraculum.define 'routes', -> (match) ->
    match '!*input', 'Index.Controller#execute'
    match '*input', 'Index.Controller#hashbang'
