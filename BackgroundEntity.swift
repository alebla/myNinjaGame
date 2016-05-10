//
//  BackgroundEntity.swift
//  myNinjaGame
//
//  Created by aB on 5/8/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit
import GameplayKit

class BackgroundEntity: GKEntity {
    
    var spriteComponent: SpriteComponent!
    
    
    init(movementFactor: CGPoint, image: SKTexture, size: CGSize, position: CGPoint, reset: Bool) {
        super.init()
        
        spriteComponent = SpriteComponent(entity: self, texture: image, size: size, position: position)
        addComponent(spriteComponent)
        let parallaxComponent = ParallaxComponent(entity: self, movementFactor: movementFactor, spritePosition: position, reset: reset)
        addComponent(parallaxComponent)
    }
    
}