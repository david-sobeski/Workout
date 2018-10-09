//
//  AddWorkoutViewController.swift
//

//
//  AddAthlete.swift
//  Workout
//

import UIKit

class AddWorkoutViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Constant Defintions
    
    //
    //  The constant definitions tell us what item is at what row index in the table. We need
    //  this because this particular table is a static table.
    //
    private let ROWINDEX_TITLE          = 0
    private let ROWINDEX_TYPE           = 1
    private let ROWINDEX_KIND           = 2
    private let ROWINDEX_DIFFICULTY     = 3
    private let ROWINDEX_DETAILS        = 4

    
    // ---------------------------------------------------------------------------------------------
    // MARK: - IBOutlets
    
    @IBOutlet var detailsTextView: UITextView!
    
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
        
        self.detailsTextView.layer.borderWidth = 1.0
        self.detailsTextView.layer.cornerRadius = 8.0
        self.detailsTextView.layer.borderColor = UIColor.lightGray.cgColor
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
    }
    
    //
    //  The specified row is now selected.
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        //  If the keyboard is displayed, hide it.
        //
        self.view.endEditing(true)

        //
        //  We don't want to row to be in grey, so we immediately deselect the row.
        //
        tableView.deselectRow(at: indexPath, animated: true)
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
        //  Dismiss our screen to return to the list of athletes.
        //
        self.dismiss(animated: true, completion: nil)
    }
}


