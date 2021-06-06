//
//  ViewController.swift
//  Movie-Challenge
//
//  Created by Vitor Campos on 04/06/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var textRegister: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - Constants
    fileprivate enum Constants{
        static let kViewStoryboardId = "RegisterViewController"
        static let kButtonOk = "OK"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
        textRegister.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    //MARK: - LabelToRegister
    @objc func tapFunction(sender: UITapGestureRecognizer){
        self.nextScreen(viewId: Constants.kViewStoryboardId)
    }
    //MARK:- Login Click Button
    @IBAction func login(_ sender: Any) {
        validateFields()
    }
    //MARK: -ValidateFields
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

