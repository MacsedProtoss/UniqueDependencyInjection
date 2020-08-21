# UniqueDependencyInjection

## Unique 组件补全计划 
依赖注入

## Progress

- [x] Bind & Link
- [x] FindContext
- [x] Context隔离
- [ ] Debug Tools
- [ ] 快速全局依赖注入

## Requirements
- Swift 5.0+
- iOS 10.0+

## How to Use
已接入Swift Package Manager，使用SPM直接导入本项目即可

### 前置条件
正常使用时，应当confirm to UDIObject这一协议
```Swift
protocol myProtocol{
    func YOURFUNC()
}

class myClass : UDIObject,myProtocol{
    func didAttachContext() {
        //这里通常是将自身bind上去，如果不需要bind自身，则此处留空即可
    }

    var _attachedContext: UDIContext? //请不要直接使用该属性
    
    func YOURFUNC(){
        //这是你的协议所定义的能力
    }
}
```

### Bind
将依赖注入进当前所在上下文（UDIContext）
```Swift
// UDIBind(PROPERTY,PROTOCOL)

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

```


UDILinkInLine
```Swift
// UDILinkInLine() 

var a : myProtocol?
a = UDILinkInLine()

```

### 快速全局依赖注入
Under constructing


## License

This repo is under Anti-996-License


