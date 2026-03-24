//
//  ViewController.swift
//  HelloWorld
//
//  Created by Alumnos on 18/03/26.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    // MARK: - Componentes visuales
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var labelErrorUsername: UILabel!
    @IBOutlet weak var labelErrorPassword: UILabel!

    //MARK: - Propiedades privadas
    private let viewModel = MainViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    
    //MARK: - Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //ocultar teclado
        let tapGesture = UITapGestureRecognizer(
            target: view,
            action: #selector(UIView.endEditing)
        )
        
        tapGesture.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tapGesture)
        
        // fin de ocultar teclado
        
        tfUser.delegate = self
        tfPassword.delegate = self
        
        //signo por ser publisher
        viewModel.$isValidForm
            .sink { [weak self] isValid in
                guard let self else { return }
                self.btnLogin.isEnabled = isValid
            }
            .store(in: &cancellable)
        
        viewModel.$isUserNameValid
            .sink { [weak self] isValid in
                guard let self else { return }
                self.labelErrorUsername.text = isValid ? nil : "El usuario no puede estar vacío"
            }
            .store(in: &cancellable)
        
        viewModel.$isPasswordValid
            .sink { [weak self] isValid in
                guard let self else { return }
                self.labelErrorPassword.text = isValid ? nil : "La contraseña no puede estar vacía"
            }
            .store(in: &cancellable)
    }
    
    @IBAction func loginTapped() {
        guard let navigationController = navigationController else { return }
        let storyBoardName = "Main" //Nombre del archivo del storyboard
        let id = "Home"
        
        let secondVC = UIStoryboard(
            name: storyBoardName,
            bundle: nil
        ).instantiateViewController(
                identifier: id
        ) { coder in
            self.viewModel.user.name = "David"
            let model = HomeModel(user: self.viewModel.user)
            let viewModel = HomeViewModel(model: model)
            return HomeViewController(coder: coder, viewModel: viewModel)
        }
        
        navigationController.pushViewController(secondVC, animated: true)
        //navigationController.present
    }
}

// MARK: - UITextFiledDelegate
extension MainViewController : UITextFieldDelegate {
    //Optional: quita el teclado al presionar return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Calculamos el texto
        let currentText = textField.text ?? ""
        guard let range = Range(range, in: currentText) else { return false } // preguntar si es diferente de nulo
        let updatedText = currentText.replacingCharacters(in: range, with: currentText)
        
        if tfUser == textField {
            viewModel.user.userName = updatedText
            viewModel.validateUserName()
        }
        else if tfPassword == textField {
            viewModel.user.password = updatedText
            viewModel.validatePassword()
        }
        
        
        viewModel.validateForm()
        
        return true
    }
}

