## [GTK](https://www.gtk.org/)

### Install manually

Download using the [GitHub .zip download](https://github.com/dracula/gtk/archive/master.zip) option and extract the `.zip` file to the themes directory i.e. `/usr/share/themes/` or `~/.themes/` (create it if necessary).

### Activating theme

To activate the theme in Gnome, run the following commands in Terminal:

```
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
```

or Change via distribution specific tweak tool.


## KDE

### Install manually
Pull the source code using git (or alternatively [Download the Latest ZIP File](https://github.com/dracula/gtk/archive/refs/heads/master.zip)):

```bash
git clone https://github.com/dracula/gtk.git
```

In a terminal, enter the directory containing the source code and run the `install` make target with the `PLATFORM` variable set to `KDE`:

```bash
cd gtk
make install PLATFORM=KDE
```

After installation is complete, open the appearance settings and choose the Dracula theme in the `Global Theme` section.

### Uninstall manually
To uninstall the manually installed KDE theme, pull the source code using git (or alternatively [Download the Latest ZIP File](https://github.com/dracula/gtk/archive/refs/heads/master.zip)):

```bash
git clone https://github.com/dracula/gtk.git
```

In a terminal, enter the directory containing the source code and run the `clean` make target

```bash
cd gtk
make clean
```

## Icon Theme (optional)

### Install manually

Download using the [GitHub .zip download](https://github.com/dracula/gtk/files/5214870/Dracula.zip) option and extract the `.zip` file to the icons directory i.e. `/usr/share/icons/` or `~/.icons/` (create it if necessary).

### Activating icon theme

To activate the theme in Gnome, run the following commands in Terminal: 

```
gsettings set org.gnome.desktop.interface icon-theme "Dracula"
```

or Change via distribution specific tweak tool.
