//
//  Coordinator.swift
//  MyProjectApp
//
//  Created by admin on 22/02/2024.
//


import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
