//
//  PlayerSortSelection.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 2/20/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import UIKit

class PlayerSortSelection: UIViewController {
    
    @IBOutlet weak var playersWillAppear: UILabel!
    @IBOutlet weak var playerSort0: UIButton!
    @IBOutlet weak var playerSort1: UIButton!
    @IBOutlet weak var playerSort2: UIButton!
    @IBOutlet weak var playerSort3: UIButton!
    @IBOutlet weak var playerSort4: UIButton!
    @IBOutlet weak var aReturnButton: UIButton!
    @IBOutlet weak var aReturnButton2: UIButton!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    // Set the sort order option button colors
    
    func setPlayerSortColorsOn(sortCode: String) {
        switch sortCode {
        case playerSortAlpha:
            playerSort0.setTitleColor(appColorBlack, for: .normal)
            playerSort0.backgroundColor = appColorBrightGreen
            playerSort1.setTitleColor(appColorGray, for: .normal)
            playerSort1.backgroundColor = appColorDarkGreen
            playerSort2.setTitleColor(appColorGray, for: .normal)
            playerSort2.backgroundColor = appColorDarkGreen
            playerSort3.setTitleColor(appColorGray, for: .normal)
            playerSort3.backgroundColor = appColorDarkGreen
            playerSort4.setTitleColor(appColorGray, for: .normal)
            playerSort4.backgroundColor = appColorDarkGreen
        case playerSortEntry:
            playerSort0.setTitleColor(appColorGray, for: .normal)
            playerSort0.backgroundColor = appColorDarkGreen
            playerSort1.setTitleColor(appColorBlack, for: .normal)
            playerSort1.backgroundColor = appColorBrightGreen
            playerSort2.setTitleColor(appColorGray, for: .normal)
            playerSort2.backgroundColor = appColorDarkGreen
            playerSort3.setTitleColor(appColorGray, for: .normal)
            playerSort3.backgroundColor = appColorDarkGreen
            playerSort4.setTitleColor(appColorGray, for: .normal)
            playerSort4.backgroundColor = appColorDarkGreen
        case playerSortDealer:
            playerSort0.setTitleColor(appColorGray, for: .normal)
            playerSort0.backgroundColor = appColorDarkGreen
            playerSort1.setTitleColor(appColorGray, for: .normal)
            playerSort1.backgroundColor = appColorDarkGreen
            playerSort2.setTitleColor(appColorBlack, for: .normal)
            playerSort2.backgroundColor = appColorBrightGreen
            playerSort3.setTitleColor(appColorGray, for: .normal)
            playerSort3.backgroundColor = appColorDarkGreen
            playerSort4.setTitleColor(appColorGray, for: .normal)
            playerSort4.backgroundColor = appColorDarkGreen
        case playerSortLowToHigh:
            playerSort0.setTitleColor(appColorGray, for: .normal)
            playerSort0.backgroundColor = appColorDarkGreen
            playerSort1.setTitleColor(appColorGray, for: .normal)
            playerSort1.backgroundColor = appColorDarkGreen
            playerSort2.setTitleColor(appColorGray, for: .normal)
            playerSort2.backgroundColor = appColorDarkGreen
            playerSort3.setTitleColor(appColorBlack, for: .normal)
            playerSort3.backgroundColor = appColorBrightGreen
            playerSort4.setTitleColor(appColorGray, for: .normal)
            playerSort4.backgroundColor = appColorDarkGreen
        case playerSortHighToLow:
            playerSort0.setTitleColor(appColorGray, for: .normal)
            playerSort0.backgroundColor = appColorDarkGreen
            playerSort1.setTitleColor(appColorGray, for: .normal)
            playerSort1.backgroundColor = appColorDarkGreen
            playerSort2.setTitleColor(appColorGray, for: .normal)
            playerSort2.backgroundColor = appColorDarkGreen
            playerSort3.setTitleColor(appColorGray, for: .normal)
            playerSort3.backgroundColor = appColorDarkGreen
            playerSort4.setTitleColor(appColorBlack, for: .normal)
            playerSort4.backgroundColor = appColorBrightGreen
        default:
            _ = ""
        }
    }
    
    @IBAction func aViewTutorialButton(_ sender: Any) {
        gdefault.helpCaller = helpSectionCodePlayerSortSelection
    }
    
    @IBAction func playerSort0(_ sender: Any) {
        // Change target sort control data area based on the originating view
        switch gdefault.playerSortDecisionDriverView {
        case "Defaults":
            gdefault.defaultsPlayerSort = playerSortAlpha
            setPlayerSortColorsOn(sortCode: gdefault.defaultsPlayerSort)
        case "TheGame":
            gdefault.gamesPlayerSort = playerSortAlpha
            setPlayerSortColorsOn(sortCode: gdefault.gamesPlayerSort)
        default:
            _ = ""
        }
    }
    
    @IBAction func playerSort1(_ sender: Any) {
        // Change target sort control data area based on the originating view
        switch gdefault.playerSortDecisionDriverView {
        case "Defaults":
            gdefault.defaultsPlayerSort = playerSortEntry
            setPlayerSortColorsOn(sortCode: gdefault.defaultsPlayerSort)
        case "TheGame":
            gdefault.gamesPlayerSort = playerSortEntry
            setPlayerSortColorsOn(sortCode: gdefault.gamesPlayerSort)
        default:
            _ = ""
        }
    }
    
