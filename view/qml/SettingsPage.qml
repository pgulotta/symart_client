import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.3
import com.twentysixapps.constants 1.0

Page {
    id: infoPageId
    objectName: "SettingsPage"
    property string pageTitle
    title: pageTitle

    Material.background: Constants.accentColor

    TumblerSelector {
        id: scheduleSelectorId
        title: qsTr("Auto-generate Wallpaper")
        selectorModel:wallpaperScheduleModelId
        width:250
        height: 200
        anchors.centerIn: parent
        onSelectorModelChanged: selectorIndex = 0
    }

    ListModel{
    id: wallpaperScheduleModelId
    ListElement {
        name: qsTr("None")
    }
    ListElement {
        name: qsTr("Hourly")
    }
    ListElement {
        name: qsTr("Daily")
    }
    }
}
