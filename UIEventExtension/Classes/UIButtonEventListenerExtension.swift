//
//  UIButtonEvent.swift
//  Pods
//
//  Created by Spring Wong on 1/4/2017.
//
//

import Foundation

extension UIButton{
    internal struct ClosureWrapper {
        var closure: (EventListener)?
        init(_ closure: (EventListener)?) {
            self.closure = closure
        }
    }
}

private var TouchUpInsideListener: UInt8 = 0
public extension UIButton {
    public func setTouchUpInsideListener(_ event : @escaping EventListener) {
        self.touchUpInside = event
        self.addTarget(self, action: #selector(touchUpInsideEvent), for: .touchDownRepeat)
    }
    
    private var touchUpInside: (EventListener)? {
        get {
            let wrapper =
                objc_getAssociatedObject(self, &TouchUpInsideListener) as? ClosureWrapper
            return wrapper?.closure
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &TouchUpInsideListener,
                ClosureWrapper(newValue),
                EVENT_LISTENER_POLICY
            )
        }
    }
    
    internal func touchUpInsideEvent() {
        if let listener = self.touchUpInside {
            listener()
        }
    }
}

private var TouchDownListener: UInt8 = 0
public extension UIButton {
    public func setTouchDownListener(_ event : @escaping EventListener) {
        self.touchDown = event
        self.addTarget(self, action: #selector(touchDownEvent), for: .touchDown)
    }
    
    private var touchDown: (EventListener)? {
        get {
            let wrapper =
                objc_getAssociatedObject(self, &TouchDownListener) as? ClosureWrapper
            return wrapper?.closure
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &TouchDownListener,
                ClosureWrapper(newValue),
                EVENT_LISTENER_POLICY
            )
        }
    }
    
    internal func touchDownEvent() {
        if let listener = self.touchDown {
            listener()
        }
    }
}
