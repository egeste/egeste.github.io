require [
  'jquery'
  'image!img/octocat-spinner-128.gif'
], ($) ->

  spinner = $ '''
    <div id="github-is-slow">
      <img src="img/octocat-spinner-128.gif">
    </div>
  '''
  spinner.css {opacity: 0}
  spinner.appendTo document.body
  spinner.animate {opacity: 1}, 1000

  require [
    'oraculum'
    'cs!application/layout'
    'cs!application/routes'
    'oraculum/application/index'
  ], (Oraculum) ->
    'use strict'

    spinner.remove()
    Oraculum.get 'Application',
      layout: 'Console.Layout'
      routes: Oraculum.get 'routes'
