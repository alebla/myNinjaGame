//
//  SGScene.swift
//  myNinjaGame
//
//  Created by aB on 3/28/16.


import SpriteKit

class SGScene: SKScene {
   
   //Basic Functionality, expected overrides, shared scene iOS, OSX, TVOS
   
   func screenInteractionStarted(location: CGPoint){
      
   }
   
   func screenInteractionMoved(location: CGPoint){
      
   }
   
   func screenInteractionEnded(location: CGPoint){
      
   }
   
   func buttonEvent(event: String, velocity: Float, pushedOn: Bool){
      
   }
   
   func stickEvent(event: String, point: CGPoint){
      
   }
   
   // Center Camera
   func centerCameraOnPoint(point: CGPoint){
      if let camera = camera {
         camera.position = point
      }
   }
   
   //Localisation
   func lt(text: String) -> String{
      return NSLocalizedString(text, comment: "")
   }
}
