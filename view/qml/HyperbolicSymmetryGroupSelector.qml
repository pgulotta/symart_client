﻿import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

SelectorGroupBox {
    id: selectorGroupBoxlId

    property alias selectorIndex: tumblerId.currentIndex

    function getSelectedItem() {
        return symmetryModelId.get(selectorIndex)
    }

    focus: true
    title: "Symmetry"

    Column {
        id: columnId

        Tumbler {
            id: tumblerId
            height: selectorGroupBoxlId.height * 0.5
            wrap: true
            model: symmetryModelId
            onModelChanged: currentIndex = model.length / 2
            width: selectorGroupBoxlId.width * .9
            delegate: Text {
                id: delegateId
                text: groupName
                font.pointSize: smallFontPointSize
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
        Row {
            spacing: mediumPadding
            focus: true
            NumericInput {
                id: rotation0Id
                focus: true
                text: getSelectedItem().rotation0
                state: getSelectedItem().state0
            }
            NumericInput {
                id: rotation1Id
                text: getSelectedItem().rotation1
                state: getSelectedItem().state1
            }
            NumericInput {
                id: rotation2Id
                text: getSelectedItem().rotation2
                state: getSelectedItem().state2
            }
            NumericInput {
                id: rotation3Id
                text: getSelectedItem().rotation3
                state: getSelectedItem().state3
            }
            NumericInput {
                id: rotation4Id
                text: getSelectedItem().rotation4
                state: getSelectedItem().state4
            }
        }
    }

    ListModel {
        id: symmetryModelId
        ListElement {
            groupName: "*ax"
            rotation0: "*"
            rotation1: "2"
            rotation2: "x"
            rotation3: ""
            rotation4: ""
            state0: "noEdit"
            state1: "edit"
            state2: "noEdit"
            state3: "hide"
            state4: "hide"
        }
        ListElement {
            groupName: "2*ab"
            rotation0: "2"
            rotation1: "*"
            rotation2: "3"
            rotation3: "2"
            rotation4: ""
            state0: "noEdit"
            state1: "noEdit"
            state2: "edit"
            state3: "edit"
            state4: "hide"
        }
        ListElement {
            groupName: "a222"
            rotation0: "3"
            rotation1: "2"
            rotation2: "2"
            rotation3: "2"
            rotation4: ""
            state0: "edit"
            state1: "noEdit"
            state2: "noEdit"
            state3: "noEdit"
            state4: "hide"
        }
        ListElement {
            groupName: "ab2"
            rotation0: "5"
            rotation1: "4"
            rotation2: "2"
            rotation3: ""
            rotation4: ""
            state0: "edit"
            state1: "edit"
            state2: "noEdit"
            state3: "hide"
            state4: "hide"
        }
        ListElement {
            groupName: "a*b"
            rotation0: "5"
            rotation1: "*"
            rotation2: "2"
            rotation3: ""
            rotation4: ""
            state0: "edit"
            state1: "noEdit"
            state2: "edit"
            state3: "hide"
            state4: "hide"
        }
        ListElement {
            groupName: "*abc"
            rotation0: "*"
            rotation1: "5"
            rotation2: "4"
            rotation3: "2"
            rotation4: ""
            state0: "noEdit"
            state1: "edit"
            state2: "edit"
            state3: "edit"
            state4: "hide"
        }
        ListElement {
            groupName: "a2x"
            rotation0: "3"
            rotation1: "2"
            rotation2: "x"
            rotation3: ""
            rotation4: ""
            state0: "edit"
            state1: "noEdit"
            state2: "noEdit"
            state3: "hide"
            state4: "hide"
        }
        ListElement {
            groupName: "22*a"
            rotation0: "2"
            rotation1: "2"
            rotation2: "*"
            rotation3: "2"
            rotation4: ""
            state0: "noEdit"
            state1: "noEdit"
            state2: "noEdit"
            state3: "edit"
            state4: "hide"
        }
        ListElement {
            groupName: "a*bc"
            rotation0: "3"
            rotation1: "*"
            rotation2: "2"
            rotation3: "2"
            rotation4: ""
            state0: "edit"
            state1: "noEdit"
            state2: "edit"
            state3: "edit"
            state4: "hide"
        }
        ListElement {
            groupName: "*abcd"
            rotation0: "*"
            rotation1: "3"
            rotation2: "2"
            rotation3: "2"
            rotation4: "2"
            state0: "noEdit"
            state1: "edit"
            state2: "edit"
            state3: "edit"
            state4: "edit"
        }
        ListElement {
            groupName: "a2*b"
            rotation0: "3"
            rotation1: "2"
            rotation2: "*"
            rotation3: "1"
            rotation4: ""
            state0: "edit"
            state1: "noEdit"
            state2: "noEdit"
            state3: "edit"
            state4: "hide"
        }
        ListElement {
            groupName: "*a*b"
            rotation0: "*"
            rotation1: "2"
            rotation2: "*"
            rotation3: "1"
            rotation4: ""
            state0: "noEdit"
            state1: "edit"
            state2: "noEdit"
            state3: "edit"
            state4: "hide"
        }
        ListElement {
            groupName: "ao"
            rotation0: "2"
            rotation1: "o"
            rotation2: ""
            rotation3: ""
            rotation4: ""
            state0: "edit"
            state1: "noEdit"
            state2: "hide"
            state3: "hide"
            state4: "hide"
        }
        ListElement {
            groupName: "abc"
            rotation0: "5"
            rotation1: "2"
            rotation2: "4"
            rotation3: ""
            rotation4: ""
            state0: "edit"
            state1: "edit"
            state2: "edit"
            state3: "hide"
            state4: "hide"
        }
        ListElement {
            groupName: "axx"
            rotation0: "2"
            rotation1: "x"
            rotation2: "x"
            rotation3: ""
            rotation4: ""
            state0: "edit"
            state1: "noEdit"
            state2: "noEdit"
            state3: "hide"
            state4: "hide"
        }
        ListElement {
            groupName: "2*abc"
            rotation0: "2"
            rotation1: "*"
            rotation2: "2"
            rotation3: "2"
            rotation4: "2"
            state0: "noEdit"
            state1: "noEdit"
            state2: "edit"
            state3: "edit"
            state4: "edit"
        }
        ListElement {
            groupName: "abx"
            rotation0: "3"
            rotation1: "3"
            rotation2: "x"
            rotation3: ""
            rotation4: ""
            state0: "edit"
            state1: "edit"
            state2: "noEdit"
            state3: "hide"
            state4: "hide"
        }
        ListElement {
            groupName: "ab22"
            rotation0: "3"
            rotation1: "3"
            rotation2: "2"
            rotation3: "2"
            rotation4: ""
            state0: "edit"
            state1: "edit"
            state2: "noEdit"
            state3: "noEdit"
            state4: "hide"
        }
    }
}
