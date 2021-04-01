import QtQuick
import QtWayland.Compositor

Rectangle {
	id: root
	property double whasp: 1.0
	property alias winlist: winList.model
	signal windowSelected (int index)
	ListView { id: winList
		anchors.fill: parent
		delegate: ShellSurfaceItem {
			shellSurface: modelData
			width: root.width
			height: width * whasp
			inputEventsEnabled: false
			MouseArea {
				anchors.fill: parent
				onClicked: root.windowSelected(index)
			}
		}
	}
}
