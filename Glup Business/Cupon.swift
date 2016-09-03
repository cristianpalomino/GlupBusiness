//
//  Cupon.swift
//  Glup Business
//
//  Created by Cristian Palomino Rivera on 2/09/16.
//  Copyright © 2016 Glup. All rights reserved.
//

import Foundation
import SwiftyJSON

class Cupon {
    
    var indUserRegister      :String!
    var mallName             :String!
    var placeName            :String!
    var discount             :String!
    var storeName            :String!
    var wearName             :String!
    var expirationDay        :String!
    var expirationMonth      :String!
    var expirationMonthText  :String!
    var expirationDate       :String!
    var wearPrice            :String!
    var listSize             :String!
    var promotionDescription :String!
    
    init(json :JSON) {
        
        indUserRegister         = json[JsonKeys.indUserRegister].stringValue
        mallName                = json[JsonKeys.mallName].stringValue
        placeName               = json[JsonKeys.placeName].stringValue
        discount                = json[JsonKeys.discount].stringValue
        storeName               = json[JsonKeys.storeName].stringValue
        wearName                = json[JsonKeys.wearName].stringValue
        expirationDay           = json[JsonKeys.expirationDay].stringValue
        expirationMonth         = json[JsonKeys.expirationMonth].stringValue
        expirationMonthText     = json[JsonKeys.expirationMonthText].stringValue
        expirationDate          = json[JsonKeys.expirationDate].stringValue
        wearPrice               = json[JsonKeys.wearPrice].stringValue
        listSize                = json[JsonKeys.listSize].stringValue
        promotionDescription    = json[JsonKeys.promotionDescription].stringValue
    }
}

extension Cupon {
    
    struct JsonKeys {
        
        static let indUserRegister      = "indUserRegister"
        static let mallName             = "mallName"
        static let placeName            = "placeName"
        static let discount             = "discount"
        static let storeName            = "storeName"
        static let wearName             = "wearName"
        static let expirationDay        = "expirationDay"
        static let expirationMonth      = "expirationMonth"
        static let expirationMonthText  = "expirationMonthText"
        static let expirationDate       = "expirationDate"
        static let wearPrice            = "wearPrice"
        static let listSize             = "listSize"
        static let promotionDescription = "promotionDescription"
    }
}