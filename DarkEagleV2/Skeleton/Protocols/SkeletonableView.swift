//
//  SkeletonableView.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 05/05/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

protocol SkeletonableView: NibLoadable {
    func startSkeleton()
    func stopSkeleton()
}
