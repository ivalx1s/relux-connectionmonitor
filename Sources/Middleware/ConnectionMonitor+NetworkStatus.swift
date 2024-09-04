
public extension ConnectionMonitor {
    struct NetworkStatus: Sendable, Equatable, CustomStringConvertible, CustomDebugStringConvertible {
        public let connected: Bool
        public let expensive: Bool
        
        public init(connected: Bool, expensive: Bool) {
            self.connected = connected
            self.expensive = expensive
        }
        
        public static let initial: Self = .init(connected: false, expensive: false)
        
        public var description: String {
            "connected: \(connected), expensive: \(expensive)"
        }
        
        public var debugDescription: String {
            description
        }
        
    }
}
