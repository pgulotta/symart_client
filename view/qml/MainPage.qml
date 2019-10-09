import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Window 2.13
import QtQuick.Controls.Material 2.3
import com.twentysixapps.constants 1.0

ApplicationWindow {
    id: rootId

    readonly property bool isMobileDevice: Qt.platform.os === "android"
                                           || Qt.platform.os === "ios"
    property int windowHeight: isMobileDevice ? Screen.desktopAvailableHeight : Screen.desktopAvailableHeight * .68
    property int windowWidth: isMobileDevice ? Screen.width : Screen.width * .4
    property bool isPortraitMode: windowHeight > windowWidth
    property bool isWideWidth: windowHeight < windowWidth

    readonly property int smallFontPointSize: 14
    readonly property int mediumFontPointSize: 18
    readonly property int smallPadding: 4
    readonly property int mediumPadding: 8
    readonly property int rectRadius: 10
    readonly property int borderWidth: 1

    property int pageHeight

    objectName: "MainPage"
    visible: true
    width: windowWidth
    height: windowHeight

    /// title: Controller.applicationTitle()
    Material.background: "#101010"
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
            font.pointSize: mediumFontPointSize
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
