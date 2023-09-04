//
//  MainMenuScene.swift
//  Cheems Journey
//
//  Created by Donnie Tran on 9/2/23.
//

import SpriteKit

class MainMenu: SKScene{
    //MARK: -Properties
    var containerNode: SKSpriteNode!
    
    //MARK: -System
    override func didMove(to view: SKView) {
        setUpBG()
        setUpGround()
        setUpNode()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else {return}
        let node = atPoint(touch.location(in: self))
        
        if node.name == "play"{
            let scene = GameScene(size: size)
            scene.scaleMode = scaleMode
            view!.presentScene(scene, transition: .doorsOpenVertical(withDuration: 0.3))
        }else if node.name == "highscore"{
            setUpPanel()
        }else if node.name == "setting"{
            setUpSetting()
        }else if node.name == "container"{
            containerNode.removeFromParent()
        }else if node.name == "music"{
            let node = node as! SKSpriteNode
            SKTAudio.musicEnabled = !SKTAudio.musicEnabled
            node.texture = SKTexture(imageNamed: SKTAudio.musicEnabled ? "musicOn" : "musicOff")
        }else if node.name == "effect"{
            let node = node as! SKSpriteNode
            effectEnabled = !effectEnabled
            node.texture = SKTexture(imageNamed: effectEnabled ? "effectOn" : "effectOff")
        }else if node.name == "tutorial"{
            setUpTutorial()
        }
    }
    override func update(_ currentTime: TimeInterval) {
        moveGround()
    }
}

//MARK: -Configurations

extension MainMenu{
    func setUpBG(){
        let bgNode = SKSpriteNode(imageNamed: "background")
        bgNode.anchorPoint = .zero
        bgNode.position = .zero
        bgNode.zPosition = -1.0
        addChild(bgNode)
    }
    func setUpGround(){
        for i in 0...2{
            let groundNode = SKSpriteNode(imageNamed: "ground")
            groundNode.name = "ground"
            groundNode.anchorPoint = .zero
            groundNode.zPosition = 1.0
            groundNode.position = CGPoint(x: -CGFloat(i)*groundNode.frame.width, y:0.0)
            addChild(groundNode)
        }
    }
    func moveGround(){
        enumerateChildNodes(withName: "ground") { (node, _) in
            let node = node as! SKSpriteNode
            node.position.x -= 8.0
            
            if node.position.x < -self.frame.width{
                node.position.x += node.frame.width*2.0
            }
        }
    }
    func setUpNode() {
        let title = SKSpriteNode(imageNamed: "title")
        title.name = "title"
        title.zPosition = 10.0
        title.position = CGPoint(x: size.width/2.0, y: size.height/2.0 + title.frame.height + 300.0)
        addChild(title)
        
        let play = SKSpriteNode(imageNamed: "play")
        play.name = "play"
        play.setScale(0.85)
        play.zPosition = 10.0
        play.position = CGPoint(x: size.width/2.0, y: size.height/2.0 + play.frame.height + 50.0)
        addChild(play)
        
        let highscore = SKSpriteNode(imageNamed: "highscore")
        highscore.name = "highscore"
        highscore.setScale(0.85)
        highscore.zPosition = 10.0
        highscore.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
        addChild(highscore)
        
        let setting = SKSpriteNode(imageNamed: "setting")
        setting.name = "setting"
        setting.setScale(0.85)
        setting.zPosition = 10.0
        setting.position = CGPoint(x: size.width/2.0, y: size.height/2.0 - setting.size.height - 50.0)
        addChild(setting)
        
        let tutorial = SKSpriteNode(imageNamed: "tutorial")
        tutorial.name = "tutorial"
        tutorial.setScale(0.3)
        tutorial.zPosition = 25.0
        tutorial.position = CGPoint(x: size.width/2.0, y: size.height/4.0)
        addChild(tutorial)
        
    }
    func setUpPanel() {
        setUpContainer()
        
        let panel = SKSpriteNode(imageNamed: "panel")
        panel.setScale(1.5)
        panel.zPosition = 20.0
        panel.position = .zero
        containerNode.addChild(panel)
        
        //Highscore
        let x = -panel.frame.width/2.0 + 250.0
        let highscorelbl = SKLabelNode(fontNamed: "Krungthep")
        highscorelbl.text = "Highscore \(scoreGenerator.sharedInstance.getHighScore())"
        highscorelbl.horizontalAlignmentMode = .left
        highscorelbl.fontSize = 80.0
        highscorelbl.zPosition = 25.0
        highscorelbl.position = CGPoint(x: x, y: highscorelbl.frame.height/2.0 - 30.0)
        panel.addChild(highscorelbl)
        
        let scorelbl = SKLabelNode(fontNamed: "Krungthep")
        scorelbl.text = "Score \(scoreGenerator.sharedInstance.getScore())"
        scorelbl.horizontalAlignmentMode = .left
        scorelbl.fontSize = 80.0
        scorelbl.zPosition = 25.0
        scorelbl.position = CGPoint(x: x, y: -scorelbl.frame.height/2.0 - 30.0)
        panel.addChild(scorelbl)
    }
    
