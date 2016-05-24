//
//  PlayerEntity.swift
//  myNinjaGame
//
//  Created by aB on 5/8/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayerEntity: GKEntity {
   
   var spriteComponent: SpriteComponent!
   var animationComponent: AnimationComponent!
   var physicsComponent: PhysicsComponent!
   var scrollerComponent: SideScrollComponent!
   
   init(position: CGPoint, size: CGSize, firstFrame: SKTexture, atlas: SKTextureAtlas) {
      super.init()
      
      //Initialize Components
      spriteComponent = SpriteComponent(entity: self, texture: SKTexture(), size: size, position: position)
      addComponent(spriteComponent)
      animationComponent = AnimationComponent(node: spriteComponent.node, animations: loadAnimations(atlas))
      addComponent(animationComponent)
      
      physicsComponent = PhysicsComponent(entity: self, bodySize: CGSize(width: spriteComponent.node.size.width * 0.8, height: spriteComponent.node.size.height * 0.8), bodyShape: .squareOffset, rotation: false)
      physicsComponent.setCategoryBitmask(ColliderType.Player.rawValue, dynamic: true)
      physicsComponent.setPhysicsCollisions(ColliderType.Wall.rawValue | ColliderType.Destroyable.rawValue)
      physicsComponent.setPhysicsContacts(ColliderType.Collectable.rawValue | ColliderType.EndLevel.rawValue)
      addComponent(physicsComponent)
      
      scrollerComponent = SideScrollComponent(entity: self)
      addComponent(scrollerComponent)
      
      spriteComponent.node.physicsBody = physicsComponent.physicsBody
      spriteComponent.node.name = "playerNode"
   }
   
   func loadAnimations(textureAtlas: SKTextureAtlas) -> [AnimationState: Animation] {
      var animations = [AnimationState: Animation]()
      
      animations[.Jump] = AnimationComponent.animationFromAtlas(textureAtlas,
         withImageIdentifier: AnimationState.Jump.rawValue,
         forAnimationState: .Jump, repeatTexturesForever: false, textureSize: CGSize(width: 40.1, height: 48.0))
      animations[.Run] = AnimationComponent.animationFromAtlas(textureAtlas,
         withImageIdentifier: AnimationState.Run.rawValue,
         forAnimationState: .Run, repeatTexturesForever: true, textureSize: CGSize(width: 37.93, height: 48.0))
      animations[.IdleThrow] = AnimationComponent.animationFromAtlas(textureAtlas,
         withImageIdentifier: AnimationState.IdleThrow.rawValue,
         forAnimationState: .IdleThrow, repeatTexturesForever: false, textureSize: CGSize(width: 40.1, height: 48.0))
      
      return animations
   }
   
   
}
