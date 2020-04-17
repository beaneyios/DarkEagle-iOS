//
//  ImageDownloader.swift
//  DarkEagleV2
//
//  Created by Matt Beaney on 14/04/2020.
//  Copyright © 2020 Matt Beaney. All rights reserved.
//

import UIKit

struct ImageDownloader {
    func downloadImage(url: URL, completion: @escaping (_ result: Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }
        }.resume()
    }
}
