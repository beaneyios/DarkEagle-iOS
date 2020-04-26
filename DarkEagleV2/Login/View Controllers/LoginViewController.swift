//
//  LoginViewController.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 25/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var logoContainer: UIView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    private var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        configureLoadingView()
        configureLoginBtn()
    }
    
    private func configureLoginBtn() {
        loginBtn.layer.cornerRadius = 5.0
        loginBtn.clipsToBounds = true
    }
    
    private func configureLoadingView() {
        let loadingView = LoadingView.instanceFromNib()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        logoContainer.addSubview(loadingView)
        loadingView.pinToEdges(on: logoContainer)
        self.loadingView = loadingView
    }
    
    private func configureTextFields() {
        let usernamePlaceholder = NSAttributedString(
            string: "example@gmail.com",
            attributes: [.foregroundColor: UIColor.white]
        )
        
        let passwordPlaceholder = NSAttributedString(
            string: "•••••••",
            attributes: [.foregroundColor: UIColor.white]
        )
        
        usernameField.attributedPlaceholder = usernamePlaceholder
        passwordField.attributedPlaceholder = passwordPlaceholder
    }
    
    @IBAction func logIn(_ sender: Any) {
        loadingView.startAnimating()
        loginBtn.setTitle("Logging in", for: .disabled)
        loginBtn.isEnabled = false
    }
}
