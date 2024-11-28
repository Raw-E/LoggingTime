import Foundation

// Extension to center a string within a container
public extension String {
    func centered(in container: String) -> String {
        let padding = max(0, container.count - self.count) / 2
        return String(repeating: " ", count: padding) + self + String(repeating: " ", count: padding)
    }
}
