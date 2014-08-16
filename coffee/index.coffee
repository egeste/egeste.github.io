require [
  'jquery'
  'image!images/octocat-spinner-128.gif'
], ($) ->

  spinner = $ '''
    <div id="github-is-slow">
      <img src="images/octocat-spinner-128.gif">
    </div>
  '''
  spinner.css {opacity: 0}
  spinner.appendTo '#main_content'
  spinner.animate {opacity: 1}, 1000

require [
  'oraculum'
  'cs!application/layout'
  'cs!application/routes'
  'oraculum/application/index'
], (Oraculum) ->
  'use strict'

  Oraculum.get 'Application',
    layout: 'Blog.Layout'
    routes: Oraculum.get 'routes'
