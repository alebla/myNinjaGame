//
//  ChaseScrollMovement.swift
//  myNinjaGame
//
//  Created by aB on 6/5/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit
import GameplayKit

class ChaseScrollComponent: GKComponent {
   
   var movementSpeed = CGPoint(x: 85.0, y: 0.0)
   
   var spriteComponent: SpriteComponent {
      guard let spriteComponent = entity?.componentForClass(SpriteComponent.self) else { fatalError("No Sprite Found")}
      return spriteComponent
   }
   
   init(entity: GKEntity) {
      super.init()
   }
   
   override func updateWithDeltaTime(seconds: NSTimeInterval) {
      super.updateWithDeltaTime(seconds)
      
      //Move sprite
      spriteComponent.node.position += (movementSpeed * CGFloat(seconds))
      
   }
   
}