//
//  GameScene.swift
//  myNinjaGame
//
//  Created by aB on 3/27/16.
//  Copyright (c) 2016 Dr3amStream. All rights reserved.
//

import SpriteKit

class GameScene: SGScene {
    override func didMoveToView(view: SKView){
        
        // Start Background Music
        SKTAudio.sharedInstance().playBackgroundMusic("bckground_music.mp3")
        SKTAudio.sharedInstance().backgroundMusicPlayer?.volume = 0.4
        
        //Transition to Main Menu
        let nextScene = MainMenu(size: self.scene!.size)
        nextScene.scaleMode = self.scaleMode
        self.view?.presentScene(nextScene)
        
    }
}
