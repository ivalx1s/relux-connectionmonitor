import Relux

extension ConnectionMonitor {
	public final class Module: Relux.Module {
		public let service: any ServiceFacade
		public let networkService: any ConnectionMonitor.NetworkMonitoring
		public let states: [any Relux.State]
		public let uistates: [any Relux.Presentation.StatePresenting]
		public let routers: [any Relux.Navigation.RouterProtocol]
		public let sagas: [any Relux.Saga]
		
		public init(
			sagas: [any ConnectionMonitor.Saga],
			serviceFacade: any ServiceFacade,
			networkService: any ConnectionMonitor.NetworkMonitoring,
			states: [any Relux.State],
			uistates: [any Relux.Presentation.StatePresenting]
		) {
			self.service = serviceFacade
			self.networkService = networkService
			self.states = states
			self.uistates = uistates
			self.routers = []
			self.sagas = sagas
		}
	}
}
