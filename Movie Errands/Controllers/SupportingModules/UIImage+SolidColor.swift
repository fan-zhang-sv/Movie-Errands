//
//  UIImage+SolidColor.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/23/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize=CGSize(width: 2, height: 3)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
