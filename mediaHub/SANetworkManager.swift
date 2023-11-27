//
//  SANetworkManager.swift
//  mediaHub
//
//  Created by asmaa gamal  on 20/11/2023.
//

import Foundation
import AVFoundation


let headers =  "L0Gh7aj9kweedghPsZmFHyOQeNPzkOUWHi0ArsfXxP9E4HPv6RZsFHGc"

class SANetworkManager : NSObject {
    
    static let shared : SANetworkManager = {
        let instance = SANetworkManager()
        return instance
    }()
    
    private override init() {
        super.init()
    }
    
    func getRequest(url: String, completion: @escaping(Bool,Data?)->())
    {
        // 1. Get the url
        guard let requestURL: URL = URL(string: url) else {
            completion(false, nil)
            return
        }
        
        // 2. Get the URLRequest
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.cachePolicy = .useProtocolCachePolicy
        urlRequest.timeoutInterval = 30.0
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(headers, forHTTPHeaderField: "Authorization")

       
        
        // 3. With URLSession
        // 1. datatask 2. downloadTask 3. uploadtask 4. Streamtask
        // 5. websockettask
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
//            print(data ?? "DATA")
//            print(response ?? "RESPONSE")
//            print(error ?? "ERROR")
            
            if data != nil {
                
                completion(true,data)
            }
            else {
                completion(false, nil)
            }
        })
        
        task.resume()
    }
    
    func postRequest(url: String, completion: @escaping(Bool,Data?)->())
    {
        // 1. Get the url
        guard let requestURL: URL = URL(string: url) else {
            completion(false, nil)
            return
        }
       
        let appBody: [String: String] = ["name": "ArpitKKk", "email": "arpit1@mail.com"]
        
        let data = try? JSONSerialization.data(withJSONObject: appBody)
       
        // 2. Get the URLRequest
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.cachePolicy = .useProtocolCachePolicy
        urlRequest.timeoutInterval = 30.0
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = data
        
        // 3. With URLSession
        // 1. datatask 2. downloadTask 3. uploadtask 4. Streamtask
        // 5. websockettask
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            print(data ?? "DATA")
            print(response ?? "RESPONSE")
            print(error ?? "ERROR")
            if data != nil {
                completion(true,data)
            }
            else {
                completion(false, nil)
            }
        })
        
        task.resume()
    }
    
    func downloadRequest(url: String, completion: @escaping(Bool,Data?)->())
    {
        // 1. Get the url
        guard let requestURL: URL = URL(string: url) else {
            completion(false, nil)
            return
        }
        
        let urlRequest = URLRequest(url: requestURL)
        
        var task = URLSession.shared.downloadTask(with: urlRequest, completionHandler: {
            (url, response, error) in
            if let localURL = url {
                print(localURL)
                if let imageData = try? Data(contentsOf: localURL) {
                    completion(true, imageData)
                }
    
            }
            else {
                completion(false, nil)
            }
            
        })
        
        task.resume()
        print(task.progress)
    }
    
//    func uploadRequest(url: String, completion: @escaping(Bool,Data?)->())
//    {
//        // 1. Get the url
//        guard let requestURL: URL = URL(string: url) else {
//            completion(false, nil)
//            return
//        }
//        
//        let urlRequest = URLRequest(url: requestURL)
//        
//        var task = URLSession.shared.uploadTask(with: urlRequest, fromFile: <#T##URL#>, completionHandler: {
//            (data, response, error) in
//            
//            
//        })
//    }
    
    
    
}

