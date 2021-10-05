//
//  Extensions.swift
//  Feeds
//
//  Created by Sarathi M on 9/22/21.
//

import UIKit

//Variable for image caching for already downloaded image for the specific url
var imageCache =  NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func downloadImage(url: String?) {
        self.image = nil

        guard let urlString = url else {
            return
        }
        
        //retrieve image from imageCache variable
        if let image = imageCache.object(forKey: urlString as NSString) {
            self.image = image as? UIImage
        }
        
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                //download image
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        //update ui: set image in main queue
                        DispatchQueue.main.async {
                            //store image in cache memory imageCache
                            imageCache.setObject(image, forKey: urlString as NSString)
                            //set image
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
