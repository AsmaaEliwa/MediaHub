//
//  SAAPIManager.swift
//  mediaHub
//
//  Created by asmaa gamal  on 20/11/2023.
//

import Foundation

class SAAPIManager: NSObject {
    
    static let shared : SAAPIManager = {
        let instance = SAAPIManager()
        return instance
    }()
    
    private override init() {
        super.init()
    }
    
    func getUserAPIVidios(completion: @escaping ([VideoModel]?, Error?) -> Void){
        var vidos: [VideoModel] = []
        let decoder = JSONDecoder()
        let url = "https://api.pexels.com/videos/search?query=nature&per_page=10&page=1"

        SANetworkManager.shared.getRequest(url: url, completion: {dataResult, data in
          
       
            do {
                guard let jsonData = data else {
                    completion(nil, NSError(domain: "NoData", code: 0, userInfo: nil))
                    return
                }

                let result = try decoder.decode(PhotoResponse.self, from: jsonData)
                
//                completion( result, nil)
            } catch {
                print(error)
                completion(nil, error)
            }
        })
        
        
        
      
    }
    
    
    func getUserAPIImages(completion: @escaping ([ImageModel]?, Error?) -> Void) {
        let decoder = JSONDecoder()
        let url = "https://api.pexels.com/v1/search?query=nature&per_page=10&page=1"

        SANetworkManager.shared.getRequest(url: url) { dataResult, data in
            do {
                guard let jsonData = data else {
                    completion(nil, NSError(domain: "NoData", code: 0, userInfo: nil))
                    return
                }

                let result = try decoder.decode(PhotoResponse.self, from: jsonData)
                completion(result.photos, nil)
            } catch {
                print(error)
                completion(nil, error)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//
//    func postUserAPI() {
//        let url = "https://x8ki-letl-twmt.n7.xano.io/api:uJKR_gWV/user"
//        let decoder = JSONDecoder()
//        SANetworkManager.shared.postRequest(url: url, completion: {dataResult, data in
//            
//            print(dataResult)
//            do {
//                
//             let result   = try decoder.decode(User.self, from: data!)
//                
//            print(result.name)
//            print(result.email)
//                
//                
//            }
//            catch {
//                print(error)
//            }
//        })
//    }
}
