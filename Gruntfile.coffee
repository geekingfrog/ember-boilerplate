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

    browserify:
      dev:
        files:
          'build/app/index.js': [ 'app/**/*.js' ]

    emberTemplates:
      compile:
        options:
          templateBasePath: /app\/templates\//
        files:
          'app/templates.js': 'app/templates/**/*.hbs'

    clean: ['app/templates.js']

    watch:
      templates:
        files: ['app/templates/**/*.hbs']
        tasks: ['emberTemplates', 'browserify']

      gruntfile:
        files: ['Gruntfile.coffee']
        options: { reload: true }

      scripts:
        files: ['app/**/*.js'] #, '!app/templates.js']
        tasks: ['browserify']
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
        url: 'http://localhost:<%= connect.options.port %>'

  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'server', [ 'connect', 'open', 'watch' ]

  grunt.registerTask 'default', [
    'bower',
    'concat',
    'emberTemplates',
    'browserify',
    'clean',
    'server'
  ]
  return
