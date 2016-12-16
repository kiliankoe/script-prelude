import Foundation

extension URLSession {
    func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?) {
        let semaphore = DispatchSemaphore(value: 0)

        var data: Data?
        var response: URLResponse?
        var error: Error?

        dataTask(with: url) {
            data = $0
            response = $1
            error = $2

            semaphore.signal()
        }.resume()

        semaphore.wait()

        return (data, response, error)
    }
}
