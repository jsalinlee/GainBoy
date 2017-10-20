//
//  MainMenuStatusScene.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 10/18/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenuStatusScene: SKScene {
    let cam = SKCameraNode()
    var healthIcon = SKSpriteNode()
    var healthBar: [SKSpriteNode] = []
    var backHealthBar: [SKSpriteNode] = []
    var expIcon = SKSpriteNode()
    var expBar: [SKSpriteNode] = []
    var backExpBar: [SKSpriteNode] = []
    var goldIcon = SKSpriteNode()
    let textureAtlas = SKTextureAtlas(named: "PlayerStatus")
    
    func createHUDNodes(screenSize: CGSize) {
        print("Creating HUD nodes")
        let cameraOrigin = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        
        healthIcon = SKSpriteNode(texture: textureAtlas.textureNamed("health-icon"))
        healthIcon.size = CGSize(width: 32, height: 32)
        healthIcon.position = CGPoint(x: cameraOrigin.x - 85, y: cameraOrigin.y + 50)
        self.addChild(healthIcon)
        goldIcon = SKSpriteNode(texture: textureAtlas.textureNamed("gold-icon"))
        goldIcon.size = CGSize(width: 32, height: 32)
        goldIcon.position = CGPoint(x: cameraOrigin.x - 85, y: cameraOrigin.y - 40)
        self.addChild(goldIcon)

        for index in 0..<100 {
            var backHealthNode = SKSpriteNode()
            var healthNode = SKSpriteNode()
            if index == 0 {
                backHealthNode = SKSpriteNode(texture: textureAtlas.textureNamed("barBack-left"))
                healthNode = SKSpriteNode(texture: textureAtlas.textureNamed("barRed-left"))
            } else if index == 99 {
                backHealthNode = SKSpriteNode(texture: textureAtlas.textureNamed("barBack-right"))
                healthNode = SKSpriteNode(texture: textureAtlas.textureNamed("barRed-right"))
            } else {
                backHealthNode = SKSpriteNode(texture: textureAtlas.textureNamed("barBack-mid"))
                healthNode = SKSpriteNode(texture: textureAtlas.textureNamed("barRed-mid"))
            }
            backHealthNode.size = CGSize(width: 1.5, height: 10)
            healthNode.size = CGSize(width: 1.5, height: 10)
            
            let xPos = cameraOrigin.x + CGFloat(Double(index) * 1.5) - CGFloat(60)
            let yPos = cameraOrigin.y + CGFloat(50)
            backHealthNode.position = CGPoint(x: xPos, y: yPos)
            healthNode.position = CGPoint(x: xPos, y: yPos)
            healthBar.append(healthNode)
            self.addChild(backHealthNode)
            self.addChild(healthNode)
        }
        
        for index in 0..<100 {
            var backExpNode = SKSpriteNode()
            var expNode = SKSpriteNode()
            if index == 0 {
                backExpNode = SKSpriteNode(texture: textureAtlas.textureNamed("barBack-left"))
                expNode = SKSpriteNode(texture: textureAtlas.textureNamed("barBlue-left"))
            } else if index == 99 {
                backExpNode = SKSpriteNode(texture: textureAtlas.textureNamed("barBack-right"))
                expNode = SKSpriteNode(texture: textureAtlas.textureNamed("barBlue-right"))
            } else {
                backExpNode = SKSpriteNode(texture: textureAtlas.textureNamed("barBack-mid"))
                expNode = SKSpriteNode(texture: textureAtlas.textureNamed("barBlue-mid"))
            }
            backExpNode.size = CGSize(width: 1.5, height: 10)
            expNode.size = CGSize(width: 1.5, height: 10)
            
            let xPos = cameraOrigin.x + CGFloat(Double(index) * 1.5) - CGFloat(60)
            let yPos = cameraOrigin.y + CGFloat(5)
            backExpNode.position = CGPoint(x: xPos, y: yPos)
            expNode.position = CGPoint(x: xPos, y: yPos)
            expBar.append(expNode)
            self.addChild(backExpNode)
            self.addChild(expNode)
        }
    }
    
    func setHealthDisplay(newHealth: Int) {
        let fadeAction = SKAction.fadeAlpha(to: 0.0, duration: 0.3)
        for index in 0 ..< healthBar.count {
            if index < newHealth {
                healthBar[index].alpha = 1
            } else {
                healthBar[index].run(fadeAction)
            }
        }
    }
    
    func setExpDisplay(newExp: Int) {
        let fadeAction = SKAction.fadeAlpha(to: 0.0, duration: 0.3)
        for index in 0 ..< expBar.count {
            if index < newExp {
                expBar[index].alpha = 1
            } else {
                expBar[index].run(fadeAction)
            }
        }
    }
    
    override func didMove(to view: SKView) {
        self.camera = cam
        self.camera!.position = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        self.addChild(self.camera!)
        self.camera!.zPosition = 50
        print(self.camera!.position)
        self.createHUDNodes(screenSize: view.bounds.size)
        var background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        background.zPosition = -5
        background.size = CGSize(width: view.bounds.size.width * 2, height: view.bounds.size.height * 2)
        self.addChild(background)
    }
    
    override func update(_ currentTime: TimeInterval) {
        setHealthDisplay(newHealth: 80)
        setExpDisplay(newExp: 35)
    }
}
