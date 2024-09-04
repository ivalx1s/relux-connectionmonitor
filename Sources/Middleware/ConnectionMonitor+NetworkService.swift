import Foundation
import Network

public extension ConnectionMonitor {
	protocol NetworkMonitoring: Sendable {
		func start() async
		var networkStatus: AsyncStream<ConnectionMonitor.NetworkStatus> { get async }
	}
}

public extension ConnectionMonitor {
	actor NetworkService: NetworkMonitoring {
		private let monitor = NWPathMonitor()
		private let queue = DispatchQueue(label: "ConnectionMonitor.NetworkService", qos: .userInitiated)
		
		private let statusSubject = AsyncStream<NetworkStatus>.makeStream()
		
		public init() {
		}
		
		public var networkStatus: AsyncStream<NetworkStatus> {
			get async {
				statusSubject.stream
			}
		}
		
		public func start() async {
			startWatchNetworkCondition()
		}
		
		private func startWatchNetworkCondition() {
			monitor.pathUpdateHandler = { [weak self] path in
				Task { [weak self] in
					guard let self = self else { return }
					let newStatus = NetworkStatus(
						connected: path.status == .satisfied,
						expensive: path.isExpensive
					)
					await self.yieldNewStatus(newStatus)
				}
			}
			monitor.start(queue: queue)
		}
		
		private func yieldNewStatus(_ status: NetworkStatus) {
			switch statusSubject.continuation.yield(status) {
				case .enqueued: break
				case .dropped:
					print("Warning: Network status update was dropped")
				case .terminated:
					print("Network status stream has been terminated")
					monitor.cancel()
				@unknown default:
					print("Unexpected yield result")
			}
		}
	}
}
