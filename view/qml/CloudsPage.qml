import QtQuick 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "CloudsPage"
    id: cloudsPageId
    shouldTileImage: true

    function drawImage() {
        Controller.generateCloudsImage(dimensionSelectorId.dimension,
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
            spacing: largePadding
            leftPadding: mediumPadding

            SliderSelector {
                id: dimensionSelectorId
                fromValue: 2
                toValue: maxImageDimension
                stepValue: 1
                initialValue: 256
                isAlwaysEven: true
            }
            TumblerSelector {
                id: distributionSelectorId
                title: qsTr("Distribution")
                selectorModel: ImmutableList.distributionNames()
                width: dimensionSelectorId.width
                height: dimensionSelectorId.height
            }
            TumblerSelector {
                id: symmetrySelectorId
                title: qsTr("Symmetry")
                selectorModel: ImmutableList.symmetryGroups()
                width: dimensionSelectorId.width
                height: dimensionSelectorId.height
            }

            ColorsSelector {
                id: colorSelector1Id
                width: dimensionSelectorId.width
                height: 150
            }
        }
    }
}
