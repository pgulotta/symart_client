import QtQuick 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "ClustersPage"
    id: clustersPageId
    shouldTileImage: true

    function drawImage() {
        imageSource = Controller.getClustersQuery(
                    dimensionSelectorId.dimension,
                    symmetrySelectorId.selectorIndex, alphaSelectorId.dimension)
    }

    function selectionDescription() {
        return dimensionSelectorId.title + "=" + dimensionSelectorId.dimension + ", "
                + symmetrySelectorId.title + "=" + ImmutableList.symmetryGroups(
                    )[symmetrySelectorId.selectorIndex] + ", "
                + alphaSelectorId.title + "=" + alphaSelectorId.dimension
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
        }
    }
}
