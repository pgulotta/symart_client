﻿import QtQuick 2.13
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    id: orbitTrapsPageId
    objectName: "OrbitTrapsPage"
    shouldTileImage: true

    function drawImage() {
        Controller.generateOrbitTrapImage(colorSelectorId.selectedColor,
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
            id: columnId
            spacing: exlargePadding
            leftPadding: mediumPadding

            SliderSelector {
                id: dimensionSelectorId
                fromValue: 2
                toValue: maxImageDimension
                stepValue: 2
                initialValue: defaultImageDimension
                isAlwaysEven: true
            }
            TumblerSelector {
                id: symmetrySelectorId
                title: qsTr("Symmetry")
                selectorModel: ImmutableList.symmetryGroups()
                width: dimensionSelectorId.width
                height: dimensionSelectorId.height
            }
            ColorSelector {
                id: colorSelectorId
                width: 100
            }
        }
    }
}
