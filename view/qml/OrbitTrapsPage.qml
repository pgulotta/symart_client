import QtQuick 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "OrbitTrapsPage"
    id: orbitTrapsPageId
    shouldTileImage: true

    function drawImage() {
        imageSource = Controller.getOrbitTrapQuery(
                    dimensionSelectorId.dimension,
                    symmetrySelectorId.selectorIndex)
    }

    function selectionDescription() {
        return dimensionSelectorId.title + "=" + dimensionSelectorId.dimension + ", "
                + symmetrySelectorId.title + "=" + ImmutableList.symmetryGroups(
                    )[symmetrySelectorId.selectorIndex]
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
        }
    }
}
