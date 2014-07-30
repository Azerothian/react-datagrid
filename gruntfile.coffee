module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    copy:
      build:
        files: [{
          expand: true
          cwd: "src"
          src: ['**', '!**/*.coffee']
          dest: "build"
        }]
    clean:
      build:
        [ 'build' ]
    coffee:
      lib:
        files: [
          expand: true
          cwd: "src/"
          src: ['**/*.coffee']
          dest: "build"
          ext: '.js'
          sourceMap: true
        ]
    watch:
      files: [
        "src/**/*"
      ]
      tasks: ['build']
    browserify:
      dist:
        files:
          'build/test/app.js': ['src/**/*.coffee']
        options:
          transform: ['coffeeify']
          browserifyOptions:
            debug: true
            extensions: [".js", ".coffee"]

  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'build', '', [ 'clean', 'coffee', 'copy', 'browserify'  ]
  grunt.registerTask 'default', '', [ 'build'  ]
