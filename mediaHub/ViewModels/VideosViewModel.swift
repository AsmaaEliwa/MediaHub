//
//  VideosViewModel.swift
//  mediaHub
//
//  Created by asmaa gamal  on 06/12/2023.
//

import Foundation

class VideosViewModel {
    var videos: [VideoModel]  = [] // Your model data
    var currentPage = 1
    var perPage = 20 
    
    func loadVideos(completion: @escaping ([VideoModel]?, Error?) -> Void) {
           SAAPIManager.shared.getVideosForPage(currentPage, perPage: perPage) { [weak self] videos, error in
               // Handle API response
               guard let strongSelf = self else { return }
               
               if let error = error {
                   print("Error fetching videos: \(error)")
                   completion(nil, error)
               } else if let newVideos = videos {
                   strongSelf.videos += newVideos // Append new videos to the existing array
                   
                   completion(newVideos, nil)
               }
           }
       }
    
    func loadMore(completion: @escaping ([VideoModel]?, Error?) -> Void) {
            currentPage += 1
            loadVideos(completion: completion)
        }
    
    // Other methods for performing actions on videos (e.g., adding to favorites)
}

