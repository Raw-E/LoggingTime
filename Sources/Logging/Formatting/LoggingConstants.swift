import Foundation

/// Constants used for log message formatting.
enum LoggingConstants {
    // MARK: - Box Drawing

    static let boxWidth = 98
    static let contentWidth = boxWidth - 2  // -2 for the side borders and spaces
    static let finalSeparator = String(repeating: "━", count: 100)
    static let boxTop = "┏" + String(repeating: "━", count: boxWidth) + "┓"
    static let boxBottom = "┗" + String(repeating: "━", count: boxWidth) + "┛"
    static let boxSide = "┃"

    // MARK: - Content Headers

    static let logContentHeader = "[📝 Log Content]"
    static let dotsWidth = (boxWidth - logContentHeader.count) / 2
    static let leftDots = String(repeating: "·", count: dotsWidth)
    static let rightDots = String(
        repeating: "·",
        count: boxWidth - dotsWidth - logContentHeader.count + 1
    )

    // MARK: - Function Indicators

    static let topLevelFunctionEmoji = "📌"
    static let regularFunctionEmoji = "⚡️"
    static let callerIndicatorEmoji = "📞"

    // MARK: - Indentation

    static let indentationMarker = "│  "
}
