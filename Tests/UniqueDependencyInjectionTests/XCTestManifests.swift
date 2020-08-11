import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(UniqueDependencyInjectionTests.allTests),
    ]
}
#endif
