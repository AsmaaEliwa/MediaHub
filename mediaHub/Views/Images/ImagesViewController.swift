//
//  ImagesViewController.swift
//  mediaHub
//
//  Created by asmaa gamal  on 20/11/2023.
//
import UIKit

class ImagesViewController: UIViewController, UITabBarDelegate {
    let imageCache = NSCache<NSString, UIImage>()
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var switchToFavoriteTab: UITabBarItem!
    var images: [ImageModel]? = []
    var currentPage = 1
    let perPage = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadImages()
//        tabBar.delegate = self
    }

    func setupCollectionView() {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
    }

    func loadImages() {
        
        SAAPIManager.shared.getImagesForPage(currentPage, perPage: perPage) { [weak self] newImages, error in
            print("Closure executed")
            guard let strongSelf = self else { return }

            if let error = error {
                print("Error fetching images: \(error)")
                
            } else if let newImages = newImages {
                
                strongSelf.images!  += newImages
                
                DispatchQueue.main.async {
                    strongSelf.collectionView.reloadData()
                }
            }
        }
    }





    @IBAction func loadMoreImages(_ sender: UIButton) {
        currentPage += 1
        loadImages()
    }


    func updateUIWithImages() {
        collectionView.reloadData()
    }
}

extension ImagesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let imageURL = images?[indexPath.item].src.medium ?? ""
           
           if let cachedImage = imageCache.object(forKey: imageURL as NSString) {
               print("Cache hit for \(imageURL)")
               cell.imageView.image = cachedImage
           } else {
               if let url = URL(string: imageURL) {
                   URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                       guard let data = data, let image = UIImage(data: data) else {
                           return
                       }
                       
                       self?.imageCache.setObject(image, forKey: imageURL as NSString)
                       
                       DispatchQueue.main.async {

                               cell.imageView.image = image
                           
                       }
                   }.resume()
               }
           }
           
           return cell
       }
}
extension ImagesViewController {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == switchToFavoriteTab { // Check if the selected item matches your 'FavImagesViewController' tab bar item
            performSegue(withIdentifier: "ToFavImages", sender: self)
        }
    }
}
