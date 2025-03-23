import Foundation
import SwiftUI

/// An actor responsible for logging messages within SwiftUI previews.
public actor PreviewLogger {
    // MARK: - Properties

    /// A shared, singleton instance of `PreviewLogger`.
    public static let shared = PreviewLogger()

    /// The active log level for determining which messages should be logged.
    public private(set) var logLevel: LogLevel = .info

    // MARK: - Initialization

    private init() {}

    // MARK: - Public Interface

    /// Schedules a task to change the global log level used by the shared logger instance.
    public static func setLogLevel(_ level: LogLevel) {
        Task {
            await shared.setLogLevelInternally(level)
        }
    }

    /// Logs a message at the specified log level using the current context.
    public static func log(
        _ message: String,
        level: LogLevel = .info,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        logInternal(
            message,
            level: level,
            context: .current(file: file, function: function, line: line)
        )
    }

    /// Logs a message at the specified log level using a custom context.
    public static func log(
        _ message: String,
        level: LogLevel = .info,
        context: LoggingContext
    ) {
        logInternal(
            message,
            level: level,
            context: context
        )
    }

    // MARK: - Private Helpers

    /// A private function that handles the core logging logic for both public logging methods.
    private static func logInternal(
        _ message: String,
        level: LogLevel,
        context: LoggingContext
    ) {
        #if DEBUG
            guard ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" else {
                return
            }

            Task { @Sendable in
                let currentLogLevel = await shared.logLevel
                // Only show logs at or above the current log level
                guard level >= currentLogLevel else {
                    return
                }

                let location = LocationInfo(context: context)
                let callerLocation = context.callerContext.map(LocationInfo.init)

                let formatter = MessageFormatter(
                    level: level,
                    message: message,
                    location: location,
                    callerLocation: callerLocation
                )

                print(formatter.formatted.joined(separator: "\n"))
            }
        #endif
    }

    /// Updates the shared log level within the actor's protected context.
    private func setLogLevelInternally(_ level: LogLevel) {
        logLevel = level
    }
}
