//
//  HomeViewController.swift
//  HelloWorld
//
//  Created by Alumnos on 23/03/26.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - Componentes visuales
    @IBOutlet weak var labelName: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelName .text = viewModel.name
    }
}
