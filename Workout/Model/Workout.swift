//
//  Workout.swift
//
//  This file contains the definition of our Workout class.
//

import Foundation

// ------------------------------------------------------------------------------------------------
// MARK: - Workout Class

//
//  This class defines the attributes of a Workout. Since we load our workouts from a JSON file,
//  we do not need to support NSCoder and the automatic persistence system provided by iOS.
//
class Workout {
    // --------------------------------------------------------------------------------------------
    // MARK: - Public Properties
    
    var id: String                  = UUID().uuidString
    var type: WorkoutType           = WorkoutType.running
    var title: String               = ""
    var details: String             = ""
    var difficulty: Difficulty      = Difficulty.easy
}
