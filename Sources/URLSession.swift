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

    /// Retrieve the contents of the specified URL via a GET request with optional headers.
    ///
    /// - Parameters:
    ///   - url: URL to be retrieved
    ///   - headers: optional headers to be set
    /// - Returns: raw data and URLResponse
    /// - Throws: any occurring error
    public func get(_ url: URL, headers: [String: String]? = nil) throws -> (Data?, URLResponse?) {
        var request = URLRequest(url: url)

        if let headers = headers {
            for (header, value) in headers {
                request.addValue(value, forHTTPHeaderField: header)
            }
        }

        let response = synchronousDataTask(with: request)
        if let error = response.2 {
            throw error
        }
        return (response.0, response.1)
    }

    /// Retrieve the contents of the specified URL via a POST request with optional headers.
    ///
    /// - Parameters:
    ///   - url: URL to be retrieved
    ///   - body: body to be sent as formurlencoded data
    ///   - headers: optional headers to be set
    /// - Returns: raw data and URLResponse
    /// - Throws: any occurring error
    public func post(_ url: URL, body: Data?, headers: [String: String]? = nil) throws -> (Data?, URLResponse?) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body

        if let headers = headers {
            for (header, value) in headers {
                request.addValue(value, forHTTPHeaderField: header)
            }
        }

        let response = synchronousDataTask(with: request)
        if let error = response.2 {
            throw error
        }
        return (response.0, response.1)
    }
}
