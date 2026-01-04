import Quickshell
import Quickshell.Services.Notifications
import QtQuick
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

        RowLayout {
            ColumnLayout {
                Repeater {
                    model: NotificationService.notifications
                    BarText {
                        required property Notification modelData
                        text: modelData.body
                    }
                }
            }

            ColumnLayout {
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
