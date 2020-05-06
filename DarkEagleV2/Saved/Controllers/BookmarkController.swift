//
//  SaveController.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 05/05/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

struct BookmarkController {
    enum Result {
        case saved
        case unsaved
        
        var bookmarkImage: UIImage? {
            switch self {
            case .saved:
                return UIImage(named: "bookmarked")
            case .unsaved:
                return UIImage(named: "bookmark")
            }
        }
    }
    
    let savedPostsId = "saved_posts"
    
    func toggleBookmarkArticle(id: String) -> Result {
        let defaults = UserDefaults.standard
        var savedArticles: [String] = defaults.array(forKey: savedPostsId) ?? []
        if let index = savedArticles.firstIndex(of: id) {
            savedArticles.remove(at: index)
            defaults.set(savedArticles, forKey: savedPostsId)
            return .unsaved
        }
        
        savedArticles.append(id)
        defaults.set(savedArticles, forKey: savedPostsId)
        return .saved
    }
    
    func getBookmarkStatus(id: String) -> Result {
        let defaults = UserDefaults.standard
        let savedArticles: [String] = defaults.array(forKey: savedPostsId) ?? []
        return savedArticles.contains(id) ? .saved : .unsaved
    }
}

extension UserDefaults {
    func array<T>(forKey key: String) -> T? {
        return array(forKey: key) as? T
    }
}
