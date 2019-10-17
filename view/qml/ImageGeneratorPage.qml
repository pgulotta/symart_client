import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import Qt.labs.platform 1.1
import com.twentysixapps.constants 1.0

Page {
    objectName: "ImageGeneratorPage"
    id: imageGeneratorPageId

    property alias controlsView: controlsViewId.contentData
    property alias imageSource: imageId.source
    property alias imageOpacity: imageId.opacity
    property bool shouldTileImage: true

    Connections {
        target: Controller
        onMessageGenerated: reportMessage(messageDescription)
    }

    Component.onCompleted: headerToolBarId.forceActiveFocus()

    onVisibleChanged: {
        imageOpacity = 0
        imageSource = ""
    }
    header: Label {
        id: headerToolBarId
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
                    cache: false
                    asynchronous: true
                    //                    onStatusChanged: {
                    //                        if (imageId.status === Image.Error)
                    //                            console.log('Error')
                    //                        else if (imageId.status === Image.Ready)
                    //                            console.log('Ready')
                    //                        else if (imageId.status === Image.Null)
                    //                            console.log('Null')
                    //                        else if (imageId.status === Image.Loading)
                    //                            console.log('Loading')
                    //                    }
                }
            }
        }
    }
    footer: ToolBar {
        id: footerToolBarId
        RowLayout {
            anchors.centerIn: parent
            spacing: exlargePadding
            Switch {
                text: qsTr("Tile")
                //onClicked:
            }
            ToolButton {
                text: qsTr("Draw")
                font.capitalization: Font.MixedCase
                onClicked: {
                    imageSource = ""
                    drawRequested()
                }
            }
            ToolButton {
                text: qsTr("Save")
                font.capitalization: Font.MixedCase
                onClicked: {
                    fileDialogId.open()
                }
            }
        }
    }

    FileDialog {
        id: fileDialogId
        modality: Qt.ApplicationModal
        title: "Please choose a file name"
        nameFilters: ["PNG Files (*.png)", "BMP Files (*.bmp)", "JPG Files (*.jpg)", "PBM Files (*.pbm)", "PGM Files (*.pgm)", "PPM Files (*.ppm)", "XBM Files (*.xbm)", "XPM Files (*.xpm)", "All Files (*.*)"]
        folder: StandardPaths.writableLocation(StandardPaths.PicturesLocation)
        defaultSuffix: "png"
        fileMode: FileDialog.SaveFile
        onAccepted: Controller.saveCurrentImage(file)
    }
}
