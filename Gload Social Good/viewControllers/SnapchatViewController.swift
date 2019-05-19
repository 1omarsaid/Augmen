//
//  SnapchatViewController.swift
//  Gload Social Good
//
//  Created by omar said on 2019-05-17.
//  Copyright © 2019 omar said. All rights reserved.
//

import UIKit
import SCSDKLoginKit

class SnapchatViewController: UIViewController {


    @IBOutlet weak var loginButton: SCSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginButton)

        
    }

    @IBAction func goToMenu(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let itemViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.present(itemViewController, animated:true, completion:nil)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        SCSDKLoginClient.login(from: self, completion: { success, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if success {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let itemViewController = storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                self.present(itemViewController, animated:true, completion:nil)
                
//                self.fetchSnapUserInfo() //example code
            }
        })
    }
    
    
    
}
