//
//  File.swift
//  
//
//  Created by Macsed on 2020/8/12.
//

import Foundation

class WeakValueDictionary<Key:Hashable,Value>{
    
    private var storage = [Key:WeakValueReference<Value>]()
    
    init(){
        
    }
    
   func removeValue(forKey key:Key){
        storage.removeValue(forKey: key)
    }
}

struct WeakValueReference<Value>{
    private weak var reference : AnyObject?
    
    init (value:Value){
        reference = value as AnyObject
    }
    
    var value : Value?{
        get {
            if let ref = reference as? Value{
                return ref
            }else{
                return nil
            }
        }
    }
}

extension WeakValueDictionary {
    subscript (key:Key) -> Value?{
        get{
            guard let ref = self.storage[key] else{
                return nil
            }
            return ref.value
        }
        set(newValue){
            if newValue != nil{
                self.storage[key] = WeakValueReference(value: newValue!)
            }
        }
    }
}
