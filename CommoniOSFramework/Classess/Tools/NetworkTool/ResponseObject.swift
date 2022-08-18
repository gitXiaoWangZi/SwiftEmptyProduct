//
//  ResponseObject.swift
//  CommoniOSFramework
//
//  Created by 刘圣洁 on 2022/8/18.
//

import UIKit
import SwiftyJSON

struct ResponseObject {

    var code: Int
    var message: String
    var data: Any?
    
    init(json: JSON) {
        self.code = json["code"].intValue
        self.message = json["message"].stringValue
        self.data = json["data"].object
    }
}
