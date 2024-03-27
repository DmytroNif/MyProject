//
//  TVShowVIewController.swift
//  MyProjectApp
//
//  Created by admin on 23/03/2024.
//


import UIKit
import ProgressHUD

class TVShowViewController: UIViewController {
    
    let genresData = Genre.allCases
    let mainView = TVShowView()
    let manager = NetworkManager()
    var storage = StorageImpl()
    
    
    
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
}
