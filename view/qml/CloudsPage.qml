import QtQuick 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "CloudsPage"
    id: cloudsPageId
    shouldTileImage: true

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
        id: controlsViewId
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        Column {
            spacing: exlargePadding
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
            TumblerSelector {
                id: distributionSelectorId
                title: "Distribution"
                selectorModel: ImmutableList.distributionNames()
                width: dimensionSelectorId.width
                height: dimensionSelectorId.height
            }
            ColorsSelector {
                id: colorSelector1Id
                width: dimensionSelectorId.width
                height: symmetrySelectorId.height * 1.34
                selectedColor1: "#FFFF00"
                selectedColor2: "#FF00FF"
                selectedColor3: "#00FFFF"
            }
        }
    }
}
