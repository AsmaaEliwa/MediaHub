//
//  VideosViewController.swift
//  mediaHub
//
//  Created by asmaa gamal  on 24/11/2023.
//
import UIKit
import AVKit

//protocol VideoCellDelegate: AnyObject {
//    func didTapVideoCell(with url: URL)
//    func videoFolder(for videoID: Int) -> URL?
//}

class VideosViewController: UIViewController {
//    func didTapVideoCell(with url: URL) {
//        
//    }

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
 
    func saveVideoLocally(videoURL: URL, videoID: Int) {
        // Existing code...
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let videosFolderURL = documentsURL.appendingPathComponent("videosForMyApp", isDirectory: true)
        let uniqueString = UUID().uuidString
        let videoName = "video_\(videoID)_\(uniqueString).mp4" // Unique filename using UUID
        let fileURL = videosFolderURL.appendingPathComponent(videoName)

        SAAPIManager.shared.downloadVideo(from: videoURL) { [weak self] (savedURL, error) in
            guard let self = self else { return }

            if let error = error {
                print("Error downloading video: \(error)")
            } else if let savedURL = savedURL {
                print("Video downloaded and saved at: \(savedURL)")

                do {
                    // Check if file exists at destination URL
                    let finalFileURL: URL
                    var finalVideoName = videoName
                    
                    if FileManager.default.fileExists(atPath: fileURL.path) {
                        let newUniqueString = UUID().uuidString
                        finalVideoName = "video_\(videoID)_\(newUniqueString).mp4"
                    }

                    finalFileURL = videosFolderURL.appendingPathComponent(finalVideoName)

                    try FileManager.default.moveItem(at: savedURL, to: finalFileURL)
                    self.videoURLs[videoID] = finalFileURL // Store the URL based on video ID
                } catch {
                    print("Error moving file: \(error)")
                    
                }
            }
        }
    }



    func loadVideos() {
//           SAAPIManager.shared.getVideosForPage(currentPage, perPage: perPage) { [weak self] videos, error in
//               guard let strongSelf = self else { return }
//
//               if let error = error {
//                   print("Error fetching videos: \(error)")
//               } else if let newVideos = videos {
//                   strongSelf.videos = newVideos // Update videos array
//
//                   DispatchQueue.main.async {
//                       strongSelf.videosTableView.reloadData()
//                   }
//
//                   // Download and save videos locally
//                   for video in newVideos {
//                       if let videoURL = URL(string: video.url) {
//                           strongSelf.saveVideoLocally(videoURL: videoURL, videoID: video.id)
//                       }
//                   }
//               }
//           }
       }
    // Your displayFolderContent function...
    
}
extension VideosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? VideoTableViewCell,
              let video = videos?[indexPath.row],
              
              let videoURL = videoURLs[video.id] else {
            
            return UITableViewCell()
        }
        
        cell.videoID = video.id // Assign video ID
        cell.setupPlayer(videoURL: videoURL)
        
        return cell
    }
    
    // Other UITableViewDelegate methods can be implemented here...
}
