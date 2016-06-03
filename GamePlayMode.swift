//
//  GamePlayMode.swift
//  myNinjaGame
//
//  Created by aB on 4/8/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit
import GameplayKit

class GamePlayMode: SGScene, SKPhysicsContactDelegate {
   
   //MARK: Instance Variables
   
   let sndButtonClick = SKAction.playSoundFileNamed("button_click_1.wav", waitForCompletion: false)
   let jumpButtonSnd = SKAction.playSoundFileNamed("jump_1.wav", waitForCompletion: true)
   let impactSnd = SKAction.playSoundFileNamed("impact_1.wav", waitForCompletion: true)

   // Initial Data
   var characterIndex = 0
   var levelIndex = 0
   
   // Generators
   
   // Layers
   var worldLayer: TileLayer!
   var backgroundLayer: SKNode!
   var overlayGUI: SKNode!
   
   // State Machine
   lazy var stateMachine: GKStateMachine = GKStateMachine(states: [
      GameSceneInitialState(scene: self),
      GameSceneActiveState(scene: self),
      GameScenePausedState(scene: self),
      GameSceneVictorySeqState(scene: self),
      GameSceneWinState(scene: self),
      GameSceneLosesState(scene: self),
      ])
   
   // ECS
   var entities = Set<GKEntity>()
   
   // Component systems
   lazy var componentSystems: [GKComponentSystem] = {
      let parallaxSystem = GKComponentSystem(componentClass: ParallaxComponent.self)
      let animationSystem = GKComponentSystem(componentClass: AnimationComponent.self)
      return [parallaxSystem, animationSystem]
   }()
   let scrollerSystem = SideScrollComponentSystem(componentClass: SideScrollComponent.self)

   
   // Timers
   
   var lastUpdateTimeInterval: NSTimeInterval = 0
   let maximumUpdateDeltaTime: NSTimeInterval = 1.0 / 60.0
   var lastDeltaTime: NSTimeInterval = 0
   
   // Controls
   var control = ControlScheme()
   var pauseLoop = false
   
   // Sounds
   
   //Mark: Initializer
   override func didMoveToView(view: SKView) {
      stateMachine.enterState(GameSceneInitialState.self)
   }
   
   //MARK: Functions
   func addEntity(entity:GKEntity, toLayer layer: SKNode) {
      //add Entity to Set
      entities.insert(entity)
      
      //add Sprites to Scene
      if let spriteNode = entity.componentForClass(SpriteComponent.self)?.node {
         layer.addChild(spriteNode)
      }
      
      //add Components to System
      for componentSystem in self.componentSystems {
         componentSystem.addComponentWithEntity(entity)
      }
      scrollerSystem.addComponentWithEntity(entity)
   }
   
   //MARK: Life Cycle
   
   override func update(currentTime: NSTimeInterval) {
      
      if !pauseLoop {
         // Calculate delta time
         var deltaTime = currentTime - lastUpdateTimeInterval
         deltaTime = deltaTime > maximumUpdateDeltaTime ?
            maximumUpdateDeltaTime : deltaTime
         lastUpdateTimeInterval = currentTime
         
         // Update Components
         for componentSystem in componentSystems {
            componentSystem.updateWithDeltaTime(deltaTime)
         }
         scrollerSystem.updateWithDeltaTime(deltaTime, controlInput: control)
      }
   }
   
   //MARK: Responders
   override func screenInteractionStarted(location: CGPoint){
      if let node = nodeAtPoint(location) as? SKLabelNode {
         if node.name == "PauseButton" {
            if node.name == "PauseButton"{
               runAction(sndButtonClick)
            }
            if pauseLoop {
               stateMachine.enterState(GameSceneActiveState.self)
            } else {
               stateMachine.enterState(GameScenePausedState.self)
            }
            return
         }
      }
      runAction(jumpButtonSnd)
      control.jumpPressed = true
   }
   
   override func screenInteractionMoved(location: CGPoint){
      control.jumpPressed = false
   }
   
   override func screenInteractionEnded(location: CGPoint){
      control.jumpPressed = false
   }
   
   override func buttonEvent(event: String, velocity: Float, pushedOn: Bool){
      
   }
   
   override func stickEvent(event: String, point: CGPoint){
      
   }
   
   //MARK: Physics Delegate 
   
   func didBeginContact(contact: SKPhysicsContact) {
      
      if let bodyA = contact.bodyA.node as? EntityNode,
        let bodyAent = bodyA.entity as? SGEntity,
        let bodyB = contact.bodyB.node as? EntityNode,
        let bodyBent = bodyB.entity as? SGEntity
      {
         contactBegan(bodyAent, nodeB: bodyBent)
         contactBegan(bodyBent, nodeB: bodyAent)
      }
      
   }
   
   func contactBegan(nodeA: SGEntity, nodeB: SGEntity){
      nodeA.contactWith(nodeB)
   }
   
   //MARK: Camera Settings
   
   func setCameraConstraints() {
      guard let camera = camera else { return }
      
      if let player = worldLayer.childNodeWithName("playerNode") as? EntityNode {
         
         let zeroRange = SKRange(constantValue: 0.0)
         let playerNode = player
         let playerLocationConstraint = SKConstraint.distance(zeroRange, toNode: playerNode)
         
         let scaledSize = CGSize(width: SKMViewSize!.width * camera.xScale, height: SKMViewSize!.height * camera.yScale)
         
         let boardContentRect = worldLayer.calculateAccumulatedFrame()
         
         let xInset = min((scaledSize.width / 2), boardContentRect.width / 2)
         let yInset = min((scaledSize.height / 2), boardContentRect.height / 2)
         
         let insetContentRect = boardContentRect.insetBy(dx: xInset, dy: yInset)
         
         let xRange = SKRange(lowerLimit: insetContentRect.minX, upperLimit: insetContentRect.maxX)
         let yRange = SKRange(lowerLimit: insetContentRect.minY, upperLimit: insetContentRect.maxY)
         
         let levelEdgeConstraint = SKConstraint.positionX(xRange, y: yRange)
         levelEdgeConstraint.referenceNode = worldLayer
         
         camera.constraints = [playerLocationConstraint, levelEdgeConstraint]
      }
      
   }
   
   
   
   
   
}
