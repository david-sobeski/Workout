//
//  Generator.swift
//
//  This class is used to generate workouts for an athlete.
//

import Foundation

class Generator {
    // ---------------------------------------------------------------------------------------------
    // MARK: - Public Methods
    
    //
    //  This is our only public method. It is used to generate a list of workouts for an Athlete.
    //
    func generateWorkouts(athlete: Athlete) -> [Workout] {
        //
        //  WE NEED TO ACTUALLY IMPLEMENT THE LOGIC FOR GENERATING WORKOUTS! RIGHT NOW WE JUST
        //  HARD CODE IT TO RETURN THE FOUR WORKOUTS THAT WE HAVE.
        //
        
        var workouts: [Workout] = []
        //workouts.append(AppData.shared.getWorkout(at: 0))
        //workouts.append(AppData.shared.getWorkout(at: 1))
        //workouts.append(AppData.shared.getWorkout(at: 4))
        //workouts.append(AppData.shared.getWorkout(at: 7))

        //
        //  Generate a random number for how many workouts we will include.
        //
        let numWorkouts = Int.random(in: 1 ..< AppData.shared.getWorkoutCount()+1)
        
        //
        //  Just create number of workouts that we randomly determined.
        for _ in 0 ..< numWorkouts {
            //
            //  We will get duplicates, this is just an example, randomly pick a workout.
            workouts.append(AppData.shared.getWorkout(at: Int.random(in: 0 ..< AppData.shared.getWorkoutCount())))
        }
        
        return workouts
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Private Methods
}
