//
//  LoginPopUp.swift
//  Pokerzone
//
//  Created by Esraa Gamal on 07/01/2022.
//

import Cocoa

class LoginPopUp: NSViewController {

    @IBOutlet weak var loginView: NSView!
    @IBOutlet weak var nameTextView: NSView!
    @IBOutlet weak var passwordTextView: NSView!
    @IBOutlet weak var loginButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let arr = [nameTextView, passwordTextView]
        
        loginView.wantsLayer = true
        loginView.layer?.backgroundColor = #colorLiteral(red: 0.02745098039, green: 0.08235294118, blue: 0.168627451, alpha: 1)
        loginView.layer?.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.36)
        loginButton.wantsLayer = true
        loginButton.layer?.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1843137255, blue: 0.4392156863, alpha: 0.99)
        arr.forEach { nsView in
            nsView?.wantsLayer = true
            nsView?.layer?.backgroundColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.4196078431, alpha: 0.39)
        }
        
        loginView.layer?.shadowRadius = 21

        loginView.shadow = NSShadow()
        loginView.layer?.shadowOpacity = 1.0
        loginView.layer?.shadowOffset = NSMakeSize(-4, 4)
        loginView.layer?.shadowOpacity = 1
      
    }
}
