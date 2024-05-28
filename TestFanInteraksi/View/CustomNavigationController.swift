//
//  CustomNavigationController.swift
//  TestFanInteraksi
//
//  Created by reyhan muhammad on 27/05/24.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate{
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        tabBarController?.tabBar.isHidden = false
        return super.popToRootViewController(animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        tabBarController?.tabBar.isHidden = viewControllers.count > 1
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        // Check if the interactive pop gesture was cancelled (user didn't complete the swipe)
        if interactivePopGestureRecognizer?.state == .cancelled {
            // Hide the tab bar if needed
            tabBarController?.tabBar.isHidden = true
        }
        return nil
    }
}
