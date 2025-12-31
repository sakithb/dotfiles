import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.common

PopupWindow {
    id: root

	default property alias content: container.data
	property alias item: root.anchor.item

	anchor.adjustment: PopupAdjustment.None
	anchor.rect.y: item.height + Config.barPaddingY * 2

	anchor.onAnchoring: {
		var pos = item.mapToGlobal(0, 0)
		var off = (item.width / 2) - (implicitWidth / 2)
		var x = pos.x + off

		if (x <= 0) {
			anchor.rect.x = 0
		} else if (x >= screen.width - implicitWidth) {
			anchor.rect.x = item.width - implicitWidth
		} else {
			anchor.rect.x = off
		}
	}

	color: "transparent"

    implicitWidth: wrapper.implicitWidth
	implicitHeight: wrapper.implicitHeight

	Rectangle {
		id: wrapper

		radius: Config.popupRadius
		color: Config.colBg

		implicitWidth: container.implicitWidth + (Config.popupPadding * 2)
		implicitHeight: container.implicitHeight + (Config.popupPadding * 2)

		anchors.margins: Config.popupPadding

		GridLayout {
			id: container

			anchors.centerIn: parent
		}
	}
}
