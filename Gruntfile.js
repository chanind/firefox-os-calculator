module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    coffee: {
      main: {
        expand: true,
        cwd: "dist/scripts",
        src: ["**.coffee"],
        dest: "dist/scripts",
        ext: ".js"
      }
    },

    copy: {
      main: {
        cwd: 'src/',
        src: '**',
        dest: 'dist/',
        expand: true
      },
      angular: {
        src: 'bower_components/angular/angular.min.js',
        dest: 'dist/vendor/angular.min.js'
      }
    },

    stylus: {
      main: {
        files: {
          'dist/styles/app.css': 'dist/styles/**.styl'
        }
      }
    },

    clean: {
      pre: ['dist'],
      post: ['dist/scripts/**.coffee', 'dist/styles/**.styl']
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-stylus');

  grunt.registerTask('default', ['clean:pre', 'copy:main', 'copy:angular', 'coffee:main', 'stylus:main', 'clean:post']);
};