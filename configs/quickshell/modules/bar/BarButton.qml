import QtQuick
import QtQuick.Layouts

import qs.common

Rectangle {
    id: root

    signal clicked

    default property alias content: container.data

    implicitWidth: container.implicitWidth + (Config.barBtnPadding * 2)
    implicitHeight: parent.height

	color: Config.barBtnCol
	radius: Config.barBtnRadius

    states: [
        State {
			name: "hover"
			when: mouseArea.containsMouse && !mouseArea.pressed
            PropertyChanges {
                root.color: Config.barBtnColHover
            }
		},
        State {
            name: "pressed"
			when: mouseArea.pressed
            PropertyChanges {
                root.color: Config.barBtnColPressed
            }
        }
	]

	transitions : [
		Transition {
			from: "*"
			to: "*"

			ColorAnimation { 
				target: root
				property: "color"
				duration: 150
			}
		}
	]

    RowLayout {
        id: container
        anchors.centerIn: parent
		spacing: Config.itemSpacing / 2
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
		hoverEnabled: true

		onClicked: root.clicked()
    }
}
