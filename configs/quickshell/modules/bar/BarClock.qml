import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.common
import qs.services

BarButton {
    id: root

    onClicked: popup.visible = !popup.visible

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    BarText {
        text: Qt.formatDateTime(clock.date, "dd MMM hh:mm")
        color: Config.colFg
    }

    BarPopup {
        id: popup
        item: root

        visible: true

        RowLayout {
            spacing: Config.itemSpacing

            ListView {
                Layout.fillHeight: true
                Layout.preferredWidth: 300

                clip: true
                spacing: Config.itemSpacing / 2

                model: NotificationService.notifications

                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AsNeeded
                    active: true
                }

                delegate: Rectangle {

                    width: ListView.view.width
                    implicitHeight: notifContent.implicitHeight + (Config.itemSpacing * 2)

                    color: Config.colBgSecondary
                    radius: Config.itemRadius

                    ColumnLayout {
                        id: notifContent

                        anchors.margins: Config.itemSpacing / 2
                        anchors.fill: parent

                        RowLayout {
                            IconImage {
                                visible: modelData.appIcon !== ""
                                source: Quickshell.iconPath(modelData.appIcon)
                                implicitSize: 16
                            }

                            BarText {
                                Layout.fillWidth: true
                                text: modelData.appName
                            }

                            Item {
                                id: closeBtn

                                // 1. HITBOX: 32px is a comfortable minimum for mouse interaction
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32

                                // 2. LAYOUT: Ensure it doesn't get crushed by long text
                                Layout.minimumWidth: 32

                                // 3. VISUALS: The background circle
                                Rectangle {
                                    anchors.centerIn: parent
                                    width: 24 // Visual size can be smaller than hitbox
                                    height: 24
                                    radius: 12

                                    // Only show background when hovered
                                    color: closeMa.containsMouse ? Config.colBgHover : "transparent"

                                    // Smooth fade for the flicker-free look
                                    Behavior on color {
                                        ColorAnimation {
                                            duration: 100
                                        }
                                    }

                                    BarText {
                                        anchors.centerIn: parent
                                        text: "✕"
                                        font.pixelSize: 10
                                        opacity: closeMa.containsMouse ? 1 : 0.5
                                    }
                                }

                                // 4. INTERACTION: Raw MouseArea for total control
                                MouseArea {
                                    id: closeMa
                                    anchors.fill: parent

                                    // Essential for "opacity: ... ? 1 : 0.5" to work
                                    hoverEnabled: true

                                    // Stops ListView from stealing the click if you drag slightly
                                    preventStealing: true

                                    // Ensures this sits on top of any delegate background clicks
                                    z: 1

                                    onClicked: modelData.dismiss()

                                    // Debug: Uncomment if you still see issues
                                    // onEntered: console.log("Hover Enter")
                                    // onExited: console.log("Hover Exit")
                                }
                            }
                        }

                        RowLayout {
                            IconImage {
                                visible: modelData.image !== ""
                                source: modelData.image
                                implicitSize: 64
                            }

                            BarText {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignTop

                                text: modelData.body
                                wrapMode: Text.Wrap
                            }
                        }
                    }
                }
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignTop

                BarText {
                    text: Qt.formatDateTime(clock.date, "MMMM")
                }

                GridLayout {
                    columns: 7

                    Repeater {
                        model: 30
                        BarText {
                            required property int index
                            text: index + 1
                        }
                    }
                }
            }
        }
    }
}
