
import UIKit

//protocol DetailViewControllerDelegate {
//    func saveItemToItemStore(_ item: Item, at index: Int)
//}

class DetailViewController: UIViewController {
        
    @IBOutlet weak var name: UITextField!

    @IBOutlet weak var body: UITextView!
    
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var date: UILabel!
    
    
    // The cell that was selected when this VC was brought up
    var selectedRow: Int?
    var item: Item?
    var taskTitle: String?
    var bodyFill: String?
    var MainTableViewController: MainTableViewController?
    //var itemStore: ItemStore!
    //var delegate: DetailViewControllerDelegate?

    //=========================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //=========================================================
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        
       // Set name
       name.text = taskTitle
       body.text = bodyFill
        if (body.text == "") {
            body.text = "..."
        }
    }
    
    //=========================================================
    /////saving!!!!
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Create an Item from the text field values, Int("") -> nil
        let item = Item(name: name.text ?? "",
                        body: body.text ?? "",
                        number: Int(number.text ?? ""))

        // Store the values in the itemStore
        //itemStore.setItem(item, number: selectedRow!)
        //delegate?.saveItemToItemStore(item, at: selectedRow!)
        
        ItemStore.shared.setItem(item, number: selectedRow!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//=========================================================
extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn( _ textField: UITextField) -> Bool {
        // Use the parameter, could be either text field
        textField.resignFirstResponder()
                            
        return true
    }
}
