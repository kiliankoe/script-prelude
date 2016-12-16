import Foundation

extension URLSession {
    /// Retrieves the contents of the specified URL, waiting for the request to be
    /// completed before returning the results directly.
    ///
    /// - Parameter url: URL to be retrieved
    /// - Returns: optional raw data, response and error objects
    public func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?) {
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

    /// Retrieves the contents of a URL based on the contents of the specificed URLRequest,
    /// waiting for the request to be completed before returning the results directly.
    ///
    /// - Parameter request: Request to be sent
    /// - Returns: optional raw data, response and error objects
    public func synchronousDataTask(with request: URLRequest) -> (Data?, URLResponse?, Error?) {
        let semaphore = DispatchSemaphore(value: 0)

        var data: Data?
        var response: URLResponse?
        var error: Error?

        dataTask(with: request) {
            data = $0
            response = $1
            error = $2

            semaphore.signal()
        }.resume()

        semaphore.wait()

        return (data, response, error)
    }

}
