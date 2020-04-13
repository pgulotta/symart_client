import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import com.twentysixapps.constants 1.0

Page {
    id: appMorePageId
    objectName: "AppMorePage"
    property string pageTitle
    title: pageTitle

    Keys.onBackPressed: {
        event.accepted = false
        popSource()
    }

    SwipeView {
        id: view
        currentIndex: pageIndicator.currentIndex
        anchors.fill: parent
        objectName: "AppMorePage"
        property string pageTitle

        SettingsPage {
            id: settingsPageId

            onVisibleChanged: {

                if (visible) {
                    category: "Wallaper"
                    settingsPageId.wallpaperSelection = value(settingsId.wallpaperSelection, 0)
                } else {
                    settingsId.setValue("SelectionIndex", settingsPageId.wallpaperSelection)
                    switch (wallpaperSelection) {
                    case 0:
                        Controller.cancelWallpaperSchedule()
                        break
                    case 1:
                        Controller.scheduleHourlyGenerateWallpaper()
                        break
                    case 2:
                        Controller.scheduleDailyGenerateWallpaper()
                        break
                    }
                }
            }
            Settings {
                id: settingsId
                property alias wallpaperSelection: settingsPageId.wallpaperSelection
            }
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
