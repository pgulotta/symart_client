import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Window 2.13
import QtQuick.Controls.Material 2.3
import com.twentysixapps.symart.constants 1.0

ApplicationWindow {
    id: rootId

    readonly property bool isMobileDevice: Qt.platform.os === "android"
                                           || Qt.platform.os === "ios"
    property int windowHeight: isMobileDevice ? Screen.desktopAvailableHeight : Screen.desktopAvailableHeight * .9
    property int windowWidth: isMobileDevice ? Screen.width : Screen.width * .3
    property bool isPortraitMode: windowHeight > windowWidth
    property bool isWideWidth: windowHeight < windowWidth

    readonly property int verySmallFontPointSize: 12
    readonly property int smallFontPointSize: 14
    readonly property int mediumFontPointSize: 16
    readonly property int mediumLargeFontPointSize: 18
    readonly property int largeFontPointSize: 24
    readonly property int exlargeFontPointSize: 30
    readonly property int smallPadding: 2
    readonly property int mediumPadding: 8
    readonly property int mediumLargePadding: 12
    readonly property int largePadding: 20
    readonly property int exlargePadding: 36
    readonly property int hugePadding: 60
    readonly property int toolbarPadding: 10
    readonly property int thinRectRadius: 2
    readonly property int rectRadius: 10
    readonly property int borderWidth: 4

    property int pageHeight

    objectName: "MainPage"
    visible: true
    width: windowWidth
    height: windowHeight

    /// title: Controller.applicationTitle()
     Material.background: Constants.mainPageBackColor
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
            text: stackViewId.depth > 1 ? Constants.leftTriangleChar : Constants.menuChar
            font.pointSize: mediumLargeFontPointSize
            onClicked: {
                if (stackViewId.depth > 1) {
                    stackViewId.pop()
                }
            }
        }

        Label {
            text: "SymArt"
            anchors.centerIn: parent
        }
    }

    StackView {
        id: stackViewId
        anchors.fill: parent
        initialItem: "qrc:/view/qml/SwitchboardPage.qml"
        Rectangle {
            Keys.onBackPressed: {
                event.accepted = true
                Qt.quit()
            }
        }
    }
}
