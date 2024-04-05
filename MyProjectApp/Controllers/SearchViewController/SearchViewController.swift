//
//  SearchViewController.swift
//  MyProjectApp
//
//  Created by admin on 23/03/2024.
//

//
//  DetailsViewController.swift
//  MyProjectApp
//
//  Created by admin on 07/02/2024.
//

import UIKit
import RealmSwift
import ProgressHUD
import YouTubeiOSPlayerHelper
import Lottie

class SearchViewController: UIViewController, UITextFieldDelegate {
    let mainView = SearchView()
    var searchArray: [String] = []
    var sortedArray: [String] = []
    var tvData: [TVShow] = []
    var moviewData: [Movie] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.searchTextField.addTarget(self, action: #selector(textfieldChangedValue), for: .valueChanged)
        mainView.searchTextField.delegate = self
        
        for i in tvData {
            searchArray.append(i.name)
        }
        
        for i in moviewData {
            searchArray.append(i.title ?? "")
        }
    }
    
   

    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    @objc func textfieldChangedValue() {
        self.sortedArray = []
        if let text = mainView.searchTextField.text {
        for i in searchArray {
                if i.contains(text) {
                    self.sortedArray.append(i)
                    mainView.searchTableView.reloadData()
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
