import XCTest
@testable import UniqueDependencyInjection

final class UniqueDependencyInjectionTests: XCTestCase,UDIObject {
    func didAttachContext() {
        //
    }
    
    var _attachedContext: UDIContext?
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let a = myClass()
        a.attachedContext = self.attachedContext
        var b : myProtocol!
        b = UDILinkInLine()
        if (b != nil){
            b!.hello()
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

protocol myProtocol {
    func hello()
}

class myClass : UDIObject,myProtocol{
    func hello() {
        print("hellp world")
    }
    
    func didAttachContext() {
        UDIBind(property: self, aProtocol: myProtocol.self)
    }
    
    var _attachedContext: UDIContext?
}
