import Foundation

/// Captures contextual information about a logging call, such as the file, function, and line.
public struct LoggingContext: Sendable {
    // MARK: - Properties

    let file: String
    let function: String
    let line: Int
    let callerContext: CallerContext?

    var fileName: String {
        (file as NSString).lastPathComponent
    }

    // MARK: - Nested Types

    /// Holds information about the caller's context if a function wraps another function's logging.
    public struct CallerContext: Sendable {
        let file: String
        let function: String
        let line: Int

        var fileName: String {
            (file as NSString).lastPathComponent
        }
    }

    // MARK: - Constructors

    /// Creates a standard logging context for the current call site.
    public static func current(
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) -> LoggingContext {
        LoggingContext(file: file, function: function, line: line, callerContext: nil)
    }

    /// Creates a logging context that retains both the current and caller contexts.
    public static func withCaller(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        callerFile: String,
        callerFunction: String,
        callerLine: Int
    ) -> LoggingContext {
        let callerContext = CallerContext(
            file: callerFile,
            function: callerFunction,
            line: callerLine
        )
        return LoggingContext(
            file: file,
            function: function,
            line: line,
            callerContext: callerContext
        )
    }
}
