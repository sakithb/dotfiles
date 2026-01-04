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

                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32

                                Layout.minimumWidth: 32

                                Rectangle {
                                    anchors.centerIn: parent
                                    width: 24
                                    height: 24
                                    radius: 12

                                    color: closeMa.containsMouse ? Config.colBgHover : "transparent"

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

                                MouseArea {
                                    id: closeMa
                                    anchors.fill: parent

                                    hoverEnabled: true

                                    preventStealing: true

                                    z: 1

                                    onClicked: modelData.dismiss()
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
