//
//  UniqueDependencyInjection.swift
//  UniqueDependencyInjection
//
//  Created by Macsed on 2020/8/11.
//  Copyright © 2020 Macsed. All rights reserved.
//
import Foundation

///可注入类型协议
///
///任何使用UniqueDI的对象都应该实现这个协议
public protocol UDIInjectObject{
    ///关联上下文后应执行的内容 **自动调用**
    ///
    ///修改可注入对象的attachedContext属性后将会自动调用
    func didAttachContext()
    ///目前关联的上下文 UDIContext **不推荐直接使用**
    ///
    ///这个属性用于内部实现，正常使用应当调用attachedContext
    var _attachedContext : UDIContext? {get set}
    
}

extension UDIInjectObject{
    var attachedContext : UDIContext? {
        set{
            self._attachedContext = newValue
            self.didAttachContext()
        }
        get{
            return _attachedContext
        }
    }
}

public protocol UDIProtocol{
    var desciption : String {set get}
}

@propertyWrapper
struct UDIInject<T:UDIInjectObject> {
    let wrappedValue : T
}



