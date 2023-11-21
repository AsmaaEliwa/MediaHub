//
//  VideoModel.swift
//  mediaHub
//
//  Created by asmaa gamal  on 20/11/2023.
//

import Foundation
struct VideoModel {
    let type: String
    let id: Int
    let width: Int
    let height: Int
    let duration: Int
    let url: String
    let image: String
    let videoFiles: [VideoFile]
    let videoPictures: [VideoPicture]
}



struct VideoFile {
    let id: Int
    let quality: String
    let fileType: String
    let width: Int
    let height: Int
    let link: String
}

struct VideoPicture {
    let id: Int
    let nr: Int
    let picture: String
}
