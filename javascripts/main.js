require.config({
  baseUrl: 'coffee',
  paths: {
    // Plugins
    cs: '../bower_components/require-cs/cs',
    text: '../bower_components/requirejs-text/text',
    image: '../bower_components/requirejs-plugins/src/image',

    // Plugin deps
    'coffee-script': '../bower_components/coffeescript/extras/coffee-script',

    // Oraculum deps
    jquery: '../bower_components/jquery/dist/jquery',
    backbone: '../bower_components/backbone/backbone',
    underscore: '../bower_components/underscore/underscore',
    Factory: '../bower_components/factoryjs/dist/Factory',
    BackboneFactory: '../bower_components/factoryjs/dist/BackboneFactory'
  },
  shim: {
    jquery: { exports: 'jQuery' },
    underscore: { exports: '_' },
    backbone: {
      deps: ['underscore', 'jquery'],
      exports: 'Backbone'
    }
  },
  packages: [{
    name: 'oraculum',
    location: '../bower_components/oraculum/dist'
  }],
  callback: function () {
    require(['cs!index']);
  }
});
