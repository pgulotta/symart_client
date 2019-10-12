import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import com.twentysixapps.constants 1.0

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

    Row {
        anchors.fill: parent
        anchors.leftMargin: mediumPadding
        spacing: 0
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
            width: parent.width - controlsViewId.width - exlargePadding
            height: parent.height
            contentData: Rectangle {
                id: rectangleId
                width: parent.width
                height: parent.height
                color: Constants.primaryColor
                Image {
                    id: imageId
                    width: shouldTileImage ? rectangleId.width - smallPadding : sourceSize.width
                    height: shouldTileImage ? rectangleId.height - smallPadding : sourceSize.height
                    fillMode: shouldTileImage ? Image.Tile : Image.PreserveAspectFit
                    anchors.centerIn: parent
                    smooth: false
                }
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
