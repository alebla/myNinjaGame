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
   var levelLayer = SKNode()
   
   
   override func didMoveToView(view: SKView) {
      let background = SKSpriteNode(imageNamed: "BG")
      background.posByCanvas(0.5, y: 0.5)
      background.xScale = 1.2
      background.yScale = 1.2
      background.zPosition = -1
      addChild(background)
      
      let nameBlock = SKLabelNode(fontNamed: "MarkerFelt-Wide")
      nameBlock.posByScreen(0.5, y: 0.9)
      nameBlock.text = "Select a Level"
      nameBlock.fontColor = SKColor.whiteColor()
      nameBlock.fontSize = 54
      nameBlock.zPosition = 1
      addChild(nameBlock)
      
      // Next and previous page
      
      //Show Levels
      showLevelsFrom(0)
      
   }
   
   func showLevelsFrom(index: Int) {
      
      for node in levelLayer.children {
         node.removeFromParent()
      }
      
      let gridSize = CGSize(width: 3, height: 2)
      let gridSpacing = CGSize(width: 160, height: -120)
      let gridStart = CGPoint(screenX: 0.1, screenY: 0.75)
      // var gridIndex = 0
      
      var currentX = 0
      var currentY = 0
      var lastAvail = false
      
      for (index, level) in tileMapLevels.MainSet.enumerate() {
         var available: Bool
         if !(index == 0) {
            available = NSUserDefaults.standardUserDefaults().boolForKey("Level_\(index)")
         } else {
            available = true
         }
         
         let sign = SKSpriteNode(texture: SKTexture(imageNamed: "Sign_1"))
         sign.position = CGPoint(x:  gridStart.x + (gridSpacing.width * CGFloat(currentX)), y:  gridStart.y + (gridSpacing.height * CGFloat(currentY)))
         sign.size = CGSize(width: 75.6, height: 78)
         sign.zPosition = 20
         sign.userData = ["Index": index, "Available": (available || lastAvail)]
         sign.name = "LevelSign"
         addChild(sign)
         
         
         let signText = SKLabelNode(fontNamed: "MarkerFelt-Wide")
         signText.position = sign.position
         signText.fontColor = SKColor.whiteColor()
         signText.fontSize = 32
         signText.zPosition = 21
         signText.text = (available || lastAvail) ? "\(index + 1)" : "X"
         addChild(signText)
         
         var gems = NSUserDefaults.standardUserDefaults().integerForKey("\(index)gems") as Int
         
         repeat {
            let gem = SKSpriteNode(imageNamed: "gem")
            gem.size = CGSize(width: 22, height: 22)
            gem.position = CGPoint(x: (-(sign.size.width / 3) + ((sign.size.width / 3) * CGFloat(gems))) as CGFloat , y: 0.0)
            gem.zPosition = 22
            sign.addChild(gem)
            gems--
         } while gems > 0
         
         currentX++
         if currentX > Int(gridSize.width) {
            currentX = 0
            currentY++
         }
         if available {
            lastAvail = true
         }else {
            lastAvail = false
         }
      }
   }

   
   override func screenInteractionStarted(location: CGPoint) {
      for node in nodesAtPoint(location) {
         if let theNode: SKNode = node,
            let nodeName = theNode.name {
            if nodeName == "LevelSign" {
               if theNode.userData!["Available"] as! Bool == true {
                  let nextScene = GamePlayMode(size: self.scene!.size)
                  nextScene.characterIndex = self.characterIndex
                  nextScene.levelIndex = (theNode.userData!["Index"] as? Int)!
                  nextScene.scaleMode = self.scaleMode
                  self.view?.presentScene(nextScene)
               }
            }
         }
      }
   }
   
}
