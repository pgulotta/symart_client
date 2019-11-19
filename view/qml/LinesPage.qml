import QtQuick 2.13
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.13
import Qt.labs.platform 1.1 as Labs

ImageGeneratorPage {
    objectName: "LinesPage"
    id: linesPageId
    shouldTileImage: true

    function drawImage() {
        imageSource = Controller.getLinessQuery(dimensionSelectorId.dimension,
                                                symmetrySelectorId.selectorIndex, colorCountSelectorId.dimension,
                                                rule1Id.getRuleName(),
                                                parseInt(rule1Id.weight),
                                                rule1Id.usePastelColors, rule2Id.getRuleName(
                                                    ), parseInt(
                                                    rule2Id.weight), rule2Id.usePastelColors,
                                                rule3Id.getRuleName(),
                                                parseInt(rule3Id.weight),
                                                rule3Id.usePastelColors)
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
                id: colorCountSelectorId
                title: "Number of Colors"
                fromValue: 1
                toValue: 99
                stepValue: 1
                initialValue: 25
                isAlwaysEven: false
                decimals: 0
            }
            RuleTypeSelector {
                id: rule1Id
                title: "Rule 1"
            }
            RuleTypeSelector {
                id: rule2Id
                title: "Rule 2"
            }
            RuleTypeSelector {
                id: rule3Id
                title: "Rule 3"
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
