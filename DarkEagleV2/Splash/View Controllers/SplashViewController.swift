//
//  SplashViewController.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 05/05/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

protocol SplashViewControllerDelegate: AnyObject {
    func splashViewControllerDidEndLoading(_ splashViewController: SplashViewController)
}

class SplashViewController: UIViewController {
    @IBOutlet weak var loadingViewContainer: UIView!
    
    weak var delegate: SplashViewControllerDelegate?
    
    private var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.splashViewControllerDidEndLoading(self)
        return
        
        configureLoadingView()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            self.loadingView.stopAnimating {
                UIView.animate(withDuration: 0.8, animations: {
                    self.loadingView.loader.transform = self.loadingView.loader.transform.scaledBy(x: 100.0, y: 100.0)
                }) { (finished) in
                    self.delegate?.splashViewControllerDidEndLoading(self)
                }
            }
        }
    }
    
    private func configureLoadingView() {
        let loadingView = LoadingView.instanceFromNib()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingViewContainer.addSubview(loadingView)
        loadingView.pinToEdges(on: loadingViewContainer)
        loadingView.startAnimating()
        self.loadingView = loadingView
    }
}
