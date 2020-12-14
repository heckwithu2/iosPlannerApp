//
//  IntroViewController.swift
//  projectAppToDoList
//
//  Created by Jeremiah and Alyssa on 12/12/20.
//

import UIKit

//protocol DetailViewControllerDelegate {
//    func saveItemToItemStore(_ item: Item, at index: Int)
//}

class IntroViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    
    public var name = ""
    var SettingsViewController: SettingsViewController?
    var MainTableViewController: MainTableViewController?
    
    
   
    @IBAction func enterName(_ sender: Any) {
        
        if (userName.text != nil) {
            MainTableViewController?.userName = userName.text!
            name = userName.text!
        }
        
    }       
    

}
