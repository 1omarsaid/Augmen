//
//  MenuViewController.swift
//  Gload Social Good
//
//  Created by omar said on 2019-05-17.
//  Copyright © 2019 omar said. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    let catalogButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Catalog", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(catalogView), for: .touchUpInside)
        btn.layer.borderWidth = 1
        btn.tintColor = .white
        btn.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 45)
        btn.layer.cornerRadius = 30
        return btn
    }()
    
    let captureButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Places", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(captureView), for: .touchUpInside)
        btn.layer.borderWidth = 1
        btn.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 45)
        btn.tintColor = .white
        btn.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        btn.layer.cornerRadius = 30
        return btn
    }()
    
    let foodButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Food", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(foodView), for: .touchUpInside)
        btn.layer.borderWidth = 1
        btn.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 45)
        btn.tintColor = .white
        btn.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        btn.layer.cornerRadius = 30
        return btn
    }()
    
    let Title: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Augmen-Topics", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        btn.isEnabled = false
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        return btn
    }()
    
    
    @objc func foodView() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let itemViewController = storyBoard.instantiateViewController(withIdentifier: "FoodViewController") as! FoodViewController
        self.present(itemViewController, animated:true, completion:nil)
    }
    
    
    let roundedView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.9))
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        view.addSubview(roundedView)
        roundedView.center.x = view.center.x
        roundedView.center.y = view.center.y
        roundedView.addSubview(catalogButton)
        roundedView.addSubview(captureButton)
        roundedView.addSubview(foodButton)
        roundedView.addSubview(Title)
        
        setupUI()
        
    }
    
    
    @objc func catalogView() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let itemViewController = storyBoard.instantiateViewController(withIdentifier: "catalogViewController") as! catalogViewController
        self.present(itemViewController, animated:true, completion:nil)
        
    }
    
    @objc func captureView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let itemViewController = storyBoard.instantiateViewController(withIdentifier: "CaptureViewController") as! CaptureViewController
        self.present(itemViewController, animated:true, completion:nil)
    }
    
    func setupUI() {
        captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        captureButton.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.35).isActive = true
        captureButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7).isActive = true
        captureButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15).isActive = true
        
        catalogButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        catalogButton.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.55).isActive = true
        catalogButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7).isActive = true
        catalogButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15).isActive = true
        
        foodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        foodButton.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.75).isActive = true
        foodButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7).isActive = true
        foodButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15).isActive = true
        
        Title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Title.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.1).isActive = true
        Title.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7).isActive = true
        Title.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15).isActive = true
    }


}
