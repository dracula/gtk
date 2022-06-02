var gulp = require('gulp');
var sass = require('gulp-sass')(require('sass'));
var exec = require('gulp-exec');

gulp.task('styles-gtk3', function(done) {
    gulp.src('gtk-3.20/**/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('./gtk-3.20/'))
        .pipe(exec(' gsettings set org.gnome.desktop.interface gtk-theme "Dracula"'))
    done();
});
gulp.task('styles-gtk4', function(done) {
    gulp.src('gtk-4.0/**/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('./gtk-4.0/'))
        .pipe(exec(' gsettings set org.gnome.desktop.interface gtk-theme "Dracula"'))
    done();
});
gulp.task('shell-style', function(done) {
    gulp.src('gnome-shell/**/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('./gnome-shell/'))
        .pipe(exec('gsettings set org.gnome.shell.extensions.user-theme name "Ant"'))
        .pipe(exec('gsettings set org.gnome.shell.extensions.user-theme name "Dracula"'))
    done();
});
gulp.task('cinnamon-style', function(done) {
    gulp.src('cinnamon/**/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('./cinnamon/'))
        .pipe(exec(' gsettings set org.cinnamon.desktop.interface gtk-theme "Dracula"'))
        .pipe(exec(' gsettings set org.cinnamon.desktop.wm.preferences theme "Dracula"'))
        .pipe(exec(' gsettings set org.cinnamon.theme name "Dracula"'))
    done();
});

//Watch tasks
gulp.task('default',function() {
    gulp.watch(['gtk-4.0/**/*.scss', 'gtk-3.20/**/*.scss'], gulp.series(gulp.parallel('styles-gtk4', 'styles-gtk3')));
});

gulp.task('shell',function() {
    gulp.watch('gnome-shell/**/*.scss', gulp.series('shell-style'));
});

gulp.task('cinnamon',function() {
    gulp.watch('cinnamon/**/*.scss', gulp.series('cinnamon-style'));
});