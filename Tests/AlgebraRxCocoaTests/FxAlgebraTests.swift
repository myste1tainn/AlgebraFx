import XCTest
@testable import RxAlgebra

final class RxAlgebraTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RxAlgebra().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
