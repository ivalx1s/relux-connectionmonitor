

extension ConnectionMonitor {
	public protocol ServiceFacade: Sendable {
		func startNetworkMonitor() async
		var networkStatus: AsyncStream<ConnectionMonitor.NetworkStatus> { get async }
	}
}


extension ConnectionMonitor {
	public final class Service: ServiceFacade {
		private let networkService: ConnectionMonitor.NetworkMonitoring
		
		public init(networkService: NetworkMonitoring) {
			self.networkService = networkService
		}
		
		public func startNetworkMonitor() async {
			await networkService.start()
		}
		
		public var networkStatus: AsyncStream<ConnectionMonitor.NetworkStatus> {
			get async {
				await networkService.networkStatus
			}
		}
	}
}
