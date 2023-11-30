//
//  ImageModel.swift
//  mediaHub
//
//  Created by asmaa gamal  on 20/11/2023.
//

import Foundation
 
struct PhotoResponse: Codable {
    let total_results:Int?
    let page: Int?
    let perPage: Int?
    let photos: [ImageModel]
    let next_page : String?
}

struct ImageModel: Codable{
    let type: String?
    let id: Int
    let url : String
    let width: Int
    let height:Int
    let src: ImageType
    let liked:Bool
    
}

struct ImageType: Codable {
    let original:String
    let medium:String
    let small:String
}
