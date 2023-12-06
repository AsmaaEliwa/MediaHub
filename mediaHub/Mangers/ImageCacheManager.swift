//
//  ImageCacheManager.swift
//  mediaHub
//
//  Created by asmaa gamal  on 06/12/2023.
//


import Foundation
import UIKit

class ImageCacheManager {
    let imageCache = NSCache<NSString, UIImage>()

    func getImageFromCacheOrURL(imageURL: String, completion: @escaping (Data?) -> Void) {
        if let cachedImage = imageCache.object(forKey: imageURL as NSString) {
            print("Cache hit for \(imageURL)")
            if let data = cachedImage.pngData() {
                completion(data)
            } else {
                completion(nil)
            }
        } else {
            if let url = URL(string: imageURL) {
                URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                    guard let imageData = data, error == nil else {
                        completion(nil)
                        return
                    }

                    if let downloadedImage = UIImage(data: imageData) {
                        self?.imageCache.setObject(downloadedImage, forKey: imageURL as NSString)
                        completion(imageData)
                    } else {
                        completion(nil)
                    }
                }.resume()
            } else {
                completion(nil)
            }
        }
    }
}
