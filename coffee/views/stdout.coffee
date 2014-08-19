define [
  'oraculum'

  'cs!views/mdout'

  'oraculum/mixins/listener'
  'oraculum/mixins/disposable'
  'oraculum/views/mixins/list'
  'oraculum/views/mixins/auto-render'
  'oraculum/views/mixins/region-attach'
  'oraculum/views/mixins/static-classes'
  'oraculum/views/mixins/html-templating'
  'oraculum/views/mixins/remove-disposed'
  'oraculum/views/mixins/dom-property-binding'
  'oraculum/abstract/polymorphactory'
], (Oraculum) ->
  'use strict'

  Oraculum.extend 'PolymorPhactory', 'STDOUT.PolymorPhactory',
    getTypeString: ({model}) ->
      return 'MDOUT.View' if model.has 'markdown'
      return 'STDIN.Line' if model.has 'input'
      return 'STDOUT.Line'

  Oraculum.extend 'View', 'STDIN.Line', {
    tagName: 'article'

    mixinOptions:
      staticClasses: ['stdin-view']
      template: '''
        <aside class="pull-left">
          <small data-prop="model" data-prop-attr="_timestamp"/>
        </aside>
        <pre>&nbsp;&gt; <code data-prop="model" data-prop-attr="input"/></pre>
        <div class="clearfix"/>
      '''

  }, mixins: [
    'Disposable.Mixin'
    'StaticClasses.ViewMixin'
    'HTMLTemplating.ViewMixin'
    'DOMPropertyBinding.ViewMixin'
  ]

  Oraculum.extend 'View', 'STDOUT.Line', {
    tagName: 'article'

    mixinOptions:
      staticClasses: ['stdout-line']
      template: '<pre><code data-prop="model" data-prop-attr="stdout"/></pre>'

  }, mixins: [
    'Disposable.Mixin'
    'StaticClasses.ViewMixin'
    'HTMLTemplating.ViewMixin'
    'DOMPropertyBinding.ViewMixin'
  ]

  Oraculum.extend 'View', 'STDOUT.View', {
    tagName: 'section'

    mixinOptions:
      staticClasses: ['stdout-view']
      list:
        modelView: 'STDOUT.PolymorPhactory'
        viewOptions: ({model}) ->
          viewOptions = model.get 'viewOptions'
          return _.extend { model }, viewOptions

  }, mixins: [
    'Disposable.Mixin'
    'List.ViewMixin'
    'RegionAttach.ViewMixin'
    'StaticClasses.ViewMixin'
    'RemoveDisposed.ViewMixin'
    'AutoRender.ViewMixin'
  ]
