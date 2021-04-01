import QtQuick
import QtQuick.Shapes

Item {
	id: root
	property int posX
	property int posY
	property int buttons
	property color colorInside: "black"
	property color colorOutside: "white"
	property int borderInside: 2
	property int borderOutside: 1
	property double maxOpa: 1.0
	property int size: 32
	property int half: size / 2
	property int fade: 250

	function onWheel (wx, wy, px, py) {
		root.posX = px
		root.posY = py
		if (wy > 0) {
			scrollVis.angle = 0
		} else if (wy < 0) {
			scrollVis.angle = 180
		}
		if (wx > 0) {
			scrollVis.angle = 90
		} else if (wx < 0) {
			scrollVis.angle = 270
		}
		wheelAnim.start()
	}
	PropertyAnimation {
		id: wheelAnim
		target: scrollVis
		properties: "opacity"
		from: root.maxOpa
		to: 0
		duration: fade
	}

	property bool leftPressed: buttons & Qt.LeftButton
	property bool rightPressed: buttons & Qt.RightButton
	property bool middlePressed: buttons & Qt.MiddleButton
	property bool scrolled: false
	property int outsideWidth: borderInside + borderOutside * 2

	width: size
	height: size
	x: posX - width/2
	y: posY - height/2

	Rectangle {
		id: leftButtonVis
		color: "transparent"
		border.color: root.colorOutside
		border.width: root.outsideWidth
		anchors.centerIn: parent
		width: root.size
		height: width
		radius: width
		layer.enabled: true
		opacity: root.leftPressed ? root.maxOpa : 0
		Behavior on opacity {
			enabled: root.leftPressed
			PropertyAnimation {
				duration: root.fade
			}
		}
		Rectangle {
			color: "transparent"
			border.color: root.colorInside
			border.width: root.borderInside
			anchors.centerIn: parent
			width: root.size - root.outsideWidth / 2
			height: width
			radius: width
		}
	}

	Rectangle {
		id: rightButtonVis
		color: "transparent"
		border.color: root.colorOutside
		border.width: root.outsideWidth
		anchors.centerIn: parent
		width: root.size
		height: width
		layer.enabled: true
		opacity: root.rightPressed ? root.maxOpa : 0
		Behavior on opacity {
			enabled: root.rightPressed
			PropertyAnimation {
				duration: root.fade
			}
		}
		Rectangle {
			color: "transparent"
			border.color: root.colorInside
			border.width: root.borderInside
			anchors.centerIn: parent
			width: root.size - root.outsideWidth / 2
			height: width
		}
	}

	Shape {
		id: middleButtonVis
		anchors.centerIn: parent
		width: root.size
		height: width
		//layer.enabled: true // TODO: this cuts our corners...
		opacity: root.middlePressed ? root.maxOpa : 0
		Behavior on opacity {
			enabled: root.middlePressed
			PropertyAnimation {
				duration: root.fade
			}
		}
		ShapePath {
			strokeColor: root.colorOutside
			strokeWidth: root.outsideWidth
			fillColor: "transparent"
			startX: root.half
			startY: 0
			joinStyle: ShapePath.MiterJoin
			PathLine { x:root.size; y:root.half }
			PathLine { x:root.half; y:root.size }
			PathLine { x:0;         y:root.half }
			PathLine { x:root.half; y:0 }
		}
		ShapePath {
			strokeColor: root.colorInside
			strokeWidth: root.borderInside
			fillColor: "transparent"
			startX: root.half
			startY: 0
			joinStyle: ShapePath.MiterJoin
			PathLine { x:root.size; y:root.half }
			PathLine { x:root.half; y:root.size }
			PathLine { x:0;         y:root.half }
			PathLine { x:root.half; y:0 }
		}
	}

	Shape {
		id: scrollVis
		property int angle: 0
		rotation: angle
		anchors.centerIn: parent
		width: root.size
		height: width
		opacity: 0
		//layer.enabled: true // TODO: this cuts our corners...
		ShapePath {
			strokeColor: root.colorOutside
			strokeWidth: root.outsideWidth
			fillColor: "transparent"
			startX: 0
			startY: root.half
			joinStyle: ShapePath.MiterJoin
			PathLine { x:root.half; y:0 }
			PathLine { x:root.size; y:root.half }
		}
		ShapePath {
			strokeColor: root.colorInside
			strokeWidth: root.borderInside
			fillColor: "transparent"
			startX: 0
			startY: root.half
			joinStyle: ShapePath.MiterJoin
			PathLine { x:root.half; y:0 }
			PathLine { x:root.size; y:root.half }
		}
	}
}
