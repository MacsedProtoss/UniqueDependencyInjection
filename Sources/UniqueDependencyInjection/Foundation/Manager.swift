//
//  UDIManager.swift
//  
//
//  Created by Macsed on 2020/8/11.
//

import Foundation

class UDIManager {
    
    static func linkObj<T>(in context:UDIContext) -> T? {
        return findObjInWholeTree(in: context)
    }
    
    static func bindObj<T:UDIObject>(in context:UDIContext, for aProtocol:Any, with property:T) {
        context.bind(property: property, aProtocol: aProtocol)
    }
    
    static func getContext(in parentContext:UDIContext,for tag:String) -> UDIContext? {
        return findContextInWholeTree(in: parentContext, for: tag)
    }
    
    static private func findObjInWholeTree<T>(in parentContext:UDIContext) -> T?{
        var queue = Queue<UDIContext>()
        queue.push(parentContext)
        
        while queue.remainCount > 0{
            guard let context = queue.pop() else{
                continue
            }
            
            if let result : T = context.link() {
                return result
            }else{
                for subContext in context.subContexts{
                    queue.push(subContext)
                }
            }
        }
        return nil
    }
    
    static private func findContextInWholeTree(in parentContext:UDIContext,for tag:String) -> UDIContext! {
        var queue = Queue<UDIContext>()
        queue.push(parentContext)
        
        while queue.remainCount > 0 {
            guard let context = queue.pop() else{
                continue
            }
            if let result = findContext(in: context, for: tag){
                return result
            }else{
                for subContext in context.subContexts{
                    queue.push(subContext)
                }
            }
        }
        
        return nil
    }
    
    static private func findContext(in parentContext:UDIContext,for tag:String) -> UDIContext! {
        if let contenxt = parentContext.findSubContext(withTag: tag) {
            return contenxt
        }else{
            return nil
        }
    }
    
}
