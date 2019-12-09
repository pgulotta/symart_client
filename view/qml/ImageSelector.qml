import QtQuick 2.13
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.13
import Qt.labs.platform 1.1 as Labs

Column {
    id: imageSelectorId
    objectName: "ImageSelector"
    visible: true

    property string imagePaletteUrl: ""
    property alias imagePaletteName: imagePaletteNameId.text
    property alias useBrightness: useBrightnessSwitchId.checked
    property alias useHue: useHueSwitchId.checked
    property alias useSaturation: useSaturationSwitchId.checked
    property alias saturationBoost: saturationBoostSelectorId.dimension

    Switch {
        id: useImageColorsSwitchId
        text: qsTr("Use Image Palette")
        checked: false
        onCheckedChanged: if (checked === false) {
                              imagePaletteName = ""
                              imagePaletteUrl = ""
                          }
    }
    RowLayout {
        spacing: 0
        TextArea {
            id: imagePaletteNameId
            placeholderText: qsTr("Select Image")
            wrapMode: Label.WordWrap
            Layout.fillWidth: true
            Layout.preferredWidth: dimensionSelectorId.width
            readOnly: true
            selectByMouse: false
            onTextChanged: if (text !== "") {
                               useBrightnessSwitchId.checked = true
                               useHueSwitchId.checked = true
                               useSaturationSwitchId.checked = true
                           }
        }
        ToolButton {
            Layout.fillWidth: true
            text: "..."
            onClicked: showFileDialog()
        }
    }
    Switch {
        id: useBrightnessSwitchId
        text: qsTr("Use Color Brightness")
        enabled: useImageColorsSwitchId.checked && imagePaletteUrl !== ""
        checked: false
    }
    Switch {
        id: useHueSwitchId
        text: qsTr("Use Color Hue")
        enabled: useImageColorsSwitchId.checked && imagePaletteUrl !== ""
        checked: false
    }
    Switch {
        id: useSaturationSwitchId
        text: qsTr("Use Color Saturation")
        enabled: useImageColorsSwitchId.checked && imagePaletteUrl !== ""
        checked: false
    }
    SliderSelector {
        id: saturationBoostSelectorId
        title: qsTr("Saturation Boost")
        fromValue: 0.01
        toValue: 3.0
        stepValue: 0.1
        initialValue: 1.5
        isAlwaysEven: false
        decimals: 2
        enabled: useSaturationSwitchId.checked && imagePaletteUrl !== ""
    }

    Labs.FileDialog {
        id: fileDialogId
        fileMode: Labs.FileDialog.OpenFile
        modality: Qt.WindowModal
        onAccepted: {
            imagePaletteUrl = file
            imagePaletteName = Controller.toLocalFile(file)
            useImageColorsSwitchId.checked = true
            useHueSwitchId.checked = true
            useSaturationSwitchId.checked = true
        }
    }

    function showFileDialog() {
        fileDialogId.currentFile = imagePaletteUrl
        fileDialogId.file = imagePaletteUrl
        fileDialogId.open()
    }
}
