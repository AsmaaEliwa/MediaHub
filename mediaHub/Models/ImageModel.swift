//
//  ImageModel.swift
//  mediaHub
//
//  Created by asmaa gamal  on 20/11/2023.
//

import Foundation
 

struct ImageModel{
    let type: String
    let id: Int
    let url : String
    let width: Int
    let height:Int
    let src: ImageType
    let liked:Bool
    
}

struct ImageType {
    let original:String
    let medium:String
    let small:String
}
