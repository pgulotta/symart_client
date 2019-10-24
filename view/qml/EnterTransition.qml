import QtQuick 2.12
import com.twentysixapps.constants 1.0

Transition {
    property alias itemHeight: heightId.to
    property alias itemWidth: widthId.to
    NumberAnimation {
        id: heightId
        properties: "height"
        from: 0.0
        to: 500
        duration: Constants.shortAnimationDuration
    }
    NumberAnimation {
        id: widthId
        properties: "width"
        from: 0.0
        to: 250
        duration: Constants.shortAnimationDuration
    }
    NumberAnimation {
        property: "opacity"
        from: 0.0
        to: 1.0
        easing.type: Easing.OutCubic
        duration: Constants.animationDuration
    }
}
