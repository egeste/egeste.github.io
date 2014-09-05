require [
  'jquery'
  'image!img/octocat-spinner-128.gif'
], ($) ->

  githubIsSlow = $('''<div id="github-is-slow">
    <div class="wrapper">
      <img src="img/octocat-spinner-128.gif">
    </div>
  </div>''')
  githubIsSlow.appendTo document.body
  githubIsSlow.animate {opacity: 1}, 1000

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
