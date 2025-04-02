import Relux

extension ConnectionMonitor {
	public final class Module: Relux.Module {
		public let service: any ServiceFacade
		public let networkService: any ConnectionMonitor.NetworkMonitoring
		public let states: [any Relux.AnyState]
		public let sagas: [any Relux.Saga]
		
		public init(
			sagas: [any ConnectionMonitor.Saga],
			serviceFacade: any ServiceFacade,
			networkService: any ConnectionMonitor.NetworkMonitoring,
            states: [any Relux.AnyState]
		) {
			self.service = serviceFacade
			self.networkService = networkService
			self.states = states
			self.sagas = sagas
		}
	}
}
