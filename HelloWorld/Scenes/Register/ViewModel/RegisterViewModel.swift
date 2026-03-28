//
//  RegisterViewModel.swift
//  HelloWorld
//
//  Created by Alumnos on 27/03/26.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    @Published var model = RegisterModel(user: User(name: "", userName: "", lastName: "", password: "", confirmPassword: ""))
    
    @Published var isUserNameValid: Bool = false
    @Published var isNameValid: Bool = false
    @Published var isLastNameValid: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isConfirmPasswordValid: Bool = false
    @Published var isRegisterValid: Bool = false
    
    @Published var userNameError: String?
    @Published var nameError: String?
    @Published var lastNameError: String?
    @Published var passwordError: String?
    @Published var confirmPasswordError: String?
    
    var user: User {
        get {
            return model.user
        }
        set { // var newValue: User
            model.user = newValue
        }
    }
    
    // Aquí va a estar la validación del nombre de usuario
    func validateUserName() {
        let text = user.userName.trimmingCharacters(in: .whitespacesAndNewlines)
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: "-_")
        
        if text.isEmpty {
            isUserNameValid = false
            userNameError = "El usuario es requerido."
        } else if text.count < 4 {
            isUserNameValid = false
            userNameError = "El usuario no puede tener 4 o menos caracteres"
        } else if text.count > 21 {
            isUserNameValid = false
            userNameError = "El usuario no puede tener más de 20 caracteres"
        } else if text.contains(" ") {
            isUserNameValid = false
            userNameError = "El usuario no puede tener espacios"
        } else if ((text.first?.isNumber) == true) {
            isUserNameValid = false
            userNameError = "El usuario no puede empezar con un número"
        } else if (text.rangeOfCharacter(from: allowed.inverted) != nil) {
            isUserNameValid = false
            userNameError = "El usuario no puede tener caracteres especiales"
        } else {
            isUserNameValid = true
            userNameError = nil
        }
    }
    
    // Aquí va a estar la validación del nombre
    func validateName() {
        let text = user.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let caracteresEspeciales = CharacterSet(charactersIn: "¿?!¡@#")
        
        if text.isEmpty {
            isNameValid = false
            nameError = "El nombre es requerido."
        } else if (text.rangeOfCharacter(from: caracteresEspeciales) != nil) {
            isNameValid = false
            nameError = "El nombre no puede tener caracteres especiales"
        } else if text.count < 2 {
            isNameValid = false
            nameError = "El nombre no puede tener 2 o menos caracteres"
        } else if text.count > 31 {
            isNameValid = false
            nameError = "El nombre no puede tener más de 30 caracteres"
        } else {
            isNameValid = true
            nameError = nil
        }
    }
    
    // Aquí va a estar la validación del apellido
    func validateLastName() {
        let text = user.lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        let caracteresEspeciales = CharacterSet(charactersIn: "¿?!¡@#")
        
        if text.isEmpty {
            isLastNameValid = false
            lastNameError = "El apellido es requerido."
        } else if (text.rangeOfCharacter(from: caracteresEspeciales) != nil) {
            isLastNameValid = false
            lastNameError = "El apellido no puede tener caracteres especiales"
        } else if text.count < 2 {
            isLastNameValid = false
            lastNameError = "El apellido no puede tener 2 o menos caracteres"
        } else if text.count > 31 {
            isLastNameValid = false
            lastNameError = "El apellido no puede tener más de 30 caracteres"
        } else {
            isLastNameValid = true
            lastNameError = nil
        }
    }

    // Aquí va a estar la validación de la contraseña
    func validatePassword() {
        let text = user.password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Validaciones de si es que tiene Mayúsculas, minúsculas y números
        let tieneMayuscula = text.contains { $0.isUppercase }
        let tieneMinuscula = text.contains { $0.isLowercase }
        let tieneNumero = text.contains { $0.isNumber }
        
        if text.isEmpty {
            isPasswordValid = false
            passwordError = "La contraseña es requerida."
        } else if text.count < 7 {
            isPasswordValid = false
            passwordError = "La contraseña debe tener mínimo 8 caracteres"
        } else if text.contains(" ") {
            isPasswordValid = false
            passwordError = "La contraseña no puede tener espacios"
        } else if !(tieneMayuscula && tieneMinuscula && tieneNumero) {
            isPasswordValid = false
            passwordError = "La contraseña debe tener mayúsculas, minúsculas y números"
        } else {
            isPasswordValid = true
            passwordError =  nil
        }
    }
    
    // Aquí va a estar la validación de confirmar la contraseña
    func validateConfirmPassword() {
        let text = user.confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if text.isEmpty {
            isConfirmPasswordValid = false
            confirmPasswordError = "Confirmar la contraseña es requerido."
        } else if user.confirmPassword != user.password {
            isConfirmPasswordValid = false
            confirmPasswordError = "Las contraseñas no coinciden."
        } else {
            isConfirmPasswordValid = true
            confirmPasswordError = nil
        }

    }
    
    // Aquí va a estar la validación del registro como tal
    func validateRegister() {
        validateUserName()
        validateName()
        validateLastName()
        validatePassword()
        validateConfirmPassword()
        
        isRegisterValid = isUserNameValid && isNameValid && isLastNameValid && isPasswordValid && isConfirmPasswordValid
    }
}

