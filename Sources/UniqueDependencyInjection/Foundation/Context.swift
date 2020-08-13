//
//  File.swift
//  
//
//  Created by Macsed on 2020/8/11.
//

import Foundation

public class UDIContext {
    
    public var tag : String
    private var dependencies = WeakValueDictionary<String,UDIObject>()
    internal var subContexts = [UDIContext]()
    
    internal func bind<T:UDIObject>(property : T, aProtocol : Any){
        dependencies["\(aProtocol)"] = property
    }
    
    internal func remove(_ aProtocol : Any){
        dependencies.removeValue(forKey: "\(aProtocol)")
    }
    
    internal func link<T:UDIObject>(_ aProtocol : Any) -> T? {
        if dependencies["\(aProtocol)"] != nil{
            if let obj = dependencies["\(aProtocol)"] as? T{
                return obj
            }else{
                return nil
            }
        }else{
            return nil
        }
    }
    
    public func addSubContext(_ context:UDIContext){
        if let _ = self.subContexts.firstIndex(where: { (_context) -> Bool in
            return _context.tag == context.tag
        }){
            fatalError("you can't add sub contexts with same tag")
        }else{
            self.subContexts.append(context)
        }
    }
    
    public func romoveSubContext(_ context:UDIContext){
        self.subContexts.append(context)
    }
    
    public func removeSubContext(withTag tag:String){
        self.subContexts.removeAll { (_context) -> Bool in
            return _context.tag == tag
        }
    }
    
    public init(withTag tag:String){
        self.tag = tag
    }
    
}

let AppContext = UDIContext(withTag: "AppContext")
