import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.common
import qs.widgets

ShellButton {
    id: root

    color: Config.barBtnCol
    colorHover: Config.barBtnColHover
    colorPressed: Config.barBtnColPressed
	radius: Config.barBtnRadius

	paddingX: Config.barBtnPaddingX
	anchors.top: parent.top
	anchors.bottom: parent.bottom

    // onClicked: popup.visible = !popup.visible

    RowLayout {
        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }

        ShellText {
			text: Qt.formatDateTime(clock.date, "dd MMM hh:mm")
			font.weight: Font.DemiBold
        }

        // BarPopup {
        //     id: popup
        //     item: root

        //     RowLayout {
        //         spacing: Config.itemSpacing

        //         ListView {
        //             Layout.fillHeight: true
        //             Layout.preferredWidth: 300

        //             clip: true
        //             spacing: Config.itemSpacing / 2

        //             model: NotificationService.notifications

        //             ScrollBar.vertical: ScrollBar {
        //                 policy: ScrollBar.AsNeeded
        //                 active: true
        //             }

        //             delegate: Rectangle {

        //                 width: ListView.view.width
        //                 implicitHeight: notifContent.implicitHeight + (Config.itemSpacing * 2)

        //                 color: Config.colBgSecondary
        //                 radius: Config.itemRadius

        //                 ColumnLayout {
        //                     id: notifContent

        //                     anchors.margins: Config.itemSpacing / 2
        //                     anchors.fill: parent

        //                     RowLayout {
        //                         IconImage {
        //                             visible: modelData.appIcon !== ""
        //                             source: Quickshell.iconPath(modelData.appIcon)
        //                             implicitSize: 16
        //                         }

        //                         ShellText {
        //                             Layout.fillWidth: true
        //                             text: modelData.appName
        //                         }

        //                         Item {
        //                             id: closeBtn

        //                             Layout.preferredWidth: 32
        //                             Layout.preferredHeight: 32

        //                             Layout.minimumWidth: 32

        //                             Rectangle {
        //                                 anchors.centerIn: parent
        //                                 width: 24
        //                                 height: 24
        //                                 radius: 12

        //                                 color: closeMa.containsMouse ? Config.colBgHover : "transparent"

        //                                 Behavior on color {
        //                                     ColorAnimation {
        //                                         duration: 100
        //                                     }
        //                                 }

        //                                 ShellText {
        //                                     anchors.centerIn: parent
        //                                     text: "✕"
        //                                     font.pixelSize: 10
        //                                     opacity: closeMa.containsMouse ? 1 : 0.5
        //                                 }
        //                             }

        //                             MouseArea {
        //                                 id: closeMa
        //                                 anchors.fill: parent

        //                                 hoverEnabled: true

        //                                 preventStealing: true

        //                                 z: 1

        //                                 onClicked: modelData.dismiss()
        //                             }
        //                         }
        //                     }

        //                     RowLayout {
        //                         IconImage {
        //                             visible: modelData.image !== ""
        //                             source: modelData.image
        //                             implicitSize: 64
        //                         }

        //                         ShellText {
        //                             Layout.fillWidth: true
        //                             Layout.alignment: Qt.AlignTop

        //                             text: modelData.body
        //                             wrapMode: Text.Wrap
        //                         }
        //                     }
        //                 }
        //             }
        //         }

        //         ColumnLayout {
        //             Layout.alignment: Qt.AlignTop

        //             ShellText {
        //                 text: Qt.formatDateTime(clock.date, "MMMM")
        //             }

        //             GridLayout {
        //                 columns: 7

        //                 Repeater {
        //                     model: 30
        //                     ShellText {
        //                         required property int index
        //                         text: index + 1
        //                     }
        //                 }
        //             }
        //         }
        //     }
        // }
    }
}
