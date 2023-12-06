//
//  ImagesViewModel.swift
//  mediaHub
//
//  Created by asmaa gamal  on 05/12/2023.
//

import Foundation
import SwiftUI
class ImagesViewModel {
    var currentPage = 1
    let imageCache = NSCache<NSString, UIImage>()
    var images: [ImageModel] = []
    let apiManager = SAAPIManager.shared
    func numberOfImages()->Int{
        loadImages(completion: {(data, error) in
            
        })
        return images.count
    }
    
    func loadImages(completion: @escaping ([ImageModel]?, Error?) -> Void) {
//        let currentPage = 1 // You can make this a property of the ViewModel if needed
        let perPage = 20 // Similarly, make it a property if it changes
        
        apiManager.getImagesForPage(currentPage, perPage: perPage) { [weak self] newImages, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("Error fetching images: \(error)")
                completion(nil, error)
            } else if let newImages = newImages {
                strongSelf.images += newImages
                completion(strongSelf.images, nil)
            }
        }
    }

    func getImageURL(at index: Int) -> String {
        return images[index].src.medium ?? ""
    }
    
    func loadMore(){
        currentPage+=1
        loadImages(completion: {(data, error) in
            
        })
    }
    func getImage(at index: Int, completion: @escaping (UIImage?) -> Void) {
        let imageURL = getImageURL(at: index)
        
        if let cachedImage = imageCache.object(forKey: imageURL as NSString) {
            print("Cache hit for \(imageURL)")
            completion(cachedImage)
        } else {
            if let url = URL(string: imageURL) {
                URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                    guard let data = data, let image = UIImage(data: data) else {
                        completion(nil)
                        return
                    }
                    
                    self?.imageCache.setObject(image, forKey: imageURL as NSString)
                    completion(image)
                }.resume()
            }
        }
    }
}
