//
//  SettingsViewController.swift
//  projectAppToDoList
//
//  Created by Jeremiah and Alyssa on 12/12/20.
//

import UIKit


class SettingsViewController: UIViewController {
    
    public var userNameSettings: String = "Nobody"
    
    @IBOutlet weak var userName: UITextField!

    @IBOutlet weak var save: UIButton!
    
    var DetailViewController: DetailViewController?
    var MainTableViewController: MainTableViewController?
    var IntroViewController: IntroViewController?
    
    //=========================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        IntroViewController = self.navigationController?.viewControllers[0] as? IntroViewController
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //init wwith proper states
        nameSetUp()
    }
    func nameSetUp() {
        if (IntroViewController?.name != "") {
            let original: String? = IntroViewController?.name
            //let addon: String = "'s Planner"
            userName.text = original!
        } else {
            //let addon: String = "'s Planner"
            userName.text = userNameSettings
        }
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        IntroViewController?.name = userName.text!
    }
}
