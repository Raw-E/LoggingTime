import Foundation

// Extension to center a string within a container
extension String {
    func centered(in container: String, paddingCharacter: Character = " ") -> String {
        let containerWidth = container.count
        let textWidth = self.count

        guard textWidth < containerWidth else { return self }

        let totalPadding = containerWidth - textWidth
        let leftPadding = totalPadding / 2
        let rightPadding = totalPadding - leftPadding  // Handles odd-length differences

        return String(repeating: paddingCharacter, count: leftPadding) + self
            + String(repeating: paddingCharacter, count: rightPadding)
    }
}
