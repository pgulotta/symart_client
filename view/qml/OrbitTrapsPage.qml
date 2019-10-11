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
            spacing: 0
            RowLayout {
                spacing: 0
                Label {
                    id: dimensionLabelId
                    text: "Dimension"
                    wrapMode: Label.WordWrap
                }
                TextField {
                    text: sizeSliderId.value
                    wrapMode: Label.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    Layout.leftMargin: mediumPadding
                    onTextChanged: {
                        var v = parseInt(text)
                        sizeSliderId.value = v + (v % 2)
                    }
                }
            }
            Slider {
                id: sizeSliderId
                from: 2
                to: 1000
                value: 256
                live: false
                stepSize: 2
                snapMode: Slider.SnapAlways
                Layout.leftMargin: mediumPadding
                Layout.rightMargin: mediumPadding
                implicitWidth: parent.width - 2 * mediumPadding
            }

            Item {
                height: exlargePadding
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
