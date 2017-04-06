//
//  UIViewEventListenerExtension.swift
//  Pods
//
//  Created by Spring Wong on 1/4/2017.
//
//

import Foundation

public extension UIView{
    internal struct UITapGestureWrapper {
        var listener: (EventListener)?
        var recognizer : UITapGestureRecognizer?
        
        init(_ wrapper : UITapGestureWrapper?) {
            self.listener = wrapper?.listener
            self.recognizer = wrapper?.recognizer
        }
        init(_ listener : EventListener? , _ recognizer : UITapGestureRecognizer?) {
            self.listener = listener
            self.recognizer = recognizer
        }
    }
    internal struct UIRotationGestureWrapper {
        var listener: (RotateEventListener)?
        var recognizer : UIRotationGestureRecognizer?
        
        init(_ wrapper : UIRotationGestureWrapper?) {
            self.listener = wrapper?.listener
            self.recognizer = wrapper?.recognizer
        }
        init(_ listener : RotateEventListener? , _ recognizer : UIRotationGestureRecognizer?) {
            self.listener = listener
            self.recognizer = recognizer
        }
    }
    internal struct UIPinchGestureWrapper {
        var listener: (PinchEventListener)?
        var recognizer : UIPinchGestureRecognizer?
        
        init(_ wrapper : UIPinchGestureWrapper?) {
            self.listener = wrapper?.listener
            self.recognizer = wrapper?.recognizer
        }
        init(_ listener : PinchEventListener? , _ recognizer : UIPinchGestureRecognizer?) {
            self.listener = listener
            self.recognizer = recognizer
        }
    }
    internal struct UIScreenEdgePanGestureWrapper {
        var listener: (PanEventListener)?
        var recognizer : UIScreenEdgePanGestureRecognizer?
        
        init(_ wrapper : UIScreenEdgePanGestureWrapper?) {
            self.listener = wrapper?.listener
            self.recognizer = wrapper?.recognizer
        }
        init(_ listener : PanEventListener? , _ recognizer : UIScreenEdgePanGestureRecognizer?) {
            self.listener = listener
            self.recognizer = recognizer
        }
    }
    internal struct UIPanGestureWrapper {
        var listener: (PanEventListener)?
        var recognizer : UIPanGestureRecognizer?
        
        init(_ wrapper : UIPanGestureWrapper?) {
            self.listener = wrapper?.listener
            self.recognizer = wrapper?.recognizer
        }
        init(_ listener : PanEventListener? , _ recognizer : UIPanGestureRecognizer?) {
            self.listener = listener
            self.recognizer = recognizer
        }
    }
}


private var UIViewTapEvent: UInt8 = 0
public extension UIView {
    private var tapWrapper : (UITapGestureWrapper)? {
        get {
            let wrapper =
                objc_getAssociatedObject(self, &UIViewTapEvent) as? UITapGestureWrapper
            return wrapper
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &UIViewTapEvent,
                UITapGestureWrapper(newValue),
                EVENT_LISTENER_POLICY
            )
        }
    }
    public func setTapListener(numberOfTaps : Int, numberOfTouches : Int, _ callback : @escaping EventListener) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapEvent))
        tapGestureRecognizer.numberOfTapsRequired = numberOfTaps
        tapGestureRecognizer.numberOfTouchesRequired = numberOfTouches
        
        self.isUserInteractionEnabled = true
        if let wrapper = self.tapWrapper, let recognizer = wrapper.recognizer{
            self.removeGestureRecognizer(recognizer)
        }
        self.addGestureRecognizer(tapGestureRecognizer)
        self.tapWrapper = UITapGestureWrapper(callback, tapGestureRecognizer)
    }
    public func setTapListener(_ callback : @escaping EventListener) {
        setTapListener(numberOfTaps: 1, numberOfTouches: 1, callback)
    }
    internal func tapEvent(){
        if let wrapper = self.tapWrapper{
            if let event = wrapper.listener {
                event()
            }
        }
    }
}

