//
//  UDIManager.swift
//  
//
//  Created by Macsed on 2020/8/11.
//

import Foundation

class UDIManager {
    
    static func linkObj<aProtocol>(in context:UDIContext) -> aProtocol? {
        return findObjInWholeTree(in: context)
    }
    
    static func bindObj<Property:UDIObject>(in context:UDIContext, for aProtocol:Any, with property:Property) {
        context.bind(property: property, aProtocol: aProtocol)
    }
    
    static func getContext(in parentContext:UDIContext,for tag:String) -> UDIContext? {
        return findContextInWholeTree(in: parentContext, for: tag)
    }
    
    static func cancelBind(in context:UDIContext,for aProtocol:Any){
        context.remove(aProtocol)
    }
    
    static private func findObjInWholeTree<aProtocol>(in parentContext:UDIContext) -> aProtocol?{
        var queue = Queue<UDIContext>()
        queue.In(parentContext)
        
        while queue.remainCount > 0{
            guard let context = queue.Out() else{
                continue
            }
            
            if let result : aProtocol = context.link() {
                return result
            }else{
                for subContext in context.subContexts{
                    queue.In(subContext)
                }
            }
        }
        return nil
    }
    
    static private func findContextInWholeTree(in parentContext:UDIContext,for tag:String) -> UDIContext! {
        var queue = Queue<UDIContext>()
        queue.In(parentContext)
        
        while queue.remainCount > 0 {
            guard let context = queue.Out() else{
                continue
            }
            if let result = findContext(in: context, for: tag){
                return result
            }else{
                for subContext in context.subContexts{
                    queue.In(subContext)
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
