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

    Component.onCompleted: {
        var insertIndex = 0
        if (isAndroidDevice) {
            settingsLoaderId.sourceComponent = settingsComponentId
            swipeViewId.insertItem(insertIndex++, settingsLoaderId.item)
        }
        infoPageLoaderId.sourceComponent = infoPageComponentId
        swipeViewId.insertItem(insertIndex, infoPageLoaderId.item)
        pageIndicatorId.currentIndex = 0
    }
    Keys.onBackPressed: {
        event.accepted = false
        popSource()
    }

    SwipeView {
        id: swipeViewId
        anchors.fill: parent
        objectName: "AppMorePage"
        property string pageTitle
    }
    PageIndicator {
        id: pageIndicatorId
        spacing: exlargePadding
        interactive: true
        count: swipeViewId.count
        currentIndex: swipeViewId.currentIndex
        anchors.bottomMargin: mediumPadding
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        delegate: Rectangle {
            id: pageIndicatorRectId
            visible: pageIndicatorId.count > 1
            implicitWidth: exlargePadding
            implicitHeight: largePadding
            radius: rectRadius
            color: Constants.linkTextColor
            opacity: index === swipeViewId.currentIndex ? 0.95 : pressed ? 0.7 : 0.45
            TapHandler {
                onTapped: {
                    console.log("pageIndicatorId.currentIndex" + pageIndicatorId.currentIndex)
                    pageIndicatorId.currentIndex = (pageIndicatorId.currentIndex === 0) ? 1 : 0
                    swipeViewId.currentIndex = pageIndicatorId.currentIndex
                    console.log("pageIndicator.currentIndex" + pageIndicatorId.currentIndex)
                    console.log("swipeViewId.currentIndex" + swipeViewId.currentIndex)
                }
            }
            Behavior on opacity {
                OpacityAnimator {
                    duration: Constants.shortAnimationDuration
                }
            }
        }
    }

    Loader {
        id: infoPageLoaderId
    }

    Component {
        id: infoPageComponentId
        InfoPage {
            title: pageTitle
        }
    }

    Loader {
        id: settingsLoaderId
    }
    Component {
        id: settingsComponentId

        SettingsPage {
            id: settingsPageId

            onVisibleChanged: {

                if (visible) {
                    category: "Wallaper"
                    settingsPageId.wallpaperSelection = value(
                                settingsId.wallpaperSelection, 0)
                } else {
                    settingsId.setValue("SelectionIndex",
                                        settingsPageId.wallpaperSelection)
                    switch (wallpaperSelection) {
                    case 0:
                        Controller.cancelWallpaperSchedule()
                        break
                    case 1:
                        Controller.scheduleFifteenMinutesGenerateWallpaper()
                        break
                    case 2:
                        Controller.scheduleHourlyGenerateWallpaper()
                        break
                    case 3:
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
    }
}
