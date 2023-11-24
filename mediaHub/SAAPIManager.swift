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
    
       
        
        
        
        
        
        func getImagesForPage(_ page: Int, perPage: Int, completion: @escaping ([ImageModel]?, Error?) -> Void) {
            let baseURL = "https://api.pexels.com/v1/search?query=nature&per_page=\(perPage)&page=\(page)"
            let decoder = JSONDecoder()
            
            SANetworkManager.shared.getRequest(url: baseURL) { dataResult, data in
                guard let jsonData = data else {
                    completion(nil, NSError(domain: "NoData", code: 0, userInfo: nil))
                    return
                }
                
                do {
                    let result = try decoder.decode(PhotoResponse.self, from: jsonData)
                    let images = result.photos
                    completion(images, nil)
                } catch {
                    print(error)
                    completion(nil, error)
                }
            }
        }
        
        
        
        
        
        
        func searchForImages(with query: String, completion: @escaping ([ImageModel]?, Error?) -> Void) {
            let headers =  "L0Gh7aj9kweedghPsZmFHyOQeNPzkOUWHi0ArsfXxP9E4HPv6RZsFHGc"
            let perPage = 20 // Adjust the number of results per page
            let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let baseURL = "https://api.pexels.com/v1/search?query=\(encodedQuery)&per_page=\(perPage)"
            
            // Set up your API request with appropriate headers and authentication
            var request = URLRequest(url: URL(string: baseURL)!)
            request.addValue(headers, forHTTPHeaderField: "Authorization") // Replace 'Your-API-Key' with your actual API key
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, NSError(domain: "NoData", code: 0, userInfo: nil))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(PhotoResponse.self, from: data)
                    completion(result.photos, nil)
                } catch {
                    completion(nil, error)
                }
            }.resume()
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

