import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "OrbitTrapsPage"
    id: orbitTrapsPageId

    function drawRequested() {
        imageSource = Controller.getOrbitTrapQuery(
                    dimensionSelectorId.dimension,
                    symmetrySelectorId.symmetryIndex)
    }

    controlsView: RowLayout {
        id: controlsViewId
        anchors.centerIn: parent
        Column {
            spacing: exlargePadding
            leftPadding: largePadding
            DimensionSelector {
                id: dimensionSelectorId
            }
            SymmetrySelector {
                id: symmetrySelectorId
                width: dimensionSelectorId.width
                height: width * 1.2
            }
        }
    }
    shouldTileImage: true
}
