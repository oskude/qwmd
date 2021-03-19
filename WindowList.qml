import QtQuick
import QtWayland.Compositor

Rectangle {
	id: root
	property alias winlist: winList.model
	signal windowSelected (int index)
	ListView { id: winList
		anchors.fill: parent
		delegate: ShellSurfaceItem {
			shellSurface: modelData
			width: root.width
			height: width
			inputEventsEnabled: false
			MouseArea {
				anchors.fill: parent
				preventStealing: true
				onClicked: root.windowSelected(index)
			}
		}
	}
}
