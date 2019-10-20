﻿import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "OrbitTrapsPage"
    id: orbitTrapsPageId
    shouldTileImage: true

    function drawImage() {
        console.log("drawImage ===============================")
        imageSource = Controller.getOrbitTrapQuery(
                    dimensionSelectorId.dimension,
                    symmetrySelectorId.tumblerIndex)
    }

    controlsView: RowLayout {
        id: controlsViewId
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        Column {
            spacing: exlargePadding
            leftPadding: largePadding

            DimensionSelector {
                id: dimensionSelectorId
                fromValue: 2
                toValue: 1024
            }
            TumblerSelector {
                id: symmetrySelectorId
                title: "Symmetry"
                tumblerModel: ImmutableList.symmetryGroups()
                width: dimensionSelectorId.width
                height: width * 1.2
            }
        }
    }
}
