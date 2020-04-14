//
//  NativePostViewModel.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

class NativePostViewModel {
    enum Change {
        case updated
    }
    
    private let postId: String
    private var post: Post?
    
    var didChange: ((Change) -> Void)?
    
    private(set) var blockSections: [BlockSection] = []
    
    init(postId: String) {
        self.postId = postId
    }
    
    func fetchPost() {
        PostDownloader().downloadPost(id: "1") { (result) in
            switch result {
            case let .success(post):
                self.blockSections = post.blockSections
            default:
                break
            }
        }
    }
    
    func block(for indexPath: IndexPath) -> Block {
        blockSections[indexPath.section].blocks[indexPath.row].resource
    }
    
    func numberOfBlocks(in section: Int) -> Int {
        return blockSections[section].blocks.count
    }
    
    func numberOfBlockSections() -> Int {
        return blockSections.count
    }
}
