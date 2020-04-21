import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import com.twentysixapps.constants 1.0

ColumnLayout {
    property alias text: textId.text
    property alias pointSize: textId.font.pointSize

    property string websiteLink
    property bool endBlankLine: false
    property bool isTitle: false
    property bool isBold: false
    property bool isUpperCase: false
    property string textColor: Qt.lighter(Constants.accentColor, 1.5)
    property string titleColor: Qt.lighter(Constants.accentColor, 1.75)
    property bool isCentered: false

    width: parent.width
    Text {
        id: textId
        width: parent.width
        Layout.leftMargin: isTitle ? smallPadding : largePadding
        Layout.rightMargin: isTitle ? smallPadding : largePadding
        Layout.fillWidth: isCentered ? false : true
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        wrapMode: Label.Wrap
        font.italic: isTitle
        font.capitalization: isUpperCase ? Font.AllUppercase : Font.MixedCase
        font.bold: isBold
        color: isTitle ? titleColor : textColor
        linkColor: Constants.linkTextColor
        onLinkActivated: {
            if (websiteLink !== undefined && websiteLink !== "")
                Qt.openUrlExternally(websiteLink)
        }
    }

    Item {
        height: mediumPadding
        width: mediumPadding
        visible: endBlankLine
    }
}
