//
//  ViewController.swift
//  FacebookPopUpAnimations
//
//  Created by Ashwini shalke on 13/12/19.
//  Copyright © 2019 Ashwini Shalke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var backgroundImageView: UIImageView = {
        let bgImageview = UIImageView()
        bgImageview.image = UIImage(named:"fb_core_data_bg")
        return bgImageview
    }()
    
    var IconsContainerView: UIView = {
        let myview = UIView()
        myview.backgroundColor = .blue
        myview.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        return myview
    }()
    
    
    let IconArray:[UIImage] = 
    
    var IconsStackView: UIStackView = {
        let stackView = UIStackView()
        
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.frame
        setupLongGesture()
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    func setupLongGesture() {
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self , action:#selector(handleLongPressGesture)))
    }
    
    
    @objc func handleLongPressGesture(gesture:UILongPressGestureRecognizer){
        if gesture.state == .began {
            handleBeganGesture(gesture:gesture)
        } else if gesture.state == .ended {
            IconsContainerView.removeFromSuperview()
        }
    }
    
    fileprivate func handleBeganGesture(gesture:UILongPressGestureRecognizer){
        view.addSubview(IconsContainerView)
        let tapLocation = gesture.location(in: self.view)
        let locationX = (view.frame.width - IconsContainerView.frame.width)/2
        IconsContainerView.transform = CGAffineTransform(translationX: locationX, y: tapLocation.y)
        
        IconsContainerView.alpha = 0
        
        UIView.animate(withDuration: 0.45, delay: 0.45, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.IconsContainerView.alpha = 1
            self.IconsContainerView.transform = CGAffineTransform(translationX: locationX, y: tapLocation.y - self.IconsContainerView.frame.height)
        })
    }
    
}

