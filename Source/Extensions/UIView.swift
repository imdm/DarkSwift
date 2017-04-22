//
//  UIView.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/2.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

extension UIView: Layoutable {
    public var coordinateSystemOrigin: CoordinateSystemOrigin {
        return .upperLeft
    }
    
    public var size: CGSize {
        return frame.size
    }
    
    public var anchorPoint: CGPoint {
        return CGPoint.zero
    }
    
    public static func layoutViews(_ views: [UIView], alignment: Alignment, in rect: CGRect) {
        let points = positions(forItems: views, alignment: alignment, in: rect)
        for (view, point) in zip(views, points) {
            view.frame.origin = point
        }
    }
    
    public func layoutSubviews(_ views: [UIView], alignment: Alignment, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        let rect = bounds.rect(byInsets: insets)
        UIView.layoutViews(views, alignment: alignment, in: rect)
    }
    
    public var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center = CGPoint(x: newValue, y: center.y)
        }
    }
    
    public var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center = CGPoint(x: center.x, y: newValue)
        }
    }

    public func setHeightFromBottom(_ newHeight: CGFloat) {
        frame.origin.y += frame.height - newHeight
        frame.size.height = newHeight
    }
    
    public var viewController: UIViewController? {
        var v: UIView? = self
        while v != nil {
            if let vc = v?.next as? UIViewController {
                return vc
            } else {
                v = v?.superview
            }
        }
        return nil
    }
    
    public func clone() -> Any {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as Any
    }
}