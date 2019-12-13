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
        myview.backgroundColor = .white
        
//        var view1 = UIView()
//        view1.backgroundColor = .red
//        var view2 = UIView()
//        view2.backgroundColor = .green
//        let arrangedIcons = [view1,view2]
        
        let emojiIcon = ["blue_like","red_heart","surprised","cry_laugh","cry","angry"]
        let arrangedIcons = emojiIcon.map { (imageName) -> UIImageView in
            let imageIconView = UIImageView()
            imageIconView.image = UIImage(named: imageName)
            return imageIconView
        }
        
        let padding:CGFloat = 6
        let Iconheight:CGFloat = 38
        let IconCount = CGFloat(arrangedIcons.count)
        let customMyViewWidth = (IconCount + Iconheight) * IconCount + padding
       
        
        
        
       
        
        let stackView = UIStackView(arrangedSubviews: arrangedIcons)
        stackView.distribution = .fillEqually
        
        myview.layer.cornerRadius = myview.frame.height/2
        
        
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        myview.frame = CGRect(x: 0, y: 0, width: customMyViewWidth, height: Iconheight)
        stackView.frame = myview.frame
        myview.addSubview(stackView)
        return myview
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

