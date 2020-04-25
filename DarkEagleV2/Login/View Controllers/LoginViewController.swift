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
    
    private var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadingView = LoadingView.instanceFromNib()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        logoContainer.addSubview(loadingView)
        loadingView.pinToEdges(on: logoContainer)
        self.loadingView = loadingView
    }
    
    @IBAction func logIn(_ sender: Any) {
        loadingView.startAnimating()
    }
    
    @IBAction func stopLoading(_ sender: Any) {
        loadingView.stopAnimating()
    }
}
