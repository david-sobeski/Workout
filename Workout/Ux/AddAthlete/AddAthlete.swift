//
//  AddAthlete.swift
//  Workout
//

import UIKit

class AddAthlete: UITableViewController, AthleteDelegate, UIGestureRecognizerDelegate {
   
    // ---------------------------------------------------------------------------------------------
    // MARK: - Constant Defintions
    
    //
    //  We use the following IDs to get the values of the form that the user filled out.
    //
    private let FIRSTNAME               = 1000
    private let LASTNAME                = 1001
    private let HEIGHT                  = 1002
    private let WEIGHT                  = 1003
    private let SPORT                   = 1004
    private let SKILL                   = 1005
    private let GENDER                  = 1006
    private let DATEOFBIRTH             = 1007
    
    //
    //  The constant definitions tell us what item is at what row index in the table. We need
    //  this because this particular table is a static table.
    //
    private let ROWINDEX_FIRSTNAME      = 0
    private let ROWINDEX_LASTNAME       = 1
    private let ROWINDEX_HEIGHT         = 2
    private let ROWINDEX_WEIGHT         = 3
    private let ROWINDEX_SPORT          = 4
    private let ROWINDEX_SKILL          = 5
    private let ROWINDEX_GENDER         = 6
    private let ROWINDEX_DATEOFBIRTH    = 7
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Private Properties
    
    private var selectedSport: Sport        = Sport.none
    private var selectedSkill: Skill        = Skill.novice
    private var selectedGender: Gender      = Gender.unknown
    private var editAthleteID: AthleteID    = "0"
    private var editMode: Bool              = false
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - UIViewController Methods
    
