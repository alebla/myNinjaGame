//
//  TileLayer.swift
//  myNinjaGame
//
//  Created by aB on 4/10/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit
import GameplayKit

let randomSceneryArt = ["B1","B2","B3","B4","Mushroom_1","Mushroom_2","Stone","Tree_1","Tree_2","Tree_3"]

class TileLayer: SKNode, tileMapDelegate {
    
    var levelGenerator = tileMapBuilder()
    let randomScenery = GKRandomDistribution(forDieWithSideCount: randomSceneryArt.count)
    
    init(levelIndex: Int, typeIndex: setType) {
        super.init()
        
        levelGenerator.delegate = self
        
        levelGenerator.loadLevel(levelIndex, fromSet: typeIndex)
        levelGenerator.presentLayerViaDelegate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: tileMapDelegate
    
    func createNodeOf(type type: tileType, location: CGPoint) {
        //Load texture atlas
        let atlasTiles = SKTextureAtlas(named: "Tiles")
        
        //Handle each object
        switch type {
        case .tileAir:
            //Intentionally left blank
            break
        case .tileGroundLeft:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("1"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileGround:
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("2"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileGroundRight:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("3"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileWallLeft:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("4"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileGroundMiddle:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("5"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileWallRight:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("6"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
        case .tileGroundCornerR:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("7"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileGroundCornerRU:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("8"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileCeiling:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("9"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileGroundCornerLU:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("10"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileGroundCornerL:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("11"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileCeilingLeft:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("12"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tilePlatformLeft:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("13"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tilePlatform:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("14"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tilePlatformRight:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("15"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileCeilingRight:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("16"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileWaterSurface:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("17"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileWater:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("18"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileRandomScenery:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed(randomSceneryArt[randomScenery.nextInt() - 1]))
            node.xScale = 0.5
            node.yScale = 0.5
            node.anchorPoint = CGPoint(x: 0.5,y: 0.0)
            node.position = CGPoint(x: location.x, y: location.y - 16)
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileSignPost:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("Sign_1"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileSignArrow:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("Sign_2"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileCrate:
            
            let node = SKSpriteNode(texture: atlasTiles.textureNamed("Crate"))
            node.size = CGSize(width: 32, height: 32)
            node.position = location
            node.zPosition = GameSettings.GameParams.zValues.zWorld
            addChild(node)
            break
        case .tileGem:
            break
        case .tileStartLevel:
            break
        case .tileEndLevel:
            break
        default :
            break
        }
    }
    
}
