//
//  Difficulty.swift
//
//  This file contains an enumeration describing difficulty levels of a workout.
//
//

import Foundation

enum Difficulty: Int {
    case easy, medium, hard, professional
    
    func description() -> String {
        switch self {
        case .easy:         return "Easy"
        case .medium:       return "Medium"
        case .hard:         return "Hard"
        case .professional: return "Professional"
        }
    }
    
    //
    //  This property on our enumeration returns the count of items.
    //
    static let count: Int = {
        var max: Int = 0
        while let _ = Difficulty(rawValue: max) { max += 1 }
        return max
    }()
    
    //
    //  This property is used to retrieve a list of all the difficulty levels. It returns
    //  all the values of the enum as an Array.
    //
    static var difficulties: [Difficulty] {
        var values: [Difficulty] = []
        var index = 0
        while let element = self.init(rawValue: index) {
            values.append(element)
            index += 1
        }
        
        return values
    }
}

