import Combine
import Relux

public extension ConnectionMonitor.Business {
	actor State: ReluxState {
		@Published private var status: ConnectionMonitor.NetworkStatus = .initial
		
		public init() {

		}
		
		public func cleanup() async {
			status = .initial
		}
		
		public var statusUpdates: AsyncStream<ConnectionMonitor.NetworkStatus> {
			AsyncStream { continuation in
				Task {
					for await status in $status.values {
						continuation.yield(status)
					}
				}
			}
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
