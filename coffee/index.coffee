require [
  'jquery'
  'image!img/octocat-spinner-128.gif'
], ($) ->

  $('#github-is-slow').animate {
    opacity: 1
  }, 1000

  require [
    'oraculum'
    'cs!application/layout'
    'cs!application/routes'
    'oraculum/application/index'
  ], (Oraculum) ->
    'use strict'

    Oraculum.get 'Application',
      layout: 'Console.Layout'
      routes: Oraculum.get 'routes'
      pushState: false
      openExternalToBlank: true
