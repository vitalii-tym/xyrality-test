//
//  GlobalExtensions.swift
//  Xyrality Login Test
//
//  Created by Vitaliy Tim on 2/25/17.
//  Copyright © 2017 Vitaliy Timoshenko. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, bodyText: String) -> Void {
        let alert = UIAlertController(title: title, message: bodyText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "is a general OK button on alerts"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

