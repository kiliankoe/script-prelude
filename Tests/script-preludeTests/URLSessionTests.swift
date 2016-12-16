import XCTest
@testable import script_prelude

class URLSessionTests: XCTestCase {
    func testSynchronousDataTask() {
        guard let url = URL(string: "https://httpbin.org/get") else {
            XCTFail("misformatted URL")
            return
        }

        let response = URLSession.shared.synchronousDataTask(with: url)
        XCTAssertEqual(response.0, nil)
    }

    static var allTests: [(String, (URLSessionTests) -> () throws -> Void)] {
        return [
            ("testSynchronousDataTask", testSynchronousDataTask),
        ]
    }
}
