import QtQuick 2.13
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.13
import Qt.labs.platform 1.1 as Labs

ImageGeneratorPage {
    objectName: "HyperLinesPage"
    id: hyperLinesPageId
    imageSource: "qrc:/view/images/hyper-lines.png"
    shouldTileImage: false

    function drawImage() {

        imageSource = Controller.getSquigglesQuery(
                    colorCountSelectorId.dimension,
                    dimensionSelectorId.dimension,
                    symmetrySelectorId.selectorIndex,
                    alphaSelectorId.dimension, exponentelectorId.dimension,
                    thicknessSelectorId.dimension,
                    sharpnessSelectorId.dimension)
    }
    function selectionDescription() {
        return dimensionSelectorId.title + "=" + dimensionSelectorId.dimension + ", "
                + groupSelectorId.title + "=" + groupSelectorId.selectedGroupName(
                    ) + ", " + colorCountSelectorId.title + "=" + colorCountSelectorId.dimension
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
                width: colorCountSelectorId.width
                fromValue: 2
                toValue: 1024
                stepValue: 2
                initialValue: 256
                isAlwaysEven: true
            }
            HyperbolicSymmetryGroupSelector {
                id: groupSelectorId
                width: colorCountSelectorId.width
                height: 150
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
            TumblerSelector {
                id: flipSelectorId
                title: "Subset"
                selectorModel: ImmutableList.flipTypes()
                width: colorCountSelectorId.width
                height: projectionSelectorId.height
                onSelectorModelChanged: selectorIndex = 0
            }
            TumblerSelector {
                id: projectionSelectorId
                title: "Projection"
                selectorModel: ImmutableList.projectionTypes()
                width: colorCountSelectorId.width
                height: dimensionSelectorId.height * 0.8
                onSelectorModelChanged: selectorIndex = 0
            }
            SliderSelector {
                id: thicknessSelectorId
                width: colorCountSelectorId.width
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
                width: colorCountSelectorId.width
                title: "Sharpness"
                fromValue: 0.0
                toValue: 1000
                stepValue: 1
                initialValue: 2
                isAlwaysEven: false
                decimals: 2
            }
        }
    }
}
