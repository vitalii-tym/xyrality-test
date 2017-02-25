//
//  AppConfig.swift
//  Xyrality Login Test
//
//  Created by Vitaliy Tim on 2/25/17.
//  Copyright © 2017 Vitaliy Timoshenko. All rights reserved.
//

import Foundation

enum xyralityAPICalls {
    case worlds
    
    func asString() -> String {
        switch  self {
        case .worlds:
            // This call returns the list of game worlds
            return "http://backend1.lordsandknights.com/XYRALITY/WebObjects/BKLoginServer.woa/wa/worlds"
        }
    }
    
    func asURL() -> URL {
        if let url = Foundation.URL(string: self.asString()) {
            return url
        } else {
            print("\(self.asString()) is not a correct url. Failed to convert it into URL")
            return Foundation.URL(string: "https://xyrality.helpshift.com/")!
        }
    }
}
