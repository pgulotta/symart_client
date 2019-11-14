﻿import QtQuick 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "HyperCloudsPage"
    id: hyperCloudsPageId
    shouldTileImage: false

    readonly property int invalidValue: -1

    function drawImage() {
        var rotationsList = assignRotations()
        var query = Controller.getHyperbolicCloudsQuery(
                    dimensionSelectorId.dimension,
                    groupSelectorId.selectorIndex,
                    projectionSelectorId.selectorIndex,
                    distributionSelectorId.selectorIndex, rotationsList[0],
                    rotationsList[1], rotationsList[2], rotationsList[3],
                    colorSelector1Id.selectedColor1,
                    colorSelector1Id.selectedColor2,
                    colorSelector1Id.selectedColor3)
        console.log(query)
        imageSource = query
    }

    function selectionDescription() {
        return dimensionSelectorId.title + "=" + dimensionSelectorId.dimension
                + ", " + groupSelectorId.title + "=" + groupSelectorId.selectedGroupName(
                    ) + ", " + distributionSelectorId.title + "="
                + ImmutableList.distributionNames()[distributionSelectorId.selectorIndex]
                + ", " + projectionSelectorId.title + "=" + ImmutableList.projectionTypes(
                    )[projectionSelectorId.selectorIndex]
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

    controlsView: RowLayout {
        id: controlsViewId
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        Column {
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

            ColorsSelector {
                id: colorSelector1Id
                width: dimensionSelectorId.width
                height: 200
                selectedColor1: "#FFFF00"
                selectedColor2: "#FF00FF"
                selectedColor3: "#00FFFF"
            }
            HyperbolicSymmetryGroupSelector {
                id: groupSelectorId
                width: dimensionSelectorId.width
                height: 150
            }
            TumblerSelector {
                id: distributionSelectorId
                title: "Distribution"
                selectorModel: ImmutableList.distributionNames()
                width: dimensionSelectorId.width
                height: dimensionSelectorId.height
                onSelectorModelChanged: selectorIndex = 1
            }
            TumblerSelector {
                id: projectionSelectorId
                title: "Projection"
                selectorModel: ImmutableList.projectionTypes()
                width: distributionSelectorId.width
                height: width * 0.8
                onSelectorModelChanged: selectorIndex = 0
            }
        }
    }
}
