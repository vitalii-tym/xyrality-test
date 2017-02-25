//
//  DataModel.swift
//  Xyrality Login Test
//
//  Created by Vitaliy Tim on 2/25/17.
//  Copyright © 2017 Vitaliy Timoshenko. All rights reserved.
//

import Foundation

class xyralityError {

    /* Example error:
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
        if let jsonObjectRoot = tryGetDictFromData(data) {
            if let message = jsonObjectRoot["error"] as? String {
                self.errorText = message
            } else {
                return nil
            }
        } else {
            return nil
        }
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
    
    /* Example of worlds list
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
        if let jsonObjectRoot = tryGetDictFromData(data) {
            if let availableWorlds = jsonObjectRoot["allAvailableWorlds"] as? Array<AnyObject> {
                for aWorld in availableWorlds {
                    () // TODO: continue parsing worlds here
                }
            } else {
                return nil
            }
        } else {
            return nil
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
    
    if let theDict = dict {
        return theDict
    } else {
        print("type casting to Dict failed - the data is not in dictionary format")
        return nil
    }
}
