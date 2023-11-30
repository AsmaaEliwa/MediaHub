//
//  imagesData.swift
//  mediaHub
//
//  Created by asmaa gamal  on 20/11/2023.
//

import Foundation
import SwiftUI
class ImagesData{
  static let  shared = ImagesData()
    private init(){
        
    }
    
    
    func downloadImageToFile(image: UIImage) -> String {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = UUID().uuidString + ".jpg" // Unique filename using UUID
        let imageUrl = documentDirectory.appendingPathComponent(fileName)

        if let imageData = image.jpegData(compressionQuality: 1.0) {
            do {
                try imageData.write(to: imageUrl)
                return fileName
                
            } catch {
                print(error)
                
                return ""
            }
        }
        return ""
    }


    
    
    
//    func downloadImageToFile(image: UIImage) -> String {
//        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyyMMddHHmmssSSS" // Use a timestamp format
//        let timestamp = formatter.string(from: Date())
//        let fileName = "\(timestamp).jpg"
//        let imageUrl = documentDirectory.appendingPathComponent(fileName)
//
//        if let imageData = image.jpegData(compressionQuality: 1.0) {
//            do {
//                try imageData.write(to: imageUrl)
//                return fileName
//            } catch {
//                print(error)
//                return ""
//            }
//        }
//        return ""
//    }


}
