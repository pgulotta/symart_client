import QtQuick 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "StripesPage"
    id: clustersPageId
    shouldTileImage: true

    function drawImage() {
        Controller.generateStripesImage(dimensionSelectorId.dimension,
                                        symmetrySelectorId.selectorIndex,
                                        alphaSelectorId.dimension)
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
            spacing: mediumPadding
            leftPadding: mediumPadding

            SliderSelector {
                id: dimensionSelectorId
                fromValue: 2
                toValue: maxImageDimension
                stepValue: 2
                initialValue: defaultImageDimension
            }

            TumblerSelector {
                id: symmetrySelectorId
                title: qsTr("Symmetry")
                selectorModel: ImmutableList.symmetryGroups()
                width: dimensionSelectorId.width
                height: dimensionSelectorId.height
            }

            SliderSelector {
                id: alphaSelectorId
                title: qsTr("Alpha Blending")
                fromValue: 0.04
                toValue: 2.0
                stepValue: 0.1
                initialValue: 1.5
                isAlwaysEven: false
                decimals: 2
            }
        }
    }
}
