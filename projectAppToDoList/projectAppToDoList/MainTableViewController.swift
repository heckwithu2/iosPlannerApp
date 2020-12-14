//
//  MainTableViewController.swift
//  projectAppToDoList
//
//  Created by Jeremiah and Alyssa on 12/11/20.
//

import UIKit

class MainTableViewController: UITableViewController {
    // MARK: - ========================================
    private let tableSectionCount = 1
    
    public var userName: String = "Nobody"
    
    var IntroViewController: IntroViewController?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - ========================================
    // MARK: Helper
    func toggleEditingMode() {
        // Toggle ...
        if self.isEditing { self.setEditing(false, animated: true) }
        else              { self.setEditing(true,  animated: true) }
    }

    // MARK: - ========================================
    // MARK: View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
        IntroViewController = self.navigationController?.viewControllers[0] as? IntroViewController
    }
    
    //============================================
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupName()
         // Refresh the table
        tableView.reloadData()
    }

    func setupName() {
        if (IntroViewController?.name != "") {
            let original: String? = IntroViewController?.name
            let adon: String = "'s Planner"
            titleLabel.text = original! + adon
        } else {
            let adon: String = "'s Planner"
            titleLabel.text = userName + adon
        }
        
        
    }

    
    //============================================
    @IBAction func addRow(_ sender: AnyObject) {
        // Add an new Item for the new row
        ItemStore.shared.addItem()
        
        tableView.reloadData()
    }
    
    
    @IBAction func toggleEditingMode(_ sender: UIBarButtonItem) {
        toggleEditingMode()
    }
    
  

    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        -> UISwipeActionsConfiguration?
    {
        // Create an action to do the delete
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Delete") {
                                                (contextAction: UIContextualAction,
                                                sourceView: UIView,
                                                completionHandler: (Bool) -> Void) in
                                                // Do the remove
                                                ItemStore.shared.removeItem(at: indexPath.row)
                                                self.tableView.deleteRows(at: [indexPath], with: .left)
                                                // Call the provided function
                                                completionHandler(true) }
        
        // Create an action that doesn't do anything
        let otherAction = UIContextualAction(style: .normal,
                                             title: "Other") {
                                                (contextAction: UIContextualAction,
                                                sourceView: UIView,
                                                completionHandler: (Bool) -> Void) in
                                                
                                                // Call the provided function
                                                completionHandler(true) }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, otherAction])
        
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView,
                            moveRowAt fromIndexPath: IndexPath,
                            to: IndexPath) {
        // Keep the correspondence between row and container indexes
        ItemStore.shared.moveItem(first: fromIndexPath.row, second: to.row)

        // Refresh the table
        tableView.reloadData()

    }

}

// MARK: - ========================================
extension MainTableViewController {
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Edit") {
                
            
            // Get a reference to the upcoming view controller
            let dest = segue.destination as? DetailViewController
                    
            // The selected table row
            let row = tableView.indexPathForSelectedRow?.row

            // Get a copy of the item from the itemStore
            let item = ItemStore.shared.getItem(index: row!)
            
            // Save the selected row in the detail VC
            dest!.selectedRow = row!
            
            if (item.body != "") {
                dest!.bodyFill = item.body
            }
            
            dest!.taskTitle = item.name
         
            // Set/copy the Item to the detail VC
            dest!.item = item
            
        }
        if (segue.identifier == "Settings") {
            // Get a reference to the upcoming view controller
            //let dest = segue.destination as? SettingsViewController
                    
            // Set up a reference in the detail VC back to the itemStore
            //dest?.itemStore = itemStore
            //dest?.delegate = self
        }
    }
}

// MARK: - ========================================
extension MainTableViewController {
    // MARK:Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableSectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemStore.shared.itemsCount()
    }

    override func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stuffCell", for: indexPath)

        // Configure the cell...
        //cell.textLabel?.text = String(format: "Row - %d", arguments: [indexPath.row])
        
        // Configure the cell...
        let row  = indexPath.row

        // Get the item from the itemStore
        var item = ItemStore.shared.getItem(index: row)

        // Do we have a non-empty string?
        
        let name = item.name
        
        if name.count != 0 {
             // Use the name from the Item
             cell.textLabel?.text = name
        }
        else {
             // Use the row number
             cell.textLabel?.text = String(format: "Task: %d",
                                            arguments: [row])
        }
        
        item.name = (cell.textLabel?.text)!
        return cell
    }
    
}
