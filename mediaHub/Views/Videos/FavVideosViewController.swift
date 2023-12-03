//
//  FavVideosViewController.swift
//  mediaHub
//
//  Created by asmaa gamal  on 03/12/2023.
//
import UIKit

import AVKit
class FavVideosViewController: UIViewController {
    @IBOutlet weak var favVideosTableView: UITableView!
    var videos: [FavVideo] = []
    var favoriteVideoURLs: [URL] = [] // Assuming these are the URLs of favorite videos
    
    var favoriteVideoNames: [String] = [] // Data structure to hold video names
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateFavoriteVideoNames()
        
        favVideosTableView.reloadData()
    }
    
    func populateFavoriteVideoNames() {
        videos = DataManger.shared.fetchFavVideos() // Fetch CoreData objects
        
        for favVideo in videos {
            if let videoURLString = favVideo.url, !videoURLString.isEmpty {
                // Convert URL string to URL
                if let videoURL = URL(string: videoURLString) {
                    favoriteVideoURLs.append(videoURL)
                    // Extract video names from URLs and store them
                    favoriteVideoNames.append(videoURL.lastPathComponent)
                }
            }
        }
    }
}

extension FavVideosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteVideoNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavVideoCell", for: indexPath)
        cell.textLabel?.text = favoriteVideoNames[indexPath.row]
        return cell
    }
    
   
}

extension FavVideosViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let selectedVideoURL = videos[indexPath.row]
        
        let fullUrl = documentDirectory.appendingPathComponent(selectedVideoURL.url ?? "")
       
        
        playVideo(at: fullUrl)
    }
    
    func playVideo(at url: URL) {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: url.path) {
            print("Video file exists at: \(url)")
            
            let player = AVPlayer(url: url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            
            present(playerViewController, animated: true) {
                player.play()
            }
        } else {
            print("Video file doesn't exist at: \(url)")
            
            // Handle the case when the file doesn't exist
        }
    }
}
