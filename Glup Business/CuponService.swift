//
//  CuponService.swift
//  Glup Business
//
//  Created by Cristian Palomino Rivera on 3/09/16.
//  Copyright © 2016 Glup. All rights reserved.
//

import SwiftyJSON
import Alamofire

class CuponService {
    
    var serviceDelegate: ServiceDelegate!

    struct EndPoints {
        static let URL = "http://108-179-236-241-pcdob5oxs0w5.runscope.net/API/orquestadorServiciosApp.php"
    }
    
    static let sharedInstance = CuponService()
    private init() {}
}

extension CuponService {
    
    func serviceCupon() {
        let params = ["barCode":Session.sharedInstance.code , "tag":"infoCouponQR"]
        
        Alamofire.request(.POST, CuponService.EndPoints.URL,
            parameters: params,
            encoding: .URL).responseJSON {
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        if !json["error"].isExists() {
                            let cupon = Cupon(json: json)
                            self.serviceDelegate.serviceSuccess(cupon)
                        }
                        else {
                            let error = NSError.errorWithMessagep(json["error_msg"].stringValue)
                            self.serviceDelegate.serviceFailed(error)
                        }
                    }
                    else {
                        let error = NSError.errorWithMessagep("Success Error")
                        self.serviceDelegate.serviceFailed(error)
                    }
                    
                case .Failure(let error):
                    self.serviceDelegate.serviceFailed(error)
            }
        }
    }
}

protocol ServiceDelegate {
    
    func serviceSuccess<T>(response :T)
    func serviceFailed(error :ErrorType)
}

extension NSError {
    
    static func errorWithMessagep(message :String) -> NSError {
        return NSError(domain: "com.glup.business", code: 100, userInfo: [NSLocalizedDescriptionKey: message])
    }
}


