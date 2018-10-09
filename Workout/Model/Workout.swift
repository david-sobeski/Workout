//
//  Workout.swift
//
//  This file contains the definition of our Workout class.
//

import Foundation

//
//  Our athlete type is really a UUID that we conver to a string. We want to have a stronger
//  type than just showing it being a string. Therefore, SWIFT gives us a nice trick to create
//  a type alias.
//
typealias WorkoutID = String

// ------------------------------------------------------------------------------------------------
// MARK: - Workout Class

//
//  This class defines the attributes of a Workout. Since we load our workouts from a JSON file,
//  we do not need to support NSCoder and the automatic persistence system provided by iOS.
//
class Workout: NSObject, NSCoding {
    //
    //  The following are constant definitions for the keys we need to persist each of our
    //  attributes of the class.
    //
    private let WORKOUT_ID          = "WORKOUT_ID"
    private let WORKOUT_TYPE        = "WORKOUT_TYPE"
    private let WORKOUT_TITLE       = "WORKOUT_TITLE"
    private let WORKOUT_DETAILS     = "WORKOUT_DETAILS"
    private let WORKOUT_DIFFICULTY  = "WORKOUT_DIFFICULTY"
    private let WORKOUT_KIND        = "WORKOUT_KIND"

    
    // --------------------------------------------------------------------------------------------
    // MARK: - Public Properties
    
    var id: WorkoutID               = UUID().uuidString
    var title: String               = ""
    var details: String             = ""
    var type: WorkoutType           = WorkoutType.running
    var difficulty: Difficulty      = Difficulty.easy
    var kind: WorkoutKind           = WorkoutKind.main
    
    // --------------------------------------------------------------------------------------------
    // MARK: - Initialization Methods
    
    override init() {
        super.init()
    }
    
    // --------------------------------------------------------------------------------------------
    // MARK: - NSCoder Methods
    
    //
    //  This method is called by NSCoder protocol to load or decode an object. We decode each of
    //  our properties of this object that we have stored using the encode method.
    //
    required init?(coder aDecoder: NSCoder) {
        self.id         = aDecoder.decodeObject(forKey: WORKOUT_ID) as? WorkoutID ?? ""
        self.title      = aDecoder.decodeObject(forKey: WORKOUT_TITLE) as? String ?? ""
        self.details    = aDecoder.decodeObject(forKey: WORKOUT_DETAILS) as? String ?? ""
        self.type       = WorkoutType(rawValue: aDecoder.decodeInteger(forKey: WORKOUT_TYPE)) ?? WorkoutType.running
        self.difficulty = Difficulty(rawValue: aDecoder.decodeInteger(forKey: WORKOUT_DIFFICULTY)) ?? Difficulty.easy
        self.kind       = WorkoutKind(rawValue: aDecoder.decodeInteger(forKey: WORKOUT_KIND)) ?? WorkoutKind.main
    }
    
    //
    //  When the NSCoder protocol is called for us to save our object, we use this method to
    //  encode (or save) each of our object's properties.
    //
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: WORKOUT_ID)
        aCoder.encode(self.title, forKey: WORKOUT_TITLE)
        aCoder.encode(self.details, forKey: WORKOUT_DETAILS)
        aCoder.encode(self.type.rawValue, forKey: WORKOUT_TYPE)
        aCoder.encode(self.difficulty.rawValue, forKey: WORKOUT_DIFFICULTY)
        aCoder.encode(self.kind.rawValue, forKey: WORKOUT_KIND)
    }
    
    // --------------------------------------------------------------------------------------------
    // MARK: - Public Methods
    
    //
    //  Returns the id for the workout.
    //
    func getId() -> WorkoutID {
        return self.id
    }
}
