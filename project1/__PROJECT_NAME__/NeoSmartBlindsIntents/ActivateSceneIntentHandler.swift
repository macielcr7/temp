import Foundation
import Intents
//import IntentKit
import os.log

public class ActivateSceneIntentHandler: NSObject, ActivateSceneIntentHandling {
    public func resolveName(for intent: ActivateSceneIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        var result: INStringResolutionResult
        if let name = intent.name {
           // If the location is valid, use it; otherwise,
           // let the user know it is not supported
           result = INStringResolutionResult.success(with: name)
           //if getSceneUUID(name) != nil {
           //   result = INStringResolutionResult.success(with: name)
           //} else {
           //   result = INStringResolutionResult.unsupported()
           //}
        } else {
           // Ask for the drop-off location.
           result = INStringResolutionResult.needsValue()
        }

        // Return the result back to SiriKit.
        completion(result)
    }
    
    public func provideNameOptions(for intent: ActivateSceneIntent, with completion: @escaping ([String]?, Error?) -> Void) {
        completion(getSceneNames(), nil)
    }
    
    public func handle(intent: ActivateSceneIntent, completion: @escaping (ActivateSceneIntentResponse) -> Void) {
        let intentResponse: ActivateSceneIntentResponse
        guard let name = intent.name else {
            intentResponse = ActivateSceneIntentResponse(code: .failureNoScene, userActivity: nil)
            completion(intentResponse)
            return
        }
        guard let sharedData = getSharedData() else {
            intentResponse = ActivateSceneIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil)
            completion(intentResponse)
            return
        }
        let accessToken = sharedData.0
        let uuid = sharedData.1
        let apiUrl = sharedData.2
        guard let scene_id = getSceneUUID(name) else {
            intentResponse = ActivateSceneIntentResponse(code: .failureNoScene, userActivity: nil)
            completion(intentResponse)
            return
        }
        let url = URL(string: apiUrl + "/siri/transmit/" + uuid + "/scenes/" + scene_id)!

        let headers = [
            "Authorization": "Bearer " + accessToken
        ]

        os_log("About to perform transmit call with %@ %@", url.absoluteString, accessToken)
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers

        let task = URLSession.shared.dataTask(with: request) {(data, resp, error) in
            let intentResponse: ActivateSceneIntentResponse
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                os_log("error=%@", String(describing: error))
                intentResponse = ActivateSceneIntentResponse(code: .failureOffline, userActivity: nil)
                completion(intentResponse)
                return
            }

            if let httpStatus = resp as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                os_log("statusCode should be 200, but is %@", String(httpStatus.statusCode))
                os_log("response = %@", String(describing: resp))
                intentResponse = ActivateSceneIntentResponse(code: .failureOffline, userActivity: nil)
            } else {
                let responseString = String(data: data, encoding: .utf8)
                os_log("responseString = %@", String(describing: responseString))
                intentResponse = ActivateSceneIntentResponse(code: .success, userActivity: nil)
            }
            completion(intentResponse)
        }
        //intentResponse = ActivateSceneIntentResponse(code: .inProgress, userActivity: nil)
        //completion(intentResponse)
        task.resume()

    }
}
