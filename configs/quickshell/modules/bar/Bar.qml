import Quickshell
import QtQuick

import qs.common

Variants {
	model: Quickshell.screens

	PanelWindow {
		id: bar

		required property var modelData

		screen: modelData

        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: Config.barHeight
		color: Config.colBg

		Item {
			anchors.fill: parent
			anchors.leftMargin: Config.barPaddingX
			anchors.rightMargin: Config.barPaddingX
			anchors.topMargin: Config.barPaddingY
			anchors.bottomMargin: Config.barPaddingY

			BarSection {
				anchors.left: parent.left

				BarClock {}
				BarClock {}
				BarClock {}
			}

			BarSection {
				anchors.horizontalCenter: parent.horizontalCenter

				BarClock {}
			}

			BarSection {
				anchors.right: parent.right

				BarClock {}
			}
		}
    }
}
