import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
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
    property bool isImageTileable: true
    property bool canAugmentImage: true

    Connections {
        target: Controller
        onMessageGenerated: {
            pageDescription = ""
            reportMessage(messageDescription)
        }
        onImageGenerated: imageSource = "image://generatedImage"
    }

    Component.onCompleted: headerToolBarId.forceActiveFocus()

    header: Column {
        id: pageHeadingId
        topPadding: mediumPadding
        spacing: smallPadding
        Label {
            id: headerToolBarId
            text: pageTitle
            scale: 1.15
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
        anchors.leftMargin: smallPadding
        spacing: 0
        ScrollView {
            Layout.fillWidth: true
            clip: true
            height: imageViewId.height
            rightPadding: mediumPadding
            Pane {
                id: controlsViewId
            }
        }
        Pane {
            id: imageViewId
            width: parent.width - controlsViewId.width - mediumPadding
            height: parent.height
            z: -1
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
        ColumnLayout {
            id: footerColumnId
            anchors.centerIn: parent
            Row {
                spacing: footer1Spacing
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: false
                ToolButton {
                    id: drawButtonId
                    text: qsTr("Generate")
                    onClicked: {
                        imageSource = ""
                        pageDescription = qsTr("Working . . .")
                        drawImage()
                    }
                }
                ToolButton {
                    id: saveButtonId
                    text: qsTr("Save")
                    enabled: isImageGenerated
                    onClicked: {
                        if (imageSource == "")
                            return
                        extensionDialogId.open()
                    }
                    ImageFileExtensionDialog {
                        id: extensionDialogId

                        //x: Math.min (windowWidth - width,saveButtonId.width / 2)
                        y: saveButtonId.height / 2 - height
                        onAccepted: Controller.saveCurrentImage(
                                        pageTitle,
                                        extensionDialogId.selectedExtension())
                    }
                }
                ToolButton {
                    text: qsTr("Restore")
                    enabled: isImageModified
                    onClicked: {
                        if (imageSource === "")
                            return
                        isImageModified = false
                        imageSource = ""
                        Controller.getLastGenerateImage()
                    }
                }
                Switch {
                    id: tileSwitchId
                    text: qsTr("Tile")
                    visible: isImageTileable
                    onClicked: {
                        if (imageSource === "")
                            return
                        shouldTileImage = checked
                    }
                }
            }
            Row {
                id: augmentImageRowId
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: false
                spacing: footer2Spacing
                visible: false
                scale: 0
                opacity: 0

                states: State {
                    when: isImageGenerated & canAugmentImage
                    PropertyChanges {
                        target: augmentImageRowId
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
                    text: qsTr("Apply to Generated Image:  ")
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
                        y: randomizeButtonId.height / 2 - height
                        onAccepted: {
                            isImageModified = true
                            imageSource = ""
                            Controller.generateRandomizeImage(
                                        randomizeDialogId.xSelection,
                                        randomizeDialogId.ySelection)
                        }
                    }
                }
                ToolButton {
                    id: hyperbolicButtonId
                    text: qsTr("Hyperbolic Image")
                    onClicked: {
                        if (imageSource == "")
                            return
                        hyperbolicDialogId.openDialog()
                    }
                    HyperbolicDialog {
                        id: hyperbolicDialogId
                        y: hyperbolicButtonId.height / 2 - height
                        onAccepted: {
                            isImageModified = true
                            shouldTileImage = false
                            imageSource = ""
                            Controller.generateHyperbolicImage(
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
                        imageSource = ""
                        Controller.generateHexagonalStretchImage()
                    }
                }
            }
        }
    }
}
