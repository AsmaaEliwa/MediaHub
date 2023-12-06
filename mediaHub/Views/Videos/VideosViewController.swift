//
//  VideosViewController.swift
//  mediaHub
//
//  Created by asmaa gamal  on 24/11/2023.
//
import UIKit
import AVKit



class VideosViewController: UIViewController {
    let viewModel = VideosViewModel()
    @IBOutlet weak var videosTabBar: UITabBar!
    
    @IBOutlet weak var FavVideos: UITabBarItem!
    
    @IBAction func moreVideos(_ sender: UIButton) {
           viewModel.loadMore { [weak self] videos, error in
               guard let strongSelf = self else { return }
               
               if let error = error {
                   print("Error loading more videos: \(error)")
               } else if let newVideos = videos {
                   strongSelf.videos = newVideos
                   
                   DispatchQueue.main.async {
                       strongSelf.videosTableView.reloadData()
                   }
               }
           }
       }

    
    @IBOutlet weak var videosTableView: UITableView!
    
    var videos: [VideoModel]? = []
    var currentPage = 1
    let perPage = 20
    var videoURLs: [Int: URL] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadVideos()
        videos =  viewModel.videos
       
    }

    func videoFolder(for videoID: Int) -> URL? {
        return videoURLs[videoID] // Access the folder name using the video ID from the dictionary
    }
    
    func setupTableView() {
        videosTableView.register(VideoTableViewCell.self, forCellReuseIdentifier: "VideoCell")
        
    }
    

    
    
   
        func loadVideos() {
            
               viewModel.loadVideos { [weak self] videos, error in
                   guard let strongSelf = self else { return }
                   
                   if let error = error {
                       print("Error loading videos: \(error)")
                       
                   } else if let newVideos = videos {
                       strongSelf.videos = newVideos // Update videos array
                       
                       DispatchQueue.main.async {
                           strongSelf.videosTableView.reloadData()
                       }
                   }
               }
           }
    
}
extension VideosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as? VideoTableViewCell,
              let video = videos?[indexPath.row]
              
              else {
            
            return UITableViewCell()
        }

        cell.videoID = video.id // Assign video ID
        cell.delegate = self
        if let firstPicture = video.video_pictures.first, let imageURL = URL(string: firstPicture.picture) {
            
            cell.videoImageView.loadImage(from: imageURL)
        } else {
            print("No pictures available for this video")
            
        }

        return cell
    }

    
}
extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}

extension VideosViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Tab bar item selected: \(item.title ?? "")")
        
        if item == FavVideos { // Check if the selected item matches your 'FavImagesViewController' tab bar item
            print("Performing segue to FavVideos...")
            performSegue(withIdentifier: "ToFavVideos", sender: self)
        }
    }
}

extension VideosViewController: VideoTableViewCellDelegate {
    func starButtonTapped(inCell cell: VideoTableViewCell) {
        
        guard let indexPath = videosTableView.indexPath(for: cell),
              
              let video = videos?[indexPath.row] else {
            
            return
        }
        
        DataManger.shared.addVideoToFav(video: video)
      
    }
}
