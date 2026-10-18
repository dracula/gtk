/*
    SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick 2.15

Item {
    id: controller

    property bool wayland: Qt.platform.pluginName.indexOf("wayland") !== -1
    property var waylandKeyboard: null
    property Item passwordField: null

    // Keep the optional Qt keyboard in a separate file: a missing module must
    // only fail this Loader, not the login screen. These properties also let
    // the tests use fakes without contacting a desktop keyboard service.
    property url x11Source: Qt.resolvedUrl("VirtualKeyboard.qml")
    property var inputMethod: Qt.inputMethod

    readonly property bool available: wayland
        ? !!waylandKeyboard && waylandKeyboard.available
        : x11Loader.status === Loader.Ready
    readonly property bool keyboardActive: wayland
        ? !!waylandKeyboard && waylandKeyboard.visible
        : !!x11Loader.item && x11Loader.item.active
    readonly property real keyboardHeight: !wayland && keyboardActive ? x11Loader.height : 0

    function toggle() {
        if (!available) {
            return;
        }

        if (keyboardActive) {
            if (wayland) {
                waylandKeyboard.active = false;
            } else {
                x11Loader.item.activated = false;
                inputMethod.hide();
            }
            return;
        }

        // The button takes focus, including on the alternate-user form.
        // Restore the current form's password focus before activating the IM.
        if (passwordField) {
            passwordField.forceActiveFocus();
        }
        if (wayland) {
            if (typeof waylandKeyboard.forceActivate === "function") {
                waylandKeyboard.forceActivate();
            } else {
                waylandKeyboard.active = true;
            }
        } else {
            x11Loader.item.activated = true;
            inputMethod.show();
        }
    }

    Loader {
        id: x11Loader
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        active: !controller.wayland
        source: controller.x11Source
    }
}
