//
//  DetailsViewController.swift
//  MyProjectApp
//
//  Created by admin on 07/02/2024.
//

import UIKit

class DetailsViewController: UIViewController {
    let mainView = DetailsView()

    var movie: Movie? 

    weak var coordinator: MainCoordinator?
    
    var titleText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backButton.addTarget(self, action: #selector(backButtonTaped), for: .touchUpInside)
        
        if let titleText {
            mainView.titleLabel.text = titleText
        }
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    @objc
    func backButtonTaped() {
        dismiss(animated: true)
    }
}
