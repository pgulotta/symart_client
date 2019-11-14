import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

SelectorGroupBox {
    id: selectorGroupBoxlId

    property alias selectedIndex: tumblerId.currentIndex

    property alias rotation0: rotation0Id.text
    property alias rotation1: rotation1Id.text
    property alias rotation2: rotation2Id.text
    property alias rotation3: rotation3Id.text
    property alias rotation4: rotation4Id.text
    property alias canEdit0: rotation0Id.canEdit
    property alias canEdit1: rotation1Id.canEdit
    property alias canEdit2: rotation2Id.canEdit
    property alias canEdit3: rotation3Id.canEdit
    property alias canEdit4: rotation4Id.canEdit

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

            onCurrentIndexChanged: {
                rotation0Id.text = getSelectedRotaton0()
                rotation1Id.text = getSelectedRotaton1()
                rotation2Id.text = getSelectedRotaton2()
                rotation3Id.text = getSelectedRotaton3()
                rotation4Id.text = getSelectedRotaton4()
                rotation0Id.defaultText = rotation0Id.text
                rotation1Id.defaultText = rotation1Id.text
                rotation2Id.defaultText = rotation2Id.text
                rotation3Id.defaultText = rotation3Id.text
                rotation4Id.defaultText = rotation4Id.text
                rotation0Id.canEdit = getSelectedCanEdit0()
                rotation1Id.canEdit = getSelectedCanEdit1()
                rotation2Id.canEdit = getSelectedCanEdit2()
                rotation3Id.canEdit = getSelectedCanEdit3()
                rotation4Id.canEdit = getSelectedCanEdit4()

                forceActiveFocus()
            }

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
            id: rowId
            focus: true
            spacing: smallPadding
            leftPadding: smallPadding
            NumericInput {
                id: rotation0Id
                focus: true
            }
            NumericInput {
                id: rotation1Id
            }
            NumericInput {
                id: rotation2Id
            }
            NumericInput {
                id: rotation3Id
            }
            NumericInput {
                id: rotation4Id
            }
        }
    }

    function selectedGroupName() {
        return symmetryModelId.get(selectedIndex).groupName
    }

    function getSelectedRotaton0() {
        if (selectedIndex < 0)
            return ""
        return symmetryModelId.get(selectedIndex).rotation0
    }
    function getSelectedRotaton1() {
        if (selectedIndex < 0)
            return ""
        return symmetryModelId.get(selectedIndex).rotation1
    }
    function getSelectedRotaton2() {
        if (selectedIndex < 0)
            return ""
        return symmetryModelId.get(selectedIndex).rotation2
    }
    function getSelectedRotaton3() {
        if (selectedIndex < 0)
            return ""
        return symmetryModelId.get(selectedIndex).rotation3
    }
    function getSelectedRotaton4() {
        if (selectedIndex < 0)
            return ""
        return symmetryModelId.get(selectedIndex).rotation4
    }

    function getSelectedCanEdit0() {
        if (selectedIndex < 0)
            return ""
        return symmetryModelId.get(selectedIndex).canEdit0
    }
    function getSelectedCanEdit1() {
        if (selectedIndex < 0)
            return ""
        return symmetryModelId.get(selectedIndex).canEdit1
    }
    function getSelectedCanEdit2() {
        if (selectedIndex < 0)
            return ""
        return symmetryModelId.get(selectedIndex).canEdit2
    }
    function getSelectedCanEdit3() {
        if (selectedIndex < 0)
            return ""
        return symmetryModelId.get(selectedIndex).canEdit3
    }
    function getSelectedCanEdit4() {
        if (selectedIndex < 0)
            return ""
        return symmetryModelId.get(selectedIndex).canEdit4
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
