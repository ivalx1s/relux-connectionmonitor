import Foundation
import Relux

extension ConnectionMonitor {
	public protocol Saga: Relux.Saga {}
}


extension ConnectionMonitor {
	public actor ConnectionMonitorSaga: Saga {
		private let service: ConnectionMonitor.ServiceFacade
		
		private var networkStatusTask: Task<Void, Never>?
		
		public init(service: ServiceFacade) {
			self.service = service
			Task { await setupNetworkMonitoring() }
		}
		
		deinit {
			networkStatusTask?.cancel()
		}
		
		public func apply(_ effect: Relux.Effect) async {
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
		}
		
		private func startNetworkMonitor() async {
			await service.startNetworkMonitor()
		}
	}
}
