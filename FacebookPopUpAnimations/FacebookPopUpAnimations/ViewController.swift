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
        let containerView = UIView()
        containerView.backgroundColor = .white
        let padding:CGFloat = 6
        let Iconheight:CGFloat = 38
        
 
        let emojiIcon = ["blue_like","red_heart","surprised","cry_laugh","cry","angry"]
        let arrangedIcons = emojiIcon.map { (imageName) -> UIImageView in
            let imageIconView = UIImageView()
            imageIconView.layer.cornerRadius = Iconheight/2
            imageIconView.isUserInteractionEnabled = true
            imageIconView.image = UIImage(named: imageName)
            return imageIconView
        }
        
        
        let IconCount = CGFloat(arrangedIcons.count)
        let customMyViewWidth = (IconCount + Iconheight) * IconCount + padding

        let stackView = UIStackView(arrangedSubviews: arrangedIcons)
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        containerView.frame = CGRect(x: 0, y: 0, width: customMyViewWidth, height: Iconheight + 2 * padding)
        containerView.layer.cornerRadius = containerView.frame.height/2
        containerView.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        containerView.layer.shadowRadius = 8
        containerView.layer.opacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        stackView.frame = containerView.frame
        containerView.addSubview(stackView)
        return containerView
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
            let stackView = self.IconsContainerView.subviews.first
            stackView?.subviews.forEach({ (image) in
                image.transform = .identity
            })
            IconsContainerView.removeFromSuperview()
        } else if gesture.state == .changed{
            handleChangedGesture(gesture: gesture)
        }
    }
    
    fileprivate func handleChangedGesture(gesture: UILongPressGestureRecognizer){
        let pressLocation = gesture.location(in: IconsContainerView)
        let hitTestView = IconsContainerView.hitTest(pressLocation, with: nil)
        if (hitTestView is UIImageView){
            UIView.animate(withDuration: 0.30, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                let stackView = self.IconsContainerView.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
            })
            hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
        }
    }
    
    fileprivate func handleBeganGesture(gesture:UILongPressGestureRecognizer){
        view.addSubview(IconsContainerView)
        let pressLocation = gesture.location(in: self.view)
        let locationX = (view.frame.width - IconsContainerView.frame.width)/2
        IconsContainerView.transform = CGAffineTransform(translationX: locationX, y: pressLocation.y)
        
        IconsContainerView.alpha = 0
        
        UIView.animate(withDuration: 0.30, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.IconsContainerView.alpha = 1
            self.IconsContainerView.transform = CGAffineTransform(translationX: locationX, y: pressLocation.y - self.IconsContainerView.frame.height)
        })
    }
    
}

