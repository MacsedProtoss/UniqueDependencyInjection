
import Foundation

public protocol UDIInjectObject{
    
}

public protocol UDIProtocol{
    
}

@propertyWrapper
struct UDIInject<T:UDIInjectObject> {
    let wrappedValue : T
}

func keyForProtocol<P>(aProtocol: P.Type) -> String {
    return ("\(aProtocol)")
}

class UDIContext {
    private var dependencies = [String:UDIInjectObject]()
    
    func bind<T:UDIInjectObject,K:Any>(property : T, aProtocol : K){
        dependencies["\(aProtocol)"] = property
    }
    
    
}

let context = UDIContext()

protocol testProtocol :UDIProtocol{
    
}

class testClass : UDIInjectObject,testProtocol{
    
}

let obj = testClass()

context.bind(property: obj, aProtocol: testProtocol.self)
