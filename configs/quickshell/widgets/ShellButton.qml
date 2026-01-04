import QtQuick

Rectangle {
    id: root

    signal clicked

	default property Item child

	property color colorHover: "transparent"
	property color colorPressed: "transparent"

	property int paddingX: 0
	property int paddingY: 0

	implicitWidth: container.width + (paddingX*2)
	implicitHeight: container.height + (paddingY*2)

	onChildChanged: {
		if (child) {
			child.parent = container
		}
	}

    states: [
        State {
            name: "hover"
            when: mouseArea.containsMouse && !mouseArea.pressed
            PropertyChanges {
                root.color: root.colorHover
            }
        },
        State {
            name: "pressed"
            when: mouseArea.pressed
            PropertyChanges {
                root.color: root.colorPressed
            }
        }
    ]

    transitions: [
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

	Item {
		id: container
		anchors.centerIn: parent
		width: root.child.implicitWidth
		height: root.child.implicitHeight
	}

    MouseArea {
		id: mouseArea

        anchors.fill: parent
		hoverEnabled: true

        onClicked: root.clicked()
    }
}
