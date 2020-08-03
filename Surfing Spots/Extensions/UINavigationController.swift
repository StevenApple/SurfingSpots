
import UIKit

extension UINavigationController {
    
    func configNavigationBarAppearance() {
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 31, weight: UIFont.Weight.medium) ]
        navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
