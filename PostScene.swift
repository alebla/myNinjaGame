//
//  PostScene.swift
//  myNinjaGame
//
//  Created by aB on 6/5/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import Foundation
import SpriteKit

class PostScreen: SGScene {
   
   var level: Int?
   var win: Bool?
   var gems: Int?
   
   override func didMoveToView(view: SKView) {
      layoutScene()
      saveStats()
   }
   
   func layoutScene() {
      
      let background = SKSpriteNode(imageNamed: "BG")
      background.posByCanvas(0.5, y: 0.5)
      background.xScale = 1.2
      background.yScale = 1.2
      background.zPosition = -1
      addChild(background)
      
      let nameBlock = SKLabelNode(fontNamed: "MarkerFelt-Wide")
      nameBlock.posByScreen(0.5, y: 0.5)
      nameBlock.fontColor = SKColor.whiteColor()
      nameBlock.fontSize = 64
      if (win != nil) {
         nameBlock.text = win! ? "You Passed!" : "You Failed"
      }
      addChild(nameBlock)
   }
   
   func saveStats() {
      
      if win! {
         NSUserDefaults.standardUserDefaults().setBool(true, forKey: "Level_\(level!)")
         if gems! > NSUserDefaults.standardUserDefaults().integerForKey("\(level!)gems") {
            NSUserDefaults.standardUserDefaults().setInteger(gems!, forKey: "\(level!)gems")
         }
         NSUserDefaults.standardUserDefaults().synchronize()
      }
   }
   
   override func screenInteractionStarted(location: CGPoint) {
      let nextScene = MainMenu(size: self.scene!.size)
      nextScene.scaleMode = self.scaleMode
      self.view?.presentScene(nextScene)
   }
   #if !os(OSX)
   override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
      let nextScene = MainMenu(size: self.scene!.size)
      nextScene.scaleMode = self.scaleMode
      self.view?.presentScene(nextScene)
   }
   #endif
}