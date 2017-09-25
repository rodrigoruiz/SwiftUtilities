//
//  UIImage+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension UIImage {
    
    public convenience init?(url: String) {
        if let data = try? Data(contentsOf: URL(string: url)!) {
            self.init(data: data)
        } else {
            return nil
        }
    }
    
    public convenience init?(base64EncodedString: String) {
        if let imageData = Data(base64Encoded: base64EncodedString, options: .ignoreUnknownCharacters) {
            self.init(data: imageData)
        } else {
            return nil
        }
    }
    
    public convenience init(color: UIColor, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
    
    public func roundedImage() -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        UIGraphicsBeginImageContext(size)
        UIBezierPath(roundedRect: rect, cornerRadius: size.height).addClip()
        draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
}
