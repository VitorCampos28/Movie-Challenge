//
//  RegisterViewController.swift
//  Movie-Challenge
//
//  Created by Vitor Campos on 05/06/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController{
    //MARK: -Outlet
    @IBOutlet weak var emailRegisterField: UITextField!
    @IBOutlet weak var passwordRegisterField: UITextField!
    @IBOutlet weak var nameRegisterField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    fileprivate enum Constants {
        static let kHomeViewControllerId = "HomeViewController"
        static let kTitleEmailFieldEmpty = "Empty email"
        static let kMessageEmailFieldEmpty = "Write your email"
        static let kTitlePasswordFieldEmpty = "Empty password"
        static let kMessagePasswordFieldEmpty = "Write your password"
        static let kTitleNameFieldEmpty = "Empty name"
        static let kMessageNameFieldEmpty = "Write your Name"
        static let kRegisterErrorTitle = "Register Error"
        static let kRegisterErrorMessage = "Error when trying to create user"
        static let kButtonAction = "OK"
        static let kErrorDatabaseTitle = "Database Error"
        static let kErrorDatabaseMessage = "Error when try save data in database"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Register
    @IBAction func register(_ sender: Any) {
        if (validateFields()){
            guard let email = emailRegisterField.text , let password = passwordRegisterField.text,
                let name = nameRegisterField.text else { return }
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                guard let uId = result?.user.uid else { return }
                print(result)
                if error != nil {
                    self.creatAlert(title: Constants.kRegisterErrorTitle, message: Constants.kRegisterErrorMessage , buttonTitle: Constants.kButtonAction)
                }else {
                    let dp = Firestore.firestore()
                    dp.collection("Users").addDocument(data: ["NameAccount" : name, "Uid" : uId]) { (error) in
                        
                        if error != nil {
                            self.creatAlert(title: Constants.kErrorDatabaseTitle, message: Constants.kErrorDatabaseMessage, buttonTitle: Constants.kButtonAction)
                        }
                    }
                    
                    //NextScreen
                    self.nextScreen(viewId: Constants.kHomeViewControllerId )
                }
            }
        }
    }
    
    //MARK: -ValidateFields
    func validateFields() -> Bool{
        if (nameRegisterField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == String()){
            self.creatAlert(title: Constants.kTitleNameFieldEmpty, message: Constants.kMessageNameFieldEmpty, buttonTitle: Constants.kButtonAction)
            return false
        }
        
        if (emailRegisterField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == String()){
            self.creatAlert(title: Constants.kTitleEmailFieldEmpty, message: Constants.kMessageEmailFieldEmpty , buttonTitle: Constants.kButtonAction)
            return false
        }
        
        if (passwordRegisterField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == String()){
            self.creatAlert(title: Constants.kTitlePasswordFieldEmpty, message: Constants.kMessagePasswordFieldEmpty, buttonTitle: Constants.kButtonAction)
            return false
        }
        
        return true
    }
}
