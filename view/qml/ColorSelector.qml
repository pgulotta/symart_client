import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import com.twentysixapps.constants 1.0

SelectorGroupBox {
    id: colorSelectorId
    property alias selectedColor: selectedColorId.color

    title: "Color Selection"

    RowLayout {
        id: controlsViewId
        spacing: 0
        anchors.centerIn: parent
        width: parent.width
        Rectangle {
            id: selectedColorId
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            height: colorDialogSelectorButtonId.height
            border {
                width: 1
                color: Constants.disabledTextColor
            }
        }

        ToolButton {
            id: colorDialogSelectorButtonId
            Layout.fillWidth: false
            text: " ..."
            onClicked: {
                colorDialogId.currentColor = selectedColor
                colorDialogId.open()
            }
        }
    }
    ColorDialog {
        id: colorDialogId
        modality: Qt.ApplicationModal
        title: "Please choose a color"
        onAccepted: selectedColor = currentColor
    }
}
