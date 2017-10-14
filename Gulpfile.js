var gulp = require('gulp');
var sass = require('gulp-sass');
var exec = require('gulp-exec');

gulp.task('styles', function() {
    gulp.src('gtk-3.20/**/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('./gtk-3.20/'))
        .pipe(exec(' gsettings set org.gnome.desktop.interface gtk-theme "Dracula"'))
});
gulp.task('shell-style', function() {
    gulp.src('gnome-shell/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('./gnome-shell/'))
        .pipe(exec('gsettings set org.gnome.shell.extensions.user-theme name "Ant"'))
        .pipe(exec('gsettings set org.gnome.shell.extensions.user-theme name "Dracula"'))
});

//Watch task
gulp.task('default',function() {
    gulp.watch('gtk-3.20/**/*.scss',['styles']);
});

gulp.task('shell',function() {
    gulp.watch('gnome-shell/*.scss',['shell-style']);
});