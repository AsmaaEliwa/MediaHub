//
//  VideoManger.swift
//  mediaHub
//
//  Created by asmaa gamal  on 24/11/2023.
//
import AVKit
import Foundation
class VideoManger{
    static  let  shared = VideoManger()

    func saveVideoLocally(videoURL: URL) {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let videoName = "video_\(Date().timeIntervalSince1970).mp4"
        let fileURL = documentsURL.appendingPathComponent(videoName)
        
        URLSession.shared.downloadTask(with: videoURL) { (tempLocalURL, response, error) in
            if let tempLocalURL = tempLocalURL, error == nil {
                do {
                    try FileManager.default.moveItem(at: tempLocalURL, to: fileURL)
                } catch {
                    print("Error saving video: \(error)")
                }
            }
        }.resume()
    }

    // Inside VideoCollectionViewCell
//    func setupPlayer(videoURL: URL) {
//       let player = AVPlayer(url: videoURL)
//       let  playerLayer = AVPlayerLayer(player: player)
//        playerLayer.videoGravity = .resizeAspectFill
//        contentView.layer.addSublayer(playerLayer)
//
//        // Start playing the video
//        player.play()
//    }

}
