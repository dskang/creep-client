module.exports = (grunt) ->
  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  appConfig =
    app: "app"
    dist: "dist"

  grunt.initConfig
    creep: appConfig

    watch:
      coffee:
        files: ["<%= creep.app %>/{,*/}*.coffee"]
        tasks: ["coffee"]
      copy:
        files: ["<%= creep.app %>/manifest.json"]
        tasks: ["copy"]

    clean:
      dist:
        files: [
          dot: true
          src: [
            "<%= creep.dist %>/*"
          ]
        ]

    coffee:
      dist:
        files: [
          expand: true
          cwd: "<%= creep.app %>"
          src: "{,*/}*.coffee"
          dest: "<%= creep.dist %>"
          ext: ".js"
        ]

    copy:
      dist:
        files: [
          expand: true
          cwd: "<%= creep.app %>"
          dest: "<%= creep.dist %>"
          src: [
            "manifest.json"
          ]
        ]

  grunt.registerTask "default", [
    "clean"
    "coffee"
    "copy"
  ]
