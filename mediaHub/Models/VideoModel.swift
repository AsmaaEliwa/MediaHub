//
//  VideoModel.swift
//  mediaHub
//
//  Created by asmaa gamal  on 20/11/2023.
//

import Foundation
struct VideoResponse: Decodable {
    let page: Int
    let perPage: Int?
    let videos: [VideoModel]
    let totalResults: Int?
    

}
struct VideoModel: Decodable {
    let type: String?
    let id: Int
    let width: Int
    let height: Int
    let duration: Int
    let url: String
    let image: String
    let video_files: [VideoFile]
    let video_pictures: [VideoPicture]
}



struct VideoFile:Decodable {
    let id: Int
    let quality: String
    let file_type: String
    let width: Int
    let height: Int
    let link: String
}

struct VideoPicture:Decodable {
    let id: Int
    let nr: Int
    let picture: String
}
