import QtQuick 2.13
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.13
import Qt.labs.platform 1.1 as Labs

ImageGeneratorPage {
    objectName: "HyperLinesPage"
    id: hyperLinesPageId
    shouldTileImage: false
    canAugmentImage: false

    function drawImage() {
        var rotationsList = assignRotations()
        imageSource = Controller.getHyperbolicLines(
                    dimensionSelectorId.dimension,
                    groupSelectorId.selectorIndex, rotationsList[0],
                    rotationsList[1], rotationsList[2], rotationsList[3],
                    projectionSelectorId.selectorIndex,
                    flipSelectorId.selectorIndex,
                    thicknessSelectorId.dimension,
                    sharpnessSelectorId.dimension,
                    colorCountSelectorId.dimension)
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
    function assignRotations() {
        var rotationsList = new Array
        if (groupSelectorId.canEdit0 && groupSelectorId.rotation0 !== "")
            rotationsList.push(parseInt(groupSelectorId.rotation0))
        if (groupSelectorId.canEdit1 && groupSelectorId.rotation1 !== "")
            rotationsList.push(parseInt(groupSelectorId.rotation1))
        if (groupSelectorId.canEdit2 && groupSelectorId.rotation2 !== "")
            rotationsList.push(parseInt(groupSelectorId.rotation2))
        if (groupSelectorId.canEdit3 && groupSelectorId.rotation3 !== "")
            rotationsList.push(parseInt(groupSelectorId.rotation3))
        if (groupSelectorId.canEdit4 && groupSelectorId.rotation4 !== "")
            rotationsList.push(parseInt(groupSelectorId.rotation4))
        while (rotationsList.length < 4)
            rotationsList.push(invalidValue)

        return rotationsList
    }
}
