﻿import QtQuick 2.14
import QtQuick.Controls 2.14

Dialog {
    id: dialogId
    x: 0
    modal: true
    focus: true
    clip: true

    standardButtons: Dialog.Cancel | Dialog.Ok

    enter: EnterTransition {}

    exit: ExitTransition {}

    MouseArea {
        anchors.fill: parent
        property real lastMouseX: 0
        property real lastMouseY: 0
        onPressed: {
            lastMouseX = mouseX
            lastMouseY = mouseY
        }
        onMouseXChanged: dialogId.x += (mouseX - lastMouseX)
        onMouseYChanged: dialogId.y += (mouseY - lastMouseY)
    }
    function openDialog() {
        dialogId.open()
    }
}
