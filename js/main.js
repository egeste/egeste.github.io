require.config({
  baseUrl: 'coffee',

  paths: {
    // Config
    config: '../config.json',

    // Plugins
    cs: '../bower_components/require-cs/cs',
    text: '../bower_components/requirejs-text/text',
    json: '../bower_components/requirejs-plugins/src/json',
    image: '../bower_components/requirejs-plugins/src/image',

    // Plugin deps
    'coffee-script': '../bower_components/coffeescript/extras/coffee-script',

    // Oraculum deps
    jquery: '../bower_components/jquery/dist/jquery.min',
    backbone: '../bower_components/backbone/backbone',
    underscore: '../bower_components/underscore/underscore',
    Factory: '../bower_components/factoryjs/dist/Factory.min',
    BackboneFactory: '../bower_components/factoryjs/dist/BackboneFactory.min',

    // d3/maps
    d3: '../bower_components/d3/d3.min',
    topojson: '../bower_components/topojson/topojson',
    'simple-map-d3': '../bower_components/simple-map-d3/dist/simple-map-d3.src',

    // Markdown/hljs
    marked: '../bower_components/marked/lib/marked',
    highlight: '../bower_components/highlightjs/highlight.pack',

    // DISQUS
    disqus: 'https://egeste-net.disqus.com/embed.js'
  },

  shim: {
    highlight: { exports: 'hljs' },

    jquery: { exports: 'jQuery' },
    underscore: { exports: '_' },
    backbone: {
      deps: ['underscore', 'jquery'],
      exports: 'Backbone'
    },

    d3: { exports: 'd3' },
    topojson: {
      deps: ['d3'],
      exports: 'topojson'
    },
    'simple-map-d3': {
      deps: ['d3', 'topojson'],
      exports: 'SimpleMapD3'
    },

    disqus: {
      deps: ['cs!disqus_vars'],
      exports: 'DISQUS'
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
