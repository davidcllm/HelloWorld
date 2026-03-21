//
//  MainViewModel.swift
//  HelloWorld
//
//  Created by Alumnos on 20/03/26.
//

import Combine

class MainViewModel {
    var model = MainModel()
    
    //Contenedor de una clase observable (Observador)
    @Published var isValidForm: Bool = false
    
    var user: User {
        get { model.user }
        set { model.user = newValue }
    }
    
    func validateForm() {
        print("User \(user)")
        isValidForm = !(user.name.isEmpty && user.password.isEmpty)
        print("isValid: \(isValidForm)")
    }
}
