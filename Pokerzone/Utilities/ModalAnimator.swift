//
//  ModelAnimator.swift
//  Pokerzone
//
//  Created by Esraa Gamal on 07/01/2022.
//

import Cocoa

class BackGroundView : NSView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.1607843137, blue: 0.3019607843, alpha: 0)
        alphaValue = 0
    }
    
    override func mouseDown(with event: NSEvent) {
        ///
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ModalAnimator: NSObject, NSViewControllerPresentationAnimator {
    
    let backgroundView = BackGroundView(frame: .zero)
    var currentVC : NSViewController? = nil
    
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        
        self.currentVC = viewController
        
        let contentView = fromViewController.view
        backgroundView.frame = contentView.bounds
        backgroundView.autoresizingMask = [.height, .width]
        contentView.addSubview(backgroundView)
                
        let blurView = NSVisualEffectView(frame: backgroundView.bounds)
        blurView.autoresizingMask = [.height, .width]
        blurView.blendingMode = .withinWindow
        blurView.material = .fullScreenUI
        blurView.state = .active
        blurView.wantsLayer = true
        blurView.layer?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2640076722)
        backgroundView.addSubview(blurView)
        
        
        let modalView = viewController.view
        modalView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.addSubview(modalView)
        modalView.makeItCentered(centerX: backgroundView.centerXAnchor, centerY: backgroundView.centerYAnchor)
        modalView.setConstraints(width: 450, height: 398)
        NSAnimationContext.runAnimationGroup ({ context in
            self.backgroundView.animator().alphaValue = 1
        }, completionHandler: nil)
        
        backgroundView.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(tappedOnBackGround(_:))))
    }
    
    @objc func tappedOnBackGround(_ sender: NSGestureRecognizer) {
        let point = sender.location(in: backgroundView)
        
        if (currentVC?.view.frame.contains(point) ?? false) == false {
            currentVC?.dismiss(currentVC)
        }
        
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.5
            backgroundView.animator().alphaValue = 0
        } completionHandler: {
            self.backgroundView.removeFromSuperview()
        }
    }
}
