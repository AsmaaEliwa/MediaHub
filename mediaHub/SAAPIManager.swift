//
//  SAAPIManager.swift
//  mediaHub
//
//  Created by asmaa gamal  on 20/11/2023.
//

import Foundation
//
//class SAAPIManager: NSObject {
//    
//    static let shared : SAAPIManager = {
//        let instance = SAAPIManager()
//        return instance
//    }()
//    
//    private override init() {
//        super.init()
//    }
//    
//    func getUserAPI() {
//        let url = "https://x8ki-letl-twmt.n7.xano.io/api:uJKR_gWV/user"
//        let decoder = JSONDecoder()
//        SANetworkManager.shared.getRequest(url: url, completion: {dataResult, data in
//            
//            print(dataResult)
//            do {
//                
//             let result   = try decoder.decode([User].self, from: data!)
//                if result.count > 1 {
//                    let user1 = result[0]
//                    print(user1.name)
//                    print(user1.email)
//                }
//                
//            }
//            catch {
//                print(error)
//            }
//        })
//    }
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
//}
