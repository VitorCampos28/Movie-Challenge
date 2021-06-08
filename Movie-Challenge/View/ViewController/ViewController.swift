//
//  ViewController.swift
//  Movie-Challenge
//
//  Created by Vitor Campos on 04/06/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class ViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var textRegister: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginFacebookButton: UIButton!
    
    //MARK: - Constants
    fileprivate enum Constants{
        static let kHomeViewControllerId = "HomeViewController"
        static let kViewStoryboardId = "RegisterViewController"
        static let kButtonOk = "OK"
        static let kLoginErrorWithFacebookTitle = "Facebook login error"
        static let kLoginErrorWithFacebookMessage = "Erro to try authenticate with Facebook"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
        textRegister.addGestureRecognizer(tap)
        
    }
    //MARK: - LabelToRegister
    @objc func tapFunction(sender: UITapGestureRecognizer){
        self.nextScreen(viewId: Constants.kViewStoryboardId)
    }

    //MARK:- Login Click Button
    
    @IBAction func loginFacebookButton(_ sender: Any) {
        let loginManeger = LoginManager()
        loginManeger.logIn(permissions: [.publicProfile, .email], viewController: self) { (resultLogin) in
            switch resultLogin {
            case .success(granted: _, declined: _, token: _):
                self.loginWithFacebook()
            case .failed(let err):
                print(err)
            case .cancelled:
                print("Canceled")
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        if (validateFields()){
            logInFunc()
        }
    }
    
    //MARK: - LogInFunc
    func logInFunc(){
        guard let email = emailField.text, let password = passwordField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.creatAlert(title: "Login Error", message: "Error when try to login, try later", buttonTitle: Constants.kButtonOk)
            }else {
                self.nextScreen(viewId: Constants.kHomeViewControllerId)
            }
        }
    }
    //MARK: - FuncLoginWithFacebook
    func loginWithFacebook(){
        guard let accesTokenString = AccessToken.current?.tokenString else { return }
        let credential = FacebookAuthProvider.credential(withAccessToken: accesTokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if (error != nil){
                self.creatAlert(title: Constants.kLoginErrorWithFacebookTitle, message: Constants.kLoginErrorWithFacebookMessage, buttonTitle: Constants.kButtonOk)
            }else {
                Auth.auth()
                self.nextScreen(viewId: Constants.kHomeViewControllerId)
            }
        }
    }
    //MARK: - ValidateFields
    func validateFields() -> Bool{
        
        if (emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            self.creatAlert(title: "Empty email", message: "Write your email", buttonTitle: "OK")
            return false
        }
        if (passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            self.creatAlert(title: "Empty password", message: "Write your password", buttonTitle: "OK")
            return false
        }
        return true
    }
}

