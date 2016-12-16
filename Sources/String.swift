import Foundation

extension String {
    var base64: String? {
        return data(using: .utf8)?.base64EncodedString(options: .lineLength64Characters)
    }
}
