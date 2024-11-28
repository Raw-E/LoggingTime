import Foundation
import SwiftUI

// Logger: A concise, globally accessible logging utility for SwiftUI previews
public final actor PreviewLogger: Sendable {
    // LogLevel: Defines severity levels for logging
    public enum LogLevel: Int, Sendable {
        case debug = 0, info, warning, error

        public var description: String {
            switch self {
            case .debug: return "DEBUG"
            case .info: return "INFO"
            case .warning: return "WARNING"
            case .error: return "ERROR"
            }
        }
    }

    // Shared instance for global access
    public static let shared = PreviewLogger()

    // Current log level
    public var logLevelThreshold: LogLevel = .info

    private init() {}

    // Configure the logger's log level
    public func configure(logLevelThreshold: LogLevel) {
        self.logLevelThreshold = logLevelThreshold
    }

    // Main logging function
    public func log(
        _ message: String,
        level: LogLevel = .info,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        #if DEBUG
        // Only log in preview environments
        guard ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" else { return }
        // Check if the message meets the current log level
        guard level.rawValue >= logLevelThreshold.rawValue else { return }

        let fileName = (file as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
        let header = "[\(level.description)] \(fileName) - \(function) (line \(line))"
        let separator = String(repeating: "-", count: 100)
        let centeredHeader = header.centered(in: separator)

        print("""
        \(separator)
        \(centeredHeader)
        \(separator)
        \(message)
        \(separator)
        """)
        #endif
    }

    // Static Methods
    public static func configure(logLevelThreshold: LogLevel) {
        Task {
            await shared.configure(logLevelThreshold: logLevelThreshold)
        }
    }

    public static func log(
        _ message: String,
        level: LogLevel = .info,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        Task {
            await shared.log(message, level: level, file: file, function: function, line: line)
        }
    }
}

// Extension to center a string within a container
public extension String {
    func centered(in container: String) -> String {
        let padding = max(0, container.count - self.count) / 2
        return String(repeating: " ", count: padding) + self + String(repeating: " ", count: padding)
    }
}