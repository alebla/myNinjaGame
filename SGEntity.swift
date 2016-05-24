//
//  SGEntity.swift
//  myNinjaGame
//
//  Created by aB on 5/24/16.
//  Copyright © 2016 Dr3amStream. All rights reserved.
//

import SpriteKit
import GameplayKit

class SGEntity: GKEntity {
   
   var name = ""
   
   func contactWith(entity: SGEntity){
      //Overridden by subclass
   }
   
}