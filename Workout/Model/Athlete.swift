//
//  Athlete.swift
//
//  This file contains the definition of our Athlete class.
//

import Foundation

//
//  Our athlete type is really a UUID that we conver to a string. We want to have a stronger
//  type than just showing it being a string. Therefore, SWIFT gives us a nice trick to create
//  a type alias.
//
typealias AthleteID = String

// ------------------------------------------------------------------------------------------------
// MARK: - Athlete Class

//
//  This class defines the attributes of the Athlete. Since we want to support automatic persistence,
//  we need to support both NSObject and NSCoding. NSObject tells the system that this conforms to
//  the basics of being an iOS object. NSCoding allows us to easily save and load the Athlete object.
//
class Athlete: NSObject, NSCoding {
    //
    //  This is constant definition that describes the format of the date of birth string that we
    //  will store.
    //
    private let DOB_FORMAT: String      = "yyyy-MM-dd"
    
    //
    //  The following are constant definitions for the keys we need to persist each of our
    //  attributes of the class.
    //
    private let ATHLETE_ID              = "ID"
    private let ATHLETE_FIRSTNAME       = "FIRST_NAME"
    private let ATHLETE_LASTNAME        = "LAST_NAME"
    private let ATHLETE_HEIGHT          = "HEIGHT"
    private let ATHLETE_WEIGHT          = "WEIGHT"
    private let ATHLETE_DOB             = "DATE_OF_BIRTH"
    private let ATHLETE_SPORT           = "SPORT"
    private let ATHLETE_GENDER          = "GENDER"
    private let ATHLETE_SKILL           = "SKILL"
    private let ATHLETE_WORKOUTS        = "WORKOUTS"
    
    //
    //  We need to give each athlete a unique id. We do this be creating a UUID for the athlete.
    //  The will ensure that each athlete in the system has a unique id and that we will not
    //  get collisions. We need to do this because this is how we will find, delete, update
    //  athletes. For example, two athletes can have same first and last names ("Mike Smith").
    //  Therefore, it would be a bad idea to key off of name.
    //
    private (set) var id: AthleteID     = UUID().uuidString
    
    //
    //  First and last name of the athlete.
    //
    var firstName: String               = ""
    var lastName: String                = ""
    
    //
    //  We store our height in centimeters and our weight in kilograms. This makes life a
    //  bit easier as we can convert these to imperial equivalents (feet + inchecs and pounds)
    //  if needed.
    //
    var height: Int                     = 0
    var weight: Int                     = 0
    
    //
    //  We store the date of birth. This gives us an exact time when the person was born.
    //  Therefore, when we need the age, we compute it from the current date and the
    //  date of birth. Thus, age is a read only property.
    //
    var dateOfBirth: Date               = Date()
    var age: Int {
        get {
            //
            //  We want to set our date in the format of mm/dd/yyyy and conform to the gregorian
            //  calendar.
            //
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = self.DOB_FORMAT
            let calendar: Calendar = Calendar(identifier: .gregorian)
            
            //
            //  Get today's date.
            //
            let now = Date()
            
            //
            //  Compute the age and return the year difference from birthdate and now.
            //
            let ageComponents = calendar.dateComponents([.year], from: self.dateOfBirth, to: now)
            return ageComponents.year!
        }
    }
    var dateOfBirthString: String {
        get {
            //
            //  We want to set our date in the format of mm/dd/yyyy and return a string version
            //  of our date.
            //
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = self.DOB_FORMAT
            return dateFormatter.string(from: self.dateOfBirth)
        }
    }
    
    //
    //  We store which is the primary sport of the athlete.
    //
    var sport: Sport                    = Sport.none
    
    //
    //  We need to store the Gender of the athlete. We use our built-in enumeration Gender. We do
    //  this so we can consistently know which sex the athlete is and it is helps with
    //  compiler and type verification.
    //
    var gender: Gender                  = Gender.unknown
    
    //
    //  Each athlete has a particular expertise or a skill level associated with their
    //  capability.
    //
    var skill: Skill                    = Skill.novice
    