private var UIViewRotateEvent: UInt8 = 0
public extension UIView {
    private var rotation : (UIRotationGestureWrapper)? {
        get {
            let wrapper =
                objc_getAssociatedObject(self, &UIViewRotateEvent) as? UIRotationGestureWrapper
            return wrapper
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &UIViewRotateEvent,
                UIRotationGestureWrapper(newValue),
                EVENT_LISTENER_POLICY
            )
        }
    }
    public func setRotationEventListener(_ callback : @escaping RotateEventListener) {
        let recognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotationEvent(recognizer:)))
        self.isUserInteractionEnabled = true
        if let wrapper = self.rotation, let recognizer = wrapper.recognizer{
            self.removeGestureRecognizer(recognizer)
        }
        self.addGestureRecognizer(recognizer)
        self.rotation = UIRotationGestureWrapper(callback, recognizer)
    }
    internal func rotationEvent(recognizer : UIRotationGestureRecognizer){
        if let wrapper = self.rotation{
            if let event = wrapper.listener {
                event(recognizer.rotation, recognizer.velocity, recognizer.state)
            }
        }
    }
}

private var UIViewPinchEvent: UInt8 = 0
public extension UIView {
    private var pinch : (UIPinchGestureWrapper)? {
        get {
            let wrapper =
                objc_getAssociatedObject(self, &UIViewPinchEvent) as? UIPinchGestureWrapper
            return wrapper
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &UIViewPinchEvent,
                UIPinchGestureWrapper(newValue),
                EVENT_LISTENER_POLICY
            )
        }
    }
    public func setPinchEventListener(_ callback : @escaping PinchEventListener) {
        let recognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchEvent(recognizer:)))
        self.isUserInteractionEnabled = true
        if let wrapper = self.pinch, let recognizer = wrapper.recognizer{
            self.removeGestureRecognizer(recognizer)
        }
        self.addGestureRecognizer(recognizer)
        self.pinch = UIPinchGestureWrapper(callback, recognizer)
    }
    internal func pinchEvent(recognizer : UIPinchGestureRecognizer){
        if let wrapper = self.pinch{
            if let event = wrapper.listener {
                event(recognizer.scale, recognizer.velocity, recognizer.state)
            }
        }
    }
}

private var UIViewEdgePanEvent: UInt8 = 0
public extension UIView {
    private var screenEdgePan : (UIScreenEdgePanGestureWrapper)? {
        get {
            let wrapper =
                objc_getAssociatedObject(self, &UIViewEdgePanEvent) as? UIScreenEdgePanGestureWrapper
            return wrapper
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &UIViewEdgePanEvent,
                UIScreenEdgePanGestureWrapper(newValue),
                EVENT_LISTENER_POLICY
            )
        }
    }
    public func setScreenEdgePanEventListener(_ callback : @escaping PanEventListener, edge : UIRectEdge) {
        let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgePanEvent(recognizer:)))
        self.isUserInteractionEnabled = true
        recognizer.edges = edge
        if let wrapper = self.screenEdgePan, let recognizer = wrapper.recognizer{
            self.removeGestureRecognizer(recognizer)
        }
        self.addGestureRecognizer(recognizer)
        self.screenEdgePan = UIScreenEdgePanGestureWrapper(callback, recognizer)
    }
    internal func screenEdgePanEvent(recognizer : UIScreenEdgePanGestureRecognizer){
        if let wrapper = self.screenEdgePan{
            if let event = wrapper.listener {
                event(recognizer.translation(in: self), recognizer.velocity(in: self), recognizer.state)
            }
        }
    }
}

private var UIViewPanEvent: UInt8 = 0
public extension UIView {
    private var pan : (UIPanGestureWrapper)? {
        get {
            let wrapper =
                objc_getAssociatedObject(self, &UIViewPanEvent) as? UIPanGestureWrapper
            return wrapper
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &UIViewPanEvent,
                UIPanGestureWrapper(newValue),
                EVENT_LISTENER_POLICY
            )
        }
    }
    public func setPanEventListener(_ callback : @escaping PanEventListener) {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(panEvent(recognizer:)))
        self.isUserInteractionEnabled = true
        if let wrapper = self.pan, let recognizer = wrapper.recognizer{
            self.removeGestureRecognizer(recognizer)
        }
        self.addGestureRecognizer(recognizer)
        self.pan = UIPanGestureWrapper(callback, recognizer)
    }
    internal func panEvent(recognizer : UIPanGestureRecognizer){
        if let wrapper = self.pan{
            if let event = wrapper.listener {
                event(recognizer.translation(in: self), recognizer.velocity(in: self), recognizer.state)
            }
        }
    }
}

