//
//  OSX_Responder.swift
//  myNinjaGame
//
//  Created by aB on 3/28/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import Foundation
import SpriteKit

extension SGScene {
    
    // handles mouse clicks and drags
    
    override func mouseDown(theEvent: NSEvent) {
        let location = theEvent.locationInNode(self)
        screenInteractionStarted(location)
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        let location = theEvent.locationInNode(self)
        screenInteractionMoved(location)
    }
    
    override func mouseUp(theEvent: NSEvent) {
        let location = theEvent.locationInNode(self)
        screenInteractionEnded(location)
    }
    
    override func mouseExited(theEvent: NSEvent) {
        let location = theEvent.locationInNode(self)
        screenInteractionEnded(location)
    }
    
    // handles key presses
    
    override func keyDown(theEvent: NSEvent) {
        handleKeyEvent(theEvent, keyDown: true)
    }
    
    override func keyUp(theEvent: NSEvent) {
        handleKeyEvent(theEvent, keyDown: false)
    }
    
    func handleKeyEvent(event: NSEvent, keyDown: Bool) {
        guard let characters = event.charactersIgnoringModifiers?.characters else {
            return
        }
        for character in characters {
            buttonEvent("\(character)", velocity: 1.0, pushedOn: keyDown)
        }
    }
    
}


