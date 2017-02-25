//
//  ErrorHandling.swift
//  Xyrality Login Test
//
//  Created by Vitaliy Tim on 2/25/17.
//  Copyright © 2017 Vitaliy Timoshenko. All rights reserved.
//

import Foundation
import UIKit

internal func isRequestOK(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Bool {
    if error == nil {
        if let theResponse = response as? HTTPURLResponse {
            if theResponse.statusCode == 200 {
                return true
            } else {
                UIApplication.shared.keyWindow?.rootViewController?.showAlert(title: errorTitles.internalError.text(),
                    bodyText: NSLocalizedString("Server error. Code: \(theResponse.statusCode)", comment: "error description when the API is reachable but it responds with an error code"))
                return false
            }
        } else {
            UIApplication.shared.keyWindow?.rootViewController?.showAlert(title: errorTitles.internalError.text(),
                       bodyText: NSLocalizedString("Couldn't read response from server. Try again", comment: "error description when failed to convert response from server into HTTPURLResponse"))
            return false
        }
    } else {
        UIApplication.shared.keyWindow?.rootViewController?.showAlert(title: errorTitles.networkError.text(), bodyText: error!.localizedDescription)
        return false
    }
}
