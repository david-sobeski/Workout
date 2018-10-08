//
//  AthleteInfoViewController.swift
//
//  In the Athlete Details, we have an embedded table view controller that simply shows the
//  detailed information of an athlete. This is the implementation of that table view controller.
//

import UIKit

class AthleteInfoViewController: UITableViewController {
    // ---------------------------------------------------------------------------------------------
    // MARK: - Constant Definitions
    
    private let ROWINDEX_NAME           = 0
    private let ROWINDEX_SPORT          = 1
    private let ROWINDEX_SKILL          = 2
    private let ROWINDEX_HEIGHT         = 3
    private let ROWINDEX_WEIGHT         = 4
    private let ROWINDEX_GENDER         = 5
    private let ROWINDEX_DATEOFBIRTH    = 6
    private let ROWINDEX_AGE            = 7
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Private Properties
    
    private var athlete: Athlete = Athlete()
    
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
        self.tableView.reloadData()
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
        //  selected athlete that was pased into this object.
        //
        switch indexPath.row {
        case ROWINDEX_NAME:             cell.textLabel?.text = "\(athlete.firstName) \(athlete.lastName)"
        case ROWINDEX_SPORT:            cell.textLabel?.text = self.athlete.sport.description()
        case ROWINDEX_SKILL:            cell.textLabel?.text = self.athlete.skill.description()
        case ROWINDEX_HEIGHT:           cell.textLabel?.text = String(describing: self.athlete.height)
        case ROWINDEX_WEIGHT:           cell.textLabel?.text = String(describing: self.athlete.weight)
        case ROWINDEX_GENDER:           cell.textLabel?.text = self.athlete.gender.description()
        case ROWINDEX_DATEOFBIRTH:      cell.textLabel?.text = self.athlete.dateOfBirthString
        case ROWINDEX_AGE:              cell.textLabel?.text = String(describing: self.athlete.age)
        default:
            break
        }
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
