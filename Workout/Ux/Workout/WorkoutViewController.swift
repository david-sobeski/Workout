//
//  WorkoutViewController.swift
//

import UIKit

class WorkooutViewController: UITableViewController {
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
        //  We set our delegate based on the segue that was initiated.
        //
        //if segue.identifier ==  "athleteDetailSegue" {
        //    let viewController = segue.destination as! WorkoutDetailViewController
        //    viewController.setWorkout(workout: appData.getAthlete(at: self.selectedAthlete))
        //}
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
        //
        //  Fetch our reusable cell and retrieve the cell components.
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell")!
        
        //
        //  Set our text label with the workout title.
        //
        if AppData.shared.getWorkoutCount() > 0 {
            let workout = AppData.shared.getWorkout(at: indexPath.row)
            cell.textLabel?.text = workout.title
        }
        
        return cell
    }
    
    //
    //  Return the number of sections in the table view.
    //
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //
    //  Return the number of rows in a given section of a table view.
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        //  We simply return the number of athletes we have stored.
        //
        return AppData.shared.getWorkoutCount()
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

