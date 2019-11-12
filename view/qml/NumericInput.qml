import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import com.twentysixapps.constants 1.0

TextInput {
    property bool canEdit: false

    width: 16
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
    inputMask: canEdit ? "9" : ""
    readOnly: canEdit ? false : true
}
