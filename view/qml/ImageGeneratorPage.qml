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
    property alias imageStatus: imageId.status
    property alias imageVisible: imageId.visible
    property alias shouldTileImage: tileSwitchId.checked
    property alias headerTitle: headerToolBarId.text
    property string pageTitle
    property int footer1Spacing: imageGeneratorPageId.width * 0.10
    property int footer2Spacing: imageGeneratorPageId.width * 0.01
    property bool isImageGenerated: false

    Connections {
        target: Controller
        onMessageGenerated: reportMessage(messageDescription)
    }

    Component.onCompleted: headerToolBarId.forceActiveFocus()

    header: Label {
        id: headerToolBarId
        text: pageTitle
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Label.WordWrap
        padding: largePadding
        OpacityAnimator on opacity {
            from: 0
            to: 1
            duration: 2000
        }
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
                    fillMode: shouldTileImage ? Image.Tile : Image.Pad
                    anchors.centerIn: parent
                    smooth: false
                    cache: false
                    asynchronous: true
                    source: ""
                    scale: 0
                    opacity: 0

                    states: State {
                        when: imageStatus === Image.Ready
                        PropertyChanges {
                            target: imageId
                            scale: 1
                            opacity: 1
                        }
                    }
                    transitions: Transition {
                        PropertyAction {
                            property: "imageStatus"
                        }
                        NumberAnimation {
                            properties: "opacity,scale"
                            duration: Constants.animationDuration
                            easing.type: Easing.OutCirc
                        }
                    }
                    onStatusChanged: {
                        if (imageId.status === Image.Error) {
                            isImageGenerated = false
                        } else if (imageId.status === Image.Ready) {
                            isImageGenerated = true
                            headerTitle = pageTitle + "\nwhere " + selectionDescription()
                        }
                    }
                }
            }
            RandomizeDialog {
                id: randomizeDialogId
                onAccepted: {
                    imageSource = Controller.getRandomizeQuery(
                                randomizeDialogId.xSelection,
                                randomizeDialogId.ySelection)
                }
            }
            HyperbolicDialog {
                id: hyperbolicDialogId
                onAccepted: {
                    shouldTileImage = false
                    imageSource = Controller.getHyperbolicImageQuery(
                                hyperbolicDialogId.sizeSelection,
                                hyperbolicDialogId.projectionSelection)
                }
            }
            FileDialog {
                id: fileDialogId
                modality: Qt.ApplicationModal
                title: "Please choose a file name"
                nameFilters: ["PNG Files (*.png)", "BMP Files (*.bmp)", "JPG Files (*.jpg)", "PBM Files (*.pbm)", "PGM Files (*.pgm)", "PPM Files (*.ppm)", "XBM Files (*.xbm)", "XPM Files (*.xpm)", "All Files (*.*)"]
                folder: StandardPaths.writableLocation(
                            StandardPaths.PicturesLocation)
                defaultSuffix: "png"
                fileMode: FileDialog.SaveFile
                onAccepted: Controller.saveCurrentImage(file)
            }
        }
    }
    footer: ToolBar {
        id: footerToolBarId
        implicitWidth: parent.width
        Grid {
            id: footerColumnId
            rows: 2
            anchors.centerIn: parent
            Row {
                spacing: footer1Spacing
                Switch {
                    id: tileSwitchId
                    text: qsTr("Tile")
                    onClicked: {
                        if (imageSource == "")
                            return
                        shouldTileImage = checked
                    }
                }
                ToolButton {
                    text: qsTr("Draw")
                    onClicked: {
                        imageSource = ""
                        drawImage()
                    }
                }
                ToolButton {
                    text: qsTr("Save")
                    onClicked: {
                        if (imageSource == "")
                            return
                        fileDialogId.open()
                    }
                }
                ToolButton {
                    text: qsTr("Restore")
                    onClicked: {
                        if (imageSource === "")
                            return
                        imageSource = Controller.getLastGenerateImageQuery()
                    }
                }
            }
            Row {
                id: footerRowTwoId
                spacing: footer2Spacing
                visible: false
                scale: 0
                opacity: 0

                states: State {
                    when: isImageGenerated
                    PropertyChanges {
                        target: footerRowTwoId
                        visible: true
                        scale: 1
                        opacity: 1
                    }
                }
                transitions: Transition {
                    PropertyAction {
                        property: "visible"
                    }
                    NumberAnimation {
                        properties: "opacity,scale"
                        duration: Constants.animationDuration
                        easing.type: Easing.OutExpo
                    }
                }
                Label {
                    text: "Apply to Generated Image:  "
                    anchors.verticalCenter: parent.verticalCenter
                    visible: footer2Spacing > 5
                    scale: 0.8
                }

                ToolButton {
                    text: qsTr("Randomize")
                    onClicked: {
                        if (imageSource == "")
                            return
                        randomizeDialogId.openDialog()
                    }
                }
                ToolButton {
                    text: qsTr("Hyperbolic")
                    onClicked: {
                        if (imageSource == "")
                            return
                        hyperbolicDialogId.openDialog()
                    }
                }
                ToolButton {
                    text: qsTr("Hexagonal Stretch ")
                    onClicked: {
                        if (imageSource == "")
                            return
                        imageSource = Controller.getHexagonalStretchImageQuery()
                    }
                }
            }
        }
    }
}
