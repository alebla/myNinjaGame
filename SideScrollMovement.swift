//
//  SideScrollMovement.swift
//  myNinjaGame
//
//  Created by aB on 5/13/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit
import GameplayKit

struct ControlScheme {
   var jumpPressed: Bool = false
   var throwPressed: Bool = false
}

class SideScrollComponentSystem: GKComponentSystem {
   
   func updateWithDeltaTime(seconds: NSTimeInterval, controlInput: ControlScheme) {
      for component in components {
         if let comp = component as? SideScrollComponent {
            comp.updateWithDeltaTime(seconds, controlInput: controlInput)
         }
      }
   }
}


class SideScrollComponent: GKComponent {
   
   var movementSpeed = CGPoint(x: 90.0, y: 0.0)
   
   //State
   var isJumping = false
   var jumpTime: CGFloat = 0.0
   var isThrowing = false
   
   var spriteComponent: SpriteComponent {
      guard let spriteComponent = entity?.componentForClass(SpriteComponent.self) else {fatalError("Sprite Component not found")}
      return spriteComponent
   }
   
   var animationComponent: AnimationComponent {
      guard let animationComponent = entity?.componentForClass(AnimationComponent.self) else {fatalError("Animation Component not found")}
      return animationComponent
   }
   
   init(entity: GKEntity) {
      super.init()
   }
   
   func updateWithDeltaTime(seconds: NSTimeInterval, controlInput: ControlScheme) {
      super.updateWithDeltaTime(seconds)
      
      //Move Sprite
      spriteComponent.node.position += (movementSpeed * CGFloat(seconds))
      
      //Jump 
      
      if controlInput.jumpPressed && !isJumping {
         if let playerEnt = entity as? PlayerEntity {
            playerEnt.gameScene.runAction(playerEnt.gameScene.sndJump)
         }
         isJumping = true
         jumpTime = 0.2
         animationComponent.requestedAnimationState = .Jump
      }
      if (jumpTime > 0.0) {
         jumpTime = jumpTime - CGFloat(seconds)
         spriteComponent.node.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: (seconds * 25)))
      }
      if spriteComponent.node.physicsBody?.allContactedBodies().count > 0 {
         for body in (spriteComponent.node.physicsBody?.allContactedBodies())! {
            let nodeDir = ((body.node?.position)! - spriteComponent.node.position).angle
            if (nodeDir > -2.355 && nodeDir < -0.785) {
               isJumping = false
               animationComponent.requestedAnimationState = .Run
            }
         }
      }
      
   }
   
}