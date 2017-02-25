//
//  DataModel.swift
//  Xyrality Login Test
//
//  Created by Vitaliy Tim on 2/25/17.
//  Copyright © 2017 Vitaliy Timoshenko. All rights reserved.
//

import Foundation

class xyralityError {

    /* Example error as returned from API:
    {
        "error" = "Insufficient parameters.";
        "requestParameters" = {};
        "requestUri" = "/XYRALITY/WebObjects/BKLoginServer.woa/15/wa/worlds";
        "clientCommand" = {
        "isLocalized" = "false";
        "action" = "1";
        "message" = "Insufficient parameters.";
        };
        "requestCookies" = ();
    } */

    var errorText: String!
    
    init? (data: Data) {
        guard let jsonObjectRoot = tryGetDictFromData(data) else { return nil }
        guard let message = jsonObjectRoot["error"] as? String else { return nil }
        self.errorText = message
    }
}

struct gameWorld {
    var name: String
    var mapURL: String
    var country: String
    var language: String
    var id: Int
    var url: String
    var status: (id: Int, description: String)
}

class xyralityWorldsList {
    
    /* Example worlds list as returned from API
    {
    "featureAppleTVSynchronisation" = "false";
    "featureDirectPlay" = "true";
    "googleLoginSwitchOn" = "true";
    "serverVersion" = "6.4.1";
    "facebookLoginSwitchOn" = "true";
    "allAvailableWorlds" = (
        {
            "name" = "USA 12 (recommended)";
            "mapURL" = "https://maps3.lordsandknights.com/LKWorldServer-US-12";
            "worldStatus" = {
                        "id" = "3";
                        "description" = "online";
            };
            "country" = "US";
            "language" = "en";
            "id" = "168";
            "url" = "https://backend3.lordsandknights.com/XYRALITY/WebObjects/LKWorldServer-US-12.woa";
        },
        {
            "name" = "USA 11";
            "mapURL" = "https://maps1.lordsandknights.com/LKWorldServer-US-11";
            "worldStatus" = {
                "id" = "3";
                "description" = "online";
            };
            "country" = "US";
            "language" = "en";
            "id" = "153";
            "url" = "https://backend1.lordsandknights.com/XYRALITY/WebObjects/LKWorldServer-US-11.woa";
        }
    );
    "featureHelpshift" = "true";
    "time" = "2017-02-25 12:05:32 Etc/GMT";
    "info" = "Unknown user";
    } */
 
    var worlds: [gameWorld] = []

    init?(data: Data) {
        guard let jsonObjectRoot = tryGetDictFromData(data) else { return nil }
        guard let availableWorlds = jsonObjectRoot["allAvailableWorlds"] as? Array<AnyObject> else { return nil }
        
        for aWorld in availableWorlds {
            if let worldDict = aWorld as? Dictionary<String, AnyObject>,
                let name = worldDict["name"] as? String,
                let mapURL = worldDict["mapURL"] as? String,
                let country = worldDict["country"] as? String,
                let language = worldDict["language"] as? String,
                let idString = worldDict["id"] as? String,
                let url = worldDict["url"] as? String,
                let statusDict = worldDict["worldStatus"] as? Dictionary<String,String> {
                if let idInt = Int(idString),
                    let statusIDString = statusDict["id"],
                    let statusID = Int(statusIDString),
                    let statusDescription = statusDict["description"] {
                    self.worlds.append(gameWorld(name: name,
                                                 mapURL: mapURL,
                                                 country: country,
                                                 language: language,
                                                 id: idInt,
                                                 url: url,
                                                 status: (statusID, statusDescription)))
                }
            }
        }
    }
}

func tryGetDictFromData (_ data: Data) -> Dictionary<String, AnyObject>? {
    var dict: Dictionary<String, AnyObject>?
            
    do {
        dict = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? Dictionary<String, AnyObject>
    }
    catch let error as NSError {
        print("can't deserialized JSON data. Error: \(error.localizedDescription)")
        return nil
    }
    
    guard let theDict = dict else {
        print("type casting to Dict failed - the data is not in dictionary format")
        return nil
    }
    return theDict
}
