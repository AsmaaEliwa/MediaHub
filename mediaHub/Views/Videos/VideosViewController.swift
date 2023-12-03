//
//  VideosViewController.swift
//  mediaHub
//
//  Created by asmaa gamal  on 24/11/2023.
//
import UIKit
import AVKit



class VideosViewController: UIViewController {
 
    @IBOutlet weak var videosTabBar: UITabBar!
    
    @IBOutlet weak var FavVideos: UITabBarItem!
    
    @IBAction func moreVideos(_ sender: UIButton) {
        currentPage+=1
        loadVideos()
       
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
       
    }

    func videoFolder(for videoID: Int) -> URL? {
        return videoURLs[videoID] // Access the folder name using the video ID from the dictionary
    }
    
    func setupTableView() {
        videosTableView.register(VideoTableViewCell.self, forCellReuseIdentifier: "VideoCell")
        
    }
    
//    func saveVideoLocally(videoURL: URL, videoID: Int) {
//        // Existing code...
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let videosFolderURL = documentsURL.appendingPathComponent("videosForMyApp", isDirectory: true)
//        let uniqueString = UUID().uuidString
//        let videoName = "video_\(videoID)_\(uniqueString).mp4" // Unique filename using UUID
//        let fileURL = videosFolderURL.appendingPathComponent(videoName)
//        
//        SAAPIManager.shared.downloadVideo(from: videoURL) { [weak self] (savedURL, error) in
//            guard let self = self else { return }
//            
//            if let error = error {
//                print("Error downloading video: \(error)")
//            } else if let savedURL = savedURL {
//                print("Video downloaded and saved at: \(savedURL)")
//                
//                do {
//                    // Check if file exists at destination URL
//                    let finalFileURL: URL
//                    var finalVideoName = videoName
//                    
//                    if FileManager.default.fileExists(atPath: fileURL.path) {
//                        let newUniqueString = UUID().uuidString
//                        finalVideoName = "video_\(videoID)_\(newUniqueString).mp4"
//                    }
//                    
//                    finalFileURL = videosFolderURL.appendingPathComponent(finalVideoName)
//                    
//                    try FileManager.default.moveItem(at: savedURL, to: finalFileURL)
//                    self.videoURLs[videoID] = finalFileURL // Store the URL based on video ID
//                } catch {
//                    print("Error moving file: \(error)")
//                    
//                }
//            }
//        }
//    }
    
    
    
    func loadVideos() {
        SAAPIManager.shared.getVideosForPage(currentPage, perPage: perPage) { [weak self] videos, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("Error fetching videos: \(error)")
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
//        cell.setupPlayer(videoURL: videoURL)
//        cell.setupStarButton()
        // Check if there are pictures available
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
        // Perform actions with the tapped video here
        // For example: DataManger.shared.addVideoToFav(video: video)
    }
}
