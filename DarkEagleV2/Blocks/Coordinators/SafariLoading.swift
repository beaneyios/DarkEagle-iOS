//
//  SafariLoading.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 06/05/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit
import SafariServices

protocol SafariLoading {
    func loadUrlInSafari(url: URL, on viewController: UIViewController)
}

extension SafariLoading {
    func loadUrlInSafari(url: URL, on viewController: UIViewController) {
        let sf = SFSafariViewController(url: url)
        viewController.present(sf, animated: true, completion: nil)
    }
}


