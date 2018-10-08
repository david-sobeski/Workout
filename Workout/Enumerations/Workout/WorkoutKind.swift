//
//  WorkoutKind.swift
//
//  This file containsthe enumeration of the different types of workouts that our applications
//  supports.
//

import Foundation

enum WorkoutKind: Int {
    case any, warmup, main, cooldown
    
    func description() -> String {
        switch self {
        case .any:      return "Any"
        case .warmup:   return "Warm-Up"
        case .main:     return "Main"
        case .cooldown: return "Cool Down"
        }
    }
    
    //
    //  This property on our enumeration returns the count of items.
    //
    static let count: Int = {
        var max: Int = 0
        while let _ = WorkoutKind(rawValue: max) { max += 1 }
        return max
    }()
    
    //
    //  This property is used to retrieve a list of all the WorkoutType. It returns
    //  all the values of the enum as an Array.
    //
    static var kinds: [WorkoutKind] {
        var values: [WorkoutKind] = []
        var index = 0
        while let element = self.init(rawValue: index) {
            values.append(element)
            index += 1
        }
        
        return values
    }
}
