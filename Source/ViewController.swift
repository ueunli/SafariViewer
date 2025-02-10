//
//  ViewController.swift
//  SafariViewer
//
//  Created by Jenna on 2/10/25.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    private let dummy: UIViewController = {
        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen
        
        return vc
    }()
    
    private let safari: SFSafariViewController = {
        let url = URL(string: "https://www.google.com")!
        let vc = SFSafariViewController(url: url)
        vc.modalPresentationStyle = .fullScreen
        vc.preferredBarTintColor = bgColor
        vc.preferredControlTintColor = fgColor
        vc.dismissButtonStyle = .close
        vc.configuration.barCollapsingEnabled = true
        vc.configuration.entersReaderIfAvailable = false
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return vc
    }()
    
    override func viewWillTransition(
        to size: CGSize,
        with coordinator: any UIViewControllerTransitionCoordinator
    ) {
        // Breakpoint here 🤖
        // super.viewWillTransition(to: size, with: coordinator)
        // Breakpoint here 🤖
        
        // Not called...
        print(dummy.view.window == getWindow())
        print(dummy.view.window?.rootViewController == getWindow()?.rootViewController)
    }

    @IBAction
    private func didTouchShowButton() {
        dummy.addChild(safari)
        safari.didMove(toParent: dummy)
        
        dummy.view.addSubview(safari.view)
        safari.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            safari.view.topAnchor.constraint(equalTo: dummy.view.topAnchor),
            safari.view.bottomAnchor.constraint(equalTo: dummy.view.bottomAnchor),
            safari.view.leadingAnchor.constraint(equalTo: dummy.view.leadingAnchor),
            safari.view.trailingAnchor.constraint(equalTo: dummy.view.trailingAnchor)
        ])
        
        /* 📌 [A] Present as it is : A bit normal
         * - Annotate line49~59 before run
         * - Not normal for same reason as [B]
         * - The topAnchor is destroyed when rotated
         */
        // present(safari, animated: true)
        
        /* 📌 [B] Present on another VC : A byte normal
         * - The custom toolBar color is cleared once rotated
         * - Normal if don't call super in the overriden viewWillTransition
         * - Need dummy VC because of the second problem of [A] (line52~59 is needed)
         */
        // present(dummy, animated: false)
        // topMostViewController?.present(dummy, animated: false)
        
        /* 📌 [C] Present on certain window : Abnormal
         * - The custom toolBar color is cleared once rotated
         * - viewWillTransition is not called
         * - Need it because sometimes we want to present a VC on another window
         */
        presentOnWindow(dummy, from: self)
    }
    
}
