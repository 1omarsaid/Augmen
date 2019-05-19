//
//  DetailViewController.swift
//  Gload Social Good
//
//  Created by omar said on 2019-05-18.
//  Copyright © 2019 omar said. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var english: UITextView!
    @IBOutlet weak var arabic: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arabic.isHidden = true
        english.isHidden = false

    }
    
    @IBAction func translateTextField(_ sender: Any) {
            arabic.isHidden = false
            english.isHidden = true
            translateButton.titleLabel?.text = "Translate: English"
    }
    
    @IBAction func `return`(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
