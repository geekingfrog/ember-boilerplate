module.exports = (grunt) ->
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
          'app/templates.js': 'app/templates/*.hbs'




  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'default', [
    'bower',
    'concat',
    'emberTemplates',
    'browserify'
  ]
  return
