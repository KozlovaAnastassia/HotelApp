//
//  Extension.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 28.12.2023.
//

import Foundation
import UIKit

class ImageCache {
        static let shared = ImageCache()

        private let cache = NSCache<NSString, UIImage>()
    
        func setImage(_ image: UIImage, forKey key: String) {
            cache.setObject(image, forKey: key as NSString)
        }
        func getImage(forKey key: String) -> UIImage? {
            return cache.object(forKey: key as NSString)
    }
}

extension UIImageView {
    func loadImage(withURL urlString: String, id: String) {
        
        guard let url = URL(string:  urlString) else {return}
        let placeholder = UIImage(named: "placeholder")
        self.image = placeholder
        
        if  ImageCache.shared.getImage(forKey: id) != nil {
            self.image = ImageCache.shared.getImage(forKey: id)
            
        } else {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                ImageCache.shared.setImage(image, forKey: id)
                DispatchQueue.main.async {
                    self.image = image
                }
            }.resume()
        }
    }
}

