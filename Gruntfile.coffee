module.exports = (grunt) ->
  grunt.initConfig
    bower:
      install:
        options:
          targetDir: 'dependencies'


  require('load-grunt-tasks')(grunt)

  grunt.registerTask 'default', ['bower']
  return
