//
//  ViewController.swift
//  UIEventExtension
//
//  Created by rudolphwong2002@gmail.com on 04/01/2017.
//  Copyright (c) 2017 rudolphwong2002@gmail.com. All rights reserved.
//

import UIKit
import UIEventExtension

class ViewController: UIViewController, UITextViewDelegate {

    var btn = UIButton()
    var iv = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(btn)
        btn.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        btn.backgroundColor = UIColor.red
        btn.setTouchDownListener {
            print("Touch down")
        }
        btn.setTouchUpInsideListener(touchUpInside)
        
        self.view.addSubview(iv)
        iv.frame = CGRect(x: 0, y: 200, width: 200, height: 200)
        iv.backgroundColor = .green
        iv.setTapListener(numberOfTaps: 2, numberOfTouches: 1) { 
            print("double tap")
        }
//        iv.setRotationEventListener { (rotation, velocity, state) in
//            print("Rotate : \(rotation)")
//            self.iv.transform = CGAffineTransform(rotationAngle: rotation)
//        }
//        
//        iv.setPinchEventListener { (scale, velocity, state) in
//            print("Pinch : \(scale)")
//            self.iv.transform = CGAffineTransform(scaleX: scale, y: scale)
//        }
//        
//        iv.setScreenEdgePanEventListener({ (translation, velocity, state) in
//            print("Screen Edge Left, state:\(state.rawValue)")
//            print("Translate : \(translation)")
//            print("Velocity : \(velocity)")
//        }, edge: .left)
        
        iv.setPanEventListener { (translate, velocity, state) in
            print("Pan")
            print("Translate : \(translate)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func touchUpInside(){
        print("touchUpInside")
    }

}

