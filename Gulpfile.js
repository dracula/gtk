var gulp = require('gulp');
var sass = require('gulp-sass');
var exec = require('gulp-exec');

gulp.task('styles', function(done) {
    gulp.src('gtk-3.20/**/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('./gtk-3.20/'))
        .pipe(exec(' gsettings set org.gnome.desktop.interface gtk-theme "Dracula"'))
    done();
});
gulp.task('shell-style', function(done) {
    gulp.src('gnome-shell/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('./gnome-shell/'))
        .pipe(exec('gsettings set org.gnome.shell.extensions.user-theme name "Ant"'))
        .pipe(exec('gsettings set org.gnome.shell.extensions.user-theme name "Dracula"'))
    done();
});

//Watch task
gulp.task('default',function() {
    gulp.watch('gtk-3.20/**/*.scss', gulp.series('styles'));
});

gulp.task('shell',function() {
    gulp.watch('gnome-shell/*.scss', gulp.series('shell-style'));
});