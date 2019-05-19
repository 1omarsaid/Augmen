//
//  CatalogItemViewController.swift
//  Gload Social Good
//
//  Created by omar said on 2019-05-04.
//  Copyright © 2019 omar said. All rights reserved.
//


import UIKit

class CatalogItemViewController: UIViewController {
    

    var titlename: String!
    let items = ["CN Tower"]
    let cellID = "cellID"
    let fileURL = Bundle.main.path(forResource: "jet", ofType: "mp3")
    
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
    
    let titlelabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height * 0.02, width: UIScreen.main.bounds.size.width * 0.4 , height: UIScreen.main.bounds.size.height * 0.13))
        lbl.textAlignment = .center
        lbl.text = "Canada"
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        return lbl
    }()
    
    
    @objc func goback() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        setupUI()
        view.addSubview(resetPasswordDescription)
        view.addSubview(titlelabel)
        titlelabel.center.x = view.center.x
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
    
    private func setupUI() {
        view.addSubview(collectionView)
        //Setting up the constraints for the collectin View
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.1).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        collectionView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)

    }

}





extension CatalogItemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CustomCollectionViewCell
        //stating the collection name to the collection's title
        var collectionName = items[indexPath.item]
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
        let type = items[indexPath.item]
        let itemView = CatalogItemViewController()
        itemView.title = type
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let itemViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(itemViewController, animated:true, completion:nil)
        
        
    }
    
}
