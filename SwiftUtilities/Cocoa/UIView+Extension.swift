//
//  UIView+Extension.swift
//  SwiftUtilities
//
//  Created by SwiftUtilities on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import RxSwift


extension UIView {
    
    public var isVisible: Bool {
        get {
            return !isHidden
        }
        set {
            isHidden = !newValue
        }
    }
    
    public static func animate(
        duration: TimeInterval,
        delay: TimeInterval = 0,
        options: UIViewAnimationOptions = UIViewAnimationOptions(),
        animations: @escaping () -> Void
    ) -> Observable<Bool> {
        return Observable<Bool>.create({ observer in
            UIView.animate(
                withDuration: duration,
                delay: delay,
                options: options,
                animations: animations,
                completion: { finished in
                    observer.onNext(finished)
                    observer.onCompleted()
                }
            )
            
            return Disposables.create()
        })
    }
    
    public static func animate(
        duration: TimeInterval,
        delay: TimeInterval = 0,
        usingSpringWithDamping: CGFloat,
        initialSpringVelocity: CGFloat,
        options: UIViewAnimationOptions = UIViewAnimationOptions(),
        animations: @escaping () -> Void
    ) -> Observable<Bool> {
        return Observable<Bool>.create({ observer in
            UIView.animate(
                withDuration: duration,
                delay: delay,
                usingSpringWithDamping: usingSpringWithDamping,
                initialSpringVelocity: initialSpringVelocity,
                options: options,
                animations: animations,
                completion: { finished in
                    observer.onNext(finished)
                    observer.onCompleted()
                }
            )
            
            return Disposables.create()
        })
    }
    
    public func screenshot(scale: CGFloat = 0.0, isOpaque: Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    public func blur(radius: CGFloat) -> UIImage? {
        guard let blur = CIFilter(name: "CIGaussianBlur") else { return nil }
        
        blur.setValue(CIImage(image: screenshot(scale: 1.0)), forKey: kCIInputImageKey)
        blur.setValue(radius, forKey: kCIInputRadiusKey)
        
        let context = CIContext(options: nil)
        let result = blur.value(forKey: kCIOutputImageKey) as! CIImage
        let rect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let cgImage = context.createCGImage(result, from: rect)!
        
        return UIImage(cgImage: cgImage)
    }
    
    @IBInspectable public var cornerRadius: Double {
        get {
            return Double(layer.cornerRadius)
        }
        set {
            layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable public var borderWidth: Double {
        get {
            return Double(layer.borderWidth)
        }
        set {
            layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable public var borderColor: UIColor? {
        get {
            return layer.borderColor.flatMap(UIColor.init)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    public func updateFrame(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        frame = CGRect(
            x: x ?? frame.origin.x,
            y: y ?? frame.origin.y,
            width: width ?? frame.width,
            height: height ?? frame.height
        )
    }
    
    // MARK: - Shadow
    
    @IBInspectable public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable public var shadowRadius: Double {
        get {
            return Double(layer.shadowRadius)
        }
        set {
            layer.shadowRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable public var shadowOpacity: Double {
        get {
            return Double(layer.shadowOpacity)
        }
        set {
            layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable public var shadowColor: UIColor? {
        get {
            return layer.shadowColor.flatMap(UIColor.init)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable public var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable public var rotationAnimationDuration: Double {
        get {
            return layer.animation(forKey: "transform.rotation.z")?.duration ?? 0
        }
        set {
            layer.removeAnimation(forKey: "transform.rotation.z")
            
            guard newValue > 0 else { return }
            
            let animation = CABasicAnimation()
            animation.fromValue = 0
            animation.toValue = Double.pi * 2
            animation.duration = newValue
            animation.repeatCount = .infinity
            animation.isRemovedOnCompletion = false
            animation.fillMode = kCAFillModeForwards
            
            layer.add(animation, forKey: "transform.rotation.z")
        }
    }
    
}
