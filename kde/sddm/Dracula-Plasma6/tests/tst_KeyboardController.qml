// SPDX-License-Identifier: GPL-3.0-or-later
import QtQuick 2.15
import QtTest 1.2
import "../components"

TestCase {
    id: testCase
    name: "KeyboardController"
    when: windowShown
    width: 800
    height: 600

    TextInput { id: password; width: 200; height: 40 }
    TextInput { id: alternatePassword; y: 50; width: 200; height: 40 }
    Item { id: buttonFocus }

    Component {
        id: controllerFactory
        KeyboardController {
            anchors.fill: parent
            wayland: true
            passwordField: password
        }
    }

    Component {
        id: backendFactory
        QtObject {
            property bool available: true
            property bool visible: false
            property bool active: false
            property int forceCalls: 0
            property bool focusedBeforeActivation: false
            property Item expectedField: password
            function forceActivate() {
                focusedBeforeActivation = expectedField.activeFocus;
                forceCalls++;
                active = true;
            }
        }
    }

    Component {
        id: oldBackendFactory
        QtObject {
            property bool available: true
            property bool visible: false
            property bool active: false
            property bool focusedBeforeActivation: false
            onActiveChanged: if (active) focusedBeforeActivation = password.activeFocus
        }
    }

    Component {
        id: inputMethodFactory
        QtObject {
            property int showCalls: 0
            property int hideCalls: 0
            property bool focusedBeforeActivation: false
            function show() {
                focusedBeforeActivation = password.activeFocus;
                showCalls++;
            }
            function hide() { hideCalls++; }
        }
    }

    function init() {
        buttonFocus.forceActiveFocus();
    }

    function test_waylandAvailability() {
        const backend = createTemporaryObject(backendFactory, testCase, { available: false });
        const controller = createTemporaryObject(controllerFactory, testCase, { waylandKeyboard: backend });
        verify(!controller.available);
        controller.toggle();
        compare(backend.forceCalls, 0);
        verify(buttonFocus.activeFocus);
        backend.available = true;
        verify(controller.available);
        backend.available = false;
        verify(!controller.available);
        controller.waylandKeyboard = null;
        verify(!controller.available);
        verify(!controller.keyboardActive);
        controller.toggle();
    }

    function test_waylandShowHide() {
        const backend = createTemporaryObject(backendFactory, testCase);
        const controller = createTemporaryObject(controllerFactory, testCase, { waylandKeyboard: backend });
        controller.toggle();
        verify(backend.focusedBeforeActivation);
        compare(backend.forceCalls, 1);
        verify(backend.active);
        // The UI follows compositor visibility, not the activation request.
        verify(!controller.keyboardActive);
        backend.visible = true;
        verify(controller.keyboardActive);
        controller.toggle();
        verify(!backend.active);
        compare(backend.forceCalls, 1);
        backend.visible = false;
        verify(!controller.keyboardActive);
    }

    function test_alternatePasswordFocus() {
        const backend = createTemporaryObject(backendFactory, testCase, { expectedField: alternatePassword });
        const controller = createTemporaryObject(controllerFactory, testCase, { waylandKeyboard: backend });
        controller.passwordField = alternatePassword;
        controller.toggle();
        verify(backend.focusedBeforeActivation);
        verify(alternatePassword.activeFocus);
        verify(!password.activeFocus);
    }

    function test_olderWaylandAPI() {
        const backend = createTemporaryObject(oldBackendFactory, testCase);
        const controller = createTemporaryObject(controllerFactory, testCase, { waylandKeyboard: backend });
        controller.toggle();
        verify(backend.active);
        verify(backend.focusedBeforeActivation);
        backend.visible = true;
        controller.toggle();
        verify(!backend.active);
    }

    function test_waylandDoesNotLoadQtKeyboard() {
        const backend = createTemporaryObject(backendFactory, testCase);
        const controller = createTemporaryObject(controllerFactory, testCase, {
            waylandKeyboard: backend,
            x11Source: Qt.resolvedUrl("MissingKeyboard.qml")
        });
        verify(controller.available);
        controller.toggle();
        compare(backend.forceCalls, 1);
        compare(controller.keyboardHeight, 0);
    }

    function test_x11ShowHide() {
        const inputMethod = createTemporaryObject(inputMethodFactory, testCase);
        const controller = createTemporaryObject(controllerFactory, testCase, {
            wayland: false,
            x11Source: Qt.resolvedUrl("FakeKeyboard.qml"),
            inputMethod: inputMethod
        });
        tryCompare(controller, "available", true);
        verify(!controller.keyboardActive);
        controller.toggle();
        verify(controller.keyboardActive);
        compare(controller.keyboardHeight, 120);
        verify(inputMethod.focusedBeforeActivation);
        compare(inputMethod.showCalls, 1);
        controller.toggle();
        verify(!controller.keyboardActive);
        compare(controller.keyboardHeight, 0);
        compare(inputMethod.hideCalls, 1);
    }

    function test_missingQtKeyboard() {
        const inputMethod = createTemporaryObject(inputMethodFactory, testCase);
        ignoreWarning(/.*module "org.dracula.test.missingkeyboard" is not installed.*/);
        const controller = createTemporaryObject(controllerFactory, testCase, {
            wayland: false,
            x11Source: Qt.resolvedUrl("MissingKeyboard.qml"),
            inputMethod: inputMethod
        });
        verify(!controller.available);
        verify(!controller.keyboardActive);
        controller.toggle();
        compare(inputMethod.showCalls, 0);
        compare(inputMethod.hideCalls, 0);
    }
}
