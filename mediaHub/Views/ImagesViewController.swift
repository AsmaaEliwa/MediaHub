//
//  ImagesViewController.swift
//  mediaHub
//
//  Created by asmaa gamal  on 20/11/2023.
//
import UIKit

class ImagesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var images: [ImageModel]? = []
    var currentPage = 1
    let perPage = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadImages()
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
        
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                }
            }.resume()
        }
        
        
        return cell
    }
}
