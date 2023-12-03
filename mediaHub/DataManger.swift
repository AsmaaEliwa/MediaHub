//
//  DataManger.swift
//  mediaHub
//
//  Created by asmaa gamal  on 30/11/2023.
//

import Foundation
import CoreData
import SwiftUI
class DataManger{
    static let shared = DataManger()
    private init(){
        
    }
    lazy var persistentContainer: NSPersistentContainer = {
         let container = NSPersistentContainer(name: "mediaHub")
         container.loadPersistentStores { description, error in
             if let error = error {
                 fatalError("Unable to load persistent stores: \(error)")
             }else{
                 print("loaded")
             }
         }
         return container
     }()
    
    
    
    func addImageToFav(image:UIImage){
        let url = ImagesData.shared.downloadImageToFile(image: image)
        if let entity  = NSEntityDescription.entity(forEntityName: "FavImage", in: persistentContainer.viewContext){
            let newfavImage = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
            newfavImage.setValue(url, forKey: "url")
            
            do{
                try persistentContainer.viewContext.save()
                print("added to fav")
            }catch {
                print(error)
            }
            
        }
    }
    
    
    
    func fetchFavImages()->[FavImage]{
        let request:NSFetchRequest<FavImage> = FavImage.fetchRequest()
        do{
          let result =   try persistentContainer.viewContext.fetch(request)
            
            
            print("fetched")
            
            
            return result
            
            
        }catch{
            print(error)
            
            return []
        }
    }
    
    
    func addVideoToFav(video:VideoModel){
        
        guard  let videoUrl = URL(string:video.url) else{
            return
        }
        VideoManger.shared.saveVideoLocally(videoURL: videoUrl) {(videoName) in
            if let videoInFolder = videoName {
                
                if let entity  = NSEntityDescription.entity(forEntityName: "FavVideo", in: self.persistentContainer.viewContext){
                    let newfavVideo = NSManagedObject(entity: entity, insertInto: self.persistentContainer.viewContext)
                    newfavVideo.setValue(videoInFolder, forKey: "url")
                    
                    do{
                        try self.persistentContainer.viewContext.save()
                        print("added to fav")
                        
                    }catch {
                        
                        print(error)
                        
                    }
                }
            }
        }
    }
    
    
    
    
    
    func fetchFavVideos()->[FavVideo]{
        let request:NSFetchRequest<FavVideo> = FavVideo.fetchRequest()
        do{
          let result =   try persistentContainer.viewContext.fetch(request)
            
            
            print("fetched")
            
            
            return result
            
            
        }catch{
            print(error)
            
            return []
        }
    }
    
    
    
}
