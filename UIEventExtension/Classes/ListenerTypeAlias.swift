//
//  EventTypeAlias.swift
//  Pods
//
//  Created by Spring Wong on 1/4/2017.
//
//

import Foundation

public typealias EventListener = ()->Void
public typealias RotateEventListener = (_ rotation : CGFloat, _ velocity : CGFloat, _ state : UIGestureRecognizerState)->Void
public typealias PinchEventListener = (_ scale : CGFloat, _ velocity : CGFloat, _ state : UIGestureRecognizerState)->Void
public typealias PanEventListener = (_ translate : CGPoint, _ velocty : CGPoint, _ state : UIGestureRecognizerState)->Void
