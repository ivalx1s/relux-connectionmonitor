import Combine
import Relux

public extension ConnectionMonitor.Business {
	actor State: ReluxState {
		@Published public private(set) var status: ConnectionMonitor.NetworkStatus = .initial
		
		public func cleanup() async {
			
		}
	}
}

// MARK: - Reducer
extension ConnectionMonitor.Business.State {
	public func reduce(with action: ReluxAction) async {
		guard let action = action as? ConnectionMonitor.Action else {
			return
		}
		switch action {
			case let .updateStatus(status):
				self.status = status
		}
	}
}