    //
    //  An athlete can have a "list" of workouts assigned to them. We store an array of workout
    //  IDs.
    //
    var workouts: [String]              = []
    
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
        self.id             = aDecoder.decodeObject(forKey: self.ATHLETE_ID) as? AthleteID ?? ""
        self.firstName      = aDecoder.decodeObject(forKey: self.ATHLETE_FIRSTNAME) as? String ?? ""
        self.lastName       = aDecoder.decodeObject(forKey: self.ATHLETE_LASTNAME) as? String ?? ""
        self.height         = aDecoder.decodeInteger(forKey: self.ATHLETE_HEIGHT)
        self.weight         = aDecoder.decodeInteger(forKey: self.ATHLETE_WEIGHT)
        self.dateOfBirth    = aDecoder.decodeObject(forKey: self.ATHLETE_DOB) as? Date ?? Date()
        self.sport          = Sport(rawValue: aDecoder.decodeInteger(forKey: self.ATHLETE_SPORT)) ?? Sport.none
        self.gender         = Gender(rawValue: aDecoder.decodeInteger(forKey: self.ATHLETE_GENDER)) ?? Gender.unknown
        self.skill          = Skill(rawValue: aDecoder.decodeInteger(forKey: self.ATHLETE_SKILL)) ?? Skill.novice
        self.workouts       = aDecoder.decodeObject(forKey: self.ATHLETE_WORKOUTS) as? [String] ?? []
    }
    
    //
    //  When the NSCoder protocol is called for us to save our object, we use this method to
    //  encode (or save) each of our object's properties.
    //
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: self.ATHLETE_ID)
        aCoder.encode(self.firstName, forKey: self.ATHLETE_FIRSTNAME)
        aCoder.encode(self.lastName, forKey: self.ATHLETE_LASTNAME)
        aCoder.encode(self.height, forKey: self.ATHLETE_HEIGHT)
        aCoder.encode(self.weight, forKey: self.ATHLETE_WEIGHT)
        aCoder.encode(self.dateOfBirth, forKey: self.ATHLETE_DOB)
        aCoder.encode(self.sport.rawValue, forKey: self.ATHLETE_SPORT)
        aCoder.encode(self.gender.rawValue, forKey: self.ATHLETE_GENDER)
        aCoder.encode(self.skill.rawValue, forKey: self.ATHLETE_SKILL)
        aCoder.encode(self.workouts, forKey: self.ATHLETE_WORKOUTS)
    }
    
    // --------------------------------------------------------------------------------------------
    // MARK: - Public Methods
    
    //
    //  Returns the id for the athlete.
    //
    func getId() -> AthleteID {
        return self.id
    }
    
    //
    //  We store our height internally as centimeters. This method will return the height
    //  in Imperial units - feet and inches.
    //
    func heightToImperial() -> (feet: Int, inches: Int) {
        //
        //  If our height is 0 or a negative number, simply return 0 feet and 0 inches.
        //
        if self.height <= 0 {
            return (0, 0)
        }
        
        //
        //  We are using the built-in Measurement object to help us compute the new value. We
        //  do this so we don't have to manually compute and do a ton of conversions. Simply,
        //  get a new measurement instance in centimeters.
        //
        let heightInCM = Measurement(value: Double(self.height), unit: UnitLength.centimeters)
        
        //
        //  Fetch the feet and inches from the measurement object of our known height and
        //  return the converted centermeter in feet and inches.
        //
        let feet = heightInCM.converted(to: UnitLength.feet)
        let inches = Int(heightInCM.converted(to: UnitLength.inches).value) % 12
        return (Int(feet.value), Int(inches))
    }
    
    //
    //  We store our weight as kilograms. This function will return pounds.
    //
    func weightToPounds() -> Int {
        let weightInKg = Measurement(value: Double(self.weight), unit: UnitMass.kilograms)
        return Int(weightInKg.converted(to: UnitMass.pounds).value)
    }
}
