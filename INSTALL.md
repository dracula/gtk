## [GTK](https://www.gtk.org/)

### Install manually

1.- Two options for download:
 - Download using the [GitHub .zip download](https://github.com/dracula/gtk/archive/master.zip) (Once extracted it must be renamed from `gtk-master` to `Dracula`)
 - Download from [gnome-look](https://www.gnome-look.org/p/1687249/) - You can check the other theme variants there
 
2.- Extract the `.zip` file to the themes directory i.e. `/usr/share/themes/` or `~/.themes/` (create it if necessary).

### Activating theme

To activate the theme in Gnome, run the following commands in Terminal:

```
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
```

or Change via distribution specific tweak-tool.

**For the latest versions of Gnome using Gtk4(libadwaita) some extra steps should be done in order to get it working properly, you could do it in two ways:**

1.- Manual way
  - Copy the `assets` folder to the `~/.config` directory
  - Copy the `gtk-4.0/gtk.css` and `gtk-4.0/gtk-dark.css` files to `~/.config/gtk-4.0/`

2.- Using [this script](https://github.com/odziom91/libadwaita-theme-changer) which will copy the needed folders to the right directories


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
