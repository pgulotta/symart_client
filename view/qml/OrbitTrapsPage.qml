import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "OrbitTrapsPage"
    id: orbitTrapsPageId

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
    //imageSource: "qrc:/view/images/orbit-traps.png"
    imageSource: "http://localhost:60564/test/?trap"
}
