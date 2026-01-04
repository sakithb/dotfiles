pragma Singleton

import Quickshell
import Quickshell.Services.Notifications

Singleton {
	property alias notifications: notifServer.trackedNotifications

	NotificationServer {
		id: notifServer

		onNotification: notif => {
			console.log(notif)
			notif.tracked = true
		}
	}
}
