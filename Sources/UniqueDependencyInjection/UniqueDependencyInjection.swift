//
//  UniqueDependencyInjection.swift
//  UniqueDependencyInjection
//
//  Created by Macsed on 2020/8/11.
//  Copyright © 2020 Macsed. All rights reserved.
//
import Foundation

public protocol UDIInjectObject{
    
}

public protocol UDIProtocol{
    var desciption : String {set get}
}

@propertyWrapper
struct UDIInject<T:UDIInjectObject> {
    let wrappedValue : T
}
