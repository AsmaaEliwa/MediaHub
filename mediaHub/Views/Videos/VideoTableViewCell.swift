import UIKit
import AVKit
protocol VideoTableViewCellDelegate: AnyObject {
    func starButtonTapped(inCell cell: VideoTableViewCell)
}
class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var videoImageView: UIImageView!
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var videoID: Int?
    weak var delegate: VideoTableViewCellDelegate?
    let starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .yellow
        button.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStarButton() // Call setupStarButton here or in your cellForRowAtIndexPath
    }
    
    // Other functions...
    
    func setupStarButton() {
        starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
            
        addSubview(starButton)
        starButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            starButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            starButton.widthAnchor.constraint(equalToConstant: 30),
            starButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func starButtonTapped() {
        delegate?.starButtonTapped(inCell: self)
    }
//    @objc private func starButtonTapped() {
//        delegate?.starButtonTapped(inCell: self)
//        guard let tableView = self.superview?.superview as? UITableView,
//              
//                
//              let indexPath = tableView.indexPath(for: self) else {
//            
//            return
//        }
//        
//        if let videosViewController = tableView.delegate as? VideosViewController {
//            guard let video = videosViewController.videos?[indexPath.row] else { 
//                
//                return
//                
//            }
//            DataManger.shared.addVideoToFav(video: video)
//        }
//    }


}
