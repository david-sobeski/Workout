//
//  AthleteViewController.swift
//  Workout
//

import UIKit

class AthleteDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // ---------------------------------------------------------------------------------------------
    // MARK: - Private Properties
    
    private var athlete: Athlete = Athlete()
    private var selectedWorkout: Int = 0
   
    // ---------------------------------------------------------------------------------------------
    // MARK: - IBOutlets
    
    @IBOutlet var workoutTable: UITableView!
    
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
        
        //
        //  We need to manually add our edit button. For some reason, Interface Builder will
        //  not allow us to add a button to the UINaviagationItem.
        //
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(onEdit(sender:)))
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
        //  If it is the athlete segue, then we set our information for the athlete to the new
        //  view controller.
        //
        if segue.identifier ==  "athleteInfoSegue" {
            let viewController = segue.destination as! AthleteInfoViewController
            viewController.setAthlete(athlete: self.athlete)
        }
        
        //
        //  If it is the workout detail that was tapped, then we set our workout information to
        //  the workout detail view controller that is about to be displayed.
        //
        if segue.identifier == "workoutDetailSegue" {
            let viewController = segue.destination as! WorkoutDetailViewController
            let workout = AppData.shared.getWorkoutByID(id: self.athlete.workouts[self.selectedWorkout])!
            viewController.setWorkout(workout: workout)
        }
        
        //
        //  If the user tapped the edit button, then we need to transiation to the edit
        //  athlete and pass in the current athlete.
        //
        if segue.identifier == "editAthleteSegue" {
            //
            //  We need to do this one a little different than the above mechanisms because our
            //  manual segue is poiting to a UINavigationController. From that, we need to get
            //  the first view controller on its navigation stack, that would be our AddAthlete.
            //  Once we have that, we can tell that we are in "edit mode".
            //
            let viewController = segue.destination as! UINavigationController
            let athleteController = viewController.viewControllers[0] as! AddAthlete
            athleteController.editAthlete(id: self.athlete.getId())
        }
    }
    
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - UITableViewDataSource Methods
    
    //
    //  The returned UITableViewCell object is frequently one that the application reuses for
    //  performance reasons. You should fetch a previously created cell object that is marked for
    //  reuse by sending a dequeueReusableCell(withIdentifier:) message to tableView. Various
    //  attributes of a table cell are set automatically based on whether the cell is a separator
    //  and on information the data source provides, such as for accessory views and editing
    //  controls.
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        //  Fetch our reusable cell and retrieve the cell components.
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell")!
        
        //
        //  Since we store the workout ID inside of an athlete, we fetch the workout based on
        //  that ID. If it is found, then we set the table cell's label text to the title
        //  of the workout.
        //
        if let workout = AppData.shared.getWorkoutByID(id: self.athlete.workouts[indexPath.row]) {
            cell.textLabel?.text = workout.title
        }
    
        return cell
    }
    
    //
    //  This method is used to return the number of sections that our table view will display.
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //
    //  Returns the number of rows in a give section for a table view.
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        //  Since we only have one section, we simply return the number of workouts that we
        //  have based on the count from our workouts array that is maintained by an athlete.
        //
        return self.athlete.workouts.count
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - UITableViewDelegate Methods
    
    //
    //  The row is about to be selected.
    //
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        //
        //  Set the selected athlete.
        //
        self.selectedWorkout = indexPath.row
        return indexPath
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - IBAction Methods
    
    @IBAction func onEdit(sender: Any?) {
        performSegue(withIdentifier: "editAthleteSegue", sender: self)
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Public Methods
    
    //
    //  This method is used to set the selected athlete. We use this information to set up
    //  our athlete info in the table.
    //
    func setAthlete(athlete: Athlete) {
        self.athlete = athlete
    }
}
