import QtQuick
import QtQuick.Window
import QtWayland.Compositor
import QtWayland.Compositor.IviApplication
import "." as A

WaylandCompositor { id: waycomp
	WaylandOutput { id: wayout
		property ListModel shellSurfaces: ListModel {}
		window: Window { id: screen
			width: 852
			height: 480
			visible: true
			color: "#222"
			WaylandMouseTracker {
				id: mouseTracker
				anchors.fill: parent
				windowSystemCursorEnabled: true
				A.WindowManager { id: wm
					anchors {
						left: wl.right
						right: parent.right
						top: parent.top
						bottom: parent.bottom
					}
					winlist: wayout.shellSurfaces
					onWindowDestroyed: wayout.shellSurfaces.remove(index)
				}
				A.WindowList { id: wl
					whasp: screen.height / (screen.width - width)
					width: avatar.width
					height: screen.height
					color: "#333"
					winlist: wayout.shellSurfaces
					onWindowSelected: wm.currentIndex = index
				}
				Image {
					id: avatar
					source: "avatar.png"
					anchors.bottom: parent.bottom
					MouseArea {
						anchors.fill: parent
						acceptedButtons: Qt.LeftButton | Qt.MiddleButton
						onClicked: {
							if (mouse.button === Qt.LeftButton) {
								io.runCmdline("qterminal")
							} else if (mouse.button === Qt.MiddleButton) {
								Qt.quit()
							}
						}
					}
				}
				onMouseXChanged: {
					if (mouseX < screen.width - blah.width - 5) {
						blah.x = mouseX + 5
					}
				}
				onMouseYChanged: {
					if (mouseY < screen.height - blah.height - 10) {
						blah.y = mouseY + 10
					}
				}
				// TODO: this cant capture capslock...
				Shortcut {
					sequence: "Ctrl+<"
					context: Qt.ApplicationShortcut
					onActivated: {
						blahTxt.text = ""
						blahTxt.forceActiveFocus()
					}
				}
				Rectangle {
					id: blah
					color: "#333"
					radius: 4
					width: blahTxt.width
					height: blahTxt.height
					border.color: "#aaa"
					border.width: 1
					opacity: blahTxt.focus | blahTxt.text.length > 0 ? 1.0 : 0
					TextInput {
						id: blahTxt
						text: "press ctrl+< to write here"
						topPadding: 4
						bottomPadding: topPadding
						leftPadding: topPadding * 2
						rightPadding: leftPadding
						color: "#aaa"
						font.family: "monospace"
						onAccepted: focus = false
					}
				}

				A.MouseButtonVis {
					id: mbv
				}

				// TODO: is there a better way for this yet?
				// or better yet, is there a "master" mouse event in qml yet?
				signal reMouseClick (int buttons, int x, int y)
				signal reMouseWheel (int wx, int wy, int px, int py)
				Component.onCompleted: {
					io.mouseClick.connect(reMouseClick)
					io.mouseWheel.connect(reMouseWheel)
				}
				Connections {
					onReMouseClick: {
						mbv.posX = x
						mbv.posY = y
						mbv.buttons = buttons
					}
					onReMouseWheel: mbv.onWheel(wx, wy, px, py)
				}
			}
		}
	}
	IviApplication {
		onIviSurfaceCreated: {
			wayout.shellSurfaces.append({shellSurface: iviSurface});
			iviSurface.sendConfigure(Qt.size(wm.width, screen.height))
		}
	}
}
