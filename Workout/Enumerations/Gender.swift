//
//  Gender.swift
//
//  This file contains the definition of our Gender enumeration.
//

import Foundation

enum Gender: Int {
    case male, female, nonbinary, unknown
    
    //
    //  This method returns a string represnation (a description) of our gender.
    //
    func description() -> String {
        switch self {
        case .male:         return "Male"
        case .female:       return "Female"
        case .nonbinary:   return "Non-binary (Third Gender)"
        case .unknown:     return "Not Declared"
        }
    }
    
    //
    //  This property on our enumeration returns the count of items.
    //
    static let count: Int = {
        var max: Int = 0
        while let _ = Gender(rawValue: max) { max += 1 }
        return max
    }()
    
    //
    //  This property is used to retrieve a list of all the genders. It returns
    //  all the values of the enum as an Array.
    //
    static var genders: [Gender] {
        var values: [Gender] = []
        var index = 0
        while let element = self.init(rawValue: index) {
            values.append(element)
            index += 1
        }
        
        return values
    }
}
