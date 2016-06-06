//
//  PlayModeStates.swift
//  myNinjaGame
//
//  Created by aB on 4/8/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class GameSceneState: GKState {
   unowned let gs: GamePlayMode
   init(scene: GamePlayMode) {
      self.gs = scene
   }
}

class GameSceneInitialState: GameSceneState {
   override func didEnterWithPreviousState(previousState: GKState?) {
      // Delegates
      gs.physicsWorld.contactDelegate = gs
      gs.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
      
      // Camera
      let myCamera = SKCameraNode()
      gs.camera = myCamera
      gs.addChild(myCamera)
      gs.camera?.setScale(0.44)
      
      // Layers
      
      gs.worldLayer = TileLayer(levelIndex: gs.levelIndex, typeIndex: .setMain)
      gs.addChild(gs.worldLayer)
      gs.backgroundLayer = SKNode()
      gs.overlayGUI = SKNode()
      myCamera.addChild(gs.backgroundLayer)
      myCamera.addChild(gs.overlayGUI)
      
      //Initial Entities
      let background01 = BackgroundEntity(movementFactor: CGPoint(x: -20.0, y: 0.0), image: SKTexture(imageNamed: "BG001"), size: SKMSceneSize!, position: CGPointZero, reset: true)
      background01.spriteComponent.node.zPosition = GameSettings.GameParams.zValues.zBackground01
      gs.addEntity(background01, toLayer: gs.backgroundLayer)
      let background02 = BackgroundEntity(movementFactor: CGPoint(x: -20.0, y: 0.0), image: SKTexture(imageNamed: "BG001"), size: SKMSceneSize!, position: CGPoint(x: SKMSceneSize!.width, y: 0), reset: true)
      background02.spriteComponent.node.zPosition = GameSettings.GameParams.zValues.zBackground01
      gs.addEntity(background02, toLayer: gs.backgroundLayer)
      let background03 = BackgroundEntity(movementFactor: CGPoint(x: -40.0, y: 0.0), image: SKTexture(imageNamed: "BG002"), size: SKMSceneSize!, position: CGPointZero, reset: true)
      background03.spriteComponent.node.zPosition = GameSettings.GameParams.zValues.zBackground02
      gs.addEntity(background03, toLayer: gs.backgroundLayer)
      let background04 = BackgroundEntity(movementFactor: CGPoint(x: -40.0, y: 0.0), image: SKTexture(imageNamed: "BG002"), size: SKMSceneSize!, position: CGPoint(x: SKMSceneSize!.width, y: 0), reset: true)
      background04.spriteComponent.node.zPosition = GameSettings.GameParams.zValues.zBackground02
      gs.addEntity(background04, toLayer: gs.backgroundLayer)
      let background05 = BackgroundEntity(movementFactor: CGPoint(x: -90.0, y: 0.0), image: SKTexture(imageNamed: "BG003"), size: SKMSceneSize!, position: CGPointZero, reset: true)
      background05.spriteComponent.node.zPosition = GameSettings.GameParams.zValues.zBackground03
      gs.addEntity(background05, toLayer: gs.backgroundLayer)
      let background06 = BackgroundEntity(movementFactor: CGPoint(x: -90.0, y: 0.0), image: SKTexture(imageNamed: "BG003"), size: SKMSceneSize!, position: CGPoint(x: SKMSceneSize!.width, y: 0), reset: true)
      background06.spriteComponent.node.zPosition = GameSettings.GameParams.zValues.zBackground03
      gs.addEntity(background06, toLayer: gs.backgroundLayer)
      
      let characters = ["Male", "Female"]
      let atlas = SKTextureAtlas(named: characters[gs.characterIndex])
      
      if let playerPlaceholder = gs.worldLayer.childNodeWithName("placeholder_StartPoint") {
         let player = PlayerEntity(position: playerPlaceholder.position, size: CGSize(width: 25.4,height: 48.0), firstFrame: atlas.textureNamed("Idle_000"), atlas: atlas, scene: gs)
         player.spriteComponent.node.anchorPoint = CGPoint(x:0.5, y:0.0)
         player.spriteComponent.node.zPosition = GameSettings.GameParams.zValues.zPlayer
         player.animationComponent.requestedAnimationState = .Run
         gs.centerCameraOnPoint(playerPlaceholder.position)
         gs.addEntity(player, toLayer: gs.worldLayer)
         gs.worldFrame = gs.worldLayer.calculateAccumulatedFrame()
         gs.setCameraConstraints()
      } else {
         fatalError("Play Mode: No placeholder for player!")
      }
      
      gs.worldLayer.enumerateChildNodesWithName("placeholder_FinishPoint") { (node, stop) -> Void in
         let finish = FinishEntity(position: node.position, size: CGSize(width: 32, height: 32), texture: SKTexture())
         self.gs.addEntity(finish, toLayer: self.gs.worldLayer)
      }
      
      let tileAtlas = SKTextureAtlas(named: "Tiles")
      gs.worldLayer.enumerateChildNodesWithName("placeholder_Gem") { (node, stop) -> Void in
         let gem = GemEntity(position: node.position, size: CGSize(width: 32, height: 32), texture: tileAtlas.textureNamed("gem"))
         gem.spriteComponent.node.zPosition = GameSettings.GameParams.zValues.zWorldFront
         self.gs.addEntity(gem, toLayer: self.gs.worldLayer)
      }
      
      let killZone = KillZoneEntity(position: gs.worldFrame.origin, size: CGSize(width: 20.0, height: gs.worldFrame.size.height), texture: SKTexture(noiseWithSmoothness: 0.5, size: CGSize(width: 20.0, height: gs.worldFrame.height), grayscale: true))
      killZone.spriteComponent.node.alpha = 0.5
      killZone.spriteComponent.node.zPosition = GameSettings.GameParams.zValues.zPlayer + 2
      killZone.spriteComponent.node.position = CGPoint(x: killZone.spriteComponent.node.position.x + (killZone.spriteComponent.node.size.width / 2), y: killZone.spriteComponent.node.position.y + (killZone.spriteComponent.node.size.height / 2))
      gs.addEntity(killZone, toLayer: gs.worldLayer)
      
      //Setup UI
      let pauseButton = SKLabelNode(fontNamed: "MarkerFelt-Wide")
      pauseButton.posByScreen(0.46, y: 0.42)
      pauseButton.fontSize = 80
      pauseButton.text = gs.lt("II")
      pauseButton.fontColor = SKColor.whiteColor()
      pauseButton.zPosition = 150
      pauseButton.name = "PauseButton"
      gs.overlayGUI.addChild(pauseButton)
      
   }
   
