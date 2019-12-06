import QtQuick 2.13
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.13
import Qt.labs.platform 1.1 as Labs

ImageGeneratorPage {
    objectName: "SquigglesPage"
    id: squigglesPageId
    shouldTileImage: true

    function drawImage() {
        if (imageSelectorId.imagePaletteUrl === "") {
            Controller.generateSquigglesImage(colorCountSelectorId.dimension,
                                              dimensionSelectorId.dimension,
                                              symmetrySelectorId.selectorIndex,
                                              alphaSelectorId.dimension,
                                              exponentelectorId.dimension,
                                              thicknessSelectorId.dimension,
                                              sharpnessSelectorId.dimension)
        } else {
            Controller.loadColorsImage(imageSelectorId.imagePaletteName)
            Controller.generateSquigglesImage(colorCountSelectorId.dimension,
                                              imageSelectorId.saturationBoost,
                                              imageSelectorId.useHue,
                                              imageSelectorId.useSaturation,
                                              imageSelectorId.useBrightness,
                                              dimensionSelectorId.dimension,
                                              symmetrySelectorId.selectorIndex,
                                              alphaSelectorId.dimension,
                                              exponentelectorId.dimension,
                                              thicknessSelectorId.dimension,
                                              sharpnessSelectorId.dimension)
        }
    }

    function selectionDescription() {
        return dimensionSelectorId.title + "=" + dimensionSelectorId.dimension + ", "
                + symmetrySelectorId.title + "=" + ImmutableList.symmetryGroups(
                    )[symmetrySelectorId.selectorIndex] + ", "
                + colorCountSelectorId.title + "=" + colorCountSelectorId.dimension
    }

    function updateImage() {
        imageSource = ""
        Controller.updateSquigglesImage(dimensionSelectorId.dimension,
                                        symmetrySelectorId.selectorIndex)
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
                toValue: maxImageDimension
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
            ToolButton {
                text: "Change Colors"
                enabled: pageDescription !== ""
                onClicked: updateImage()
            }
            SliderSelector {
                id: alphaSelectorId
                title: "Alpha Blending"
                fromValue: 0.04
                toValue: 2.0
                stepValue: 0.1
                initialValue: 1.5
                isAlwaysEven: false
                decimals: 2
            }
            SliderSelector {
                id: exponentelectorId
                title: "Exponent"
                fromValue: 0.0
                toValue: 16.00
                stepValue: 0.01
                initialValue: 4
                isAlwaysEven: false
                decimals: 2
            }
            SliderSelector {
                id: thicknessSelectorId
                title: "Thickness"
                fromValue: 0.0
                toValue: 20.00
                stepValue: 0.01
                initialValue: 1
                isAlwaysEven: false
                decimals: 2
            }
            SliderSelector {
                id: sharpnessSelectorId
                title: "Sharpness"
                fromValue: 0.0
                toValue: 1000
                stepValue: 1
                initialValue: 2
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

            ImageSelector {
                id: imageSelectorId
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
