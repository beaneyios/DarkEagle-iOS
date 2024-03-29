//
//  PostDownloader.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 11/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import Foundation

struct PostDownloader {
    func downloadPost(id: String, completion: @escaping (_ result: Result<Post, Error>) -> Void) {
        let url = Bundle.main.url(forResource: id, withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
        
        do {
            let post = try decoder.decode(Post.self, from: data)
            completion(.success(post))
        } catch {
            print(error)
        }
    }
    
    func downloadPosts(id: String, completion: @escaping (_ result: Result<List, Error>) -> Void) {
        let url = Bundle.main.url(forResource: "home", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
        
        do {
            let post = try decoder.decode(List.self, from: data)
            completion(.success(post))
        } catch {
            print(error)
        }
    }
}
