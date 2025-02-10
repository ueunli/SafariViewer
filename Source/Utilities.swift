//
//  Utilities.swift
//  SafariViewer
//
//  Created by Jenna on 2/10/25.
//

import UIKit

var topMostViewController: UIViewController? {
    guard let rootVC = rootViewController else {
        return nil
    }
    
    var topMostVC = rootVC
    
    while topMostVC.presentedViewController != nil {
        topMostVC = topMostVC.presentedViewController!
    }
    
    if topMostVC.self === UIAlertController.self {
        topMostVC = topMostVC.presentingViewController!
    }
    
    return topMostVC
}

var rootViewController: UIViewController? {
    let keyWindow = getWindow()
    
    if let keyWindow,
       !keyWindow.isKeyWindow {
        keyWindow.makeKey()
    }
    
    return keyWindow?.rootViewController
}

func getWindow() -> UIWindow? {
    var window: UIWindow?
    let scenes = UIApplication.shared.connectedScenes
    
    for scene in scenes {
        if window != nil {
            break
        }
        
        if scene.activationState == .foregroundActive,
           let windowScene = scene as? UIWindowScene {
            for w in windowScene.windows where w.isKeyWindow {
                window = w
            }
        }
    }
    
    return window
}

func presentOnWindow(
    _ presentedVC: UIViewController,
    from rootVC: UIViewController,
    _ completion: (() -> Void)? = nil
) {
    DispatchQueue.main.async {
        let window = rootVC.view.window
        window?.windowLevel = .normal
        
        let dummyVC = UIViewController()
        window?.rootViewController = dummyVC
        
        window?.makeKeyAndVisible()
        window?.isHidden = false
        presentedVC.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async {
            dummyVC.present(presentedVC, animated: false, completion: completion)
        }
    }
}
