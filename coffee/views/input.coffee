define [
  'oraculum'
  'oraculum/mixins/listener'
  'oraculum/mixins/disposable'
  'oraculum/mixins/evented-method'
  'oraculum/views/mixins/attach'
  'oraculum/views/mixins/dom-cache'
  'oraculum/views/mixins/auto-render'
  'oraculum/views/mixins/static-classes'
  'oraculum/views/mixins/html-templating'
  'oraculum/views/mixins/dom-property-binding'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'View', 'Input.View', {

    events:
      'blur input': '_focus'
      'keydown input': '_run'

    mixinOptions:
      staticClasses: ['input-view']
      eventedMethods:
        render: {}
      listen:
        'domcache this': '_update'
        'change:pwd model': '_updatePadding'
      template: '''
        <input class="pull-left" type="text" data-cache="input"/>
        <aside class="pull-left" data-cache="prompt">
          <span data-prop="model" data-prop-attr="pwd"/>
          &nbsp;&gt;
        </aside>
      '''

    _update: ->
      @_focus()
      @_updatePadding()

    _focus: ->
      @domcache.input.focus()

    _updatePadding: ->
      _.defer =>
        @domcache.input.css
          paddingLeft: @domcache.prompt.outerWidth true

    _run: (e) ->
      return @_ctrl arguments... if e.ctrlKey
      return unless e.keyCode is 13
      @model.run @domcache.input.val()
      @_clear()

    _ctrl: (e) ->
      switch e.keyCode
        when 'C'.charCodeAt(0) then @_clear()

    _clear: ->
      @domcache.input.val ''

  }, mixins: [
    'Listener.Mixin'
    'Disposable.Mixin'
    'EventedMethod.Mixin'
    'Attach.ViewMixin'
    'DOMCache.ViewMixin'
    'StaticClasses.ViewMixin'
    'HTMLTemplating.ViewMixin'
    'DOMPropertyBinding.ViewMixin'
    'AutoRender.ViewMixin'
  ]
