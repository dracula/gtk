### [GTK](https://www.gtk.org/)

#### Install manually

Download using the [GitHub .zip download](https://github.com/dracula/gtk/archive/master.zip) option and extract the `.zip` file to the themes directory i.e. `/usr/share/themes/` or `~/.themes/` (create it if necessary). Some apps require to have the theme in `/usr/share/themes`, if your app isn't changing colors from `~/.themes/`, try moving to `/usr/share/themes`.

#### Activating theme

To activate the theme in Gnome, run the following commands in Terminal:

```
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
```

or Change via distribution specific tweak tool.

## Icon Theme (optional)

#### Install manually

Download using the [GitHub .zip download](https://github.com/dracula/gtk/files/5214870/Dracula.zip) option and extract the `.zip` file to the icons directory i.e. `/usr/share/icons/` or `~/.icons/` (create it if necessary).

#### Activating icon theme

To activate the theme in Gnome, run the following commands in Terminal: 

```
gsettings set org.gnome.desktop.interface icon-theme "Dracula"
```

or Change via distribution specific tweak tool.

## System context

The Calendar, Notifications, Right-click menu and some other context require the installation of `User Themes` extension https://extensions.gnome.org/extension/19/user-themes/  