    @IBAction func playerSort2(_ sender: Any) {
        // Change target sort control data area based on the originating view
        switch gdefault.playerSortDecisionDriverView {
        case "Defaults":
            gdefault.defaultsPlayerSort = playerSortDealer
            setPlayerSortColorsOn(sortCode: gdefault.defaultsPlayerSort)
        case "TheGame":
            gdefault.gamesPlayerSort = playerSortDealer
            setPlayerSortColorsOn(sortCode: gdefault.gamesPlayerSort)
        default:
            _ = ""
        }
    }
    
    @IBAction func playerSort3(_ sender: Any) {
        // Change target sort control data area based on the originating view
        switch gdefault.playerSortDecisionDriverView {
        case "Defaults":
            gdefault.defaultsPlayerSort = playerSortLowToHigh
            setPlayerSortColorsOn(sortCode: gdefault.defaultsPlayerSort)
        case "TheGame":
            gdefault.gamesPlayerSort = playerSortLowToHigh
            setPlayerSortColorsOn(sortCode: gdefault.gamesPlayerSort)
        default:
            _ = ""
        }
    }
    
    @IBAction func playerSort4(_ sender: Any) {
        // Change target sort control data area based on the originating view
        switch gdefault.playerSortDecisionDriverView {
        case "Defaults":
            gdefault.defaultsPlayerSort = playerSortHighToLow
            setPlayerSortColorsOn(sortCode: gdefault.defaultsPlayerSort)
        case "TheGame":
            gdefault.gamesPlayerSort = playerSortHighToLow
            setPlayerSortColorsOn(sortCode: gdefault.gamesPlayerSort)
        default:
            _ = ""
        }
    }
    
    // Just go back to Defaults, where the Games file will be updated
    @IBAction func aReturnButton(_ sender: Any) {
    }
    
    // Update the Games file here before returning to EditGame
    @IBAction func aReturnButton2(_ sender: Any) {
        
        // Save all global memory values in the Games file for the current
        // game

        // Get the offset of this game in the Games file
        let fileHandlePSSGamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
        let fileContent:String=String(data:fileHandlePSSGamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandlePSSGamesGet.closeFile()
        let gameFileSize = fileContent.count
        //print("PSS aRB2 original record=<\(fileContent)> len=\(gameFileSize)")
        //print("PSS aRB2 first find game record offset for game \(originalGameName)")
        
        var gameRecordOffset = 0
        while gameRecordOffset < gameFileSize {
            //print("PSS aRB2 scanning: offset is \(gameRecordOffset)")
            let tempGameRec = extractRecordField(recordIn: fileContent,  fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
            let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
            //print("PSS aRB2 comparing desired game \(originalGameName) vs. file game \(thisGameName)")
            if thisGameName == gdefault.gamesGameName {
                //print("PSS aRB2 found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                break
            }
            gameRecordOffset += gdefault.gamesRecordSize
        }
        
        // Update the record and recreate the file
        //print("PSS aRB2 now calling updateGamesFile with offset \(gameRecordOffset)")
        updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Initialize error message
        errorMessage.text = ""
        
        // Make the error message have bold text
        errorMessage.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)

        // Round the button corners
        playerSort0.layer.cornerRadius = cornerRadiusStdButton
        playerSort1.layer.cornerRadius = cornerRadiusStdButton
        playerSort2.layer.cornerRadius = cornerRadiusStdButton
        playerSort3.layer.cornerRadius = cornerRadiusStdButton
        playerSort4.layer.cornerRadius = cornerRadiusStdButton
        aReturnButton.layer.cornerRadius = cornerRadiusStdButton
        aReturnButton2.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton
        // Change sentence grammar based on the originating view
        switch gdefault.playerSortDecisionDriverView {
        case "Defaults":
            playersWillAppear.text = "players will appear in a game."
        case "TheGame":
            playersWillAppear.text = "players will appear in the game."
        default:
            _ = ""
        }
        
        // Set sort order button text
        
        playerSort0.setTitle(playerSortDescription[0], for: .normal)
        playerSort1.setTitle(playerSortDescription[1], for: .normal)
        playerSort2.setTitle(playerSortDescription[2], for: .normal)
        playerSort3.setTitle(playerSortDescription[3], for: .normal)
        playerSort4.setTitle(playerSortDescription[4], for: .normal)
        
        // Set sort selection button colors based on current setting
        switch gdefault.playerSortDecisionDriverView {
        case "Defaults":
            setPlayerSortColorsOn(sortCode: gdefault.defaultsPlayerSort)
        case "TheGame":
            setPlayerSortColorsOn(sortCode: gdefault.gamesPlayerSort)
        default:
            _ = ""
        }
    }
   
     override func viewWillAppear(_ animated: Bool) {
     
        refreshView()
         
         super.viewWillAppear(animated)
     } // End viewWillAppear
     
    func refreshView () {
        
        // Set up the two return buttons so that only one appears and is enabled
        switch gdefault.playerSortDecisionDriverView {
        case "Defaults":
            aReturnButton.isEnabled = true
            aReturnButton.setTitleColor(appColorYellow, for: .normal)
            aReturnButton.backgroundColor = appColorDarkGreen
            aReturnButton2.isEnabled = false
            aReturnButton2.setTitleColor(appColorClear, for: .normal)
            aReturnButton2.backgroundColor = appColorClear
        case "TheGame":
            aReturnButton.isEnabled = false
            aReturnButton.setTitleColor(appColorClear, for: .normal)
            aReturnButton.backgroundColor = appColorClear
            aReturnButton2.isEnabled = true
            aReturnButton2.setTitleColor(appColorYellow, for: .normal)
            aReturnButton2.backgroundColor = appColorDarkGreen
        default:
            _ = ""
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
