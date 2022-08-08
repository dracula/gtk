.ONESHELL:
DE = ${XDG_CURRENT_DESKTOP}

gnome-40:
	# Switch over gnome-shell.css for GNOME 40+
	mv gnome-shell/gnome-shell.css gnome-shell/gnome-shell.css.old && \
	cp -f gnome-shell/v40/gnome-shell.css gnome-shell/gnome-shell.css
	# Set files and directories for libadwaita compatibility.
	cp -f gtk-4.0/gtk-dark.css ~/.config/gtk-4.0/gtk-dark.css
	cp -f gtk-4.0/gtk.css ~/.config/gtk-4.0/gtk.css
	cp -rf assets ~/.config/gtk-4.0/assets

prune :
	# Delete KDE folders, if not using KDE.
	if [ "${DE}" != "KDE" ]; then
		rm -rf kde
	fi
	# Delete XFCE folders, if not using XFCE.
	if [ "${DE}" != "XFCE" ]; then
		rm -rf xfwm4
	fi
	# Delete GNOME folders, if not using GNOME.
	if [ "${DE}" != "GNOME" ]; then
		rm -rf {cinnamon,gnome-shell,gtk-2.0,gtk-3.0,gtk-3.20,gtk-4.0,metacity-1,unity}
	fi
