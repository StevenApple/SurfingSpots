
import UIKit

extension UIView {
    

    public func makeTheViewCornersRounded(targetView : UIView?)  {
        
        targetView!.layer.cornerRadius = 20;
        targetView!.layer.masksToBounds = true;
    }
}
