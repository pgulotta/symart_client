import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import com.twentysixapps.constants 1.0

Page {
    id: appMorePageId
    objectName: "AppMorePage"
    property string pageTitle
    title: pageTitle

    SwipeView {
        id: view
        currentIndex: pageIndicator.currentIndex
        anchors.fill: parent
        objectName: "AppMorePage"
        property string pageTitle

        SettingsPage {
            title: qsTr("Settings")
        }
        InfoPage {
            title: pageTitle
        }
    }
    PageIndicator {
        id: pageIndicator
        interactive: true
        count: view.count
        currentIndex: view.currentIndex
        anchors.bottomMargin: mediumPadding
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
