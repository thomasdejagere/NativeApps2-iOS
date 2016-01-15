import UIKit

class EmptyViewController: UIViewController
{
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        if splitViewController?.displayMode == .PrimaryHidden {
            let target = navigationItem.leftBarButtonItem!.target!
            let action = navigationItem.leftBarButtonItem!.action
            target.performSelector(action)
        }
    }
}