import QtQuick
import QtQuick.Window
import QtWayland.Compositor
import QtWayland.Compositor.IviApplication
import QtWayland.Compositor.XdgShell

WaylandCompositor {
	WaylandOutput { id: wayout
		property ListModel shellSurfaces: ListModel {}
		window: Window { id: screen
			width: 640
			height: 360
			visible: true
			color: "#222"
			WindowManager { id: wm
				anchors {
					left: wl.right
					right: parent.right
					top: parent.top
					bottom: parent.bottom
				}
				winlist: wayout.shellSurfaces
				onWindowDestroyed: wayout.shellSurfaces.remove(index)
			}
			WindowList { id: wl
				width: 42
				height: screen.height
				color: "#333"
				winlist: wayout.shellSurfaces
				onWindowSelected: wm.currentIndex = index
			}
		}
	}
	IviApplication {
		onIviSurfaceCreated: {
			wayout.shellSurfaces.append({shellSurface: iviSurface});
			iviSurface.sendConfigure(Qt.size(wm.width, screen.height))
		}
	}
	// i guess in wayland we need to implement every "client thing"...
	XdgShell {
		onToplevelCreated: {
			// TODO: how to remove decoration, and place firefox correctly???
			//xdgSurface.toplevel.sendConfigure(Qt.size(wm.width, screen.height), [])
			//xdgSurface.toplevel.sendFullscreen(Qt.size(wm.width, screen.height))
			//xdgSurface.toplevel.sendMaximized(Qt.size(wm.width, screen.height))
			wayout.shellSurfaces.append({shellSurface: xdgSurface})
		}
	}
}
