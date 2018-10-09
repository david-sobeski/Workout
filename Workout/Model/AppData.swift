//
//  AppData.swift
//  Workout
//

import Foundation

class AppData: NSObject {
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Singleton Definition
    
    static let shared = AppData()
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - UserDefault Keys
    
    private let ATHLETEDATA: String     = "ATHLETE_DATA"
    private let WORKOUTDATA: String     = "WORKOUT_DATA"
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Internal Data
    
    private var athletes: [Athlete] = []
    private var workouts: [Workout] = []
   
    // ---------------------------------------------------------------------------------------------
    // MARK: - Initialization and Deallocation
    
    //
    //  When our AppData is initialized, we force a synchronization
    //
    override init()
    {
        super.init()
        self.load()
    }
    
    //
    //  If our class is being terminated, we want to for a synchronization on our NSUserDefaults
    //  just in case something was not written to memory/disk.
    //
    deinit
    {
        self.save()
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Persistent Methods

    //
    //  This function is used to load our data from the iPhone's storage.
    //
    public func load() {
        //
        //  Loads the athlete data from iPhone storage.
        //
        if let value = UserDefaults.standard.object(forKey: self.ATHLETEDATA) {
            self.athletes = (NSKeyedUnarchiver.unarchiveObject(with: value as! Data) as? [Athlete])!
        }
        
        //
        //  Loads the athlete data from iPhone storage.
        //
        if let value = UserDefaults.standard.object(forKey: self.WORKOUTDATA) {
            self.workouts = (NSKeyedUnarchiver.unarchiveObject(with: value as! Data) as? [Workout])!
        }
        
        //
        //  When we load our workouts, and if our count is 0, then we want to load our default
        //  workouts from workouts JSON file.
        //
        if self.getWorkoutCount() == 0 {
            self.loadWorkoutData()
        }
    }
    
    //
    //  This function will save all of our data to the iPhone's storage.
    //
    public func save() {
        let athleteSaveData = NSKeyedArchiver.archivedData(withRootObject: self.athletes)
        UserDefaults.standard.set(athleteSaveData, forKey: self.ATHLETEDATA)
        
        let workoutSaveData = NSKeyedArchiver.archivedData(withRootObject: self.workouts)
        UserDefaults.standard.set(workoutSaveData, forKey: self.WORKOUTDATA)

        UserDefaults.standard.synchronize()
    }
    
    //
    //  This method is used to load our workout data from our Workout.json file.
    //
    private func loadWorkoutData() {
        //
        //  Load our Workout JSON file.
        //
        do {
            if let workoutFile = Bundle.main.url(forResource: "Workouts", withExtension: "json", subdirectory: nil, localization: nil) {
                //
                //  Convert the contents of our file to an object via JSON serialization.
                //
                let data = try Data(contentsOf: workoutFile)
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                //
                //  In our JSON files, the Workouts object contains an array of workout items. We
                //  need to iterate over all the workout items and create new Workouts for each
                //  item.
                //
                let workouts: NSArray = json.object(forKey: "Workouts") as! NSArray
                for count in 0..<workouts.count {
                    //
                    //  Each workout item contained in the array is a dictionary object where we
                    //  access the properties through the key name - the JSON variable. First, we
                    //  need to case a workoutItem to an NSDictionary and (second) we can then
                    //  access each item throught the JSON tag name an d set it to our Workout's
                    //  property.
                    //
                    let workoutItem: NSDictionary = workouts[count] as! NSDictionary
                    let workout: Workout = Workout()
                    
                    workout.id          = workoutItem.object(forKey: "id") as! String
                    workout.type        = WorkoutType(rawValue: (workoutItem.object(forKey: "type") as? Int)!)!
                    workout.title       = workoutItem.object(forKey: "title") as! String
                    workout.details     = workoutItem.object(forKey: "details") as! String
                    workout.difficulty  = Difficulty(rawValue: (workoutItem.object(forKey: "difficulty") as? Int)!)!
                    workout.kind        = WorkoutKind(rawValue: (workoutItem.object(forKey: "kind") as? Int)!)!
                
                    //
                    //  Add our workout to our workout array.
                    //
                    self.workouts.append(workout)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Athlette Methods
    
    //
    //  We use this method to add a new athlete to the system.
    //
    public func addAthlete(athlete: Athlete) {
        self.athletes.append(athlete)
        
        //
        //  We want to ensure that all of our athletes are sorted in the array via their
        //  last name. Therefore, we will sort the array and then we will save the new data.
        //
        athletes.sort {
            $0.lastName < $1.lastName
        }
        
        self.save()
    }
    
    //
    //  This method allows one to modify an existing athlete. We search for the athlete by the
    //  ID.
    public func modifyAthlete(id: AthleteID, athlete: Athlete) {
        //
        //  Search for an athlete based on its id field.
        //
        if let foundIndex = self.athletes.index(where: { $0.getId() == id } ) {
            //
            //  Set the found athlete's properties.
            //
            //  SIDE EFFECTS: We don't need to set the ID property becasue we are modifying an
            //                existing athlete.
            //
            //                We don't set the workout property as we do not regenerate workouts.
            //
            self.athletes[foundIndex].firstName     = athlete.firstName
            self.athletes[foundIndex].lastName      = athlete.lastName
            self.athletes[foundIndex].height        = athlete.height
            self.athletes[foundIndex].weight        = athlete.weight
            self.athletes[foundIndex].dateOfBirth   = athlete.dateOfBirth
            self.athletes[foundIndex].sport         = athlete.sport
            self.athletes[foundIndex].skill         = athlete.skill
            self.athletes[foundIndex].gender        = athlete.gender
        }
    }
    
    //
    //  This methdo will delete an athlete for the passed in Athlete object. What happens is that
    //  we search for the athlete based on its ID. If we find it, then we remove it from our
    //  Athlete array.
    //
    public func deleteAthlete(athlete: Athlete) {
        //
        //  Search for an athlete based on its id field. If found, remove it from the
        //  array of athletes.
        //
        if let foundIndex = self.athletes.index(where: { $0.getId() == athlete.getId() } ) {
            self.athletes.remove(at: foundIndex)
            
            //
            //  Since we deleted an athlete, we want to save our new athlete array.
            //
            self.save()
        }
    }
    
    //
    //  Returns the number of athletes in our internal array.
    //
    public func getAthleteCount() -> Int {
        return self.athletes.count
    }
    
    //
    //  Returns an athlete for a given index.
    //
    public func getAthlete(at index: Int) -> Athlete {
        return self.athletes[index]
    }
    
    //
    //  Returns an athlete by its ID.
    //
    public func getAthlete(id: AthleteID) -> (found: Bool, athlete: Athlete) {
        //
        //  Search for an athlete based on its id field. If found, return the athlete otherwise
        //  return nil.
        //
        if let foundIndex = self.athletes.index(where: { $0.getId() == id } ) {
            return (true, self.athletes[foundIndex])
        }
            
        //
        //  If we did not find the athlete, then return false as found and an empty athlete
        //  object.
        //
        return (false, Athlete())
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Workout Methods
    
    //
    //  Returns the total number of workouts that we have stored.
    //
    public func getWorkoutCount() -> Int {
        return self.workouts.count
    }
    
    //
    //  This method adds a new workout to our list.
    //
    public func addWorkout(workout: Workout) {
        self.workouts.append(workout)
    }
    
    //
    //  This method will fetch a workout based on its ID.
    //
    public func getWorkoutByID(id: String) -> Workout? {
        //
        //  Search for an workout based on its id field. If found, return the workout.
        //
        if let foundIndex = self.workouts.index(where: { $0.id == id } ) {
            return self.workouts[foundIndex]
        }
        
        //
        //  In this case, the workout was not found based on its ID, therefore we return nil.
        //
        return nil
    }
    
    //
    //  Returns an workout for a given index.
    //
    public func getWorkout(at index: Int) -> Workout {
        return self.workouts[index]
    }
}

