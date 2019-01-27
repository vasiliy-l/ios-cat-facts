//
//  Loader.swift
//  CatFacts
//
//  Created by  William on 1/27/19.
//  Copyright © 2019 Vasiliy Lada. All rights reserved.
//

import Foundation
import UIKit

class Loader {
    
    let view: UIView
    
    private(set) var loaderImage = UIImage(named: "Loader")!
    private(set) var loader: UIImageView
    
    var loaderAnimation: CAAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        animation.isRemovedOnCompletion = false
        animation.toValue = -5
        animation.duration = 1
        animation.isCumulative = true
        animation.repeatCount = Float.infinity
        
        return animation
    }
    
    /**
     Creates loader view and ads it as a subview to parent.
     
     - Parameters:
       - view: parent view above which animated loader will be displayed when needed
    */
    init(for view: UIView) {
        self.view = view
        
        loader = UIImageView(image: loaderImage)
        self.view.addSubview(loader)
    }
    
    deinit {
        loader.removeFromSuperview()
    }
    
    /**
     Displays animated loader above parent view.
    */
    func display() {
        // update loader position
        let loaderImageSize = loaderImage.size
        loader.frame = CGRect(
            x: view.frame.width/2 - loaderImageSize.width/2,
            y: view.frame.height/2 - loaderImageSize.height/2,
            width: loaderImageSize.width,
            height: loaderImageSize.height)
        
        loader.layer.add(loaderAnimation, forKey: "rotationAnimation")
        
        loader.isHidden = false
        view.bringSubviewToFront(loader)
    }
    
    /**
     Stops displaying animated loader above parent view.
     */
    func hide() {
        loader.isHidden = true
        loader.layer.removeAllAnimations()
    }
}
