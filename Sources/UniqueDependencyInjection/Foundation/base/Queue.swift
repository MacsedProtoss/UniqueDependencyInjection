//
//  Queue.swift
//  
//
//  Created by Macsed on 2020/8/13.
//

import Foundation

struct Queue<T> {
    private var storage = [T]()
    
    mutating func push(_ element:T){
        storage.append(element)
    }
    
    mutating func pop() -> T!{
        let output = storage.first
        if (storage.count > 0){
            storage.removeFirst()
        }
        return output
    }
    
    var remainCount : Int{
        get{
            return storage.count
        }
    }
}
