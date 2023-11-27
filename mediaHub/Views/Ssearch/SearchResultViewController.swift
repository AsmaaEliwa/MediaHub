//
//  SearchResultViewController.swift
//  mediaHub
//
//  Created by asmaa gamal  on 23/11/2023.
//

import UIKit
import UIKit

class SearchResultViewController: UIViewController {

    var searchResults: [ImageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchedImage", for: indexPath)
        let imageURL = searchResults[indexPath.row].src.medium
        
        // Load images asynchronously
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = image
                        cell.setNeedsLayout() // Ensure the cell updates its layout
                    }
                }
                // Handle image loading error (e.g., set a placeholder image)
                if let error = error {
                    // Set a placeholder image or handle the error as needed
                    print("Error loading image: \(error)")
                    // Example: cell.imageView?.image = UIImage(named: "placeholderImage")
                }
            }.resume()
        }
        
        return cell
    }
}
