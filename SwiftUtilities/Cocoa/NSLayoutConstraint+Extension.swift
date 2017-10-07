//
//  NSLayoutConstraint+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 10/5/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension NSLayoutConstraint {
    
    public static func constraints(
        visualFormats: [String],
        options: NSLayoutFormatOptions = NSLayoutFormatOptions(),
        metrics: [String : AnyObject]? = nil,
        views: [String : AnyObject]
    ) -> [NSLayoutConstraint] {
        return Array(visualFormats
            .map({ visualFormat in
                return constraints(
                    visualFormat: visualFormat,
                    options: options,
                    metrics: metrics,
                    views: views
                )
            })
            .joined()
        )
    }
    
    public static func constraints(
        visualFormat: String,
        options: NSLayoutFormatOptions = NSLayoutFormatOptions(),
        metrics: [String : AnyObject]? = nil,
        views: [String : AnyObject]
    ) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(
            withVisualFormat: visualFormat,
            options: options,
            metrics: metrics,
            views: views
        )
    }
    
    public func update(
        firstItem: AnyObject?? = nil,
        firstAttribute: NSLayoutAttribute? = nil,
        relation: NSLayoutRelation? = nil,
        secondItem: AnyObject?? = nil,
        secondAttribute: NSLayoutAttribute? = nil,
        multiplier: CGFloat? = nil,
        constant : CGFloat? = nil
    ) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: (firstItem ?? self.firstItem) as Any,
            attribute: firstAttribute ?? self.firstAttribute,
            relatedBy: relation ?? self.relation,
            toItem: secondItem ?? self.secondItem,
            attribute: secondAttribute ?? self.secondAttribute,
            multiplier: multiplier ?? self.multiplier,
            constant: constant ?? self.constant
        )
    }
    
}