    func setUpContainer(){
        containerNode = SKSpriteNode()
        containerNode.name = "container"
        containerNode.zPosition = 15.0
        containerNode.color = .clear
        containerNode.size = size
        containerNode.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
        addChild(containerNode)
    }
    func setUpSetting() {
        setUpContainer()
        
        //Panel
        let panel = SKSpriteNode(imageNamed: "panel")
        panel.setScale(1.5)
        panel.zPosition = 20.0
        panel.position = .zero
        containerNode.addChild(panel)
        
        //Music
        let music = SKSpriteNode(imageNamed: SKTAudio.musicEnabled ? "musicOn" : "musicOff")
        music.name = "music"
        music.setScale(0.7)
        music.zPosition = 25.0
        music.position = CGPoint(x: -music.frame.width - 50.0, y: 0.0)
        panel.addChild(music)
        
        //Sound
        let sound = SKSpriteNode(imageNamed: effectEnabled ? "effectOn" : "effectOff")
        sound.name = "effect"
        sound.setScale(0.7)
        sound.zPosition = 25.0
        sound.position = CGPoint(x: music.frame.width + 50.0, y: 0.0)
        panel.addChild(sound)
        
    }
    func setUpTutorial(){
        setUpContainer()
        
        let tutorial = SKSpriteNode(imageNamed: "panel2")
        tutorial.setScale(1.5)
        tutorial.zPosition = 20.0
        tutorial.position = .zero
        containerNode.addChild(tutorial)
        
        //Tutorial
        let x = -tutorial.frame.width/2.0 + 250.0
        let description = SKLabelNode(fontNamed: "Krungthep")
        description.text = "How to play"
        description.horizontalAlignmentMode = .left
        description.fontSize = 60.0
        description.zPosition = 25.0
        description.position = CGPoint(x: x, y: description.frame.height/2.0 + 45.0)
        tutorial.addChild(description)
        
        let description2 = SKLabelNode(fontNamed: "Krungthep")
        description2.text = "-Try to run away from the screen border"
        description2.horizontalAlignmentMode = .left
        description2.fontSize = 20.0
        description2.zPosition = 25.0
        description2.position = CGPoint(x: x, y: -description2.frame.height/2.0 + 30.0)
        tutorial.addChild(description2)
        
        let description3 = SKLabelNode(fontNamed: "Krungthep")
        description3.text = "-Shrooms and Spikes are posoinous"
        description3.horizontalAlignmentMode = .left
        description3.fontSize = 20.0
        description3.zPosition = 25.0
        description3.position = CGPoint(x: x, y: -description3.frame.height/2.0)
        tutorial.addChild(description3)
        
        let description4 = SKLabelNode(fontNamed: "Krungthep")
        description4.text = "-You have 3 chances before the poison kill you"
        description4.horizontalAlignmentMode = .left
        description4.fontSize = 20.0
        description4.zPosition = 25.0
        description4.position = CGPoint(x: x, y: -description4.frame.height/2.0 - 30.0)
        tutorial.addChild(description4)
        
        let description5 = SKLabelNode(fontNamed: "Krungthep")
        description5.text = "-Coins will give you points"
        description5.horizontalAlignmentMode = .left
        description5.fontSize = 20.0
        description5.zPosition = 25.0
        description5.position = CGPoint(x: x, y: -description5.frame.height/2.0 - 60.0)
        tutorial.addChild(description5)
        
        let description6 = SKLabelNode(fontNamed: "Krungthep")
        description6.text = "-Cheems will roll faster by time"
        description6.horizontalAlignmentMode = .left
        description6.fontSize = 20.0
        description6.zPosition = 25.0
        description6.position = CGPoint(x: x, y: -description6.frame.height/2.0 - 90.0)
        tutorial.addChild(description6)
    }
}
