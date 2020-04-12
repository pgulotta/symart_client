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

    Flickable {
        clip: false
        anchors.fill: parent
        contentHeight: windowHeight * 1.5
        Label {
            id: aboutTitleId
            text: qsTr("Settings")
            color: Constants.linkTextColor
            scale: 1.25
            anchors.left: parent.left
            anchors.leftMargin: largePadding
            anchors.top: parent.top
            anchors.topMargin: largePadding
            anchors.bottomMargin: exlargePadding
        }

        Grid {
            id: aboutGridId
            width: parent.width * 0.80
            anchors.top: aboutDescriptionId.bottom
            anchors.topMargin: largePadding
            anchors.left: parent.left
            anchors.leftMargin: exlargePadding
            anchors.right: parent.right
            anchors.rightMargin: largePadding
            columns: 1
            HtmlText {
                text: " "
            }

            HtmlText {
                width: aboutGridId.width
                endBlankLine: true
                text: "<a href=\"" + qtLink + "\">Qt Company</a>"
                      + " software is used to develop " + Controller.applicationTitle(
                          ) + ". It is developed under the Qt Company GNU Lesser General Public License v3 (“LGPLv3”) open-source license."
                websiteLink: qtLink
            }
            HtmlText {
                text: qsTr("Privacy")
                isUpperCase: true
                isTitle: true
            }
            HtmlText {
                width: aboutGridId.width
                endBlankLine: true
                text: Controller.applicationTitle(
                          ) + " does not request or share any personal information with third parties. It does not request or know the user's physical location."
            }
            HtmlText {
                text: qsTr("Feedback")
                isUpperCase: true
                isTitle: true
            }
            HtmlText {
                width: aboutGridId.width
                endBlankLine: true
                text: "Send " + "<a href=\"" + emailLink + "\">email</a>"
                websiteLink: emailLink
            }
            HtmlText {
                text: qsTr("Disclaimer")
                isUpperCase: true
                isTitle: true
            }
            HtmlText {
                width: aboutGridId.width
                endBlankLine: true
                text: Controller.applicationTitle(
                          ) + " provided by 26Apps is supplied 'AS IS' without any warranties and support. "
            }
        }
    }
}
