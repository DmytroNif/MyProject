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
    let mainView = RightView()
    var searchArray: [String] = []
    var sortedArray: [String] = []
    var tvData: [TVShow] = []
    var moviewData: [TVShow] = []
    
    var textField: UITextField = UITextField()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.addTarget(self, action: #selector(textfieldChangedValue), for: .valueChanged)
        textField.delegate = self
        
        for i in tvData {
            searchArray.append(i.title ?? "")
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
        if let text = textField.text {
        for i in searchArray {
                if i.contains(text) {
                    self.sortedArray.append(i)
//                    UITableView.reloadData()
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
