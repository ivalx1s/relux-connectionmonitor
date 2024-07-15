import Relux

extension ConnectionMonitor {
	public final class Module: Relux.Module {
		public let service: any ServiceFacade
		public let states: [ReluxState]
		public let viewStates: [any ReluxViewState]
		public let viewStatesObservables: [any ReluxViewStateObserving]
		public let sagas: [ReluxSaga]
		
		public init(
			networkService: any ConnectionMonitor.NetworkMonitoring,
			viewStates: [any ReluxViewState],
			viewStateObservables: [any ReluxViewStateObserving]
		) {
			let serviceFacade = Service(networkService: networkService)
			self.service = serviceFacade
			
			let businessState = ConnectionMonitor.Business.State()
			let saga = ConnectionMonitor.ConnectionMonitorSaga(service: serviceFacade)
			
			self.states = [businessState]
			self.viewStates = viewStates
			self.viewStatesObservables = viewStateObservables
			self.sagas = [saga]
		}
	}
}