   override func willExitWithNextState(nextState: GKState) {
      
   }
}

class GameSceneActiveState: GameSceneState {
   
}

class GameScenePausedState: GameSceneState {
   
   override func didEnterWithPreviousState(previousState: GKState?) {
      gs.paused = true
      gs.pauseLoop = true
   }
   
   override func willExitWithNextState(nextState: GKState) {
      gs.runAction(gs.sndPause)
      gs.paused = false
      gs.pauseLoop = false
   }
   
}

class GameSceneVictorySeqState: GameSceneState {
   
}

class GameSceneWinState: GameSceneState {
   override func didEnterWithPreviousState(previousState: GKState?) {
      //TODO - temp link to main menu
      gs.runAction(gs.sndWin)
      let nextScene = PostScreen(size: gs.scene!.size)
      nextScene.level = gs.levelIndex
      nextScene.win = true
      nextScene.gems = gs.gemsCollected
      nextScene.scaleMode = gs.scaleMode
      gs.view?.presentScene(nextScene)
   }
}

class GameSceneLosesState: GameSceneState {
   override func didEnterWithPreviousState(previousState: GKState?) {
      gs.runAction(gs.sndDeathScreen)
      let nextScene = PostScreen(size: gs.scene!.size)
      nextScene.level = gs.levelIndex
      nextScene.win = false
      nextScene.gems = gs.gemsCollected
      nextScene.scaleMode = gs.scaleMode
      gs.view?.presentScene(nextScene)
   }
}

