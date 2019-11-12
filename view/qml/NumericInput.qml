import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import com.twentysixapps.constants 1.0

TextField {
    property bool canEdit: false
    property string defaultText: ""
    width: 16
    focus: true

    color: canEdit ? Material.foreground : Constants.disabledTextColor
    selectedTextColor: Constants.linkTextColor
    horizontalAlignment: Text.AlignHCenter
    font.pointSize: smallFontPointSize
    anchors.bottom: parent.bottom
    anchors.bottomMargin: mediumPadding
    maximumLength: 1
    overwriteMode: true
    selectByMouse: true
    visible: text !== ""
    enabled: canEdit ? true : false
    inputMethodHints: Qt.ImhDigitsOnly

    onTextEdited: {
        if (canEdit) {
            if (text === "0" || text === "") {
                text = defaultText
            }
        }
    }
}
