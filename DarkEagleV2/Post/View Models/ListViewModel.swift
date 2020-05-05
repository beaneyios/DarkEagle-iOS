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
        skeletise()
        fetchList()
    }
    
    func reloadData() {
        fetchList()
    }
    
    private func skeletise() {
        self.blockSections = [
            BlockSection(
                blocks: [
                    AnyBlock(
                        resource: SkeletonBlock(
                            id: "",
                            type: .skeleton,
                            skeletonType: .largeCard,
                            size: .fullWidthFixedHeight(350.0)
                        )
                    )
                ] + (0...10).map {
                    AnyBlock(
                        resource: SkeletonBlock(
                            id: "\($0)",
                            type: .skeleton,
                            skeletonType: .rowCard,
                            size: .fullWidthFixedHeight(75.0)
                        )
                    )
                },
                sectionSpacing: 0.0,
                itemSpacing: 2.0
            )
        ]
        
        didChange?(.updated)
    }
    
    private func fetchList() {
        didChange?(.startLoading)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2.0) {
            PostDownloader().downloadPosts(id: "1") { (result) in
                switch result {
                case let .success(list):
                    self.blockSections = list.blockSections
                    self.didChange?(.stopLoading)
                    self.didChange?(.updated)
                default:
                    break
                }
            }
        }
    }
}
