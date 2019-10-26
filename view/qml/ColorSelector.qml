import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import com.twentysixapps.constants 1.0

SelectorGroupBox {
    id: colorSelectorId
    property alias selectedColor: selectedColorId.color

    title: "Color Selection"

    Column {
        spacing: largePadding
        Rectangle {
            id: selectedColorId
            width: colorSelectorId.width * 0.8
            height: colorDialogSelectorButtonId.height * 0.5
            border {
                width: 1
                color: Constants.disabledTextColor
            }
        }

        ToolButton {
            id: colorDialogSelectorButtonId
            width: parent.width
            text: "..."
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
