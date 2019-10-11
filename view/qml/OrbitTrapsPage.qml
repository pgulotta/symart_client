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
            spacing: 0
            leftPadding: largePadding
            DimensionControl {}

            Tumbler {
                id: symmetrytumblerId
                model: 60
                delegate: TumblerDelegate {
                    text: modelData
                }
            }
        }
    }

    imageSource: "qrc:/view/images/orbit-traps.png"
}
