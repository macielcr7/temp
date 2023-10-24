import Foundation
import Intents
//import IntentKit
/*
public class ControlBlindIntentHandler: NSObject, ControlBlindIntentHandling {
    public func handle(intent: ControlBlindIntent, completion: @escaping (ControlBlindIntentResponse) -> Void) {
        let response: ControlBlindIntentResponse
        let defaults = UserDefaults.standard
        guard let accessToken = defaults.string(forKey: "siriToken") else {
            response = ControlBlindIntentResponse(code: .failure, userActivity: nil)
            completion(response)
            return
        }
        guard let uuid = defaults.string(forKey: "account") else {
            response = ControlBlindIntentResponse(code: .failure, userActivity: nil)
            completion(response)
            return
        }
        guard let apiUrl = defaults.string(forKey: "api")  else {
            response = ControlBlindIntentResponse(code: .failure, userActivity: nil)
            completion(response)
            return
        }
        let url = URL(string: apiUrl + "/siri/transmit/" + uuid + "/rooms/<room_id>/<blind_id>/<cmd>")!

        let headers = [
            "Authorization": "Bearer " + accessToken
        ]

        print(String(format:"About to perform transmit call with %@ %@", url.absoluteString, accessToken))
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers

        let task = URLSession.shared.dataTask(with: request) {(data, resp, error) in
            let response: ControlBlindIntentResponse
            print(String(format:"Received Data"))
            dump(data)
            dump(resp)
            dump(error)
            response = ControlBlindIntentResponse(code: .success, userActivity: nil)
            completion(response)
        }

        task.resume()

    }
}
*/