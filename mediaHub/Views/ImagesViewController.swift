//
//  ImagesViewController.swift
//  mediaHub
//
//  Created by asmaa gamal  on 20/11/2023.
//

import UIKit

class ImagesViewController: UIViewController {
let url = "https://api.pexels.com/videos/search?query=nature&per_page=10&orientation=portrait"
    override func viewDidLoad() {
        super.viewDidLoad()
        SANetworkManager.shared.getRequest(url: url) { success, data in
            
               if success, let data = data {
            
                   print(data)
                   
               
               } else {
                   print("Failed to fetch data.")
               }
           }
   
       
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
