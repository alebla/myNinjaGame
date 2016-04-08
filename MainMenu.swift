//
//  MainMenu.swift
//  myNinjaGame
//
//  Created by aB on 4/8/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit
#if os(OSX)
    import AppKit
#endif

class MainMenu: SGScene {
    
    let sndTitleDrop = SKAction.playSoundFileNamed("title_drop.wav", waitForCompletion: false)
    let sndButtonClick = SKAction.playSoundFileNamed("button_click.wav", waitForCompletion: false)
    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "BG")
        background.posByCanvas(0.5, y: 0.5)
        background.xScale = 1.2
        background.yScale = 1.2
        background.zPosition = -1
        addChild(background)
        
        let playButton = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        playButton.posByScreen(0.5, y: 0.3)
        playButton.fontSize = 56
        playButton.text = lt("Enter")
        playButton.fontColor = SKColor.whiteColor()
        playButton.zPosition = 10
        playButton.name = "playGame"
        addChild(playButton)
        
        let title = SKSpriteNode(imageNamed: "TOTSG01")
        title.posByCanvas(0.5, y: 1.5)
        title.xScale = 0.5
        title.yScale = 0.5
        title.zPosition = 15
        addChild(title)
        title.runAction(SKAction.sequence([SKAction.moveTo(CGPoint(screenX: 0.5, screenY: 0.7), duration: 1.2), sndTitleDrop]))
        
        #if os(OSX)
            let exitButton = SKLabelNode(fontNamed: "MarkerFelt-Wide")
            exitButton.posByScreen(0.5, y: 0.1)
            exitButton.fontSize = 56
            exitButton.text = lt("Exit")
            exitButton.fontColor = SKColor.whiteColor()
            exitButton.zPosition = 10
            exitButton.name = "exitGame"
            addChild(exitButton)
        #endif
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