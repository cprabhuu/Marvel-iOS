//
//  UIColor+Marvel.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 16/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

import Foundation

extension UIColor {
    private
    class func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

    public
    class func nagitationBarColor() -> UIColor {
        return UIColorFromHex(0xf11e22)
    }
    
    class func backgroundColor() -> UIColor {
        return self.blackColor()
    }
}
