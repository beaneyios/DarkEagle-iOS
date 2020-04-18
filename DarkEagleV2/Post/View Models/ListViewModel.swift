//
//  ListViewModel.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 18/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

class ListViewModel: BlockListViewModel {
    private var list: List?
    
    var didChange: ((BlockListChange) -> Void)?
    
    private(set) var blockSections: [BlockSection] = []
    
    func loadData() {
        fetchList()
    }
    
    private func fetchList() {
        PostDownloader().downloadPosts(id: "1") { (result) in
            switch result {
            case let .success(list):
                self.blockSections = list.blockSections
            default:
                break
            }
        }
    }
}