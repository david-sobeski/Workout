//
//  WorkoutDetailViewController.swift
//
//  In the Athlete Details, we have an embedded table view controller that simply shows the
//  detailed information of an athlete. This is the implementation of that table view controller.
//

import UIKit

class WorkoutDetailViewController: UITableViewController {
    // ---------------------------------------------------------------------------------------------
    // MARK: - Constant Definitions
    
    private let ROWINDEX_TITLE      = 0
    private let ROWINDEX_DIFFICULTY = 1
    private let ROWINDEX_TYPE       = 2
    private let ROWINDEX_KIND       = 3
    private let ROWINDEX_DETAILS    = 4
    private let TAG_DETAILS         = 1000
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Private Properties
    
    private var workout: Workout = Workout()
    
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
    }
    
    //
    //  You can override this method to perform additional tasks associated with presenting the
    //  view. If you override this method, you must call super at some point in your implementation.
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - UITableViewDelegate Methods
    
    //
    //  A table view sends this message to its delegate just before it uses cell to draw a row,
    //  thereby permitting the delegate to customize the cell object before it is displayed. This
    //  method gives the delegate a chance to override state-based properties set earlier by the
    //  table view, such as selection and background color. After the delegate returns, the
    //  table view sets only the alpha and frame properties, and then only when animating rows
    //  as they slide in or out.
    //
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //
        //  Based on our row index, we want to set the athlete's information based on the
        //  selected workout that was pased into this object.
        //
        switch indexPath.row {
        case ROWINDEX_TITLE:        cell.textLabel?.text = self.workout.title
        case ROWINDEX_DIFFICULTY:   cell.textLabel?.text = self.workout.difficulty.description()
        case ROWINDEX_TYPE:         cell.textLabel?.text = self.workout.type.description()
        case ROWINDEX_KIND:         cell.textLabel?.text = self.workout.kind.description()
        case ROWINDEX_DETAILS:
            let textView = cell.viewWithTag(self.TAG_DETAILS) as? UITextView
            textView?.text = self.workout.details
        default:
            break
        }
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Public Methods
    
    //
    //  This method is used to set the selected workout.
    //
    func setWorkout(workout: Workout) {
        self.workout = workout
    }
}
