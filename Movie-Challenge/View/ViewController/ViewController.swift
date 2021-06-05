//
//  ViewController.swift
//  Movie-Challenge
//
//  Created by Thiago Pontes Lima on 04/06/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textRegister: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
        textRegister.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    @objc func tapFunction(sender: UITapGestureRecognizer){
        guard let storyboard = self.storyboard, let navController = self.navigationController else { return }
        
        let pushScreen = storyboard.instantiateViewController(identifier: "RegisterViewController")
        navController.pushViewController(pushScreen, animated: true)
    }
}

