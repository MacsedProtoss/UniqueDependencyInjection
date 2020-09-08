# UniqueDependencyInjection
 
Swift 依赖注入

## Progress

- [x] Bind & Link
- [x] FindContext
- [x] Context隔离
- [ ] Debug Tools
- [x] 快速全局依赖注入

## Requirements
- Swift 5.0+
- iOS 10.0+

## How to Use
已接入Swift Package Manager，使用SPM直接导入本项目即可

### 前置条件
正常使用时，应当confirm to UDIObject这一协议
```Swift
protocol myProtocol{
    func myFunc()
}

class myClass : UDIObject,myProtocol{
    func didAttachContext() {
        //推荐在此处进行 UDILink、UDIBind
    }

    var _attachedContext: UDIContext? //请不要直接使用该属性
    
    func myFunc(){
        //这是你的协议所定义的能力
    }
}
```

### Bind
将依赖注册进当前所在上下文（UDIContext）
```Swift
// UDIBind(PROPERTY,PROTOCOL) 自动移除旧上下文注册信息

let a = myClass()
UDIBind(a,myProtocol)


```

```Swift
// UDIMultiBind(PROPERTY,PROTOCOL) 允许多上下文注册

let a = myClass()
UDIBind(a,myProtocol)


```

### Link
从当前所在上下文注入依赖

UDILink
```Swift
// UDILink(&PROPERTY) 

var a : myProtocol?
UDILink(&a)
a?.myFunc()

```


UDILinkInLine
```Swift
// UDILinkInLine(PROTOCOL) 

UDILinkInLine(myProtocol.self)?.myFunc()

```

### 快速全局依赖注入
@UDIGLink **本方法会从AppContext注入依赖**
```Swift
//@UDIGLink(PROTOCOL)

@UDIGLink(myProtocol.self) var a : myProtocol?

```


## License

This repo is under Anti-996-License


