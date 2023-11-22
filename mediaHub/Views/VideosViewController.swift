////
////  VideosViewController.swift
////  mediaHub
////
////  Created by asmaa gamal  on 22/11/2023.
////
//
import UIKit
////
//class VideosViewController: UIViewController {
//
//    @IBOutlet weak var collectionView: UICollectionView!
////
//    var videos: [VideoModel] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        setupCollectionView()
////        getUserImages()
//    }
////
////    func setupCollectionView() {
//////        collectionView.dataSource = self
//////        collectionView.delegate = self
////        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
////        // Set up your collection view layout here (e.g., flow layout)
////        // collectionView.collectionViewLayout = ...
////    }
////
////    func getUserImages() {
////        SAAPIManager.shared.getUserAPIVidios() { [weak self] receivedImages, error in
////            if let error = error {
////                print("Error fetching images: \(error)")
////            } else if let receivedImages = receivedImages {
////                self?.videos = receivedImages
////                DispatchQueue.main.async {
////                    self?.updateUIWithImages()
////                }
////            }
////        }
////    }
////
////    func updateUIWithImages() {
////        collectionView.reloadData()
////    }
////}
//////
//extension ImagesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return videos.count
//    }
//   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//     guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell else {
//          return UICollectionViewCell()
//     }
//
//      let imageURL = images[indexPath.item].src.medium // Use the appropriate
//
//       if let url = URL(string: imageURL) {
//           URLSession.shared.dataTask(with: url) { data, _, error in
//              if let data = data, let image = UIImage(data: data) {
//                  DispatchQueue.main.async {                   
//                      cell.imageView.image = image
//                    }
//               }
//            }.resume()
//       }
////
////
//       return cell
//    }
//////
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        // Set your desired item size here
//        return CGSize(width: 100, height: 100)
//    }
////
//}
