//
//  UDIContext.swift
//  
//
//  Created by Macsed on 2020/8/11.
//

import Foundation

public class UDIContext {
    
    public var tag : String
    private var dependencies = WeakValueDictionary<String,UDIObject>()
    internal var subContexts = [UDIContext]()
    
    internal func bind<Property:UDIObject>(property : Property, aProtocol : Any){
        dependencies[self.wrappedKey(aProtocol)] = property
    }
    
    internal func remove(_ aProtocol : Any){
        dependencies.removeValue(forKey: self.wrappedKey(aProtocol))
    }
    
    internal func link<aProtocol>() -> aProtocol? {
        if dependencies[self.wrappedKey(aProtocol.self)] != nil{
            if let obj = dependencies[self.wrappedKey(aProtocol.self)] as? aProtocol{
                return obj
            }else{
                return nil
            }
        }else{
            return nil
        }
    }
    
    internal func findSubContext(withTag tag:String) -> UDIContext? {
        if let index = self.subContexts.firstIndex(where: { (_context) -> Bool in
            return _context.tag == tag
        }){
            return self.subContexts[index]
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
    
    private func wrappedKey(_ aProtocol:Any) -> String{
        return String(reflecting: aProtocol)
    }
    
    public init(withTag tag:String){
        self.tag = tag
    }
    
}
