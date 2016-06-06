//
//  SpriteComponent.swift
//  myNinjaGame
//
//  Created by aB on 5/8/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit
import GameplayKit

class EntityNode: SKSpriteNode  {
    weak var entity: GKEntity!
}

class SpriteComponent: GKComponent {
    
    let node: EntityNode
    
    init(entity: GKEntity, texture: SKTexture, size: CGSize, position: CGPoint) {
        node = EntityNode(texture: texture, color: SKColor.whiteColor(), size: size)
        node.position = position
        node.entity = entity
    }
    
}