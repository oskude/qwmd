import QtQuick
import QtQuick.Controls
import QtWayland.Compositor

SwipeView {
	id: root
	property alias winlist: repeater.model
	signal windowDestroyed (int index)
	interactive: false
	orientation: Qt.Vertical
	Repeater {
		id: repeater
		ShellSurfaceItem {
			shellSurface: modelData
			onSurfaceDestroyed: root.windowDestroyed(index)
		}
	}
}
