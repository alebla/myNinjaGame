//
//  GameScene.swift
//  myNinjaGame
//
//  Created by aB on 3/27/16.
//  Copyright (c) 2016 Dr3amStream. All rights reserved.
//

import SpriteKit

class GameScene: SGScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = lt("Language")
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(myLabel)
    }
    
    // Life cycle
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    //Responders
    
    override func screenInteractionStarted(location: CGPoint){
    }
    
    override func screenInteractionMoved(location: CGPoint){
        
    }
    
    override func screenInteractionEnded(location: CGPoint){
        
    }
    
    override func buttonEvent(event: String, velocity: Float, pushedOn: Bool){
        
    }
    
    override func stickEvent(event: String, point: CGPoint){
        
    }
}
