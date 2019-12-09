import QtQuick 2.12
import QtQuick.Window 2.11
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0
import com.twentysixapps.constants 1.0

Dialog {
    id: dialogId

    property int xSelection: 2
    property int ySelection: 2

    title: "Randomize"
    modal: true
    focus: true
    clip: true
    standardButtons: Dialog.Cancel | Dialog.Ok

    enter: EnterTransition {}

    exit: ExitTransition {}

    RowLayout {
        id: controlsViewId
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        Column {
            spacing: exlargePadding
            Layout.alignment: Qt.AlignHCenter
            SliderSelector {
                id: xSelectorId
                title: "X"
                dimension: xSelection
                fromValue: 1
                toValue: 99
                initialValue: 50
                isAlwaysEven: false
            }
            SliderSelector {
                id: ySelectorId
                width: xSelectorId.width
                height: xSelectorId.height
                title: "Y"
                dimension: ySelection
                fromValue: 1
                toValue: 99
                initialValue: 50
                isAlwaysEven: false
            }
        }
    }
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
