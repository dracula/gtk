for i in assets/*;

	set -l file_name (basename $i .svg)
	convert -background none $i ./$file_name'.xpm'
;end
