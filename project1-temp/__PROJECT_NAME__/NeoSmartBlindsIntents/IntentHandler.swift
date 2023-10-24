//
//  IntentHandler.swift
//  NeoSmartBlindsIntents
//
//  Created by Mac on 2020-04-30.
//

import Intents
//import IntentKit

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        //if intent is ControlBlindIntent {
        //    return ControlBlindIntentHandler()
        //}
        if intent is ActivateSceneIntent {
            return ActivateSceneIntentHandler()
        }
        return self
    }
    
}
