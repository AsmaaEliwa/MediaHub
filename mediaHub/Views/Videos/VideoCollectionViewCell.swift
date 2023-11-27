//
//  VideoCollectionViewCell.swift
//  mediaHub
//
//  Created by asmaa gamal  on 24/11/2023.
//




import UIKit
import AVKit

class VideoCollectionViewCell: UICollectionViewCell {
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
//    weak var delegate: VideoCellDelegate?
    var videoID: Int?
    // Uncomment this line if you have a folderContentLabel in your cell
    // @IBOutlet weak var folderContentLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGestureRecognizers()
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        contentView.addGestureRecognizer(tapGesture)
    }
 

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        // Handle tap action
        // if let id = videoID, let url = delegate?.videoURL(for: id) {
        //     delegate?.didTapVideoCell(with: url)
        // }
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
    
    func displayFolderContent(folderName: String) {
        // Update UI with the folder name
        // Uncomment this line if you have a folderContentLabel in your cell
        // folderContentLabel.text = folderName
    }
}
