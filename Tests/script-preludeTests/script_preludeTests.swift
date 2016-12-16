import XCTest
@testable import script_prelude

class script_preludeTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(script_prelude().text, "Hello, World!")
    }


    static var allTests : [(String, (script_preludeTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
