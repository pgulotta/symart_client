import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import com.twentysixapps.constants 1.0

SelectorGroupBox {
    id: colorSelectorId

    property alias selectedColor1: colorSelector1Id.selectedColor
    property string selectedColor2: colorSelector1Id.selectedColor
    property string selectedColor3: colorSelector1Id.selectedColor

    title: "Colors"

    Column {
        id: colorsColumnId
        spacing: 0
        Loader {
            id: colorSelector1Id
            sourceComponent: sourceComponentId
            sourceComponentId.selectedColor: selectedColor1
        }
        Loader {
            id: colorSelector2Id
            sourceComponent: sourceComponentId
            selectedColor: selectedColor2
        }
        Loader {
            id: colorSelector3Id
            sourceComponent: sourceComponentId
            selectedColor: selectedColor3
        }
    }

    Component {
        id: sourceComponentId
        property alias selectedColor: selectedColorId.color
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
                height: 25
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
