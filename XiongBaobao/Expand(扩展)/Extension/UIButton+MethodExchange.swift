//
//  UIButton+MethodExchange.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/4.
//  Copyright © 2018 双双. All rights reserved.
//

public extension UIButton {

    // 关联的键
    public struct AssociatedKeys {
        static var defaultInterval: TimeInterval = 1.5
        static var eventIntervalKey = "eventInterval"
        static var isEventUnavailableKey = "isEventUnavailable"
    }
    
    // 触发事件的间隔
    var eventInterval: TimeInterval {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.eventIntervalKey) as? TimeInterval) ?? AssociatedKeys.defaultInterval
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventIntervalKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
   
    // 是否可以触发事件
    fileprivate var isEventUnavailable: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.isEventUnavailableKey) != nil)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isEventUnavailableKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    static func initializeMethod() {
        let originalSelector = #selector(UIButton.sendAction(_:to:for:))
        let swizzledSelector = #selector(UIButton.xbb_SendAction(_: to: for:))
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
    
    @objc fileprivate func xbb_SendAction(_ action: Selector, to target: Any?, for event: UIEvent?){
        if !isEventUnavailable {
            isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + eventInterval, execute: {
                self.isUserInteractionEnabled = true
            })
        }
        xbb_SendAction(action, to: target, for: event)
    }
}
