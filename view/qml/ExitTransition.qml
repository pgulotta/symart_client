import QtQuick 2.12
import com.twentysixapps.constants 1.0

Transition {
    NumberAnimation {
        property: "scale"
        from: 1.0
        to: 0.9
        easing.type: Easing.OutQuint
        duration: Constants.animationDuration
    }
    NumberAnimation {
        property: "opacity"
        from: 1.0
        to: 0.0
        easing.type: Easing.OutCubic
        duration: Constants.animationDuration
    }
}
