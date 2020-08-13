//
//  File.swift
//  
//
//  Created by Macsed on 2020/8/11.
//

import Foundation

class UDIManager {
    
    static func linkObj<T>(in context:UDIContext,for aProtocol:T) -> T? {
        return nil
    }
    
    static func bindObj<T>(in context:UDIContext, for aProtocol:Any, with property:T) {
        
    }
    
    static func getContext(in parentContext:UDIContext,for tag:String) -> UDIContext? {
        return nil
    }
    
}
