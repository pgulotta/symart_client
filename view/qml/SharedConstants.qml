pragma Singleton

import QtQuick 2.12

QtObject {
    readonly property string accentColor: "#00FF00"
    readonly property string primaryColor: "#000000"
    readonly property string foreColor: "3399FF"
    readonly property string backColor: "#141414"

    readonly property string selectedColor: "#292929"
    readonly property string disabledTextColor: "#a9d4ff"
    readonly property string linkTextColor: "#FFFF00"

    readonly property string leftTriangleChar: "\u25C0"
    readonly property string menuChar: "\u2630"

    readonly property string questionChar: "\u003f"
    readonly property string backChar: "\u2190"
    readonly property string downChar: "\u21e3"
    readonly property string upChar: "\u21e1"
    readonly property string leftChar: "\u21e0"
    readonly property string rightChar: "\u21e2"
    readonly property string checkChar: "\u2713"
    readonly property string circleChar: "\u26aa"
    readonly property string refreshChar: "\u21bb"
    readonly property string starChar: "\u2605"
    readonly property string upDownChar: "\u21d5"
    readonly property string plusSignChar: "\u002b"
    readonly property string minusSignChar: "\u002d"
    readonly property string plusMinusSignChar: "\u00b1"
    readonly property string horizontalEllipsisChar: "\u2026"

    readonly property string workingMessage: "  Working ..."

    readonly property int shortAnimationDuration: 250
    readonly property int animationDuration: 1100
}
