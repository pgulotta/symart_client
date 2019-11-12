import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

SelectorGroupBox {
    id: selectorGroupBoxlId

    property alias selectedIndex: tumblerId.currentIndex

    focus: true
    title: "Symmetry"

    Column {
        id: columnId

        Tumbler {
            id: tumblerId
            height: selectorGroupBoxlId.height * 0.5
            wrap: true
            model: symmetryModelId
            currentIndex: 10
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
            focus: true
            spacing: mediumPadding
            leftPadding: smallPadding
            NumericInput {
                id: rotation0Id
                focus: true
                text: getSelectedItem().rotation0
                canEdit: getSelectedItem().canEdit0
            }
            NumericInput {
                id: rotation1Id
                text: getSelectedItem().rotation1
                canEdit: getSelectedItem().canEdit1
            }
            NumericInput {
                id: rotation2Id
                text: getSelectedItem().rotation2
                canEdit: getSelectedItem().canEdit2
            }
            NumericInput {
                id: rotation3Id
                text: getSelectedItem().rotation3
                canEdit: getSelectedItem().canEdit3
            }
            NumericInput {
                id: rotation4Id
                text: getSelectedItem().rotation4
                canEdit: getSelectedItem().canEdit4
            }
        }
    }

    function getSelectedItem() {
        if (selectedIndex < 0)
            console.log(" ============  selectedIndex < 0")

        return symmetryModelId.get(selectedIndex)
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
            canEdit0: false
            canEdit1: true
            canEdit2: false
            canEdit3: false
            canEdit4: false
        }
        ListElement {
            groupName: "2*ab"
            rotation0: "2"
            rotation1: "*"
            rotation2: "3"
            rotation3: "2"
            rotation4: ""
            canEdit0: false
            canEdit1: false
            canEdit2: true
            canEdit3: true
            canEdit4: false
        }
        ListElement {
            groupName: "a222"
            rotation0: "3"
            rotation1: "2"
            rotation2: "2"
            rotation3: "2"
            rotation4: ""
            canEdit0: true
            canEdit1: false
            canEdit2: false
            canEdit3: false
            canEdit4: false
        }
        ListElement {
            groupName: "ab2"
            rotation0: "5"
            rotation1: "4"
            rotation2: "2"
            rotation3: ""
            rotation4: ""
            canEdit0: true
            canEdit1: true
            canEdit2: false
            canEdit3: false
            canEdit4: false
        }
        ListElement {
            groupName: "a*b"
            rotation0: "5"
            rotation1: "*"
            rotation2: "2"
            rotation3: ""
            rotation4: ""
            canEdit0: true
            canEdit1: false
            canEdit2: true
            canEdit3: false
            canEdit4: false
        }
        ListElement {
            groupName: "*abc"
            rotation0: "*"
            rotation1: "5"
            rotation2: "4"
            rotation3: "2"
            rotation4: ""
            canEdit0: false
            canEdit1: true
            canEdit2: true
            canEdit3: true
            canEdit4: false
        }
        ListElement {
            groupName: "a2x"
            rotation0: "3"
            rotation1: "2"
            rotation2: "x"
            rotation3: ""
            rotation4: ""
            canEdit0: true
            canEdit1: false
            canEdit2: false
            canEdit3: false
            canEdit4: false
        }
        ListElement {
            groupName: "22*a"
            rotation0: "2"
            rotation1: "2"
            rotation2: "*"
            rotation3: "2"
            rotation4: ""
            canEdit0: false
            canEdit1: false
            canEdit2: false
            canEdit3: true
            canEdit4: false
        }
        ListElement {
            groupName: "a*bc"
            rotation0: "3"
            rotation1: "*"
            rotation2: "2"
            rotation3: "2"
            rotation4: ""
            canEdit0: true
            canEdit1: false
            canEdit2: true
            canEdit3: true
            canEdit4: false
        }
        ListElement {
            groupName: "*abcd"
            rotation0: "*"
            rotation1: "3"
            rotation2: "2"
            rotation3: "2"
            rotation4: "2"
            canEdit0: false
            canEdit1: true
            canEdit2: true
            canEdit3: true
            canEdit4: true
        }
        ListElement {
            groupName: "a2*b"
            rotation0: "3"
            rotation1: "2"
            rotation2: "*"
            rotation3: "1"
            rotation4: ""
            canEdit0: true
            canEdit1: false
            canEdit2: false
            canEdit3: true
            canEdit4: false
        }
        ListElement {
            groupName: "*a*b"
            rotation0: "*"
            rotation1: "2"
            rotation2: "*"
            rotation3: "1"
            rotation4: ""
            canEdit0: false
            canEdit1: true
            canEdit2: false
            canEdit3: true
            canEdit4: false
        }
        ListElement {
            groupName: "ao"
            rotation0: "2"
            rotation1: "o"
            rotation2: ""
            rotation3: ""
            rotation4: ""
            canEdit0: true
            canEdit1: false
            canEdit2: false
            canEdit3: false
            canEdit4: false
        }
        ListElement {
            groupName: "abc"
            rotation0: "5"
            rotation1: "2"
            rotation2: "4"
            rotation3: ""
            rotation4: ""
            canEdit0: true
            canEdit1: true
            canEdit2: true
            canEdit3: false
            canEdit4: false
        }
        ListElement {
            groupName: "axx"
            rotation0: "2"
            rotation1: "x"
            rotation2: "x"
            rotation3: ""
            rotation4: ""
            canEdit0: true
            canEdit1: false
            canEdit2: false
            canEdit3: false
            canEdit4: false
        }
        ListElement {
            groupName: "2*abc"
            rotation0: "2"
            rotation1: "*"
            rotation2: "2"
            rotation3: "2"
            rotation4: "2"
            canEdit0: false
            canEdit1: false
            canEdit2: true
            canEdit3: true
            canEdit4: true
        }
        ListElement {
            groupName: "abx"
            rotation0: "3"
            rotation1: "3"
            rotation2: "x"
            rotation3: ""
            rotation4: ""
            canEdit0: true
            canEdit1: true
            canEdit2: false
            canEdit3: false
            canEdit4: false
        }
        ListElement {
            groupName: "ab22"
            rotation0: "3"
            rotation1: "3"
            rotation2: "2"
            rotation3: "2"
            rotation4: ""
            canEdit0: true
            canEdit1: true
            canEdit2: false
            canEdit3: false
            canEdit4: false
        }
    }
}
