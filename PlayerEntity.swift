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
   
   init(position: CGPoint, size: CGSize, firstFrame: SKTexture, atlas: SKTextureAtlas) {
      super.init()
      
      //Initialize Components
      spriteComponent = SpriteComponent(entity: self, texture: SKTexture(), size: size, position: position)
      addComponent(spriteComponent)
      animationComponent = AnimationComponent(node: spriteComponent.node, textureSize: size, animations: loadAnimations(atlas))
      addComponent(animationComponent)
   }
   
   func loadAnimations(textureAtlas: SKTextureAtlas) -> [AnimationState: Animation] {
      var animations = [AnimationState: Animation]()
      
      animations[.Run] = AnimationComponent.animationFromAtlas(textureAtlas,
         withImageIdentifier: AnimationState.Run.rawValue, forAnimationState: .Run)
      
      return animations
   }
   
   
}
