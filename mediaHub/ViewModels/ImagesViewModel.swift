//
//  ImagesViewModel.swift
//  mediaHub
//
//  Created by asmaa gamal  on 05/12/2023.
//
import Foundation


class ImagesViewModel {
    var currentPage = 1
    var images: [ImageModel] = []
    let apiManager = SAAPIManager.shared
    let imageCacheManager = ImageCacheManager()

    func numberOfImages() -> Int {
        return images.count
    }

    func loadImages(completion: @escaping ([ImageModel]?, Error?) -> Void) {
        let perPage = 20
        
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
        return images[index].src.medium 
    }

    func loadMore() {
        currentPage += 1
        loadImages(completion: { _, _ in })
    }

    func getImage(at index: Int, completion: @escaping (Data?) -> Void) {
        let imageURL = getImageURL(at: index)

        imageCacheManager.getImageFromCacheOrURL(imageURL: imageURL) { data in
            completion(data)
        }
    }
}
