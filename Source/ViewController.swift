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
    }
    
    @IBAction
    private func didTouchShowButton() {
        safari.removeFromParent()
        safari.view.removeFromSuperview()
        
        /* 📌 [A] Present as it is : A bit normal
         * - The custom toolBar color is cleared once rotated
         * ↳ Normal if override viewWillTransition and don't call super
         * - The topAnchor is destroyed when rotated
         * ↳ Needs a parent UIViewController to give some constraints
         * ↳ So I tried [B]
         */
        // presentAsItIs()
        
        /* 📌 [B] Present on current VC : A byte normal
         * - The custom toolBar color is cleared once rotated
         * ↳ Normal if override viewWillTransition and don't call super
         * - As a matter of course, cannot close the webview
         * ↳ Needs a dummy parent UIViewController to give some constraints
         * ↳ So I tried [C]
         */
        // presentOnCurrentVc()
        
        /* 📌 [C] Present on current VC : A byte normal
         * - The custom toolBar color is cleared once rotated
         * ↳ Normal if override viewWillTransition and don't call super
         */
        // presentOnAnotherVc()
    }
    
    private func presentAsItIs() {
        present(safari, animated: false)
    }
    
    private func presentOnCurrentVc() {
        addChild(safari)
        safari.didMove(toParent: self)
        
        view.addSubview(safari.view)
        safari.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            safari.view.topAnchor.constraint(equalTo: view.topAnchor),
            safari.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            safari.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            safari.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func presentOnAnotherVc() {
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
        
        present(dummy, animated: false)
    }
    
}
