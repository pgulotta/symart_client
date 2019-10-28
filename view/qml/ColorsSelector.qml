import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import com.twentysixapps.constants 1.0

SelectorGroupBox {
    id: colorSelectorId

    property string selectedColor1: "#FFFF00"
    property string selectedColor2: "#FF00FF"
    property string selectedColor3: "#00FFFF"

    title: "Colors"

    Column {
        id: colorsColumnId
        spacing: 0
        Loader {
            id: colorSelector1Id
            sourceComponent: sourceComponentId
            property string selectedColor: selectedColor1
        }
        Loader {
            id: colorSelector2Id
            sourceComponent: sourceComponentId
            property string selectedColor: selectedColor2
        }
        Loader {
            id: colorSelector3Id
            sourceComponent: sourceComponentId
            property string selectedColor: selectedColor3
        }
    }

    Component {
        id: sourceComponentId
        RowLayout {
            id: controlsViewId
            spacing: 0
            anchors.centerIn: parent
            width: colorSelectorId.width
            Rectangle {
                id: selectedColorId
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: false
                width: 50
                color: selectedColor
                height: 20 // colorDialogSelectorButtonId.height
                border {
                    width: 1
                    color: Constants.disabledTextColor
                }
            }

            ToolButton {
                id: colorDialogSelectorButtonId
                Layout.fillWidth: false
                text: "..."
                onClicked: {
                    colorDialogId.currentColor = selectedColor
                    colorDialogId.open()
                }
                ColorDialog {
                    id: colorDialogId
                    modality: Qt.ApplicationModal
                    title: "Please choose a color"
                    onAccepted: selectedColorId.color = currentColor
                }
            }
        }
    }
}
