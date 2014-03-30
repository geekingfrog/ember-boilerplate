module.exports = (grunt) ->
  LIVERELOAD_PORT = 35729
  livereload = require('connect-livereload')({port: LIVERELOAD_PORT})
  mountFolder = (connect, dir) ->
    connect.static(require('path').resolve dir)

  grunt.initConfig
    bower:
      install:
        options:
          targetDir: 'bower_components'

    concat:
      dev:
        src: [
          'bower_components/jquery/dist/jquery.js',
          'bower_components/handlebars/handlebars.js',
          'bower_components/ember/ember.js'
        ]
        dest: 'build/assets/vendor.js'

      prod:
        src: [
          'bower_components/jquery/dist/jquery.min.js',
          'bower_components/handlebars/handlebars.min.js',
          'bower_components/ember/ember.min.js'
        ]
        dest: 'dist/assets/vendor.min.js'

    browserify:
      dev:
        files:
          'build/app/index.js': [ 'app/index.js', 'app/**/*.js' ]

      prod:
        files:
          'dist/app/index.js': [ 'app/**/*.js' ]

    emberTemplates:
      compile:
        options:
          templateBasePath: /app\/templates\//
        files:
          'app/templates.js': 'app/templates/**/*.hbs'

    watch:
      templates:
        files: ['app/templates/**/*.hbs']
        tasks: ['emberTemplates', 'browserify:dev']
        options: { livereload: true }

      gruntfile:
        files: ['Gruntfile.coffee']
        options: { reload: true }

      scripts:
        files: ['app/**/*.js', '!app/templates.js']
        tasks: ['browserify:dev']
        options: { livereload: true }

      jade:
        files: ['app/index.jade']
        tasks: ['jade:dev']
        options: { livereload: true }

    connect:
      options:
        port: 8000
        hostname: '0.0.0.0'
      livereload:
        options:
          middleware: (connect) ->
            [livereload, mountFolder(connect, './')]

    open:
      server:
        url: 'http://localhost:<%= connect.options.port %>/build/index.html'

    uglify:
      prod:
        files: {
          'dist/app/index.min.js': ['dist/app/index.js']
        }

    jade:
      dev:
        options:
          pretty: true
          data:
            title: 'ember boilerplate, development'
            scripts: [
              './assets/vendor.js',
              './app/index.js'
            ]
        files:
          'build/index.html': ['app/index.jade']

      prod:
        options:
          data:
            title: 'ember boilerplate, production'
            scripts: [
              './assets/vendor.min.js',
              './app/index.min.js'
            ]
        files:
          'dist/index.html': ['app/index.jade']


  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'server', [ 'connect', 'open', 'watch' ]

  grunt.registerTask 'build-dev', [
    'concat:dev',
    'emberTemplates',
    'browserify:dev'
    'jade:dev'
  ]

  grunt.registerTask 'prod', [
    'concat:prod',
    'emberTemplates',
    'browserify:prod',
    'uglify'
    'jade:prod'
  ]

  grunt.registerTask 'default', [
    'bower',
    'build-dev',
    'server'
  ]
  return
