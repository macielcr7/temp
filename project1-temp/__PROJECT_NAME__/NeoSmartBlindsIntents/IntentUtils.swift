//
//  IntentUtils.swift
//  NeoSmartBlindsIntents
//
//  Created by Mac on 2020-06-20.
//

import Foundation

typealias dataStruct = (String, String, String)?
func getSharedData() -> dataStruct {
    let defaults = UserDefaults(suiteName: "group.com.neosmartblinds.app")
    guard let accessToken = defaults?.string(forKey: "siriToken") else {
        return nil
    }
    guard let uuid = defaults?.string(forKey: "account") else {
        return nil
    }
    guard let apiUrl = defaults?.string(forKey: "api")  else {
        return nil
    }
    return (accessToken, uuid, apiUrl)
}

func getSceneUUID(_ name: String) -> String? {
    let defaults = UserDefaults(suiteName: "group.com.neosmartblinds.app")
    guard let scenes = defaults?.string(forKey: "scenes") else {
        print("No Scenes in UserDefaults")
        return nil
    }
    let json = scenes.data(using: .utf8)!
    do {
        guard let dictionary = try JSONSerialization.jsonObject(with: json, options : .allowFragments) as? Dictionary<String,String> else {
            print("Dictionary nil!")
            return nil
        }
        guard let value = dictionary[name] else {
            print("Dictionary does not have value")
            return nil
        }
        return value
    } catch let error as NSError {
        print("Deserialization error")
        print(error)
        return nil
    }
}

func getSceneNames() -> [String]? {
    let defaults = UserDefaults(suiteName: "group.com.neosmartblinds.app")
    guard let scenes = defaults?.string(forKey: "scenes") else {
        print("No Scenes in UserDefaults")
        return nil
    }
    let json = scenes.data(using: .utf8)!
    do {
        guard let dictionary = try JSONSerialization.jsonObject(with: json, options : .allowFragments) as? Dictionary<String,String> else {
            print("Dictionary nil!")
            return nil
        }
        return Array(dictionary.keys)
    } catch let error as NSError {
        print("Deserialization error")
        print(error)
        return nil
    }
}
