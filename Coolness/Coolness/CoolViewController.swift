import UIKit

class CoolViewController: UIViewController
{
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.brown
        
        let subview1 = CoolCell(frame: CGRect(x: 40, y: 60, width: 80, height: 30))
        let subview2 = CoolCell(frame: CGRect(x: 60, y: 100, width: 80, height: 30))
        view.addSubview(subview1)
        view.addSubview(subview2)
        
        subview1.text = "Hello World! 🎉"
        subview2.text = "Cool Cells are Cool!!! 😎"
        subview1.sizeToFit()
        subview2.sizeToFit()
        
        subview1.backgroundColor = UIColor.purple
        subview2.backgroundColor = UIColor.orange
    }
}

