//
//  WorkoutTypes.swift
//
//  This file containsthe enumeration of the different types of workouts that our applications
//  supports.
//

import Foundation

enum WorkoutType: Int {
    case running, swimming, cycling, weightlifting, strength, cardio
    
    func description() -> String {
        switch self {
        case .running:          return "Running"
        case .swimming:         return "Swimming"
        case .cycling:          return "Cycling"
        case .weightlifting:    return "Weight Lifting"
        case .strength:         return "Strength Training"
        case .cardio:           return "Cardio"
        }
    }
    
    //
    //  This property on our enumeration returns the count of items.
    //
    static let count: Int = {
        var max: Int = 0
        while let _ = WorkoutType(rawValue: max) { max += 1 }
        return max
    }()
    
    //
    //  This property is used to retrieve a list of all the WorkoutType. It returns
    //  all the values of the enum as an Array.
    //
    static var types: [WorkoutType] {
        var values: [WorkoutType] = []
        var index = 0
        while let element = self.init(rawValue: index) {
            values.append(element)
            index += 1
        }
        
        return values
    }
}
