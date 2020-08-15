//
//  UDIDebugAlertMananger.swift
//  
//
//  Created by Macsed on 2020/8/12.
//

import Foundation
import UIKit

class UDIDebugAlertMananger {
    
    static func show(withHost host:Any,forProtocol aProtocol:Any){
        let alertVC = UIAlertController(title: "UniqueDI使用方法不正确", message: "\(host)在使用UniqueDI时方法不正确，在操作\(aProtocol)时未关联上下文，已默认为其指定AppContext，但这会带来使用隐患，可能导致bug", preferredStyle: .alert)
        
        showAlert(for: alertVC)
    }
    
    static func show(withHost host:Any,forUsage usage:String){
        let alertVC = UIAlertController(title: "UniqueDI使用方法不正确", message: "\(host)在使用UniqueDI时方法不正确，在操作\(usage)时未关联上下文，已默认为其指定AppContext，但这会带来使用隐患，可能导致bug", preferredStyle: .alert)
        
        showAlert(for: alertVC)
    }
    
    private static func showAlert(for vc:UIAlertController){
        
        vc.addAction(.init(title: "OK", style: .default, handler: nil))
        
        var showingVC : UIViewController!
        if #available(iOS 13, *) {
            let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
            if var topController = keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                showingVC = topController
            }
        }else{
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                showingVC = topController
            }
        }
        if (showingVC == nil){
            return
        }
        showingVC.present(vc, animated: true, completion: nil)
    }
    
}
