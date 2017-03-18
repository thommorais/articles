var gulp   = require('gulp'),
    print  = require('gulp-print'),
    concat = require('gulp-concat'),
    babel  = require('gulp-babel')
    uglify = require('gulp-uglify')
    browserSync = require('browser-sync'),
    babelify = require('babelify');

  var paths = {
    dependencies: [

      'assets/javascripts/dependencies/domready.js',

      'assets/javascripts/functions/var.js',
      'assets/javascripts/dependencies/classie.js',


      'assets/javascripts/libs/lightgallery.js',
      // 'assets/javascripts/libs/lg-fullscreen.js',
      'assets/javascripts/libs/lg-thumbnail.js',
      'assets/javascripts/libs/lg-video.js',
      // 'assets/javascripts/libs/lg-autoplay.js',
      // 'assets/javascripts/libs/lg-zoom.js',
      'assets/javascripts/libs/lg-hash.js',
      'assets/javascripts/libs/lg-pager.js',
      'assets/javascripts/dependencies/jquery.mousewheel.min.js',

      'assets/javascripts/functions/dragFolder.js',
      'assets/javascripts/functions/newFolder.js',
      'assets/javascripts/functions/main.js'


    ],

  };

gulp.task('js', function(){
  gulp.src(paths.dependencies)
    .pipe(concat('new-v.js'))
    // .pipe(babel({presets: ['es2015']}))
    // .pipe(uglify())
    .pipe(gulp.dest('public/'))
})


gulp.task('server', function(){
  browserSync.init({

    server: {
      proxy: 'localhost/folha'
    }

  })

  gulp.watch(['public/*.css','public/*.js','*.html']).on('change', browserSync.reload)

})

gulp.task('default',['js','server'], function(){
  gulp.watch('assets/javascripts/**/*.js', ['js'])
})
