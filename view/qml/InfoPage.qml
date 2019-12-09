import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.3

Page {
    id: infoPageId
    objectName: "InfoPage"
    property string pageTitle
    title: pageTitle

    readonly property string qtLink: "http://www.qt.io/"
    readonly property string osmLink: "https://www.openstreetmap.org/copyright"
    readonly property string nominatimLink: "https://nominatim.openstreetmap.org"
    readonly property string openClipArtLink: "https://openclipart.org/"
    readonly property string dataUsaLink: "https://datausa.io/"
    readonly property string googleCivicInfoLink: "https://developers.google.com/civic-information/"
    readonly property string openDataLink: CityMetaData.openDataLink
    readonly property string openDataDescription: CityMetaData.openDataDescription
    readonly property string appWebsiteLink: CityMetaData.appWebsiteLink
    readonly property string emailLink: "mailto:pgulotta@gmail.com"

    Material.background: Constants.backColor

    Flickable {
        clip: false
        anchors.fill: parent
        contentHeight: windowHeight * 1.5
        Label {
            id: aboutTitleId
            text: qsTr("About")
            font.pointSize: mediumLargeFontPointSize
            color: Constants.foreColor
            width: parent.width * 0.80
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
                      ) + " from 26Apps lets you explore the city's financial stability, economic development, public safety and high performing government "
                  + " by accessing a wealth of open data resources."

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
                text: "Feedback"
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
                width: aboutGridId.width
                endBlankLine: true
                text: "Visit " + "<a href=\"" + appWebsiteLink + "\">website</a>"
                websiteLink: appWebsiteLink
            }
            HtmlText {
                text: "Privacy"
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
                text: "Attribution"
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
                width: aboutGridId.width
                endBlankLine: true
                text: "<a href=\"" + openDataLink + "\">Open Data</a>" + openDataDescription
                websiteLink: openDataLink
            }
            HtmlText {
                width: aboutGridId.width
                endBlankLine: true
                text: "<a href=\"" + osmLink + "\">OpenStreetMap</a>"
                      + "  project provides the map data in " + Controller.applicationTitle(
                          ) + ".  The data is available under the Open Database Licence."
                websiteLink: osmLink
            }
            HtmlText {
                width: aboutGridId.width
                endBlankLine: true
                text: "<a href=\"" + openClipArtLink + "\">Openclipart</a>"
                      + "  project provides much of the artwork found in "
                      + Controller.applicationTitle(
                          ) + ".  Images are available under the Creative Commons Zero 1.0 Public Domain License."
                websiteLink: openClipArtLink
            }
            HtmlText {
                width: aboutGridId.width
                endBlankLine: true
                text: "<a href=\"" + dataUsaLink + "\">Data USA</a>"
                      + " is a free platform that allows users to collect, analyze, and visualize data shared from different sources"
                      + " including US departments as well as educational institutions."
                websiteLink: dataUsaLink
            }
            HtmlText {
                width: aboutGridId.width
                endBlankLine: true
                text: "<a href=\"" + googleCivicInfoLink + "\">Google Civic Information API</a>"
                      + ", based upon the specified address, provides the corresponding district at each level of government and the names"
                      + " and social media properties for the elected officials in those districts."
                websiteLink: googleCivicInfoLink
            }
            HtmlText {
                width: aboutGridId.width
                endBlankLine: true
                text: "<a href=\"" + nominatimLink + "\">Nominatim OpenStreetMap search engine</a>"
                      + " provides the geo-location for the specfied address."
                websiteLink: nominatimLink
            }
            HtmlText {
                text: "Disclaimer"
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
