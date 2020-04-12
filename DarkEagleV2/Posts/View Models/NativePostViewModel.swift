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
    
    private(set) var blocks: [Block] = []
    
    init(postId: String) {
        self.postId = postId
    }
    
    func fetchPost() {
        PostDownloader().downloadPost(id: "1") { (result) in
            switch result {
            case let .success(post):
                self.blocks = post.blocks.map { $0.resource }
            default:
                break
            }
        }
    }
}
