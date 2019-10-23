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
    property string pageTitle
    property string pageDescription
    property int footer1Spacing: imageGeneratorPageId.width * 0.10
    property int footer2Spacing: imageGeneratorPageId.width * 0.01
    property bool isImageGenerated: false
    property bool isImageModified: false

    Connections {
        target: Controller
        onMessageGenerated: reportMessage(messageDescription)
    }

    Component.onCompleted: headerToolBarId.forceActiveFocus()

    header: Column {
        topPadding: largePadding
        spacing: 0
        Label {
            id: headerToolBarId
            text: pageTitle
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Label.AlignHCenter
            font.pointSize: smallFontPointSize
            wrapMode: Label.WordWrap
        }
        Label {
            id: descriptionId
            text: pageDescription
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Label.AlignHCenter
            wrapMode: Label.WordWrap
            opacity: 0.0
            OpacityAnimator on opacity {
                id: visibilityEnabledId
                from: 0.0
                to: 1.0
                running: false
                duration: Constants.animationDuration
            }
            OpacityAnimator on opacity {
                id: visibilityDisabledId
                from: 1.0
                to: 0.0
                running: false
                duration: Constants.animationDuration
            }
            onTextChanged: imageSource === "" ? visibilityDisabledId.start(
                                                    ) : visibilityEnabledId.start()
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
                            isImageModified = false
                            pageDescription = ""
                        } else if (imageId.status === Image.Ready) {
                            isImageGenerated = true
                            pageDescription = selectionDescription()
                            imageViewId.forceActiveFocus()
                        }
                    }
                }
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
                    id: drawButtonId
                    text: qsTr("Draw")
                    onClicked: {
                        imageSource = ""
                        drawImage()
                    }
                }
                ToolButton {
                    text: qsTr("Save")
                    enabled: isImageGenerated
                    onClicked: {
                        if (imageSource == "")
                            return
                        fileDialogId.open()
                    }
                    FileDialog {
                        id: fileDialogId
                        modality: Qt.ApplicationModal
                        title: "Please choose a file name"
                        nameFilters: ["PNG Files (*.png)", "BMP Files (*.bmp)", "JPG Files (*.jpg)", "PBM Files (*.pbm)", "PGM Files (*.pgm)", "PPM Files (*.ppm)", "XBM Files (*.xbm)", "XPM Files (*.xpm)", "All Files (*.*)"]
                        folder: StandardPaths.writableLocation(
                                    StandardPaths.PicturesLocation)
                        defaultSuffix: "png"
                        file: "image.png"
                        fileMode: FileDialog.SaveFile
                        onAccepted: Controller.saveCurrentImage(file)
                    }
                }
                ToolButton {
                    text: qsTr("Restore")
                    enabled: isImageModified
                    onClicked: {
                        if (imageSource === "")
                            return
                        isImageModified = false
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
                    id: randomizeButtonId
                    text: qsTr("Randomize")
                    onClicked: {
                        if (imageSource == "")
                            return
                        randomizeDialogId.openDialog()
                    }
                    RandomizeDialog {
                        id: randomizeDialogId
                        x: exlargePadding
                        y: -height + randomizeButtonId.height / 2
                        onAccepted: {
                            isImageModified = true
                            imageSource = Controller.getRandomizeQuery(
                                        randomizeDialogId.xSelection,
                                        randomizeDialogId.ySelection)
                        }
                    }
                }
                ToolButton {
                    id: hyperbolicButtonId
                    text: qsTr("Hyperbolic")
                    onClicked: {
                        if (imageSource == "")
                            return
                        hyperbolicDialogId.openDialog()
                    }
                    HyperbolicDialog {
                        id: hyperbolicDialogId
                        x: exlargePadding
                        y: -height + hyperbolicButtonId.height / 2
                        onAccepted: {
                            isImageModified = true
                            shouldTileImage = false
                            imageSource = Controller.getHyperbolicImageQuery(
                                        hyperbolicDialogId.sizeSelection,
                                        hyperbolicDialogId.projectionSelection)
                        }
                    }
                }
                ToolButton {
                    text: qsTr("Hexagonal Stretch ")
                    onClicked: {
                        if (imageSource == "")
                            return
                        isImageModified = true
                        imageSource = Controller.getHexagonalStretchImageQuery()
                    }
                }
            }
        }
    }

}
