//
//  Networking.swift
//  Xyrality Login Test
//
//  Created by Vitaliy Tim on 2/24/17.
//  Copyright © 2017 Vitaliy Timoshenko. All rights reserved.
//

import Foundation

class NetworkRequest {
    
    fileprivate var session: Foundation.URLSession {
        return URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func getData(forURL URL: URL, method: String, payload: String, completionHandler: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        var request = URLRequest(url: URL)
        request.httpMethod = method
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = payload.data(using: String.Encoding.utf8)

        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            OperationQueue.main.addOperation({ () -> Void in
                completionHandler(data, response, error as NSError?) })
        })
        dataTask.resume()
    }

    func cancelSession() {
        session.invalidateAndCancel()
    }
}
