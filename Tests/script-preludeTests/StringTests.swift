import XCTest
@testable import script_prelude

class StringTests: XCTestCase {
    func testBase64Encode() {
        let str = "hello world"
        guard let base64 = str.base64 else {
            XCTFail("failed to encode string")
            return
        }
        XCTAssertEqual(base64, "aGVsbG8gd29ybGQ=")
    }

    static var allTests: [(String, (StringTests) -> () throws -> Void)] {
        return [
            ("testBase64Encode", testBase64Encode),
        ]
    }
}
