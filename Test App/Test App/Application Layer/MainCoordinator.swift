//
//  MainCoordinator.swift
//  Test App
//
//  Created by Alex P on 22/12/2019.
//  Copyright © 2019 Alex Perov. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator {
    //MARK: - PUBLIC VARIAABLES
    static var shared = MainCoordinator()
    //MARK: -
    
    //MARK: - PRIVATE VARIABLES
    private(set) var navigationController = UINavigationController()
    //MARK: -
    
    //MARK: - INIT
    private init() {
        
    }
    //MARK: -
    
    //MARK: - PUBLIC METHODS
    func showHomePage() {
        let homePageVC = HomeViewController(coordinator: self)
        navigationController.pushViewController(homePageVC, animated: true)
    }
    //MARK: -
}
