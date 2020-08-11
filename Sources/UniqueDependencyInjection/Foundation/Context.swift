//
//  File.swift
//  
//
//  Created by Macsed on 2020/8/11.
//

import Foundation

class UDIContext {
    
    private var dependencies = [String:UDIInjectObject]()
    
    func bind<T:UDIInjectObject>(property : T, aProtocol : Any){
        dependencies["\(aProtocol)"] = property
    }
    
    func remove(_ aProtocol : Any){
        dependencies.removeValue(forKey: "\(aProtocol)")
    }
    
    func link(_ aProtocol : Any) -> UDIInjectObject? {
        return dependencies["\(aProtocol)"]
    }
    
}
