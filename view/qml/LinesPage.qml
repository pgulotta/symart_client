import QtQuick 2.13
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.13
import Qt.labs.platform 1.1 as Labs

ImageGeneratorPage {
    id: linesPageId
    objectName: "LinesPage"
    shouldTileImage: true

    function drawImage() {
        Controller.generateLinessImage(
                    dimensionSelectorId.dimension, symmetrySelectorId.selectorIndex,
                    colorCountSelectorId.dimension, rule1Id.getRuleName(
                        ), parseInt(rule1Id.weight), rule1Id.usePastelColors,
                    rule2Id.getRuleName(), parseInt(rule2Id.weight),
                    rule2Id.usePastelColors, rule3Id.getRuleName(), parseInt(
                        rule3Id.weight), rule3Id.usePastelColors)
    }

    function selectionDescription() {
        return dimensionSelectorId.title + "=" + dimensionSelectorId.dimension + ", "
                + symmetrySelectorId.title + "=" + ImmutableList.symmetryGroups(
                    )[symmetrySelectorId.selectorIndex] + ", "
                + colorCountSelectorId.title + "=" + colorCountSelectorId.dimension
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
                title: qsTr("Symmetry")
                selectorModel: ImmutableList.symmetryGroups()
                width: dimensionSelectorId.width
                height: dimensionSelectorId.height
            }
            SliderSelector {
                id: colorCountSelectorId
                title: qsTr("Number of Colors")
                fromValue: 1
                toValue: 99
                stepValue: 1
                initialValue: 25
                isAlwaysEven: false
                decimals: 0
            }
            RuleTypeSelector {
                id: rule1Id
                title: qsTr("Rule 1")
                initialIndex: 1
            }
            RuleTypeSelector {
                id: rule2Id
                title: qsTr("Rule 2")
                initialIndex: 4
                usePastelColors: true
            }
            RuleTypeSelector {
                id: rule3Id
                title: qsTr("Rule 3")
                initialIndex: 7
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
