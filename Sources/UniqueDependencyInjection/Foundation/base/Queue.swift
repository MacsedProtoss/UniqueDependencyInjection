//
//  Queue.swift
//  
//
//  Created by Macsed on 2020/8/13.
//

import Foundation

struct Queue<Element> {
    private var storage = [Element]()
    
    mutating func In(_ element:Element){
        storage.append(element)
    }
    
    mutating func Out() -> Element!{
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
