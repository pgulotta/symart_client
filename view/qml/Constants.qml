import QtQuick 2.12
pragma Singleton

QtObject {
    readonly property string accentColor: "#FF0000"
    readonly property string primaryColor: "#000000"
    readonly property string backColor: "#545454"
    readonly property string foreColor: "#373737"
    readonly property string disabledTextColor: "#CCCCCC"
    readonly property string mainPageBackColor: "#101010"
    readonly property string textColor: "#3399ff" //"#33ffff"
    readonly property string hooverTextColor: "Yellow"
    readonly property string linkTextColor: "Gold"

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

    readonly property string retrievingMessage: "  Working ..."

    readonly property int animationDuration: 1100
    readonly property int mediumTimerInterval: 1000
    readonly property int shortTimerInterval: 1000
    readonly property int mapFlickDeceleration: 3000
    readonly property int mapZoomLevel: 12
    readonly property int enlargedMapZoomLevel: 13
    readonly property int chartMaxDaysDuration: 7
    readonly property int refreshInterval: 60000
}
