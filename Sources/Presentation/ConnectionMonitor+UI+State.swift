import Foundation
import Combine
import Relux

extension ConnectionMonitor.UI {
	@MainActor
	final class State {
		private var pipelines: Set<AnyCancellable> = []
		
		init(
			connectionMonitorBusinessState: ConnectionMonitor.Business.State
		) {
			Task {
				await connect(connectionMonitorBusinessState: connectionMonitorBusinessState)
			}
		}
		
		private func connect(connectionMonitorBusinessState: ConnectionMonitor.Business.State) async {

		}
	}
}
