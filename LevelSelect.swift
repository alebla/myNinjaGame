//
//  LevelSelect.swift
//  myNinjaGame
//
//  Created by aB on 6/3/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit

class LevelSelect: SGScene {
   
   var characterIndex = 0
   
   override func didMoveToView(view: SKView) {
      let background = SKSpriteNode(imageNamed: "BG")
      background.posByCanvas(0.5, y: 0.5)
      background.xScale = 1.2
      background.yScale = 1.2
      background.zPosition = -1
      addChild(background)
      
      let nameBlock = SKLabelNode(fontNamed: "MarkerFelt-Wide")
      nameBlock.posByScreen(0.5, y: 0.9)
      nameBlock.zPosition  = -1
      nameBlock.text = "Choose a Level"
      nameBlock.fontColor = SKColor.whiteColor()
      nameBlock.fontSize = 54
      addChild(nameBlock)
      
      // Next and previous page
      
      //Show Levels
      showLevelsFrom(0)
      
   }
   
   func showLevelsFrom(index: Int) {
      
   }

   
   override func screenInteractionStarted(location: CGPoint) {
      //Todo
      
      let nextScene = GamePlayMode(size: self.scene!.size)
      nextScene.scaleMode = self.scaleMode
      self.view?.presentScene(nextScene, transition: SKTransition.fadeWithDuration(0.5))
   }
   
}
