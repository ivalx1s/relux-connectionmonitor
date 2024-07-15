import Foundation
import Relux

extension ConnectionMonitor {
	protocol Saga: ReluxSaga {}
}


extension ConnectionMonitor {
	actor ConnectionMonitorSaga: Saga {
		private let service: ConnectionMonitor.ServiceFacade
		
		private var networkStatusTask: Task<Void, Never>?
		
		init(service: ServiceFacade) {
			self.service = service
			Task { await setupNetworkMonitoring() }
		}
		
		deinit {
			networkStatusTask?.cancel()
		}
		
		func apply(_ effect: ReluxEffect) async {
			switch effect as? ConnectionMonitor.SideEffect {
				case .none:
					break
				case .startNetworkMonitor:
					await startNetworkMonitor()
			}
		}
		
		private func setupNetworkMonitoring() {
			networkStatusTask = Task { [weak self] in
				await self?.monitorNetworkStatus()
			}
		}
		
		private func monitorNetworkStatus() async {
			for await status in await service.networkStatus {
				await handleNetworkStatusChange(status)
			}
		}
		
		private func handleNetworkStatusChange(_ status: NetworkStatus) async {
			await action {
				ConnectionMonitor.Action.updateStatus(status)
			}
			
			guard status.connected else { return }
		}
		
		private func startNetworkMonitor() async {
			await service.startNetworkMonitor()
		}
	}
}
