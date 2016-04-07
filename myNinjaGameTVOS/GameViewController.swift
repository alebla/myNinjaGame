//
//  GameViewController.swift
//  myNinjaGameTVOS
//
//  Created by aB on 3/27/16.
//  Copyright (c) 2016 Dr3amStream. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    let scene = GameScene(size: CGSize(width: 1363, height: 768))
    var skView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        skView = self.view as! SKView
        
        if GameSettings.Debugging.ALL_TellMeStatus {
            skView.showsFPS = GameSettings.Debugging.ALL_ShowFrameRate
            skView.showsNodeCount = GameSettings.Debugging.ALL_ShowNodeCount
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}
