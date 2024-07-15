import Relux

extension ConnectionMonitor {
	enum Action: ReluxAction {
		case updateStatus(_ status: ConnectionMonitor.NetworkStatus)
	}
}
