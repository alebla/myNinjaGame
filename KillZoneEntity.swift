//
//  KillZoneEntity.swift
//  myNinjaGame
//
//  Created by aB on 6/5/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit
import GameplayKit

class KillZoneEntity: SGEntity {
   
   var spriteComponent: SpriteComponent!
   var physicsComponent: PhysicsComponent!
   var scrollerComponent: ChaseScrollComponent!
   
   init(position: CGPoint, size: CGSize, texture: SKTexture) {
      super.init()
      
      // Initialize Components 
      spriteComponent = SpriteComponent(entity: self, texture: texture, size: size, position: position)
      addComponent(spriteComponent)
      physicsComponent = PhysicsComponent(entity: self, bodySize: CGSize(width: spriteComponent.node.size.width * 0.8, height: spriteComponent.node.size.height * 0.8), bodyShape: .square, rotation: false)
      physicsComponent.setCategoryBitmask(ColliderType.KillZone.rawValue, dynamic: false)
      physicsComponent.setPhysicsCollisions(ColliderType.None.rawValue)
      physicsComponent.setPhysicsContacts(ColliderType.Player.rawValue)
      addComponent(physicsComponent)
      scrollerComponent = ChaseScrollComponent(entity: self)
      addComponent(scrollerComponent)
      
      //Final setup of components
      spriteComponent.node.physicsBody = physicsComponent.physicsBody
      spriteComponent.node.name = "killZoneNode"
      name = "killZoneEntity"
   }
   
}