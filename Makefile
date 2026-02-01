 clean:
	@echo "* Removing Plasma theme..."
	rm -rf ~/.local/share/plasma/desktoptheme/Dracula
	rm -rf ~/.local/share/plasma/desktoptheme/Dracula-Solid
	rm -rf ~/.local/share/plasma/look-and-feel/Dracula

	@echo "\n* Removing Aurorae theme..."
	rm -rf ~/.local/share/aurorae/themes/Dracula

	@echo "\n* Removing color schemes..."
	rm -f ~/.local/share/color-schemes/Dracula.colors
	rm -f ~/.local/share/color-schemes/DraculaPurple.colors

	@echo "\n* Removing cursors..."
	rm -rf ~/.icons/Dracula-cursors

	@echo "\n* Removing SDDM theme (requires root)..."
	sudo rm -rf /usr/share/sddm/themes/Dracula

install:
ifeq ($(filter $(PLATFORM),kde KDE),)
	@echo "Exiting: only KDE is currently supported by the Makefile"
	@exit 1
endif
	@echo "* Making required paths (requires root)..."
	mkdir -p ~/.local/share/plasma/desktoptheme
	mkdir -p ~/.local/share/plasma/look-and-feel
	mkdir -p ~/.local/share/aurorae/themes
	mkdir -p ~/.local/share/color-schemes
	mkdir -p ~/.icons
	sudo mkdir -p /usr/share/sddm/themes

	@echo "\n* Installing Plasma theme..."
	cp -r kde/plasma/desktoptheme/* ~/.local/share/plasma/desktoptheme/
	cp -r kde/plasma/look-and-feel/* ~/.local/share/plasma/look-and-feel/

	@echo "\n* Installing Aurorae theme..."
	cp -r kde/aurorae/Dracula ~/.local/share/aurorae/themes/

	@echo "\n* Installing color schemes..."
	cp -r kde/color-schemes/* ~/.local/share/color-schemes/

	@echo "\n* Installing cursors..."
	cp -r kde/cursors/Dracula-cursors ~/.icons/

	@echo "\n* Installing SDDM theme (requires root)..."
	sudo cp -r kde/sddm/Dracula /usr/share/sddm/themes/

