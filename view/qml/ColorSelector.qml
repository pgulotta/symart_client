import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import com.twentysixapps.constants 1.0

RowLayout {
    id: colorSelectorId

    property alias selectedColor: selectedColorId.color

    height: 50
    width: parent.width
    spacing: 0

    Rectangle {
        id: selectedColorId
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: false
        width: parent.width
        height: 20
        border {
            width: 1
            color: Constants.disabledTextColor
        }
        TapHandler {
            onTapped: showColorDialog()
        }
    }

    ToolButton {
        id: colorDialogSelectorButtonId
        Layout.fillWidth: false
        text: "..."
        onClicked: showColorDialog()
    }

    ColorDialog {
        id: colorDialogId
        modality: Qt.ApplicationModal
        title: "Please select a color"
        onAccepted: selectedColor = currentColor
    }

    function showColorDialog() {
        colorDialogId.color = selectedColor
        colorDialogId.currentColor = selectedColor
        colorDialogId.open()
    }
}