    //
    //  This method is called after the view controller has loaded its view hierarchy into memory.
    //  This method is called regardless of whether the view hierarchy was loaded from a nib file or
    //  created programmatically in the loadView method. You usually override this method to perform
    //  additional initialization on views that were loaded from nib files.
    //
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //
    //  This method is called before the view controller's view is about to be added to a view
    //  hierarchy and before any animations are configured for showing the view. You can override
    //  this method to perform custom tasks associated with displaying the view. For example, you
    //  might use this method to change the orientation or style of the status bar to coordinate
    //  with the orientation or style of the view being presented. If you override this method,
    //  you must call super at some point in your implementation.
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.editMode == true {
            self.navigationItem.title = "Edit Athlete"
        }
    }
    
    //
    //  You can override this method to perform additional tasks associated with presenting the
    //  view. If you override this method, you must call super at some point in your implementation.
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //
        //  We need the keyboard to be dismissed if it is being displayed. We need to add a tap
        //  gesture recognizer on the date picker for our date of birth. We do this so if the
        //  user taps on the picker, the keyboard will slide away.
        //
        //  1. Create a new tap gesture recognizer.
        //  2. Add our class a delegate so we can answer behavioral questins.
        //  3. Get the date picker control.
        //  4. Add the gesture recognizer.
        //
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing(sender:)))
        tapGesture.delegate = self
        let datePicker = self.view.viewWithTag(self.DATEOFBIRTH)
        datePicker!.addGestureRecognizer(tapGesture)
    }
    
    //
    //  This method should free up as much memory as possible by purging cached data objects that can
    //  be recreated (or reloaded from disk) later. Use this method in conjunction with the
    //  didReceiveMemoryWarning of the UIViewController class and the
    //  UIApplicationDidReceiveMemoryWarningNotification notification to release memory throughout
    //  the application.
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    //  The segue object containing information about the view controllers involved in the segue.
    //
    //  The default implementation of this method does nothing. Subclasses override this method and
    //  use it to configure the new view controller prior to it being displayed. The segue object
    //  contains information about the transition, including references to both view controllers that
    //  are involved.
    //
    //  Because segues can be triggered from multiple sources, you can use the information in the
    //  segue and sender parameters to disambiguate between different logical paths in your app.
    //  For example, if the segue originated from a table view, the sender parameter would identify
    //  the table view cell that the user tapped. You could then use that information to set the
    //  data on the destination view controller.
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        //  We set our delegate based on the segue that was initiated.
        //
        if segue.identifier ==  "sportsSegue" || segue.identifier == "sportsAccessorySegue" {
            let viewController = segue.destination as! SportsViewController
            viewController.delegate = self
            viewController.setSelectedSport(sport: self.selectedSport)
        } else if segue.identifier ==  "genderSegue" || segue.identifier == "genderAccessorySegue" {
            let viewController = segue.destination as! GenderViewController
            viewController.delegate = self
            viewController.setSelectedGender(gender: self.selectedGender)
        } else if segue.identifier ==  "skillSegue" || segue.identifier == "skillAccessorySegue" {
            let viewController = segue.destination as! SkillViewController
            viewController.delegate = self
            viewController.setSelectedSkill(skill: self.selectedSkill)
        }
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - UIGetstureRecognizerDelegate Methods
    
    //
    //  This method is called when recognition of a gesture by either gestureRecognizer or
    //  otherGestureRecognizer would block the other gesture recognizer from recognizing its
    //  gesture. Note that returning true is guaranteed to allow simultaneous recognition;
    //  returning false, on the other hand, is not guaranteed to prevent simultaneous recognition
    //  because the other gesture recognizer's delegate may return true.
    //
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)  -> Bool {
        return true
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.editMode == false {
            switch indexPath.row {
            case self.ROWINDEX_SPORT:   cell.detailTextLabel!.text = selectedSport.description()
            case self.ROWINDEX_SKILL:   cell.detailTextLabel!.text = selectedSkill.description()
            case self.ROWINDEX_GENDER:  cell.detailTextLabel!.text = selectedGender.description()
            case self.ROWINDEX_DATEOFBIRTH:
                //
                //  Since a person can not be born in the future, we set the maximum date of the
                //  UIDatePicker control to today.
                //
                let dateOfBirth: UIDatePicker = cell.viewWithTag(DATEOFBIRTH) as! UIDatePicker
                dateOfBirth.maximumDate = Date()
            default:
                break
            }
        }
        else if self.editMode == true {
            let editAthlete = AppData.shared.getAthlete(id: self.editAthleteID)
            if editAthlete.found == false {
                return
            }
            
            switch indexPath.row {
            case self.ROWINDEX_FIRSTNAME:
                let firstName: UITextField = cell.viewWithTag(FIRSTNAME) as! UITextField
                firstName.text = editAthlete.athlete.firstName
                
            case self.ROWINDEX_LASTNAME:
                let lastName: UITextField = cell.viewWithTag(LASTNAME) as! UITextField
                lastName.text = editAthlete.athlete.lastName
                
            case self.ROWINDEX_HEIGHT:
                let height: UITextField = cell.viewWithTag(HEIGHT) as! UITextField
                height.text = String(describing: editAthlete.athlete.height)
                
            case self.ROWINDEX_WEIGHT:
                let weight: UITextField = cell.viewWithTag(WEIGHT) as! UITextField
                weight.text = String(describing: editAthlete.athlete.weight)
                
            case self.ROWINDEX_SPORT:
                cell.detailTextLabel!.text = editAthlete.athlete.sport.description()
                self.selectedSport = editAthlete.athlete.sport
                
            case self.ROWINDEX_SKILL:
                cell.detailTextLabel!.text = editAthlete.athlete.skill.description()
                self.selectedSkill = editAthlete.athlete.skill
                
            case self.ROWINDEX_GENDER:
                cell.detailTextLabel!.text = editAthlete.athlete.gender.description()
                self.selectedGender = editAthlete.athlete.gender
                
            case self.ROWINDEX_DATEOFBIRTH:
                //
                //  Since a person can not be born in the future, we set the maximum date of the
                //  UIDatePicker control to today.
                //
                let dateOfBirth: UIDatePicker = cell.viewWithTag(DATEOFBIRTH) as! UIDatePicker
                dateOfBirth.date = editAthlete.athlete.dateOfBirth
                dateOfBirth.maximumDate = Date()
            default:
                break
            }
        }
    }
    
    //
    //  The specified row is now selected.
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        //  If one of our selected rows has a text field, we need to set it to first responder.
        //  Setting it to the first responder allows us to show the keyboard.
        //
        var tag: Int = 0
        switch indexPath.row {
        case self.ROWINDEX_FIRSTNAME:   tag = FIRSTNAME
        case self.ROWINDEX_LASTNAME:    tag = LASTNAME
        case self.ROWINDEX_HEIGHT:      tag = HEIGHT
        case self.ROWINDEX_HEIGHT:      tag = WEIGHT
        default:
            break
        }
        
        //
        //  If our "tag" for the row being selected is tapped, then make it become the first
        //  responder. What this does in iOS speak is to show the keyboard.
        //
        //  Otherwise, tell the system to "end editing" which will dismiss the keyboard - in
        //  most cases. Note, see what we neeed to do for the UIDatePicker in our viewDidAppear
        //  method.
        //
        if tag != 0 {
            let textField = self.tableView.viewWithTag(tag) as! UITextField
            textField.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        
        //
        //  We don't want to row to be in grey, so we immediately deselect the row.
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - AthleteDelegate Methods
    
    //
    //  The user tapped on sport and a view appeared to select a sport for the athlete.
    //  When the use does that, that view will call us back on this method so we can save what
    //  sport the user selected for the athlete.
    //
    func setSport(sport: Sport) {
        self.selectedSport = sport
        
        //
        //  Set the table view text for the sport.
        //
        let sportCell = self.tableView.viewWithTag(self.SPORT) as? UITableViewCell
        sportCell?.detailTextLabel?.text = selectedSport.description()
    }
    
    //
    //  The user tapped on skill and a view appeared to select a skill level for the athlete.
    //  When the use does that, that view will call us back on this method so we can save what
    //  skill the user selected for the athlete.
    //
    func setSkill(skill: Skill) {
        self.selectedSkill = skill
        
        //
        //  Set the tableview text for the skill.
        //
        let skillCell = self.tableView.viewWithTag(self.SKILL) as? UITableViewCell
        skillCell?.detailTextLabel?.text = selectedSkill.description()
    }
    
    //
    //  The user tapped on gender and a view appeared to select a gender for the athlete.
    //  When the use does that, that view will call us back on this method so we can save what
    //  gender the user selected for the athlete.
    //
    func setGender(gender: Gender) {
        self.selectedGender = gender
        
        //
        //  Set the tableview text for the gender.
        //
        let genderCell = self.tableView.viewWithTag(self.GENDER) as? UITableViewCell
        genderCell?.detailTextLabel?.text = selectedGender.description()
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - IBAction Methods
    
    //
    //  Called when the user taps the Cancel button.
    //
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        //
        //  The user canceled, so we just dismiss our screen and do not attempt to save.
        //
        self.dismiss(animated: true, completion: nil)
    }
    
    //
    //  Called when the user taps the save button.
    //
    @IBAction func onSave(_ sender: UIBarButtonItem) {
        //
        //  When the user saves the athlete that they added, we need to fetch each of the values
        //  from our addAthlete form.
        //
        let firstName: UITextField      = self.tableView.viewWithTag(FIRSTNAME) as! UITextField
        let lastName: UITextField       = self.tableView.viewWithTag(LASTNAME) as! UITextField
        let height: UITextField         = self.tableView.viewWithTag(HEIGHT) as! UITextField
        let weight: UITextField         = self.tableView.viewWithTag(WEIGHT) as! UITextField
        let dateOfBirth: UIDatePicker   = self.tableView.viewWithTag(DATEOFBIRTH) as! UIDatePicker
        
        //
        //  Save our new athlete. Fetch our shared app date and create a new athlete object.
        //
        let appData: AppData = AppData.shared
        let athlete: Athlete = Athlete()
        
        //
        //  Set the athlete properties based on the form the user filled out.
        //
        athlete.firstName       = String(describing: firstName.text!)
        athlete.lastName        = String(describing: lastName.text!)
        athlete.height          = Int(height.text ?? "") ?? 0
        athlete.weight          = Int(weight.text ?? "") ?? 0
        athlete.sport           = self.selectedSport
        athlete.gender          = self.selectedGender
        athlete.skill           = self.selectedSkill
        athlete.dateOfBirth     = dateOfBirth.date
        
        //
        //  If we are in "add" mode, then generate workouts and add our new athlete.
        //
        if self.editMode == false {
            //
            //  Generate our workouts based on the athlete that was created.
            //
            self.generateWorkoutsForAthlete(athlete)
            
            //
            //  Add our athlete to our stored athletes.
            //
            appData.addAthlete(athlete: athlete)
        } else {
            //
            //  Create an athlete to copy the attributes that were set in our UX.
            //
            let modifiedAthlete: Athlete = Athlete()
            //
            //  We are in edit mode, therefore we are editing an existing athlete. In this case
            //  we do not need to generate workouts or add it to our application data.
            //
            modifiedAthlete.firstName   = athlete.firstName
            modifiedAthlete.lastName    = athlete.lastName
            modifiedAthlete.height      = athlete.height
            modifiedAthlete.weight      = athlete.weight
            modifiedAthlete.sport       = athlete.sport
            modifiedAthlete.gender      = athlete.gender
            modifiedAthlete.skill       = athlete.skill
            modifiedAthlete.dateOfBirth = athlete.dateOfBirth
            
            AppData.shared.modifyAthlete(id: self.editAthleteID, athlete: modifiedAthlete)
        }

        //  Dismiss our screen to return to the list of athletes.

        self.dismiss(animated: true, completion: nil)
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Private Methods
    
    //
    //  This function will build a workout list for the given Athlete.
    //
    private func generateWorkoutsForAthlete(_ athlete: Athlete) {
        //
        //  Create a new Generator object so we can generate a list of workouts for our athlete.
        //
        let workoutGenerator: Generator = Generator()
        
        //
        //  Get a list of workouts.
        //
        let workouts: [Workout] = workoutGenerator.generateWorkouts(athlete: athlete)
        
        //
        //  Since the athlete only stores workouts via the id, go through each workout, pick the
        //  id and store that in the athletes workout list.
        //
        for i in 0 ..< workouts.count {
            athlete.workouts.append(workouts[i].id)
        }
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Public Methods
    
    //
    //  This is called when a tap occurs. When this happens, we want to end editing - which
    //  will cause the keyboard to be dismissed.
    //
    @objc func endEditing(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //
    //  This method tell us that when our view is presented, we are in "edit mode" and not
    //  in "add athlete mode.
    //
    func editAthlete(id: AthleteID) {
        self.editMode = true
        self.editAthleteID = id
    }
}

