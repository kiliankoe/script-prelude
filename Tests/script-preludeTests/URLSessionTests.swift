import XCTest
@testable import script_prelude

class URLSessionTests: XCTestCase {
    func testSynchronousDataTaskWithURL() {
        guard let url = URL(string: "https://httpbin.org/get") else {
            XCTFail("malformed URL")
            return
        }

        guard let response = (URLSession.shared.synchronousDataTask(with: url).1 as? HTTPURLResponse) else {
            XCTFail("failed on getting response")
            return
        }
        XCTAssertEqual(response.statusCode, 200)
    }

    func testSynchronousDataTaskWithRequest() {
        guard let url = URL(string: "https://httpbin.org/get") else {
            XCTFail("malformed URL")
            return
        }
        let request = URLRequest(url: url)

        guard let response = (URLSession.shared.synchronousDataTask(with: request).1 as? HTTPURLResponse) else {
            XCTFail("failed on getting response")
            return
        }
        XCTAssertEqual(response.statusCode, 200)
    }

    func testGet() {
        guard let url = URL(string: "https://httpbin.org/get") else {
            XCTFail("malformed URL")
            return
        }

        guard let response = try? URLSession.shared.get(url, headers: ["foo": "bar"]) else {
            XCTFail("failed on getting response")
            return
        }

        guard let statusCode = (response.1 as? HTTPURLResponse)?.statusCode else {
            XCTFail("response is not an HTTPURLResponse")
            return
        }

        XCTAssertEqual(statusCode, 200)
    }

    func testPost() {
        guard let url = URL(string: "https://httpbin.org/post") else {
            XCTFail("malformed URL")
            return
        }

        guard let response = try? URLSession.shared.post(url, body: nil, headers: ["foo": "bar"]) else {
            XCTFail("failed on getting response")
            return
        }

        guard let statusCode = (response.1 as? HTTPURLResponse)?.statusCode else {
            XCTFail("response is not an HTTPURLResponse")
            return
        }

        XCTAssertEqual(statusCode, 200)
    }

    static var allTests: [(String, (URLSessionTests) -> () throws -> Void)] {
        return [
            ("testSynchronousDataTaskWithURL", testSynchronousDataTaskWithURL),
            ("testSynchronousDataTaskWithRequest", testSynchronousDataTaskWithRequest),
            ("testGet", testGet),
            ("testPost", testPost),
        ]
    }
}
