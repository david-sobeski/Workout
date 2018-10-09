//
//  WorkoutDelegate.swift
//
//  This file defines a protocol for our Workout. We need this for our user interface
//  to work right. That is, so we can pass data between our views.
//

import Foundation

protocol WorkoutDelegate {
    func setType(type: WorkoutType)
    func setKind(kind: WorkoutKind)
    func setDifficulty(difficulty: Difficulty)
}
