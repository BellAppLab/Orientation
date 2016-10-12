import UIKit

class OrientationViewController: UIViewController {
    
    var orientation: Orientation!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.orientation = Orientation.shared
        
        print("Current orientation: \(self.orientation.check())")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.orientation = nil
        
        super.viewDidDisappear(animated)
    }
    
}


class NoOrientationViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("No orientation")
    }
    
}

