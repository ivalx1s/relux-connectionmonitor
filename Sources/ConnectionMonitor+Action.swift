import Relux

public extension ConnectionMonitor {
	enum Action: ReluxAction {
		case updateStatus(_ status: ConnectionMonitor.NetworkStatus)
	}
}
