import Foundation

extension String {
    /// Returns a Base-64 encoded representation of self.
    public var base64: String? {
        return data(using: .utf8)?.base64EncodedString(options: .lineLength64Characters)
    }
}
