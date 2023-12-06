//
//  SearchViewController.swift
//  mediaHub
//
//  Created by asmaa gamal  on 23/11/2023.
//

import UIKit

class SearchViewController: UIViewController {
    var searchResults: [ImageModel] = []
    let searchViewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var serchTextFeild: UISearchBar!
    @IBAction func SearchButton(_ sender: UIButton) {
        performSearch(with: serchTextFeild.text ?? "")
    }
    
    func performSearch(with query: String) {
            searchViewModel.searchForImages(with: query) { [weak self] images, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching search results: \(error)")
                    // Handle error
                } else if let images = images {
                    self.searchResults = images
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "ShowSearchResults", sender: self.searchResults)
                    }
                }
            }
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowSearchResults",
               let destinationVC = segue.destination as? SearchResultViewController,
               let results = sender as? [ImageModel] {
                // Pass the search results to the destination view controller
                destinationVC.searchResults = results
            }
        }
    }
