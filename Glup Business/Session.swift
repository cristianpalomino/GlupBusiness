//
//  Session.swift
//  Glup Business
//
//  Created by Cristian Palomino Rivera on 3/09/16.
//  Copyright © 2016 Glup. All rights reserved.
//

import Foundation

class Session {
    
    var code    :String!
    var cupon   :Cupon!
 
    static let sharedInstance = Session()
    private init() {}
}