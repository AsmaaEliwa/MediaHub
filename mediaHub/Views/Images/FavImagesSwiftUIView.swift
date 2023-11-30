//
//  FavImagesSwiftUIView.swift
//  mediaHub
//
//  Created by asmaa gamal  on 30/11/2023.
//



import UIKit

class FavImagesViewController: UIViewController {
    var favImages: [FavImage] = [] {
        didSet {
            DispatchQueue.main.async {
                
                self.collectionView.reloadData()
            }
//            collectionView.reloadData()
            
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(favImageCollectionViewCell.self, forCellWithReuseIdentifier: "favImageCollectionViewCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        favImages = DataManger.shared.fetchFavImages()
        
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavImagesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favImageCollectionViewCell", for: indexPath) as! favImageCollectionViewCell
        let image = favImages[indexPath.item]

        if let imageUrlString = image.url {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let imageURL = documentDirectory.appendingPathComponent(imageUrlString)

            if FileManager.default.fileExists(atPath: imageURL.path), let uiImage = UIImage(contentsOfFile: imageURL.path) {
                
                print("Image exists at: \(imageURL.path)")
                cell.configure(with: uiImage)
            } else {
                print("Image does not exist at: \(imageURL.path)")
            }
        } else {
            print("No image URL found for item at index: \(indexPath.item)")
        }

        return cell
    }



}


class favImageCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageView()
    }

    private func setupImageView() {
           contentView.addSubview(imageView)

           // Setting up constraints
           imageView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
               imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
               imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
           ])

           // Ensure that the content mode is properly set
           imageView.contentMode = .scaleAspectFill // or .scaleAspectFit, based on preference
           imageView.clipsToBounds = true
       }

       func configure(with image: UIImage) {
           
           imageView.image = image
           
           layoutIfNeeded() // Force layout update
       }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Update the image view's frame if needed
        imageView.frame = contentView.bounds
    }
}
