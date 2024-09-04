import Relux

public extension ConnectionMonitor {
	enum Action: Relux.Action {
		case updateStatus(_ status: ConnectionMonitor.NetworkStatus)
	}
}
