//
//  WorkoutViewController.swift
//

import UIKit

class WorkooutViewController: UITableViewController {
    // ---------------------------------------------------------------------------------------------
    // MARK: - Constant Defintions
    
    private let NUMBER_OF_SECTIONS: Int     = 3
    private let SECTION_WORKOUT_TYPES: Int  = 0
    private let SECTION_WORKOUT_KINDS: Int  = 1
    private let SECTION_WORKOUT_ALL: Int    = 2
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Private Properties
    
    private var selectedWorkout: Int    = 0
    
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
        
        //
        //  When the view appears, we reload the athlete data because it might have changed.
        //
        self.tableView.reloadData()
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
        //  If it is the workout detail that was tapped, then we set our workout information to
        //  the workout detail view controller that is about to be displayed.
        //
        if segue.identifier == "workoutDetailSegue2" {
            let viewController = segue.destination as! WorkoutDetailViewController
            let workout = AppData.shared.getWorkout(at: self.selectedWorkout)
            viewController.setWorkout(workout: workout)
            viewController.navigationItem.title = "Details"
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        
        //
        //  Based on our section, return the appropriate cell and data.
        //
        switch indexPath.section {
        case SECTION_WORKOUT_TYPES:
            //
            //  Show the user our workout types.
            //
            cell = tableView.dequeueReusableCell(withIdentifier: "workoutTypeCell")!
            cell.textLabel?.text =  WorkoutType.types[indexPath.row].description()
            
        case SECTION_WORKOUT_KINDS:
            //
            //  Show the user our workout kinds.
            //
            cell = tableView.dequeueReusableCell(withIdentifier: "workoutTypeCell")!
            cell.textLabel?.text =  WorkoutKind.kinds[indexPath.row].description()
            
        case SECTION_WORKOUT_ALL:
            //
            //  Fetch our reusable cell and retrieve the cell components. We do this to show
            //  all of our workouts.
            //
            cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell")!
            if AppData.shared.getWorkoutCount() > 0 {
                let workout = AppData.shared.getWorkout(at: indexPath.row)
                cell.textLabel?.text = workout.title
                cell.detailTextLabel?.text = "\(workout.kind.description())"
            }
            
        default:
            break
        }

        return cell
    }
    
    //
    //  Return the number of sections in the table view.
    //
    override func numberOfSections(in tableView: UITableView) -> Int {
        return NUMBER_OF_SECTIONS
    }
    
    //
    //  Returns the name for the section.
    //
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header: String = ""
        
        switch section {
        case SECTION_WORKOUT_TYPES:     header = "Workouts by Type"
        case SECTION_WORKOUT_KINDS:     header = "Workouts by Kind"
        case SECTION_WORKOUT_ALL:       header = "All Workouts"
        default:
            break
        }
        
        return header
    }
    
    //
    //  Return the number of rows in a given section of a table view.
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        //  Depending on section, return the correct count. If SECTION_WORKOUT_TYPES, then return
        //  the count for the number of types we have, otherwise if it is SECTION_WORKOUT_ALL,
        //  then return the total number of workouts that we have.
        //
        var count: Int = 0
        
        switch section {
        case SECTION_WORKOUT_TYPES:
            count = WorkoutType.count
        case SECTION_WORKOUT_KINDS:
            count = WorkoutKind.count
        case SECTION_WORKOUT_ALL:
            count = AppData.shared.getWorkoutCount()
        default:
            break
        }
        
        return count
    }
    
    //
    //  Returns true if the row in the table supports begining editable. We use this method
    //  in conjunction with editingStyle to allow the user to swipe and see the delete button.
    //
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - UITableViewDelegate Methods
    
    //
    //  We support the delete action. So, if the user swipes on a table cell from right to left,
    //  we show a delete button and allow for the delete if tapped.
    //
    override func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    //
    //  The row is about to be selected.
    //
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        //
        //  Set the selected athlete.
        //
        self.selectedWorkout = indexPath.row
        return indexPath
    }
    
    //
    //  The specified row is now selected.
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        //  We don't want to row to be in grey, so we immediately deselect the row.
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

