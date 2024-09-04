import Relux

extension ConnectionMonitor {
	public enum SideEffect: Relux.Effect {
		case startNetworkMonitor
	}
}
