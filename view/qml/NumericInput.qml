import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

TextField {
    readonly property string stateEdit: "edit"
    readonly property string stateNoEdit: "noEdit"
    readonly property string stateHide: "hide"

    width: 16
    color: Material.foreground
    horizontalAlignment: Text.AlignHCenter
    font.pointSize: smallFontPointSize
    anchors.bottom: parent.bottom
    anchors.bottomMargin: mediumPadding
    //  inputMask: state === stateEdit ? "9" : ""
    visible: state !== stateHide ? true : false
    enabled: state !== stateNoEdit ? true : false
}
