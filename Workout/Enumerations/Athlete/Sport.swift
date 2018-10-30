//
//  Sport.swift
//
//  This file contains the definition of our Sports enumeration.
//

import Foundation
import UIKit

enum Sport: Int {
    case none, football, soccer, baseball, basketball
    case volleyball, cycling, crosscountry, running
    case triathlon, swimming, golf, cricket
    case rugby, wrestling, autoracing
    
    //
    //  The function is used to return a text description of the enumeration item.
    //
    func description() -> String {
        switch self {
        case .none:         return "None"
        case .football:     return "Football"
        case .soccer:       return "Soccer"
        case .baseball:     return "Baseball"
        case .basketball:   return "Basketball"
        case .volleyball:   return "Volleyball"
        case .cycling:      return "Cycling"
        case .crosscountry: return "Cross Country"
        case .running:      return "Running"
        case .triathlon:    return "Triathlon"
        case .swimming:     return "Swimming"
        case .golf:         return "Golf"
        case .cricket:      return "Cricket"
        case .rugby:        return "Rugby"
        case .wrestling:    return "Wrestling"
        case .autoracing:   return "Auto Racing"
        }
    }
    
    //
    //  We associate a color with each sport type. This function return a UIColor. Since we have
    //  more sports than we do built-in UIColor constants, we have to create a few new colors.
    //  We decided to create colors based off standard HTML color names. They can be seen at:
    //  https://htmlcolorcodes.com/color-names/
    //
    func color() -> UIColor {

        switch self {
        case .none:         return UIColor.black
        case .football:     return UIColor.blue
        case .soccer:       return UIColor.brown
        case .baseball:     return UIColor.red
        case .basketball:   return UIColor.cyan
        case .volleyball:   return UIColor.darkGray
        case .cycling:      return UIColor.gray
        case .crosscountry: return UIColor.green
        case .running:      return UIColor.lightGray
        case .triathlon:    return UIColor.magenta
        case .swimming:     return UIColor.orange
        case .golf:         return UIColor.purple
        case .cricket:      return UIColor.darkKhaki
        case .rugby:        return UIColor.wheat
        case .wrestling:    return UIColor.darkRed
        case .autoracing:   return UIColor.lightBlue
        }
    }
    
    //
    //  This property on our enumeration returns the count of items.
    //
    static let count: Int = {
        var max: Int = 0
        while let _ = Sport(rawValue: max) { max += 1 }
        return max
    }()
    
    //
    //  This property is used to retrieve a list of all the sports. It returns
    //  all the values of the enum as an Array.
    //
    static var sports: [Sport] {
        var values: [Sport] = []
        var index = 0
        while let element = self.init(rawValue: index) {
            values.append(element)
            index += 1
        }
        
        return values
    }
}
