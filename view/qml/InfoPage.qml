import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.3
import com.twentysixapps.constants 1.0

Page {
    id: infoPageId
    objectName: "InfoPage"
    property string pageTitle
    title: pageTitle

    readonly property string emailLink: "mailto:pgulotta@gmail.com"
    readonly property string qtLink: "http://www.qt.io/"
    readonly property string wallpaperGroupLink: "https://en.wikipedia.org/wiki/Wallpaper_group"
    readonly property string symmetryLink: "https://www.mathsisfun.com/geometry/symmetry.html"
    readonly property string probabiltyDistributionsLink: "https://en.wikipedia.org/wiki/Probability_distribution"

    Material.background: Constants.accentColor

    Flickable {
        clip: false
        anchors.fill: parent
        contentHeight: windowHeight * 1.5
        Label {
            id: aboutTitleId
            text: qsTr("About")
            color: Constants.linkTextColor
            scale: 1.25
            anchors.left: parent.left
            anchors.leftMargin: largePadding
            anchors.top: parent.top
            anchors.topMargin: largePadding
            anchors.bottomMargin: exlargePadding
        }
        HtmlText {
            id: aboutDescriptionId
            text: Controller.applicationTitle(
                      ) + " " + Controller.applicationVersion(
                      ) + " from 26Apps lets you create, beautiful, unique, symmetrical images."

            anchors.top: aboutTitleId.bottom
            anchors.left: parent.left
            anchors.leftMargin: exlargePadding
            anchors.right: parent.right
            anchors.rightMargin: largePadding
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
                text: qsTr("Extras")
                isUpperCase: true
                isTitle: true
            }
            HtmlText {
                width: aboutGridId.width
                endBlankLine: true
                text: "<a href=\"" + symmetryLink + "\">Symmetry</a>"
                      + " is the quality of having parts that match each other, especially in a way that is attractive, or similarity of shape or contents"
                websiteLink: symmetryLink
            }
            HtmlText {
                width: aboutGridId.width
                endBlankLine: true
                text: "<a href=\"" + wallpaperGroupLink + "\">A Wallpaper Group </a>"
                      + " is a mathematical classification of a two-dimensional repetitive pattern, based on the symmetries in the pattern."
                websiteLink: wallpaperGroupLink
            }

            HtmlText {
                width: aboutGridId.width
                endBlankLine: true
                text: "<a href=\"" + probabiltyDistributionsLink
                      + "\">A Probability Distribution </a>"
                      + " is a statistical function that describes all the possible values and likelihoods that a random variable can take within a given range."
                websiteLink: probabiltyDistributionsLink
            }
            HtmlText {
                text: qsTr("Attribution")
                isUpperCase: true
                isTitle: true
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
