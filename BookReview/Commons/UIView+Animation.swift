//
//  UIView+Animation.swift
//  BookReview
//
//  Created by Juan Carlos Perez on 21/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//


import UIKit
import Lottie

enum LoaderType : String {
    case activity = "loader"
    case none
}

extension UIView {
    func customActivityIndicator(view: UIView, widthView: CGFloat? = nil, backgroundColor: UIColor? = nil, type: LoaderType = .activity) -> UIView {
        
        self.backgroundColor = backgroundColor ?? UIColor.clear
        
        var selfWidth = view.frame.width
        if widthView != nil {
            selfWidth = widthView ?? selfWidth
        }
        
        let selfHeigh = view.frame.height//CGFloat(100)
        let selfFrameX = (view.frame.width / 2) - (selfWidth / 2)
        let selfFrameY = (view.frame.height / 2) - (selfHeigh / 2)
        
        let animationView = AnimationView.init(name: type.rawValue, bundle: Bundle.main, imageProvider: nil, animationCache: nil)
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        
        var imageWidth = CGFloat(250)
        var imageHeight = CGFloat(150)
        let imageFrameX = (selfWidth / 2) - (imageWidth/2)
        let imageFrameY = (selfHeigh / 2) - (imageHeight/2)
        
        if widthView != nil {
            imageWidth = widthView ?? imageWidth
            imageHeight = widthView ?? imageHeight
        }
        
        self.addSubview(animationView)
        animationView.play { (_) in
            //TODO: Acción cuando termine la ejecución de la animación
        }
        
        animationView.frame = CGRect(x: imageFrameX, y: imageFrameY, width: imageWidth, height: imageHeight)

    
        self.frame = CGRect(x: selfFrameX, y: selfFrameY, width: selfWidth, height: selfHeigh)
        
        return self
    }
    
}

extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }

    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }

    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }

    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    
    func addParallaxToView(amount: Int) {
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount

        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount

        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        self.addMotionEffect(group)
    }
}
