//

import Foundation
import UIKit

extension UIViewController {
            
    var activityIndicatorHoldingViewTag: Int { return 999999 }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func startActivityIndicator() {
        
        /*DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                
                let holdingView = UIView(frame: UIScreen.main.bounds)
                holdingView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
                holdingView.tag = self.activityIndicatorHoldingViewTag
                
                var activityIndicator : NVActivityIndicatorView!
                let frame = CGRect(x: self.view.frame.size.width / 2 - 30 , y: self.view.frame.size.height / 2 - 20, width: 50, height: 50)
                activityIndicator = NVActivityIndicatorView(frame: frame)
                activityIndicator.type = . lineScale
                activityIndicator.color = .blue
                activityIndicator.startAnimating()
                
                holdingView.addSubview(activityIndicator)
                self.view.addSubview(holdingView) // or use  webView.addSubview(activityIndicator)
                
            }
        }*/
    }
    
    func stopActivityIndicator() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                if let holdingView = self.view.subviews.filter({ $0.tag == self.activityIndicatorHoldingViewTag}).first {
                    holdingView.removeFromSuperview()
                }
            }
        }
    }
    
}

extension UIWindow {
    
    func topMostViewController() -> UIViewController? {
        guard let rootViewController = self.rootViewController else {
            return nil
        }
        return topViewController(for: rootViewController)
    }
    
    func topViewController(for rootViewController: UIViewController?) -> UIViewController? {
        guard let rootViewController = rootViewController else {
            return nil
        }
        guard let presentedViewController = rootViewController.presentedViewController else {
            return rootViewController
        }
        switch presentedViewController {
        case is UINavigationController:
            let navigationController = presentedViewController as! UINavigationController
            return topViewController(for: navigationController.viewControllers.last)
        case is UITabBarController:
            let tabBarController = presentedViewController as! UITabBarController
            return topViewController(for: tabBarController.selectedViewController)
        default:
            return topViewController(for: presentedViewController)
        }
    }
    
}
