import QtQuick 2.12
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

ImageGeneratorPage {
    objectName: "OrbitTrapsPage"
    id: orbitTrapsPageId
    controlsView: RowLayout {
        id: controlsViewId
        anchors.centerIn: parent
        ColumnLayout {
            Slider {
                id: sizeSliderId
                from: 0
                to: 1
                value: 0.9
            }
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
