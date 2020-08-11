import XCTest

import UniqueDependencyInjectionTests

var tests = [XCTestCaseEntry]()
tests += UniqueDependencyInjectionTests.allTests()
XCTMain(tests)
