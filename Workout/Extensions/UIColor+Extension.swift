//
//  UIColor+Extension.swift
//
//  We use a feature in SWIFT called an extension. This allows us to add new methods to a class
//  that already exists. We want a method that will easily convert a HEX color to a UIColor.
//

import UIKit

//
//  This extension allows for the passing of a HEX value to a UIColor.
//
extension UIColor {
    //
    //  The following definitons are new colors based on the safe web color palette.
    //
    public class var darkKhaki: UIColor     { return UIColor().hexStringToUIColor("#BDB76B") }
    public class var wheat: UIColor         { return UIColor().hexStringToUIColor("#F5DEB3") }
    public class var darkRed: UIColor       { return UIColor().hexStringToUIColor("#8B0000") }
    public class var lightBlue: UIColor     { return UIColor().hexStringToUIColor("#ADD8E6") }
    
    //
    //  Given a hex string in the format #FFFFFF or FFFFFF, convert the string to a UIColor.
    //
    func hexStringToUIColor(_ hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        //
        //  Remove the # prefix from the hex string.
        //
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        //
        //  The string must be 6 characters in length. If it is not, then we return a
        //  default color.
        //
        if cString.count != 6 {
            return UIColor.gray
        }
        
        //
        //  Convert the hex string letters into an integer equivalent.
        //
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        //
        //  Return a new UIColor converting the values to RGB values.
        //
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0))
    }
}
