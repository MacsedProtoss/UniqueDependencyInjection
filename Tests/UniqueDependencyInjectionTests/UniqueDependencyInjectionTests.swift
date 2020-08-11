import XCTest
@testable import UniqueDependencyInjection

final class UniqueDependencyInjectionTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(UniqueDependencyInjection().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
