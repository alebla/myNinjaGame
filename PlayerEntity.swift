//
//  PlayerEntity.swift
//  myNinjaGame
//
//  Created by aB on 5/8/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayerEntity: SGEntity  {
   
   var spriteComponent: SpriteComponent!
   var animationComponent: AnimationComponent!
   var physicsComponent: PhysicsComponent!
   var scrollerComponent: SideScrollComponent!
   
   var gameScene: GamePlayMode!
   
   init(position: CGPoint, size: CGSize, firstFrame: SKTexture, atlas: SKTextureAtlas, scene: GamePlayMode) {
      super.init()
      
      gameScene = scene
      
      //Initialize Components
      spriteComponent = SpriteComponent(entity: self, texture: SKTexture(), size: size, position: position)
      addComponent(spriteComponent)
      animationComponent = AnimationComponent(node: spriteComponent.node, animations: loadAnimations(atlas))
      addComponent(animationComponent)
      
      physicsComponent = PhysicsComponent(entity: self, bodySize: CGSize(width: spriteComponent.node.size.width * 0.8, height: spriteComponent.node.size.height * 0.8), bodyShape: .squareOffset, rotation: false)
      physicsComponent.setCategoryBitmask(ColliderType.Player.rawValue, dynamic: true)
      physicsComponent.setPhysicsCollisions(ColliderType.Wall.rawValue | ColliderType.Destroyable.rawValue)
      physicsComponent.setPhysicsContacts(ColliderType.Collectable.rawValue | ColliderType.EndLevel.rawValue | ColliderType.KillZone.rawValue)
      addComponent(physicsComponent)
      
      scrollerComponent = SideScrollComponent(entity: self)
      addComponent(scrollerComponent)
      
      spriteComponent.node.physicsBody = physicsComponent.physicsBody
      spriteComponent.node.name = "playerNode"
      
      name = "playerEntity"
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
   
   override func updateWithDeltaTime(seconds: NSTimeInterval) {
      super.updateWithDeltaTime(seconds)
      
      if !gameScene.worldFrame.contains(spriteComponent.node.position) {
         playerDied()
      }
   }
   
   override func contactWith(entity: SGEntity) {
      if entity.name == "finishEntity" {
         gameScene.runAction(gameScene.sndWin)
         gameScene.stateMachine.enterState(GameSceneWinState.self)
      }
      
      if entity.name == "gemEntity" {
         if let spriteComponent = entity.componentForClass(SpriteComponent.self) {
            spriteComponent.node.removeFromParent()
            gameScene.gemsCollected += 1
            gameScene.runAction(gameScene.sndCollectGood)
         }
      }
      
      if entity.name == "killZoneEntity" {
         playerDied()
         gameScene.runAction(gameScene.sndDeathScreen)
      }
      
   }
   
   func playerDied() {
      
      gameScene.stateMachine.enterState(GameSceneLosesState.self)
   }
   
}
