for i in assets/*;

	set -l file_name (basename $i .svg)
	convert $i ./$file_name'.xpm'
;end
