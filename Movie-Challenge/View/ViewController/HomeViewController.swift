//
//  HomeViewController.swift
//  Movie-Challenge
//
//  Created by Thiago Pontes Lima on 05/06/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    @IBOutlet weak var signOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func signOutClick(_ sender: Any) {
        signOut()
    }
    func signOut(){
        if (Auth.auth().currentUser != nil){
             let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
                self.popToViewWithType(type: ViewController.self)
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
        }

    }
}

