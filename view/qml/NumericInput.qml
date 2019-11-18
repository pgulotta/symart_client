import QtQuick 2.13
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import com.twentysixapps.constants 1.0

TextField {
    property bool canEdit: false
    property string defaultText: ""
    implicitWidth: 20
    implicitHeight: 40
    focus: true
    color: canEdit ? Material.foreground : Constants.disabledTextColor
    selectedTextColor: Constants.linkTextColor
    horizontalAlignment: Text.AlignHCenter
    font.pointSize: smallFontPointSize
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
    onTextEdited: {
        if (canEdit) {
            var input = parseInt(text)
            text = (isNaN(input) || input <= 0) ? defaultText : input
        }
    }
}
