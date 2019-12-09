import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Window 2.13

import com.twentysixapps.constants 1.0

ApplicationWindow {
    id: rootId

    readonly property bool isMobileDevice: Qt.platform.os === "android"
                                           || Qt.platform.os === "ios"
    property int windowHeight: isMobileDevice ? Screen.desktopAvailableHeight : Screen.desktopAvailableHeight * 0.8
    property int windowWidth: isMobileDevice ? Screen.width : Screen.width * .5
    property bool isPortraitMode: windowHeight > windowWidth
    property bool isWideWidth: windowHeight < windowWidth

    readonly property int maxImageDimension: 2048
    readonly property int imageControlsWidth: 180
    readonly property int smallFontPointSize: 12
    readonly property int mediumFontPointSize: 18
    readonly property int smallPadding: 4
    readonly property int mediumPadding: 8
    readonly property int largePadding: 16
    readonly property int exlargePadding: 32
    readonly property int rectRadius: 10
    readonly property int borderWidth: 1
    readonly property int invalidValue: -1

    property int pageHeight

    objectName: "MainPage"
    visible: true
    width: windowWidth
    height: windowHeight

    title: Controller.applicationTitle()
    Component.onCompleted: {
        pageHeight = windowHeight - headerToolBarId.height
        if (!isMobileDevice) {
            x = Screen.width / 2 - width / 2
            y = Screen.height / 2 - height / 2
        }
        var nowDate = new Date(Date.now())
    }

    onClosing: {
        var item = stackViewId.pop()
        while (item !== null) {
            item = stackViewId.pop()
        }
    }

    onWidthChanged: {
        windowWidth = width
        isPortraitMode = windowHeight > windowWidth
    }
    onHeightChanged: {
        windowHeight = height
        pageHeight = windowHeight - headerToolBarId.height
        isPortraitMode = windowHeight > windowWidth
    }

    header: ToolBar {
        id: headerToolBarId
        contentHeight: toolButtonId.implicitHeight

        ToolButton {
            id: toolButtonId
            text: Constants.backChar
            font.pointSize: mediumFontPointSize
            onClicked: popSource()
        }

        Label {
            text: Controller.applicationTitle()
            anchors.centerIn: parent
        }
    }
    contentData: StackView {
        id: stackViewId
        anchors.fill: parent
        initialItem: "qrc:/view/qml/SwitchboardPage.qml"
        Rectangle {
            Keys.onBackPressed: {
                event.accepted = true
                Qt.quit()
            }
        }
        pushEnter: Transition {
            PropertyAnimation {
                property: "y"
                easing.type: Easing.InOutQuad
                from: height * 0.65
                to: 0
                duration: Constants.animationDuration
            }
            PropertyAnimation {
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: Constants.animationDuration
            }
        }
        pushExit: Transition {
            PauseAnimation {
                duration: Constants.shortAnimationDuration
            }
        }
        popEnter: Transition {
            PauseAnimation {
                duration: Constants.shortAnimationDuration
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "y"
                easing.type: Easing.InOutQuad
                from: 0
                to: height * 0.65
                duration: Constants.animationDuration
            }
            SequentialAnimation {
                PauseAnimation {
                    duration: Constants.shortAnimationDuration
                }
                PropertyAnimation {
                    property: "opacity"
                    from: 1.0
                    to: 0.0
                    duration: Constants.animationDuration
                }
            }
        }
        replaceEnter: pushEnter
        replaceExit: pushExit
    }

    Dialog {
        id: messageDialogId
        property alias messageDescription: textId.text
        x: largePadding
        y: largePadding
        modal: true
        focus: true
        implicitWidth: 300
        parent: ApplicationWindow.overlay
        title: qsTr("Alert ...")
        standardButtons: Dialog.Ok
        contentItem: Label {
            id: textId
            wrapMode: Label.Wrap
            anchors.centerIn: parent
            width: messageDialogId.width * 0.9
        }
    }

    function pushSource(source) {
        return stackViewId.push(source)
    }

    function popSource() {
        if (stackViewId.depth > 1) {
            stackViewId.pop()
        } else
            Qt.quit()
    }

    function reportMessage(messageDescription) {
        if (messageDescription === undefined || messageDescription === "")
            return
        messageDialogId.messageDescription = messageDescription
        messageDialogId.open()
    }
}
