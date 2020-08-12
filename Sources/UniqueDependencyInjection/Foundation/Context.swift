//
//  File.swift
//  
//
//  Created by Macsed on 2020/8/11.
//

import Foundation

public class UDIContext {
    
    private var dependencies = [String:UDIObject]()
    
    func bind<T:UDIObject>(property : T, aProtocol : Any){
        dependencies["\(aProtocol)"] = property
    }
    
    func remove(_ aProtocol : Any){
        dependencies.removeValue(forKey: "\(aProtocol)")
    }
    
    func link<T:UDIObject>(_ aProtocol : Any) -> T? {
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
    
}

let AppContext = UDIContext()
