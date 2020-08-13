//
//  UniqueDependencyInjection.swift
//  UniqueDependencyInjection
//
//  Created by Macsed on 2020/8/11.
//  Copyright © 2020 Macsed. All rights reserved.
//
import Foundation

///基础配置
///
///可以调节部分behavior
public class UDI{
    ///是否启用调试下Context设置检测
    ///
    ///启用后在调试下，如果Context未设置就调用相关能力将会有警告内容
    public static var enableUsageDetection : Bool = false
}




///UDI base协议 **被注入及获取注入的对象都需要**
///
///任何使用UniqueDI的对象都应该实现这个协议
public protocol UDIObject : AnyObject {
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
        usageCheck(aProtocol)
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
        usageCheck(aProtocol)
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

    ///注册实现Protocol的实例
    ///
    ///注册的上下文是调用本方法的实例的Context
    public func UDIBind<T:UDIObject>(property: T,aProtocol:Any){
        usageCheck(aProtocol)
        if (self.attachedContext != nil){
            UDIManager.bindObj(in: self.attachedContext!, for: aProtocol, with: property)
        }else{
            UDIManager.bindObj(in: AppContext, for: aProtocol, with: property)
        }
    }
    
    ///依据tag查找当前上下文中的子上下文
    ///
    ///当前上下文是调用本方法的实例的Context
    public func UDIFind(_ tag:String) -> UDIContext? {
        usageCheck("寻找tag为\(tag)的Context")
        if self.attachedContext != nil{
            return UDIManager.getContext(in: self.attachedContext!, for: tag)
        }else{
            return UDIManager.getContext(in: AppContext, for: tag)
        }
        
    }
    
    private func usageCheck(_ aProtocol:Any){
        #if DEBUG
        if UDI.enableUsageDetection {
            if self.attachedContext == nil{
                UDIDebugAlertMananger.show(withHost: self, forProtocol: aProtocol)
            }
        }
        #else
        return
        #endif
    }
    
    private func usageCheck(_ usage:String){
        #if DEBUG
        if UDI.enableUsageDetection {
            if self.attachedContext == nil{
                UDIDebugAlertMananger.show(withHost: self, forUsage: usage)
            }
        }
        #else
        return
        #endif
    }
}


@propertyWrapper
struct UDIInject<T:UDIObject> {
    let wrappedValue : T
}
