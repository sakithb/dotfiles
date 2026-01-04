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
