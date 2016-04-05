//
//  iOS_Responder.swift
//  myNinjaGame
//
//  Created by aB on 3/28/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import Foundation
import SpriteKit

extension SGScene {
    // Handle touch screen events
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            screenInteractionStarted(location)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            screenInteractionMoved(location)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            screenInteractionEnded(location)
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if let actualTouches = touches {
            for touch: AnyObject in actualTouches {
                let location = touch.locationInNode(self)
                screenInteractionEnded(location)
            }
        }
    }
}
