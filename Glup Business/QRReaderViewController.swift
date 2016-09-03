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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (session?.running == false) {
            session.startRunning()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (session?.running == true) {
            session.stopRunning()
        }
    }
}

extension QRReaderViewController {
    
    func initQRReader() {
        
        session = AVCaptureSession()
        let videoCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
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
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
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
        let alert = UIAlertController(title: "Can't Scan.", message: "Let's try a device equipped with a camera.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
        session = nil
    }
}

extension  QRReaderViewController : AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
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
    
    func serviceSuccess<T>(response: T) {
        if let cupon = response as? Cupon {
            Session.sharedInstance.cupon = cupon
            self.performSegueWithIdentifier("toDetail", sender: nil)
        }
    }
    
    func serviceFailed(error: ErrorType) {
        infoView.animation = "shake"
        infoView.backgroundColor = UIColor.redColor()
        infoText.text = (error as NSError).localizedDescription
        infoText.textColor = UIColor.whiteColor()
        infoView.animate()
        infoView.animateToNext({
            self.infoView.backgroundColor = UIColor.whiteColor()
            self.infoText.text = "Escanear al código QR del cupón"
            self.infoText.textColor = UIColor.blackColor()
            self.infoView.duration = 3
            self.session.startRunning()
        })
    }
}
