//
//  Skill.swift
//
//  This file contains an enumeration describing skill levels.
//
//

import Foundation

enum Skill: Int {
    case novice, intermediate, advanced, expert
    
    func description() -> String {
        switch self {
        case .novice:       return "Novice"
        case .intermediate: return "Intermediate"
        case .advanced:     return "Advanced"
        case .expert:       return "Expert"
        }
    }
    
    //
    //  This property on our enumeration returns the count of items.
    //
    static let count: Int = {
        var max: Int = 0
        while let _ = Skill(rawValue: max) { max += 1 }
        return max
    }()
    
    //
    //  This property is used to retrieve a list of all the skills. It returns
    //  all the values of the enum as an Array.
    //
    static var skills: [Skill] {
        var values: [Skill] = []
        var index = 0
        while let element = self.init(rawValue: index) {
            values.append(element)
            index += 1
        }
        
        return values
    }
}
