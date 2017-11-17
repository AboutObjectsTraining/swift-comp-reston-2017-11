import UIKit

class EditBookController: UITableViewController
{
    var book: Book?
    
    @IBOutlet weak var titleCell: EditBookCell!
    @IBOutlet weak var yearCell: EditBookCell!
    @IBOutlet weak var firstNameCell: EditBookCell!
    @IBOutlet weak var lastNameCell: EditBookCell!
    
    private weak var selectedTextField: UITextField?
    
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    
    @IBOutlet weak var accessoryView: UIView?
    override var inputAccessoryView: UIView? {
        return accessoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUndoManagerObservation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleCell.textField.text = book?.title
        yearCell.textField.text = book?.year
        firstNameCell.textField.text = book?.author?.firstName
        lastNameCell.textField.text = book?.author?.lastName
    }
    
    func updateBook() {
        book?.title = titleCell.textField.text
        book?.year = yearCell.textField.text
        book?.author?.firstName = firstNameCell.textField.text
        book?.author?.lastName = lastNameCell.textField.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Done" {
            updateBook()
        }
    }
}

// MARK: - Undo Management
extension EditBookController: UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        undoButton.isEnabled = true
        selectedTextField = textField
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        undoButton.isEnabled = false
        redoButton.isEnabled = false
    }
    
//    @IBAction func enableUndo(sender: UITextField) {
//        undoButton.isEnabled = true
//        selectedTextField = sender
//    }
    
    fileprivate func configureUndoManagerObservation() {
        NotificationCenter.default.addObserver(forName: .NSUndoManagerDidUndoChange, object: nil, queue: nil) { [weak self] notification in
            self?.undoButton.isEnabled = self?.selectedTextField?.undoManager?.canUndo ?? false
            self?.redoButton.isEnabled = true
        }
        NotificationCenter.default.addObserver(forName: .NSUndoManagerDidRedoChange, object: nil, queue: nil) { [weak self] notification in
            self?.redoButton.isEnabled = self?.selectedTextField?.undoManager?.canRedo ?? false
            self?.undoButton.isEnabled = true
        }
    }
}

