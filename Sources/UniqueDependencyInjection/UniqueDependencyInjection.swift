//
//  UniqueDependencyInjection.swift
//  UniqueDependencyInjection
//
//  Created by Macsed on 2020/8/11.
//  Copyright © 2020 Macsed. All rights reserved.
//
import Foundation

///UDI base协议 **被注入及获取注入的对象都需要**
///
///任何使用UniqueDI的对象都应该实现这个协议
public protocol UDIObject{
    ///关联上下文后应执行的内容 **自动调用**
    ///
    ///修改可注入对象的attachedContext属性后将会自动调用
    func didAttachContext()
    ///目前关联的上下文 UDIContext **不推荐直接使用**
    ///
    ///这个属性用于内部实现，正常使用应当调用attachedContext
    var _attachedContext : UDIContext? {get set}
    
}

extension UDIObject{
    ///目前关联的上下文 UDIContext
    ///
    ///修改后会自动调用didAttachContext
    public var attachedContext : UDIContext? {
        set{
            self._attachedContext = newValue
            self.didAttachContext()
        }
        get{
            return _attachedContext
        }
    }
    
    ///获取实现Protocol的实例并将其赋值给Property
    ///
    ///注意，property的引用类型weak/strong会影响到实例的生命周期
    public func UDILink<T:UDIObject>(property:inout T?,aProtocol:Any){
        if property == nil{
            return
        }
        if (self.attachedContext != nil){
            guard let _property = UDIManager.linkObj(in: self.attachedContext! , for: aProtocol) as? T else {
                property = nil
                return
            }
            property = _property
        }else{
            guard let _property = UDIManager.linkObj(in: AppContext , for: aProtocol) as? T else {
                property = nil
                return
            }
            property = _property
        }
    }
    
    ///获取实现Protocol的实例
    ///
    ///注意，使用此方法获取实例时，应直接在使用后调用其能力而非将其引用存储下来
    public func UDILinkInLine<T:UDIObject>(aProtocol:T) -> T?{
        if (self.attachedContext != nil){
            guard let _property = UDIManager.linkObj(in: self.attachedContext! , for: aProtocol) else {
                return nil
            }
            return _property
        }else{
            guard let _property = UDIManager.linkObj(in: AppContext , for: aProtocol) else {
                return nil
            }
            return _property
        }
    }

    public func UDIBind<T:UDIObject>(property: T,aProtocol:Any){
        if (self.attachedContext != nil){
            UDIManager.bindObj(in: self.attachedContext!, for: aProtocol, with: property)
        }else{
            UDIManager.bindObj(in: AppContext, for: aProtocol, with: property)
        }
    }
    
}


@propertyWrapper
struct UDIInject<T:UDIObject> {
    let wrappedValue : T
}
