//
//  CaptureViewController.swift
//  Gload Social Good
//
//  Created by omar said on 2019-05-18.
//  Copyright © 2019 omar said. All rights reserved.
//

import UIKit
import AVKit
import Vision

class CaptureViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    let augmentButton: UIButton = {
        let screenSize: CGRect = UIScreen.main.bounds
        let window = UIApplication.shared.keyWindow
        
        let lbl = UIButton(frame: CGRect(x: 250 , y: UIScreen.main.bounds.size.height * 0.1, width: UIScreen.main.bounds.size.width * 0.3 , height: UIScreen.main.bounds.size.height * 0.05))
        lbl.setTitle("Augment", for: .normal)
        lbl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.layer.borderWidth = 3
        lbl.layer.cornerRadius = 10
        lbl.isHidden = true
        lbl.addTarget(self, action: #selector(augmentView), for: .touchUpInside)
        return lbl
    }()
    
    let contentLable: UIButton = {
        let screenSize: CGRect = UIScreen.main.bounds
        let window = UIApplication.shared.keyWindow
        let lbl = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - UIScreen.main.bounds.width * 0.4 , y: UIScreen.main.bounds.size.height * 0.85, width: UIScreen.main.bounds.size.width * 0.8 , height: UIScreen.main.bounds.size.height * 0.05))
        lbl.setTitle("CN Tower", for: .normal)
        lbl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl.titleLabel?.textAlignment = .center
        lbl.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        lbl.isHidden = true
        return lbl
    }()
    
    @objc func augmentView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let itemViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(itemViewController, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "VideoQueue"))
        captureSession.addOutput(dataOutput)
        
        view.addSubview(augmentButton)
        view.addSubview(contentLable)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        
        guard let model = try? VNCoreMLModel(for: Ruhacks().model) else {return}
        
        let request = VNCoreMLRequest(model: model) { (finishedReq, error) in
            
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
            
            guard let firstObservation = results.first else {return}
            
            if firstObservation.confidence > 0.9999 {
                DispatchQueue.main.async {
                    self.augmentButton.isHidden = false
                    self.contentLable.isHidden = false
                }
                
            }
          
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }


}
