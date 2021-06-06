//
//  Util.swift
//  Movie-Challenge
//
//  Created by Thiago Pontes Lima on 05/06/21.
//  Copyright © 2021 Vitor Campos. All rights reserved.
//

import UIKit

//MARK:- Extension UIViewController
extension UIViewController{
    
    func creatAlert(title: String, message: String, buttonTitle: String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func nextScreen(viewId: String){
        guard let storyboard = self.storyboard, let navController = self.navigationController else { return }
        let pushScreen = storyboard.instantiateViewController(identifier: viewId )
        navController.pushViewController(pushScreen, animated: true)
    }
    
}
