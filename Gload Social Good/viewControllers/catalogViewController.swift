//
//  catalogViewController.swift
//  Gload Social Good
//
//  Created by omar said on 2019-05-04.
//  Copyright © 2019 omar said. All rights reserved.
//

import UIKit

class catalogViewController: UIViewController {
    let catalog = ["America","Cambodia","Canada","Paris","Italy","Germany","China","Mexico","Turkey","Thailand"]
    let cellID = "cellID"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        setupUI()
        view.addSubview(titlelabel)
        view.addSubview(resetPasswordDescription)
        titlelabel.center.x = view.center.x
    }
    
    let resetPasswordDescription: UIButton = {
        let screenSize: CGRect = UIScreen.main.bounds
        let window = UIApplication.shared.keyWindow
        
        let lbl = UIButton(frame: CGRect(x: (window?.safeAreaInsets.right)! , y: UIScreen.main.bounds.size.height * 0.02, width: UIScreen.main.bounds.size.width * 0.3 , height: UIScreen.main.bounds.size.height * 0.13))
        lbl.setTitle("Back", for: .normal)
        lbl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.addTarget(self, action: #selector(goback), for: .touchUpInside)
        return lbl
    }()
    
    @objc func goback(){
        self.dismiss(animated: true, completion: nil)
    }
    
    let titlelabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height * 0.025, width: UIScreen.main.bounds.size.width * 0.5 , height: UIScreen.main.bounds.size.height * 0.13))
        lbl.textAlignment = .center
        lbl.text = "Countries"
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        return lbl
    }()
    
    

    @objc func backAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        //Setting up the constraints for the collectin View
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.13).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        collectionView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
    }
    
    //MARK: CollectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 132, green: 179, blue: 255, alpha: 1)
        
        //If we declare the collectionView property as a lazy var, it allows access to set the delegates here and also register our custom cell, so we keep viewDidLoad a little cleaner
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    
    //Setting up the navigationBar
    private func setupNavController() {
        view.backgroundColor = .white
        navigationItem.title = "Collections"
        navigationController?.navigationBar.barTintColor =  #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.tintColor = .white
    }
}

extension catalogViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catalog.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CustomCollectionViewCell
        //stating the collection name to the collection's title
        var collectionName = catalog[indexPath.item]
        //Specifying the name label (in the cell) to the new collection name
        cell.nameLabel.text = collectionName
        //Creating a corner radium for the cell to make it look better
        cell.layer.cornerRadius = 25
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Specifying the size of the cell
        return CGSize(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //Specifying the insets of the collectionView
        return UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = catalog[indexPath.item]
        let itemView = CatalogItemViewController()
        itemView.title = name
        
        if name == "Canada" {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let itemViewController = storyBoard.instantiateViewController(withIdentifier: "CatalogItemViewController") as! CatalogItemViewController
            self.present(itemViewController, animated:true, completion:nil)
            
        }else {
            // create the alert
            let alert = UIAlertController(title: "Error", message: "There are no Places for this Country", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }

        
    }
    
    
    
    
    
}
