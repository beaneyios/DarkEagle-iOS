//
//  NativePostViewModel.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

class PostBlockListViewModel: BlockListViewModel {
    private let postId: String
    private var post: Post?
    
    var didChange: ((BlockListChange) -> Void)?
    
    private(set) var blockSections: [BlockSection] = []
    
    init(postId: String) {
        self.postId = postId
    }
    
    func loadData() {
        fetchPost()
    }
    
    func reloadData() {
        fetchPost()
    }
    
    @objc func bookmarkPost() {
        let result = BookmarkController().toggleBookmarkArticle(id: postId)
        didChange?(.bookmarked(result: result, postId: postId))
    }
    
    private func fetchPost() {
        didChange?(.startLoading)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2.0) {
            PostDownloader().downloadPost(id: self.postId) { (result) in
                switch result {
                case let .success(post):
                    self.blockSections = post.blockSections
                    self.didChange?(.updated)
                    self.didChange?(.stopLoading)
                default:
                    break
                }
            }
        }
    }
}
