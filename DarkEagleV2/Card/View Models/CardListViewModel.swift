//
//  ListViewModel.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 13/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

class CardListViewModel: BlockListViewModel {
    var didChange: ((BlockListChange) -> Void)?
    var blockSections: [BlockSection] = []
    
    func loadData() {
        
    }
}
