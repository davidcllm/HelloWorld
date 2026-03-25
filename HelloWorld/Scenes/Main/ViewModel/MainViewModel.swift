//
//  MainViewModel.swift
//  HelloWorld
//
//  Created by Alumnos on 20/03/26.
//

import Combine
import Foundation

class MainViewModel {
    var model = MainModel()
    
    //Contenedor de una clase observable (Observador)
    @Published var isValidForm: Bool = false
    @Published var isUserNameValid: Bool = false
    @Published var isPasswordValid: Bool = false
    
    var user: User {
        get { model.user }
        set { model.user = newValue }
    }
    
    func validateForm() {
        isValidForm = isUserNameValid && isPasswordValid
    }
    
    func validateUserName() {
        isUserNameValid = !user.userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func validatePassword() {
        isPasswordValid = !user.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
