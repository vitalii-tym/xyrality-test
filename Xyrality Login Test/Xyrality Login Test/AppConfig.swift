//
//  AppConfig.swift
//  Xyrality Login Test
//
//  Created by Vitaliy Tim on 2/25/17.
//  Copyright © 2017 Vitaliy Timoshenko. All rights reserved.
//

import Foundation
import UIKit

let deviceType: String = "\(UIDevice.current.model) - \(UIDevice.current.systemName) - \(UIDevice.current.systemVersion)"
let deviceID: String = NSUUID().uuidString

enum xyralityAPICalls: String {
    case worlds = "http://backend1.lordsandknights.com/XYRALITY/WebObjects/BKLoginServer.woa/wa/worlds"
    
    func method() -> String {
        switch  self {
        case .worlds: // All urls, which will be using POST method
            return "POST"
        }
    }
    
    func URL() -> URL {
        if let url = Foundation.URL(string: self.rawValue) {
            return url
        } else {
            print("\(self.rawValue) is not a correct url. Failed to convert it into URL")
            return Foundation.URL(string: "https://xyrality.helpshift.com/")!
        }
    }
    
    func generatePayload(login: String = "", password: String = "") -> String {
        switch self {
        case .worlds:
            // For Worlds we need to post a URL-encoded string
            // Example: login=test@test.com&password=test&deviceType=iPhone%20-%20iOS%20-%2010.2&deviceId=D117C8D4-B6CD-414B-9486-9A59C1CC28EA
            let params: Dictionary<String, String> = ["login": login,
                                                      "password": password,
                                                      "deviceType": deviceType,
                                                      "deviceId": deviceID]
            return dictToPayloadString(params)
        }
    }

    func dictToPayloadString (_ params: Dictionary<String, String>) -> String {
        let paramsString: String = Array(params.map { "\($0)=\($1)"}).joined(separator: "&")
        if let encodedString = paramsString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            return encodedString
        } else {
            print("failed to add percent encoding for string: \(paramsString)")
            return ""
        }
    }
}
