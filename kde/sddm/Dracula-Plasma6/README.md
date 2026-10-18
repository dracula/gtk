# Dracula SDDM for Plasma 6

This variant is based on Eliver Lara's [Dracula SDDM Plasma 6 release on KDE Store](https://store.kde.org/p/2150918).
The existing `../Dracula` directory is the Plasma 5 variant.

## Source and license

Imported from `Dracula-Plasma6.tar.xz`, retrieved on 2026-10-16 from
[KDE Store's OCS metadata](https://api.kde-look.org/ocs/v1/content/data/2150918).
The archive's SHA-256 is:

```text
21a951d39959e95215d6ac04c8bb94264fb082a533fa04f6116eb436b2f881e1
```

The archive reports version 0.1 in `metadata.desktop`. Its published MD5 is
`73f22dd78d9f21e8237afe5659e3b07d`. The first import commit preserves the shipped files byte for byte. The
compatibility changes in this directory are described below. The bundled `faces/.face.icon` is omitted; SDDM supplies
user avatars. No `theme.conf.user`, local images, or caches are included.

Author credits, file-level KDE copyright/license notices, artwork, defaults,
and the `Dracula-Plasma6` theme identifier are preserved. The theme metadata
specifies GPL-3.0-or-later; individual components retain their own license
notices. See also the repository's [GPL license](../../../LICENSE).


## Plasma 6.8 compatibility

KDE [removed `VirtualKeyboardLoader` from Breeze](https://github.com/KDE/plasma-workspace/commit/f1c83d153768faf16a35993465957f3902534e3e).
The theme now owns `components/KeyboardController.qml`:

- On Wayland, availability and visibility come from `KWinVirtualKeyboard`.
  Showing the keyboard focuses the current form's password field before
  calling `forceActivate()`; older APIs fall back to `active = true`.
  Hiding sets `active = false`.
- On X11, a Loader loads the existing Qt Virtual Keyboard component only on
  that platform. An unavailable QML module leaves the login screen usable
  and hides the keyboard button. The form moves above the keyboard while
  it is visible and returns to its original position when it is hidden.
- Keyboard visibility also controls the action buttons and inactivity timer.
  Both the user-list and alternate-user forms use the same controller. The
  keyboard button preserves mouse focus so a click can hide the keyboard
  without first closing it through focus loss and then reopening it.

The affected spacing/duration references now use `Kirigami.Units`. The clock's
software-rendering outline uses `Kirigami.Theme`, and the keyboard-layout label
handles an empty layout list (as reported by the Wayland test greeter).
The Breeze import remains necessary for the existing avatar shader.

## Dependencies

Use the **Qt 6** build of SDDM's greeter, together with the Plasma 6 QML modules:

- Qt Quick, Quick Controls, Quick Layouts, and `Qt5Compat.GraphicalEffects`.
- Kirigami, Plasma Components 3, Plasma Workspace Components, Plasma5Support
  (the keystate, time, and power-management data engines), and Breeze Components.
- `org.kde.plasma.workspace.keyboardlayout` for the KWin virtual-keyboard API.
- Cantarell is the default font; another font can be set in `theme.conf.user`.

On Arch-based systems these modules are supplied by packages including
`qt6-declarative`, `qt6-5compat`, `kirigami`, `libplasma`, `plasma-workspace`,
`plasma5support`, and `sddm`. Distribution package names may differ.

Virtual keyboards are optional:

- **Wayland greeter:** KWin must have an input method such as Plasma Keyboard
  or Maliit installed and configured for the **greeter's compositor**. A
  keyboard configured only for the logged-in desktop does not configure SDDM.
  With no backend, the keyboard button stays hidden.
- **X11 greeter:** install the Qt 6 Virtual Keyboard QML module (for example,
  `qt6-virtualkeyboard`) and configure SDDM's `[General] InputMethod=qtvirtualkeyboard`.
  For a preview, set `QT_IM_MODULE=qtvirtualkeyboard` before starting the greeter.

This theme does not install or start an input-method service.

## Installation and rollback

From the repository root, back up an existing installation before copying:

```sh
theme_dir=/usr/share/sddm/themes/Dracula-Plasma6
backup_dir=/var/backups/sddm/Dracula-Plasma6-$(date +%Y%m%d-%H%M%S)
if [ -d "$theme_dir" ]; then
    sudo mkdir -p /var/backups/sddm
    sudo cp -a "$theme_dir" "$backup_dir"
fi
sudo mkdir -p "$theme_dir"
sudo cp -a kde/sddm/Dracula-Plasma6/. "$theme_dir/"
```

Record `backup_dir` for rollback. This copy preserves an existing
`theme.conf.user` because the distribution contains no such file. The theme
identifier and all existing configuration keys are unchanged. Keep local
wallpaper/font/color settings in `theme.conf.user`.

Select **Dracula-Plasma6** in System Settings → Login Screen (SDDM), or use
`Current=Dracula-Plasma6` in the `[Theme]` section of your SDDM configuration.
An installation already using that identifier needs no selection change.
Use the next normal login to activate it; restarting SDDM terminates sessions.

To restore a previous installation, substitute the recorded backup path:

```sh
sudo mv /usr/share/sddm/themes/Dracula-Plasma6 /usr/share/sddm/themes/Dracula-Plasma6.patched
sudo cp -a /var/backups/sddm/Dracula-Plasma6-TIMESTAMP /usr/share/sddm/themes/Dracula-Plasma6
```

Choose a different `.patched` name if it already exists. This keeps both copies.
A desktop lock-screen or `ksldfd` failure is separate from this SDDM theme.

## Testing

Focused controller tests use fake compositor/input-method objects and a fake
X11 panel. They do not import KDE's keyboard module or contact the desktop's
keyboard service. Use the **Qt 6** test runner (the unqualified
`qmltestrunner` command can select Qt 5):

```sh
QT_QPA_PLATFORM=offscreen QT_QUICK_BACKEND=software \
    /usr/lib/qt6/bin/qmltestrunner -input kde/sddm/Dracula-Plasma6/tests
```

They cover availability changes, show/hide behavior, focus before activation,
alternate password fields, an API without `forceActivate()`, avoidance of the
Qt keyboard on Wayland, and an unavailable optional Qt keyboard module.

Preview the theme without ending the current session:

```sh
sddm-greeter-qt6 --test-mode --theme "$PWD/kde/sddm/Dracula-Plasma6"
```

The executable can be named `sddm-greeter` on some distributions; verify it is
the Qt 6 build. For X11 keyboard testing, use an X11 display and
`QT_QPA_PLATFORM=xcb QT_IM_MODULE=qtvirtualkeyboard`. Test Wayland under a
separate KWin compositor with a **private D-Bus session and runtime directory**.
A preview on the live desktop bus could otherwise control its keyboard service.

Check both login forms, masked password input, session and layout selection,
keyboard show/hide, action visibility, and the normal Dracula appearance.
Inspect console output (`QT_LOGGING_TO_CONSOLE=1`) for theme errors and
`Fallback to embedded theme`. Close the preview when finished.

### Validation recorded for this patch

Test environment: Plasma Workspace/KWin **6.8.0**, Qt **6.12.0**, SDDM **0.21.0**.

- The original release reproduced `VirtualKeyboardLoader is not a type` and
  fell back to the embedded SDDM theme.
- The patched theme loaded in SDDM test mode on Xvfb and an isolated KWin
  virtual Wayland display without that fallback.
- Seven focused Qt 6 test cases passed (nine results including setup/cleanup).
- Preview probes checked both password forms, focus/masking, session/layout
  menu selection, and returning to the user list. Synthetic users, sessions,
  and layout objects were used for those probes. X11 probes also checked the
  real Qt keyboard's show/hide state, action visibility, inactivity blocking,
  and keeping the login controls above the keyboard.
- Mouse-driven X11 checks showed and hid the keyboard and entered a masked
  character in both password forms using an on-screen key.
- No Plasma Keyboard or Maliit backend was installed. The isolated KWin
  service reported `available = false`; the Wayland keyboard button was hidden.
- Successful real SDDM authentication was confirmed after a reboot: the user
  logged in through the patched SDDM login screen using the normal keyboard.

Remaining manual checks:

- Wayland virtual-keyboard typing with an input-method backend installed and
  configured for the greeter's compositor.
- Full Plasma 6.7 runtime validation. The older-API test uses a mock,
  **not a full Plasma 6.7 runtime**.

The automated tests and preview probes cover related behavior but do not
replace these environment-specific manual checks. Existing deprecated
Connections/data engine warnings and private-session portal warnings are
distinct from a theme load failure.
