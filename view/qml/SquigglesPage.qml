import QtQuick 2.13
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.13
import Qt.labs.platform 1.1 as Labs

ImageGeneratorPage {
    objectName: "SquigglesPage"
    id: squigglesPageId
    shouldTileImage: true

    property alias imagePaletteName: imagePaletteNameId.text
    property string imagePaletteUrl

    function drawImage() {
        imageSource = Controller.getCloudsQuery(
                    dimensionSelectorId.dimension,
                    symmetrySelectorId.selectorIndex,
                    colorSelector1Id.selectedColor1,
                    colorSelector1Id.selectedColor2,
                    colorSelector1Id.selectedColor3,
                    distributionSelectorId.selectorIndex)
    }

    function selectionDescription() {
        return dimensionSelectorId.title + "=" + dimensionSelectorId.dimension + ", "
                + symmetrySelectorId.title + "=" + ImmutableList.symmetryGroups(
                    )[symmetrySelectorId.selectorIndex] + ", "
                + distributionSelectorId.title + "=" + ImmutableList.distributionNames(
                    )[distributionSelectorId.selectorIndex]
    }

    controlsView: RowLayout {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        Column {
            id: columnId
            spacing: largePadding
            leftPadding: largePadding

            SliderSelector {
                id: dimensionSelectorId
                fromValue: 2
                toValue: 1024
                stepValue: 2
                initialValue: 256
                isAlwaysEven: true
            }
            TumblerSelector {
                id: symmetrySelectorId
                title: "Symmetry"
                selectorModel: ImmutableList.symmetryGroups()
                width: dimensionSelectorId.width
                height: dimensionSelectorId.height
            }
            SliderSelector {
                id: alphaSelectorId
                title: "Alpha"
                fromValue: 0.01
                toValue: 2.0
                stepValue: 0.01
                initialValue: 1.5
                isAlwaysEven: false
                decimals: 2
            }
            SliderSelector {
                id: exponentelectorId
                title: "Exponent"
                fromValue: 0.0
                toValue: 99.99
                stepValue: 0.01
                initialValue: 50
                isAlwaysEven: false
                decimals: 2
            }
            SliderSelector {
                id: thicknessSelectorId
                title: "Thickness"
                fromValue: 0.0
                toValue: 99.99
                stepValue: 0.01
                initialValue: 50
                isAlwaysEven: false
                decimals: 2
            }
            SliderSelector {
                id: sharpnessSelectorId
                title: "Sharpness"
                fromValue: 0.0
                toValue: 99.99
                stepValue: 0.01
                initialValue: 50
                isAlwaysEven: false
                decimals: 2
            }
            SliderSelector {
                id: colorCountSelectorId
                title: "Number of Colors"
                fromValue: 1
                toValue: 99
                stepValue: 1
                initialValue: 25
                isAlwaysEven: false
                decimals: 0
            }
            Switch {
                id: useImageColorsSwitchId
                text: qsTr("Use Image Palette")
                checked: false
                onCheckedChanged: if (checked === false) {
                                      imagePaletteName = ""
                                  }
            }
            RowLayout {
                spacing: 0
                TextArea {
                    id: imagePaletteNameId
                    placeholderText: "Select Image"
                    wrapMode: Label.WordWrap
                    Layout.fillWidth: true
                    Layout.preferredWidth: dimensionSelectorId.width
                    readOnly: true
                    selectByMouse: false
                }
                ToolButton {
                    Layout.fillWidth: true
                    text: "..."
                    enabled: useImageColorsSwitchId.checked
                    onClicked: showFileDialog()
                }
            }
            Switch {
                id: useLightnrddSwitchId
                text: qsTr("Use Color Brightness")
                enabled: useImageColorsSwitchId.checked
                         && imagePaletteNameId.text !== ""
                checked: false
            }
            Switch {
                id: useHueSwitchId
                text: qsTr("Use Color Hue")
                enabled: useImageColorsSwitchId.checked
                         && imagePaletteNameId.text !== ""
                checked: false
            }
            Switch {
                id: useSaturationSwitchId
                text: qsTr("Use Color Saturation")
                enabled: useImageColorsSwitchId.checked
                         && imagePaletteNameId.text !== ""
                checked: false
            }
            SliderSelector {
                id: saturationBoostSelectorId
                title: "Saturation Boost"
                fromValue: 0.01
                toValue: 3.0
                stepValue: 0.01
                initialValue: 0
                isAlwaysEven: false
                decimals: 2
                enabled: useSaturationSwitchId.checked
                         && imagePaletteNameId.text !== ""
            }
        }
    }
    Labs.FileDialog {
        id: fileDialogId
        fileMode: Labs.FileDialog.OpenFile
        modality: Qt.WindowModal
        onAccepted: {
            imagePaletteUrl = file
            imagePaletteName = Controller.toLocalFile(file)
        }
    }

    function showFileDialog() {
        fileDialogId.currentFile = imagePaletteUrl
        fileDialogId.file = imagePaletteUrl
        fileDialogId.open()
    }
}
