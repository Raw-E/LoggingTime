public enum LogLevel: Int, Comparable, Sendable {
    case trace = 0
    case inspect = 1
    case search = 2
    case observe = 3
    case info = 4
    case concern = 5
    case suspect = 6
    case error = 7
    case danger = 8
    case showstopper = 9

    public var icon: String {
        switch self {
        case .trace: return "👣"
        case .inspect: return "🕵️"
        case .search: return "🔍"
        case .observe: return "👀"
        case .info: return "ℹ️"
        case .concern: return "💭"
        case .suspect: return "🤔"
        case .error: return "🐛"
        case .danger: return "⛔️"
        case .showstopper: return "💀"
        }
    }

    public var description: String {
        String(describing: self).uppercased()
    }

    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
