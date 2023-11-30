//
//  ImageCollectionViewCell.swift
//  mediaHub
//
//  Created by asmaa gamal  on 22/11/2023.
//
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
    
        return imageView
    }()
    let starButton: UIButton = {
          let button = UIButton()
          button.setImage(UIImage(systemName: "star"), for: .normal)
          button.tintColor = .yellow
          button.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
          return button
      }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupStarButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageView()
    }

    private func setupImageView() {

        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupStarButton() {
           // Add and configure starButton in the cell
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
        guard let collectionView = superview as? UICollectionView,
                let indexPath = collectionView.indexPath(for: self),
                let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else {
              return
          }
            
            // Access the image property within the cell
        guard let imageInCell = cell.imageView.image else { return  }
               
        DataManger.shared.addImageToFav(image: imageInCell)
       }
}
