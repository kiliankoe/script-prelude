import Foundation

extension URLSession {
    func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?) {
        URLSession.shared.dataTask(with: url) {
            data, response, error in

        }
        return (nil, nil, nil)
    }
}
