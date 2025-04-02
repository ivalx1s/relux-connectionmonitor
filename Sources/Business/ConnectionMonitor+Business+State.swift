import Combine
import Relux

public extension ConnectionMonitor.Business {
    actor State: Relux.BusinessState {
		@Published public private(set) var status: ConnectionMonitor.NetworkStatus = .initial
		
		public init() {

		}
		
		public func cleanup() async {
			status = .initial
		}
	
	}
}

// MARK: - Reducer
extension ConnectionMonitor.Business.State {
	public func reduce(with action: Relux.Action) async {
		guard let action = action as? ConnectionMonitor.Action else {
			return
		}
		switch action {
			case let .updateStatus(status):
				self.status = status
		}
	}
}
