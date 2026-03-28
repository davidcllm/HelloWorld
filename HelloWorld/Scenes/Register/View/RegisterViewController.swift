//
//  RegisterViewController.swift
//  HelloWorld
//
//  Created by Alumnos on 27/03/26.
//

import Foundation

import UIKit
import Combine

class RegisterViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Componentes visuales
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    
    @IBOutlet weak var lblError1: UILabel!
    @IBOutlet weak var lblError2: UILabel!
    @IBOutlet weak var lblError3: UILabel!
    @IBOutlet weak var lblError4: UILabel!
    @IBOutlet weak var lblError5: UILabel!
        
    @IBOutlet weak var btnRegisterForm: UIButton!
    
    // MARK: - Propiedades privadas
    private let viewModel = RegisterViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Oculta el teclado cuando detecta un tap
        let tapGesture = UITapGestureRecognizer(
            target: view,
            action: #selector(UIView.endEditing)
        )
        tapGesture.cancelsTouchesInView = false //Opcional: garantiza que otros botones sigan recibiendo toques
        
        view.addGestureRecognizer(tapGesture) //Fin ocultar teclado
        
        tfUsername.delegate = self  //protocolo que contiene todas las propiedades de un textfield
        tfName.delegate = self
        tfLastName.delegate = self
        tfPassword.delegate = self
        tfConfirmPassword.delegate = self
        
        //Para que aparezcan los mensajes de errores cuando entres a la pantalla
        viewModel.validateUserName()
        viewModel.validateName()
        viewModel.validateLastName()
        viewModel.validatePassword()
        viewModel.validateConfirmPassword()
        viewModel.validateRegister()
        
        // editingChanged
        [tfUsername, tfName, tfLastName, tfPassword, tfConfirmPassword].forEach {
            $0?.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        }
        
        //Suscripciones a errores
        viewModel.$userNameError
            .receive(on: RunLoop.main)
            .sink { [weak self] msg in
                self?.lblError1.text = msg
                self?.lblError1.isHidden = (msg == nil)
            }.store(in: &cancellable)

        viewModel.$nameError
            .receive(on: RunLoop.main)
            .sink { [weak self] msg in
                self?.lblError2.text = msg
                self?.lblError2.isHidden = (msg == nil)
            }.store(in: &cancellable)

        viewModel.$lastNameError
            .receive(on: RunLoop.main)
            .sink { [weak self] msg in
                self?.lblError3.text = msg
                self?.lblError3.isHidden = (msg == nil)
            }.store(in: &cancellable)

        viewModel.$passwordError
            .receive(on: RunLoop.main)
            .sink { [weak self] msg in
                self?.lblError4.text = msg
                self?.lblError4.isHidden = (msg == nil)
            }.store(in: &cancellable)

        viewModel.$confirmPasswordError
            .receive(on: RunLoop.main)
            .sink { [weak self] msg in
                self?.lblError5.text = msg
                self?.lblError5.isHidden = (msg == nil)
            }.store(in: &cancellable)
        
        btnRegisterForm.isEnabled = false
        btnRegisterForm.alpha = 0.5 // opcional, para dar feedback visual

        viewModel.$isRegisterValid
            .receive(on: RunLoop.main)
            .sink { [weak self] isValid in
                self?.btnRegisterForm.isEnabled = isValid
                self?.btnRegisterForm.alpha = isValid ? 1.0 : 0.5 // opcional
            }
            .store(in: &cancellable)

    }
    
    @objc private func textFieldChanged(_ sender: UITextField) {
        var u = viewModel.user
        if sender == tfUsername {
            u.userName = sender.text ?? ""
            viewModel.user = u
            viewModel.validateUserName()
        } else if sender == tfName {
            u.name = sender.text ?? ""
            viewModel.user = u
            viewModel.validateName()
        } else if sender == tfLastName {
            u.lastName = sender.text ?? ""
            viewModel.user = u
            viewModel.validateLastName()
        } else if sender == tfPassword {
            u.password = sender.text ?? ""
            viewModel.user = u
            viewModel.validatePassword()
        } else if sender == tfConfirmPassword {
            u.confirmPassword = sender.text ?? ""
            viewModel.user = u
            viewModel.validateConfirmPassword()
        }

        // Recalcula el estado global del formulario para el botón
        viewModel.validateRegister()
    }
    
    @IBAction func registerTapped() {
        viewModel.validateRegister()
        if viewModel.isRegisterValid {
            // Continuar: guardar usuario, cerrar, o volver a Main
            navigationController?.popViewController(animated: true)
        }
    }
}


