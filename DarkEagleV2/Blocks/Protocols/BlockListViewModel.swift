//
//  BlockListViewModel.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 14/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

enum BlockListChange {
    case updated
}

protocol BlockListViewModel {
    var didChange: ((BlockListChange) -> Void)? { get set }
    var blockSections: [BlockSection] { get }
    
    func block(for indexPath: IndexPath) -> Block
    func numberOfBlocks(in section: Int) -> Int
    func numberOfBlockSections() -> Int
    func loadData()
}
