import Quickshell
import QtQuick

import qs.common

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

		BarText {
			text: "Hello my name is sakithgs fsdfsldhfjsaf"
		}
    }
}
