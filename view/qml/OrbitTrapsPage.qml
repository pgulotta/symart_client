import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "OrbitTrapsPage"
    id: orbitTrapsPageId

    function drawRequested() {
        imageSource = "http://localhost:60564/get/?trap/id123/144/5"
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
                width: dimensionSelectorId.width
                height: width
            }
        }
    }
    shouldTileImage: true
}
