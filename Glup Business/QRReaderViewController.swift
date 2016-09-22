//
//  QRReaderViewController.swift
//  Glup Business
//
//  Created by Cristian Palomino Rivera on 2/09/16.
//  Copyright © 2016 Glup. All rights reserved.
//

import Spring
import UIKit
import AVFoundation

class QRReaderViewController: UIViewController {
    
    var session: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var infoView         :SpringView!
    @IBOutlet weak var infoText         :SpringLabel!

}

extension QRReaderViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initQRReader()
        UIUtil.transparentNavigationBar(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (session?.isRunning == false) {
            session.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (session?.isRunning == true) {
            session.stopRunning()
        }
    }
}

extension QRReaderViewController {
    
    func initQRReader() {
        
        session = AVCaptureSession()
        let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput?
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (session.canAddInput(videoInput)) {
            session.addInput(videoInput)
        } else {
            scanningNotPossible()
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (session.canAddOutput(metadataOutput)) {
            session.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
        } else {
            scanningNotPossible()
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        session.startRunning()
    }
    
    func scanningNotPossible() {
        let alert = UIAlertController(title: "Can't Scan.", message: "Let's try a device equipped with a camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        session = nil
    }
}

extension  QRReaderViewController : AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if let barcodeData = metadataObjects.first {
            let barcodeReadable = barcodeData as? AVMetadataMachineReadableCodeObject;
            if let readableCode = barcodeReadable {
                Session.sharedInstance.code = readableCode.stringValue
                CuponService.sharedInstance.serviceCupon()
                CuponService.sharedInstance.serviceDelegate = self
            }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            session.stopRunning()
        }
    }
}

extension QRReaderViewController : ServiceDelegate {
    
    func serviceSuccess<T>(_ response: T) {
        if let cupon = response as? Cupon {
            Session.sharedInstance.cupon = cupon
            self.performSegue(withIdentifier: "toDetail", sender: nil)
        }
    }
    
    func serviceFailed(_ error: Error) {
        infoView.animation = "shake"
        infoView.backgroundColor = UIColor.red
        infoText.text = (error as NSError).localizedDescription
        infoText.textColor = UIColor.white
        infoView.animate()
        infoView.animateToNext(completion: {
            self.infoView.backgroundColor = UIColor.white
            self.infoText.text = "Escanear al código QR del cupón"
            self.infoText.textColor = UIColor.black
            self.infoView.duration = 3
            self.session.startRunning()
        })
    }
}
