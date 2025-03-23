import Foundation

/// Formats function names for display in log messages.
struct FunctionNameFormatter {
    // MARK: - Properties

    private let function: String

    // MARK: - Initialization

    init(_ function: String) {
        self.function = function
    }

    // MARK: - Formatting

    var formatted: String {
        let cleaned =
            function
            .replacingOccurrences(of: "(_:file:function:line:)", with: "")
            .replacingOccurrences(of: "()", with: "")

        if cleaned == "<top_level>" {
            return cleaned
        }

        if cleaned.contains("(") {
            return cleaned
        }

        return "\(cleaned)()"
    }

    var emoji: String {
        function == "<top_level>" ? LoggingConstants.topLevelFunctionEmoji : LoggingConstants.regularFunctionEmoji
    }
}
