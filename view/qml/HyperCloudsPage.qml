import QtQuick 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "HyperCloudsPage"
    id: hyperCloudsPageId
    shouldTileImage: false
    canAugmentImage: false

    function drawImage() {
        var rotationsList = assignRotations()
        Controller.generateHyperbolicCloudsImage(
                    dimensionSelectorId.dimension,
                    groupSelectorId.selectorIndex,
                    projectionSelectorId.selectorIndex,
                    distributionSelectorId.selectorIndex, rotationsList[0],
                    rotationsList[1], rotationsList[2], rotationsList[3],
                    colorSelectorId.selectedColor1,
                    colorSelectorId.selectedColor2,
                    colorSelectorId.selectedColor3)
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
            leftPadding: mediumPadding

            SliderSelector {
                id: dimensionSelectorId
                fromValue: 2
                toValue: maxImageDimension
                stepValue: 1
                initialValue: 256
                isAlwaysEven: true
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
                width: dimensionSelectorId.width
                height: dimensionSelectorId.height * 0.8
                onSelectorModelChanged: selectorIndex = 0
            }
            ColorsSelector {
                id: colorSelectorId
                width: dimensionSelectorId.width
                height: 150
            }
        }
    }
}
