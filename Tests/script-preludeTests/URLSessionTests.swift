import XCTest
@testable import script_prelude

class URLSessionTests: XCTestCase {
    func testSynchronousDataTask() {
        guard let url = URL(string: "https://httpbin.org/get") else {
            XCTFail("misformatted URL")
            return
        }

        guard let response = (URLSession.shared.synchronousDataTask(with: url).1 as? HTTPURLResponse) else {
            XCTFail("failed on getting response")
            return
        }
        XCTAssertEqual(response.statusCode, 200)
    }

    static var allTests: [(String, (URLSessionTests) -> () throws -> Void)] {
        return [
            ("testSynchronousDataTask", testSynchronousDataTask),
        ]
    }
}
