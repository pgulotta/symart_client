import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import com.twentysixapps.constants 1.0

SelectorGroupBox {
    id: selectorGroupBoxlId

    property alias selectorIndex: tumblerId.selectorIndex

    focus: true
    title: "Rule Type"

    Column {
        id: columnId
        Row {
            id: rowId
            focus: true
            spacing: smallPadding
            leftPadding: smallPadding
            TumblerSelector {
                id: tumblerId
                title: "Rule"
                selectorModel: ImmutableList.ruleTypes()
                height: 110
            }
            Column {
                leftPadding: exlargePadding
                Label {
                    text: "Weight"
                }
                NumericInput {
                    id: weightId
                    canEdit: true
                    text: "10"
                    defaultText: "10"
                }
            }
        }
        Switch {
            id: usePastelColorsSwitchId
            width: 200
            text: qsTr("Use Pastel Colors")
            checked: false
        }
    }
}
