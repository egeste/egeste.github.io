require [
  'jquery'
  'image!img/octocat-spinner-128.gif'
], ($) ->

  $('''<div id="github-is-slow">
    <div class="wrapper">
      <img src="img/octocat-spinner-128.gif">
    </div>
  </div>''').appendTo(document.body).animate({opacity: 1}, 1000)

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
      scrollTo: false
      pushState: false
      openExternalToBlank: true
