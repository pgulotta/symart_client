import QtQuick 2.12
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Page {
    objectName: "ImageGeneratorPage"
    id: imageGeneratorPageId

    header: Label {
        text: title
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Label.WordWrap
        padding: largePadding
    }

    footer: ToolBar {
        id: footerToolBarId
        RowLayout {
            anchors.centerIn: parent

            ToolButton {
                text: qsTr("Draw")
                font.capitalization: Font.MixedCase
                //onClicked:
            }

            Item {
                width: exlargePadding
            }

            Switch {
                text: qsTr("Tile")
                //onClicked:
            }
        }
    }
}
