//
//  HomeViewController.swift
//  HelloWorld
//
//  Created by Alumnos on 23/03/26.
//

import UIKit

class HomeViewController: UITabBarController {
        
    //MARK: - Propiedades privadas
    private let viewModel: HomeViewModel
    
    //MARK: - init
    init?(coder: NSCoder, viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}
