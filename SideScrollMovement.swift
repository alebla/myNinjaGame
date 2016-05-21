//
//  SideScrollMovement.swift
//  myNinjaGame
//
//  Created by aB on 5/13/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit
import GameplayKit

class SideScrollComponent: GKComponent {
   
   var movementSpeed = CGPoint(x: 90.0, y: 0.0)
   
   var spriteComponent: SpriteComponent {
      guard let spriteComponent = entity?.componentForClass(SpriteComponent.self) else {fatalError("Sprite Component not found")}
      return spriteComponent
   }
   
   init(entity: GKEntity) {
      super.init()
   }
   
   override func updateWithDeltaTime(seconds: NSTimeInterval) {
      super.updateWithDeltaTime(seconds)
      
      //Move Sprite
      spriteComponent.node.position += (movementSpeed * CGFloat(seconds))
   }
   
}