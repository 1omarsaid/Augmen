//
//  ViewController.swift
//  Gload Social Good
//
//  Created by omar said on 2019-05-04.
//  Copyright © 2019 omar said. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation
import UberRides
import CoreLocation


class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var player: AVAudioPlayer?
    //This is the uber button
    let uberButton = RideRequestButton()
    
    let goBack: UIButton = {
        let screenSize: CGRect = UIScreen.main.bounds
        let window = UIApplication.shared.keyWindow
        
        let lbl = UIButton(frame: CGRect(x: (window?.safeAreaInsets.right)! , y: UIScreen.main.bounds.size.height * 0.02, width: UIScreen.main.bounds.size.width * 0.3 , height: UIScreen.main.bounds.size.height * 0.13))
        lbl.setTitle("Back", for: .normal)
        lbl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.addTarget(self, action: #selector(goback), for: .touchUpInside)
        return lbl
    }()
    
    let connectButton: UIButton = {
        let screenSize: CGRect = UIScreen.main.bounds
        let window = UIApplication.shared.keyWindow
        
        let lbl = UIButton(frame: CGRect(x: 250 , y: UIScreen.main.bounds.size.height * 0.06, width: UIScreen.main.bounds.size.width * 0.3 , height: UIScreen.main.bounds.size.height * 0.04))
        lbl.setTitle("connect", for: .normal)
        lbl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.layer.borderWidth = 1
        lbl.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        lbl.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        lbl.layer.cornerRadius = 10
        lbl.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.addTarget(self, action: #selector(connect), for: .touchUpInside)
        return lbl
    }()
    
   

    
    let infoButton: UIButton = {
        let screenSize: CGRect = UIScreen.main.bounds
        let window = UIApplication.shared.keyWindow
        
        let lbl = UIButton(frame: CGRect(x: 230 , y: UIScreen.main.bounds.size.height * 0.12, width: UIScreen.main.bounds.size.width * 0.38 , height: UIScreen.main.bounds.size.height * 0.04))
        lbl.setTitle("More Info", for: .normal)
        lbl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.layer.borderWidth = 1
        lbl.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        lbl.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        lbl.layer.cornerRadius = 10
        lbl.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.addTarget(self, action: #selector(info), for: .touchUpInside)
        return lbl
    }()
    
    @objc func info() {
        print("Will display more information")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let itemViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.present(itemViewController, animated:true, completion:nil)
        
    }
    
    @objc func goback() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func connect() {
        // create the alert
        let alert = UIAlertController(title: "Warning", message: "No one online for your region", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        view.addSubview(goBack)
        view.addSubview(connectButton)
        view.addSubview(infoButton)
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/cntower.dae")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        guard let url = Bundle.main.url(forResource: "cntoweraudio", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        let dropoffLocation = CLLocation(latitude: 43.642520, longitude: -79.387100)
        let builder = RideParametersBuilder()
        builder.dropoffLocation = dropoffLocation
        builder.dropoffNickname = "CN Tower"
        uberButton.rideParameters = builder.build()
        
        //Adding the uberbutton to the imageview
        view.addSubview(uberButton)
        setupUberLayout()
    }
    
    func setupUberLayout() {
        uberButton.translatesAutoresizingMaskIntoConstraints = false
        uberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uberButton.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.9).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
