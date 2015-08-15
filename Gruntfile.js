module.exports = function(grunt) {

  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks);

  var config = {
    pkg: grunt.file.readJSON("package.json"),

    app: {
        src: "assets",
        dist: "public/dist"
    },

    clean: {
      build: {
        files: [{
          src: ["<%= app.dist %>/*", "assets.json"]
        }]
      }
    },

    concat: {
      lib: {
        files: {
          "<%= app.dist %>/js/lib.js": [
            "<%= app.src %>/js/lib/*.js",
            "<%= app.src %>/js/lib/plugins/**/*.js"
          ]
        },
        options: {
          separator: ";"
        }
      },

      core: {
        files: {
          "<%= app.dist %>/js/core.js": [
            "<%= app.src %>/js/core/*.js",
            "<%= app.src %>/js/core/models/**/*.js",
            "<%= app.src %>/js/core/views/**/*.js"
          ]
        }
      }
    },

    groundskeeper: {
      compile: {
        files: {
          "<%= app.dist %>/js/core.js": "<%= app.dist %>/js/core.js"
        }
      }
    },

    jshint: {
      options: {
        jshintrc: "./.jshintrc"
      },

      all: [
        "Gruntfile.js",
        "<%= app.dist %>/js/core.js"]
    },

    copy: {
      dist: {
        files: [{
          expand: true,
          dot: true,
          cwd: "<%= app.src %>",
          dest: "<%= app.dist %>",
          src: [
            "*.{ico,png,txt}",
            "images/{,*/}*.{webp,gif,jpeg,jpg,png,svg}",
            "fonts/{,*/}*.*"
          ]
        }]
      },

      css: {
        files: [{
          expand: true,
          dot: true,
          cwd: "<%= app.src %>",
          dest: "<%= app.dist %>",
          src: [
            "css/{,*/}*.css",
          ]
        }]
      }
    },

    jst: {
      compile: {
        files: {
          "<%= app.dist %>/js/templates.js": ["<%= app.src %>/js/core/templates/**/*.html"]
        }
      }
    },

    uglify: {
      options: {
        compress: {
          sequences: false
        }
      },

      core: {
        src: "<%= app.dist %>/js/core.js",
        dest: "<%= app.dist %>/js/core.js"
      },

      templates:{
        src: "<%= app.dist %>/js/templates.js",
        dest: "<%= app.dist %>/js/templates.js"
      }
    },

    sass: {
      dist: {
        options: {
         
        },
        files: {
          "<%= app.dist %>/css/screen.css": "<%= app.src %>/css/screen.scss"
        }
      }
    },

    watch: {
      js: {
        files: ["<%= app.src %>/js/core/**/*.js"],
        tasks: ["concat:core", "jshint"]
      },

      jsLib: {
        files: ["<%= app.src %>/js/lib/**/*.js"],
        tasks: ["concat:lib"]
      },

      sass: {
        files: "<%= app.src %>/css/**/*.scss",
        tasks: ["sass"]
      },

      cssReload: {
        files: "<%= app.dist %>/css/screen.css",
        tasks: [],
        options: {
          livereload: true
        }
      },

      css: {
        files: "<%= app.src %>/css/**/*.css",
        tasks: ["copy:css"],
        options: {
          livereload: true
        }
      },

      images: {
        files: "<%= app.src %>/images/{,*/}*.{webp,gif,jpeg,jpg,png,svg}",
        tasks: ["build:img"]
      },

      js_templates: {
        files: "<%= app.src %>/js/core/templates/**/*.html",
        tasks: ["jst:compile"]
      }
    },

    hash: {
      options: {
        mapping: "assets.json",
        flatten: false,
        srcBasePath: "public/dist",
        destBasePath: "public/dist",
        hashLength: 10
      },

      all: {
        src: ["<%= app.dist %>/**/*.*", "!**/*.*.*"]
      }
    },

    responsive_images: {
      options: {
        sizes: [{
            name: "small",
            width: 320,
            quality: 1
          },{
            name: "medium",
            width: 640,
            quality: 1
          },{
            name: "large",
            width: 1024,
            quality: 1
          }]
      },

      imgs: {
        files: [{
          expand: true,
          src: ["**/*.{jpg,jpeg,gif,png}"],
          cwd: "<%= app.src %>/images",
          dest: "<%= app.dist %>/images"
        }]
      }
    },

    imagemin: {
      dynamic: {
        options: {
          progressive: true,
          pngquant: true,
          optimizationLevel: 3
        },

        files: [{
          expand: true,
          src: ["**/*.{png,jpg,jpeg,gif}"],
          cwd: "<%= app.dist %>/images",
          dest: "<%= app.dist %>/images"
        }]
      }
    },

    // compress: {
    //   main: {
    //     options: {
    //       mode: "gzip"
    //     },

    //     expand: true,
    //     cwd: "build/",
    //     dest: "build/",
    //     src: ["**/*"]
    //   }
    // },

    svgmin: {
      dist: {
        files: [{
          expand: true,
          cwd: "<%= app.dist %>/images",
          src: "{,*/}*.svg",
          dest: "<%= app.dist %>/images"
        }]
      },
      fonts: {
        files: [{
          expand: true,
          cwd: "<%= app.dist %>/fonts",
          src: "{,*/}*.svg",
          dest: "<%= app.dist %>/fonts"
        }]
      }
    }
  };

  grunt.initConfig(config);

  grunt.registerTask("build", ["clean", "build:dev","jshint","uglify", "hash"]);

  grunt.registerTask("build:dev", ["copy", "sass","concat", "jst"]);
  grunt.registerTask("build:img", ["build", "responsive_images", "imagemin", "svgmin", "hash"]);
  grunt.registerTask("default", ["build:dev", "watch"]);
};
