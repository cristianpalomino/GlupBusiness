//
//  ViewController.swift
//  Glup Business
//
//  Created by Cristian Palomino Rivera on 1/09/16.
//  Copyright © 2016 Glup. All rights reserved.
//

import UIKit

class CuponViewController : UIViewController {

    @IBOutlet weak var mallname         :UILabel!
    @IBOutlet weak var placename        :UILabel!
    @IBOutlet weak var totaldiscount    :UILabel!
    @IBOutlet weak var discount         :UILabel!
    @IBOutlet weak var storename        :UILabel!
    @IBOutlet weak var wearname         :UILabel!
    @IBOutlet weak var sizetitle        :UILabel!
    @IBOutlet weak var sizeslist        :UILabel!
    @IBOutlet weak var price            :UILabel!
    @IBOutlet weak var descripcion      :UILabel!
    
    let cupon = Session.sharedInstance.cupon
}

extension CuponViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIUtil.transparentNavigationBar(self)
        initCupon()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension CuponViewController {
    
    func initCupon() {
        
        mallname.text = cupon!.mallName!
        placename.text = cupon!.placeName!
        totaldiscount.text = cupon!.discount!
        storename.text = cupon!.storeName!
        wearname.text = cupon!.wearName!
        sizeslist.text = cupon!.listSize!
        price.text = "S/. \(cupon!.wearPrice!)"
        descripcion.text = cupon!.promotionDescription!
    }
}

