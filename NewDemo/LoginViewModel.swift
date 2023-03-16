//
//  LoginViewModel.swift
//  NewDemo
//
//  Created by Vaibhav on 25/09/21.
//

import Foundation
import RxSwift


class LoginViewModel {
    
    let username = PublishSubject<String?>()
    let password = PublishSubject<String?>()
    
    let minPasswordLen = 5
    
    var isValidUserName: Observable<Bool> {
        return username.map { $0!.validateName }
    }
    
    var isValidPassword: Observable<Bool> {
        return password.map { $0!.validatePassword }
    }
    
    var isValidLogin: Observable<Bool> {
        return Observable.combineLatest(username, password) { [unowned self] ( name, password) in
            guard name != nil && password != nil else {
                return false
            }
            
            return !(name!.isEmpty) && !(password!.isEmpty) && password!.count >= minPasswordLen && name!.validateName && password!.validatePassword
        }
    }
}


extension String {
    var validateName: Bool {
        if self.isEmpty {
            return true
        }
        let nameRegex = "^[A-Za-z0-9]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return predicate.evaluate(with: self)
    }
    
    var validatePassword: Bool {
        if self.isEmpty {
            return true
        }
        let passRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@!?_]{5,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passRegex)
        return predicate.evaluate(with: self)
    }
}


struct DemoConstants {
    static let nameFormatError = "Enter proper user name"
    static let passwordFormatError = "Password not meeting the criteria"
}
