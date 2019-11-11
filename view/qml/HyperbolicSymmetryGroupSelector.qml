import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

SelectorGroupBox {
    id: selectorGroupBoxlId

    property alias selectorIndex: tumblerId.currentIndex

    focus: true
    title: "Symmetry"

    Tumbler {
        id: tumblerId
        height: parent.width * 0.5
        wrap: true
        model: modelId
        onModelChanged: currentIndex = model.length / 2
        width: selectorGroupBoxlId.width * .9
        delegate: Text {
            id: delegateId
            text: groupName
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: Material.foreground
            opacity: (tumblerId.count < 3) ? 1.0 : 1.0 - Math.abs(
                                                 Tumbler.displacement)
                                             / (Tumbler.tumbler.visibleItemCount * 0.25)
        }

        onCurrentIndexChanged: forceActiveFocus()

        Keys.onUpPressed: {
            increaseIndex()
        }
        Keys.onDownPressed: {
            decreaseIndex()
        }
        function decreaseIndex() {
            currentIndex = (currentIndex - 1 < 0) ? currentIndex = model.length
                                                    - 1 : currentIndex - 1
        }
        function increaseIndex() {
            currentIndex = (currentIndex + 1 >= model.length) ? 0 : currentIndex + 1
        }
    }

    ListModel {
        id: modelId
        ListElement {
            groupName: "*ax"
            rotation0: "*"
            rotation1: "2"
            rotation2: "x"
            rotation3: ""
            rotation4: ""
        }
        ListElement {
            groupName: "2*ab"
            rotation0: "2"
            rotation1: "*"
            rotation2: "3"
            rotation3: "2"
            rotation4: ""
        }
        ListElement {
            groupName: "a222"
            rotation0: "3"
            rotation1: "2"
            rotation2: "2"
            rotation3: "2"
            rotation4: ""
        }
        ListElement {
            groupName: "ab2"
            rotation0: "5"
            rotation1: "4"
            rotation2: "2"
            rotation3: ""
            rotation4: ""
        }
        ListElement {
            groupName: "a*b"
            rotation0: "5"
            rotation1: "*"
            rotation2: "2"
            rotation3: ""
            rotation4: ""
        }
        ListElement {
            groupName: "*abc"
            rotation0: "*"
            rotation1: "5"
            rotation2: "4"
            rotation3: "2"
            rotation4: ""
        }
        ListElement {
            groupName: "a2x"
            rotation0: "3"
            rotation1: "2"
            rotation2: "x"
            rotation3: ""
            rotation4: ""
        }
        ListElement {
            groupName: "22*a"
            rotation0: "2"
            rotation1: "2"
            rotation2: "*"
            rotation3: "2"
            rotation4: ""
        }
        ListElement {
            groupName: "a*bc"
            rotation0: "3"
            rotation1: "*"
            rotation2: "2"
            rotation3: "2"
            rotation4: ""
        }
        ListElement {
            groupName: "*abcd"
            rotation0: "*"
            rotation1: "3"
            rotation2: "2"
            rotation3: "2"
            rotation4: "2"
        }
        ListElement {
            groupName: "a2*b"
            rotation0: "3"
            rotation1: "2"
            rotation2: "*"
            rotation3: "1"
            rotation4: ""
        }
        ListElement {
            groupName: "*a*b"
            rotation0: "*"
            rotation1: "2"
            rotation2: "*"
            rotation3: "1"
            rotation4: ""
        }
        ListElement {
            groupName: "ao"
            rotation0: "2"
            rotation1: "o"
            rotation2: ""
            rotation3: ""
            rotation4: ""
        }
        ListElement {
            groupName: "abc"
            rotation0: "5"
            rotation1: "2"
            rotation2: "4"
            rotation3: ""
            rotation4: ""
        }
        ListElement {
            groupName: "axx"
            rotation0: "2"
            rotation1: "x"
            rotation2: "x"
            rotation3: ""
            rotation4: ""
        }
        ListElement {
            groupName: "2*abc"
            rotation0: "2"
            rotation1: "*"
            rotation2: "2"
            rotation3: "2"
            rotation4: "2"
        }
        ListElement {
            groupName: "abx"
            rotation0: "3"
            rotation1: "3"
            rotation2: "x"
            rotation3: ""
            rotation4: ""
        }
        ListElement {
            groupName: "ab22"
            rotation0: "3"
            rotation1: "3"
            rotation2: "2"
            rotation3: "2"
            rotation4: ""
        }
    }
}
