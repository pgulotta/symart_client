import QtQuick 2.12
import com.twentysixapps.constants 1.0

Transition {
    NumberAnimation {
        property: "scale"
        from: 0.0
        to: 1.0
        easing.type: Easing.OutCubic
        duration: Constants.animationDuration
    }
    NumberAnimation {
        property: "opacity"
        from: 0.0
        to: 1.0
        easing.type: Easing.OutCubic
        duration: Constants.animationDuration
    }
}
