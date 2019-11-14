import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import com.twentysixapps.constants 1.0

TextField {
    property bool canEdit: false
    property string defaultText: ""
    width: 20
    focus: true

    color: canEdit ? Material.foreground : Constants.disabledTextColor
    selectedTextColor: Constants.linkTextColor
    horizontalAlignment: Text.AlignHCenter
    font.pointSize: smallFontPointSize
    anchors.bottom: parent.bottom
    anchors.bottomMargin: mediumPadding
    maximumLength: 2
    overwriteMode: true
    selectByMouse: true
    visible: text !== ""
    enabled: canEdit ? true : false
    inputMethodHints: Qt.ImhDigitsOnly

    onActiveFocusChanged: {
        if (activeFocus) {
            selectAll()
        }
    }
    onTextChanged: {
        if (canEdit) {
            var input = parseInt(text)
            text = (isNaN(input)) ? defaultText : input
        }
    }
}
