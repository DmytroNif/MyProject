//
//  RightViewController.swift
//  MyProjectApp
//
//  Created by admin on 26/01/2024.
//

import UIKit

class RightViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let mainView = RightView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    //MARK: - UITableViewDataSource methods

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Повернення кількості рядків у таблиці
            return 10
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // Створення та налаштування рядка
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Row \(indexPath.row)"
            return cell
        }

        //MARK: - UITableViewDelegate methods

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Обробка події вибору рядка
            
            let vc = DetailsViewController()
            vc.titleText = "Selected row \(indexPath.row)"
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
}
