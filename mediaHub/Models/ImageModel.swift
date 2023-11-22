//
//  ImageModel.swift
//  mediaHub
//
//  Created by asmaa gamal  on 20/11/2023.
//

import Foundation
 
struct PhotoResponse: Decodable {
    let page: Int
    let perPage: Int?
    let photos: [ImageModel]
}

struct ImageModel: Decodable{
    let type: String?
    let id: Int
    let url : String
    let width: Int
    let height:Int
    let src: ImageType
    let liked:Bool
    
}

struct ImageType: Decodable {
    let original:String
    let medium:String
    let small:String
}
