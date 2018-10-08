//
//  GenderViewController.swift
//
//  Thie file contains the implementation of our SportsViewController. It is a table view
//  that will list all the available sport.
//

import UIKit

class GenderViewController: UITableViewController {
    private let gender: [Gender]    = Gender.genders
    private var selectedRow: Int    = 0
    
    //
    //  This is a delegate or a callback. Since we are setting data to a view the called us, this
    //  points back to that view and allows us to call methods defined by the Athlete Delegate.
    //
    public var delegate: AthleteDelegate?
    
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
        self.tableView.scrollToRow(at: IndexPath(item: self.selectedRow, section: 0), at: .top, animated: true)
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
    // MARK: - UITableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        //  Fetch our reusable cell and retrieve the cell components.
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "genderCell")!
        
        if self.gender.count > 0 {
            //
            //  Our rows will go from 0..number of gender in the array (the count). We use
            //  the indexpath row as an index into our gender array. That will get us the
            //  enumeration item. We then ask for the description to display in the table
            //  cell.
            //
            cell.textLabel?.text = gender[indexPath.row].description()
            
            if indexPath.row == self.selectedRow {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    //
    //  This method is used to return the number of sections that our table view will display.
    //
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //
    //  Returns the number of rows in a give section for a table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        //  Since we only have one section, we simply return the number of sports that we
        //  have based on the count from our sports enumeration / array.
        //
        return self.gender.count
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - UITableViewDelegate Methods
    
    //
    //  The specified row is now selected.
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        //  We need to toggle the checkmark. Therefore, we need to uncheck the currently selected
        //  row and check the newly selected row.
        //
        let previousCell = self.tableView.cellForRow(at: IndexPath(row: self.selectedRow, section: 0))
        previousCell?.accessoryType = .none
        
        let selectedCell = self.tableView.cellForRow(at: indexPath)
        selectedCell?.accessoryType = .checkmark
        
        self.selectedRow = indexPath.row
        
        //
        //  Call our delegate to tell it what sport was selected.
        //
        self.delegate?.setGender(gender: self.gender[indexPath.row])
        
        //
        //  We don't want to row to be in grey, so we immediately deselect the row.
        //
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - Public Methods
    
    //
    //  This method is used to set the selected sport. By doing this, we find what item in the
    //  array our sport is contained, set the selected row and then refresh our table.
    //
    func setSelectedGender(gender: Gender) {
        if let foundIndex = self.gender.index(where: { $0 == gender } ) {
            self.selectedRow = foundIndex
        }
    }
}
