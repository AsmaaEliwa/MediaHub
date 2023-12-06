//
//  ImagesViewController.swift
//  mediaHub
//
//  Created by asmaa gamal  on 20/11/2023.
//
import UIKit


class ImagesViewController: UIViewController, UITabBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var switchToFavoriteTab: UITabBarItem!
    @IBAction func loadMoreImages(_ sender: UIButton) {
        viewModel.loadMore()
        self.collectionView.reloadData()
    }
    let viewModel = ImagesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadData()
    }

    func setupCollectionView() {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
    }

    func loadData() {
        viewModel.loadImages { [weak self] images, error in
            if let error = error {
                print("Error loading images: \(error)")
            } else {
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}

extension ImagesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfImages()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }

        viewModel.getImage(at: indexPath.item) { image in
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }

        return cell
    }
}

extension ImagesViewController {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == switchToFavoriteTab {
            performSegue(withIdentifier: "ToFavImages", sender: self)
        }
    }
}
