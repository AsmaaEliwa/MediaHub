//
//  VideoTableViewCell.swift
//  mediaHub
//
//  Created by asmaa gamal  on 25/11/2023.
//

import UIKit
import AVKit
class VideoTableViewCell: UITableViewCell {
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var videoID: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        (videoURL: <#URL#>)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupPlayer(videoURL: URL) {
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        contentView.layer.addSublayer(playerLayer!)
        
        player?.play()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }
}
