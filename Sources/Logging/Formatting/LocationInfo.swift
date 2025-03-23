import Foundation

/// Formats and stores location information for log messages.
struct LocationInfo {
    // MARK: - Properties

    let projectName: String
    let fileName: String
    let function: String
    let line: Int
    let functionEmoji: String
    let isCaller: Bool

    // MARK: - Initialization

    init(context: LoggingContext, isCaller: Bool = false) {
        self.fileName = (context.file as NSString).lastPathComponent
        self.projectName = ((context.file as NSString).deletingLastPathComponent as NSString).lastPathComponent

        let formatter = FunctionNameFormatter(context.function)
        self.function = formatter.formatted
        self.functionEmoji = formatter.emoji
        self.line = context.line
        self.isCaller = isCaller
    }

    init(callerContext: LoggingContext.CallerContext) {
        self.fileName = callerContext.fileName
        self.projectName =
            ((callerContext.file as NSString).deletingLastPathComponent as NSString).lastPathComponent

        let formatter = FunctionNameFormatter(callerContext.function)
        self.function = formatter.formatted
        self.functionEmoji = formatter.emoji
        self.line = callerContext.line
        self.isCaller = true
    }

    // MARK: - Formatting

    var formatted: String {
        let indent = LoggingConstants.indentationMarker
        let mainPath = "\(projectName)/\(fileName)"
        let functionPart = "\(functionEmoji)\(function) at line \(line)"

        if isCaller {
            return """
                \(indent)   └─ \(LoggingConstants.callerIndicatorEmoji) \(mainPath)
                \(indent)      └─ \(functionPart)
                """
        }
        else {
            return """
                📍 \(mainPath)
                \(indent)└─ \(functionPart)
                """
        }
    }
}
