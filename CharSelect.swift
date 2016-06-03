//
//  CharSelect.swift
//  myNinjaGame
//
//  Created by aB on 6/3/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit

class CharSelect: SGScene {
   
   override func didMoveToView(view: SKView) {
      
      let background = SKSpriteNode(imageNamed: "BG")
      background.posByCanvas(0.5, y: 0.5)
      background.xScale = 1.2
      background.yScale = 1.2
      background.zPosition = -1
      addChild(background)
      
      let nameBlock = SKLabelNode(fontNamed: "MarkerFelt-Wide")
      nameBlock.posByScreen(0.5, y: 0.9)
      nameBlock.fontColor = SKColor.whiteColor()
      nameBlock.fontSize = 54
      nameBlock.text = "Select A Character"
      addChild(nameBlock)
      
      //Characters
      
      let characters = ["Male", "Female"]
      let count = characters.count
      
      for (index, char) in characters.enumerate() {
         let atlas = SKTextureAtlas(named: char)
         
         let charNode = SKSpriteNode(texture: atlas.textureNamed("Idle__000"))
         let locX: Double = (1.0 / Double(count + 1))
         let location = locX + (locX * Double(index))
         charNode.posByScreen(CGFloat(location), y: 0.5)
         charNode.size = CGSize(width: 232, height: 439)
         charNode.xScale = 0.5
         charNode.yScale = 0.5
         charNode.name = "C\(index)"
         charNode.userData = ["Index": index]
         addChild(charNode)
         
         let nameBlock = SKLabelNode(fontNamed: "MarkerFelt-Wide")
         nameBlock.posByScreen(CGFloat(location), y: 0.25)
         nameBlock.fontColor = SKColor.whiteColor()
         nameBlock.fontSize = 32
         nameBlock.text = char
         addChild(nameBlock)
         
      }
      
   }
   
   override func screenInteractionStarted(location: CGPoint) {
      for node in nodesAtPoint(location) {
         if let nodeName = node.name {
            if nodeName.hasPrefix("C") {
               let nextScene = LevelSelect(size: self.scene!.size)
               nextScene.characterIndex = node.userData!["Index"] as! Int
               nextScene.scaleMode = self.scaleMode
               self.view?.presentScene(nextScene)
            }
         }
      }
   }
   
   
}