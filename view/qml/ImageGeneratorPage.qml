import QtQuick 2.12
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

Page {
    objectName: "ImageGeneratorPage"
    id: imageGeneratorPageId

    property alias controlsView: controlsViewId.contentData
    property alias imageSource: imageId.source
    property bool shouldTileImage: true

    header: Label {
        text: title
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Label.WordWrap
        padding: largePadding
    }

    Flow {
        anchors.fill: parent
        anchors.leftMargin: mediumPadding
        spacing: mediumPadding
        ScrollView {
            id: controlsViewId
            width: 200
            height: parent.height
            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AsNeeded
            }
        }
        Pane {
            id: imageViewId
            width: parent.width - controlsViewId.width - 50
            height: parent.height
            contentData: Image {
                id: imageId
                fillMode: shouldTileImage ? Image.Tile : Image.PreserveAspectFit
                anchors.fill: shouldTileImage ? parent : undefined
                anchors.centerIn: parent
                smooth: false
            }
        }
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
