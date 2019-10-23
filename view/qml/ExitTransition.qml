import QtQuick 2.12
import com.twentysixapps.constants 1.0

Transition {
    NumberAnimation {
        properties: "height"
        to: 0.0
        duration: Constants.shortAnimationDuration
    }
    NumberAnimation {
        properties: "width"
        to: 0.0
        duration: Constants.shortAnimationDuration
    }
    NumberAnimation {
        property: "opacity"
        from: 1.0
        to: 0.0
        easing.type: Easing.OutCubic
        duration: Constants.animationDuration
    }
}
