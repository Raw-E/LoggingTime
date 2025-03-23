import Foundation

/// Formats log messages with location information and visual styling.
struct MessageFormatter {
    // MARK: - Properties

    let level: LogLevel
    let message: String
    let location: LocationInfo
    let callerLocation: LocationInfo?

    // MARK: - Formatting

    var formatted: [String] {
        var output = [
            "",
            LoggingConstants.boxTop,
            "\(LoggingConstants.boxSide)\(formatLogLevel()) \(LoggingConstants.boxSide)",
        ]

        // Add location information
        let locationLines = location.formatted.split(separator: "\n")
        output.append(
            contentsOf: locationLines.map {
                "\(LoggingConstants.boxSide) \($0.padding(toLength: LoggingConstants.contentWidth, withPad: " ", startingAt: 0)) \(LoggingConstants.boxSide)"
            }
        )

        // Add caller location if available
        if let callerLocation {
            let callerLines = callerLocation.formatted.split(separator: "\n")
            output.append(
                contentsOf: callerLines.map {
                    "\(LoggingConstants.boxSide) \($0.padding(toLength: LoggingConstants.contentWidth, withPad: " ", startingAt: 0)) \(LoggingConstants.boxSide)"
                }
            )
        }

        // Add message content
        output.append(contentsOf: [
            LoggingConstants.boxBottom,
            "\(LoggingConstants.leftDots)\(LoggingConstants.logContentHeader)\(LoggingConstants.rightDots)",
            message,
            LoggingConstants.finalSeparator,
        ])

        return output
    }

    // MARK: - Private Helpers

    private func formatLogLevel() -> String {
        "[\(level.icon) \(level.description)]".centered(
            in: String(repeating: " ", count: LoggingConstants.contentWidth)
        )
    }
}
