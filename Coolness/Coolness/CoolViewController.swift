import UIKit

private let accessoryHeight = CGFloat(90)

extension CoolViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class CoolViewController: UIViewController
{
    var textField: UITextField!
    var contentView: UIView!
    
    @objc func addCoolCell() {
        let newCoolCell = CoolCell()
        newCoolCell.text = textField.text
        newCoolCell.sizeToFit()
        contentView.addSubview(newCoolCell)
    }
    
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.brown
        
        let (slice, remainder) = UIScreen.main.bounds.divided(atDistance: accessoryHeight, from: .minYEdge)
        let accessoryView = UIView(frame: slice)
        contentView = UIView(frame: remainder)
        
        contentView.clipsToBounds = true
        
        view.addSubview(accessoryView)
        view.addSubview(contentView)
        
        // Controls
        
        textField = UITextField(frame: CGRect(x: 15, y: 35, width: 240, height: 30))
        accessoryView.addSubview(textField)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter some text"
        
        textField.delegate = self
        
        let myButton = UIButton(type: .system)
        accessoryView.addSubview(myButton)
        myButton.setTitle("Add", for: .normal)
        myButton.sizeToFit()
        myButton.frame = myButton.frame.offsetBy(dx: 270, dy: 35)
        
        myButton.addTarget(self, action: #selector(addCoolCell), for: .touchUpInside)
        
        // Cool Cell
        
        let subview1 = CoolCell(frame: CGRect(x: 40, y: 60, width: 80, height: 30))
        let subview2 = CoolCell(frame: CGRect(x: 60, y: 100, width: 80, height: 30))
        contentView.addSubview(subview1)
        contentView.addSubview(subview2)
        
        subview1.text = "Hello World! 🎉"
        subview2.text = "Cool Cells are Cool!!! 😎"
        subview1.sizeToFit()
        subview2.sizeToFit()
        
        subview1.backgroundColor = UIColor.purple
        subview2.backgroundColor = UIColor.orange
        accessoryView.backgroundColor = UIColor(white: 1, alpha: 0.7)
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
}

