//
//  SearchViewModel.swift
//  mediaHub
//
//  Created by asmaa gamal  on 06/12/2023.
//


import Foundation

class SearchViewModel {
    let apiManager = SAAPIManager.shared
    
    func searchForImages(with query: String, completion: @escaping ([ImageModel]?, Error?) -> Void) {
        apiManager.searchForImages(with: query) { images, error in
            completion(images, error)
        }
    }
}
