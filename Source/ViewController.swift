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
        /* 📌 [A] Present as it is : A bit normal
         * - The custom toolBar color is cleared once rotated
         * ↳ Normal if override viewWillTransition and don't call super
         * - The topAnchor is destroyed when rotated
         * ↳ So I tried [B]
         */
        // presentAsItIs(safari)
        
        /* 📌 [B] Present on another VC : A byte normal
         * - The custom toolBar color is cleared once rotated
         * ↳ Normal if override viewWillTransition and don't call super
         * - Needs a dummy UIViewController because of the second problem of [A]
         * ↳ Lukily the caller(ViewController) is an UIViewController itself in this sample but made another 'dummy' because sometimes it isn't.
         */
        // presentOnAnotherVc(safari)
    }
    
    private func presentAsItIs(_ viewController: UIViewController) {
        present(viewController, animated: false)
    }
    
    private func presentOnAnotherVc(_ viewController: UIViewController) {
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
