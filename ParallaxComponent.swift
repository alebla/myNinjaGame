//
//  ParallaxComponent.swift
//  myNinjaGame
//
//  Created by aB on 5/8/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit
import GameplayKit

class ParallaxComponent: GKComponent {
    
    var movementFactor = CGPointZero
    var pointOfOrigin = CGPointZero
    var resetLocation = false
    
    var spriteComponent: SpriteComponent {
        guard let spriteComponent = entity?.componentForClass(SpriteComponent.self) else { fatalError("SpriteComponent missing")}
        return spriteComponent
    }
    
    init(entity: GKEntity, movementFactor factor: CGPoint, spritePosition: CGPoint, reset: Bool) {
        super.init()
        
        movementFactor = factor
        pointOfOrigin = spritePosition
        resetLocation = reset
        
    }
    
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        super.updateWithDeltaTime(seconds)
        
        //Move Sprite
        spriteComponent.node.position += CGPoint(x: movementFactor.x * CGFloat(round(seconds * 1000) / 1000) , y: movementFactor.y * CGFloat(round(seconds * 1000) / 1000))
        
        //Check location
        if (spriteComponent.node.position.x <= (spriteComponent.node.size.width * -1)) && resetLocation == true {
            spriteComponent.node.position = CGPoint(x: spriteComponent.node.size.width - 2, y: 0)
        }
        
        //Add other directions if required
        
    }
    
    
    
}