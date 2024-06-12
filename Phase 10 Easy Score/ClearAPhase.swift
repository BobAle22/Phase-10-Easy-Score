//
//  ClearAPhase.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 5/2/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
// 

import UIKit

class ClearAPhase: UIViewController {

    @IBOutlet weak var phase1NameButton: UIButton!
    @IBOutlet weak var phase1Check: UILabel!
    @IBOutlet weak var phase2NameButton: UIButton!
    @IBOutlet weak var phase2Check: UILabel!
    @IBOutlet weak var phase3NameButton: UIButton!
    @IBOutlet weak var phase3Check: UILabel!
    @IBOutlet weak var phase4NameButton: UIButton!
    @IBOutlet weak var phase4Check: UILabel!
    @IBOutlet weak var phase5NameButton: UIButton!
    @IBOutlet weak var phase5Check: UILabel!
    @IBOutlet weak var phase6NameButton: UIButton!
    @IBOutlet weak var phase6Check: UILabel!
    @IBOutlet weak var phase7NameButton: UIButton!
    @IBOutlet weak var phase7Check: UILabel!
    @IBOutlet weak var phase8NameButton: UIButton!
    @IBOutlet weak var phase8Check: UILabel!
    @IBOutlet weak var phase9NameButton: UIButton!
    @IBOutlet weak var phase9Check: UILabel!
    @IBOutlet weak var phase10NameButton: UIButton!
    @IBOutlet weak var phase10Check: UILabel!
    @IBOutlet weak var checkmarkLegend: UILabel!
    @IBOutlet weak var clearPhaseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    // Identifies which phase (if any) was tapped
    var tappedPhase = 0
    
    // Controls whether or not user is allowed to exit (via the Choose button)
    var allowExitFromView = false
    
    // Used in conjunction with allowExitFromView -- specifically to allow
    // access to the help screen
    var continueToHelp = false
    
    // History data being logged for a phase or point change
    var logHistoryData = ""
   
    @IBAction func phase1NameButton(_ sender: Any) {
        phase1NameButton.setTitleColor(appColorBlack, for: .normal)
        phase1NameButton.backgroundColor = appColorBrightGreen
        phase2NameButton.setTitleColor(appColorGray, for: .normal)
        phase2NameButton.backgroundColor = appColorDarkGreen
        phase3NameButton.setTitleColor(appColorGray, for: .normal)
        phase3NameButton.backgroundColor = appColorDarkGreen
        phase4NameButton.setTitleColor(appColorGray, for: .normal)
        phase4NameButton.backgroundColor = appColorDarkGreen
        phase5NameButton.setTitleColor(appColorGray, for: .normal)
        phase5NameButton.backgroundColor = appColorDarkGreen
        phase6NameButton.setTitleColor(appColorGray, for: .normal)
        phase6NameButton.backgroundColor = appColorDarkGreen
        phase7NameButton.setTitleColor(appColorGray, for: .normal)
        phase7NameButton.backgroundColor = appColorDarkGreen
        phase8NameButton.setTitleColor(appColorGray, for: .normal)
        phase8NameButton.backgroundColor = appColorDarkGreen
        phase9NameButton.setTitleColor(appColorGray, for: .normal)
        phase9NameButton.backgroundColor = appColorDarkGreen
        phase10NameButton.setTitleColor(appColorGray, for: .normal)
        phase10NameButton.backgroundColor = appColorDarkGreen
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            tappedPhase = 1
        case evenPhasesCode:
            tappedPhase = 2
        case oddPhasesCode:
            tappedPhase = 1
        default:
            _ = ""
        }
    }
    @IBAction func phase2NameButton(_ sender: Any) {
        phase1NameButton.setTitleColor(appColorGray, for: .normal)
        phase1NameButton.backgroundColor = appColorDarkGreen
        phase2NameButton.setTitleColor(appColorBlack, for: .normal)
        phase2NameButton.backgroundColor = appColorBrightGreen
        phase3NameButton.setTitleColor(appColorGray, for: .normal)
        phase3NameButton.backgroundColor = appColorDarkGreen
        phase4NameButton.setTitleColor(appColorGray, for: .normal)
        phase4NameButton.backgroundColor = appColorDarkGreen
        phase5NameButton.setTitleColor(appColorGray, for: .normal)
        phase5NameButton.backgroundColor = appColorDarkGreen
        phase6NameButton.setTitleColor(appColorGray, for: .normal)
        phase6NameButton.backgroundColor = appColorDarkGreen
        phase7NameButton.setTitleColor(appColorGray, for: .normal)
        phase7NameButton.backgroundColor = appColorDarkGreen
        phase8NameButton.setTitleColor(appColorGray, for: .normal)
        phase8NameButton.backgroundColor = appColorDarkGreen
        phase9NameButton.setTitleColor(appColorGray, for: .normal)
        phase9NameButton.backgroundColor = appColorDarkGreen
        phase10NameButton.setTitleColor(appColorGray, for: .normal)
        phase10NameButton.backgroundColor = appColorDarkGreen
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            tappedPhase = 2
        case evenPhasesCode:
            tappedPhase = 4
        case oddPhasesCode:
            tappedPhase = 3
        default:
            _ = ""
        }
    }
    @IBAction func phase3NameButton(_ sender: Any) {
        phase1NameButton.setTitleColor(appColorGray, for: .normal)
        phase1NameButton.backgroundColor = appColorDarkGreen
        phase2NameButton.setTitleColor(appColorGray, for: .normal)
        phase2NameButton.backgroundColor = appColorDarkGreen
        phase3NameButton.setTitleColor(appColorBlack, for: .normal)
        phase3NameButton.backgroundColor = appColorBrightGreen
        phase4NameButton.setTitleColor(appColorGray, for: .normal)
        phase4NameButton.backgroundColor = appColorDarkGreen
        phase5NameButton.setTitleColor(appColorGray, for: .normal)
        phase5NameButton.backgroundColor = appColorDarkGreen
        phase6NameButton.setTitleColor(appColorGray, for: .normal)
        phase6NameButton.backgroundColor = appColorDarkGreen
        phase7NameButton.setTitleColor(appColorGray, for: .normal)
        phase7NameButton.backgroundColor = appColorDarkGreen
        phase8NameButton.setTitleColor(appColorGray, for: .normal)
        phase8NameButton.backgroundColor = appColorDarkGreen
        phase9NameButton.setTitleColor(appColorGray, for: .normal)
        phase9NameButton.backgroundColor = appColorDarkGreen
        phase10NameButton.setTitleColor(appColorGray, for: .normal)
        phase10NameButton.backgroundColor = appColorDarkGreen
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            tappedPhase = 3
        case evenPhasesCode:
            tappedPhase = 6
        case oddPhasesCode:
            tappedPhase = 5
        default:
            _ = ""
        }
    }
    @IBAction func phase4NameButton(_ sender: Any) {
        phase1NameButton.setTitleColor(appColorGray, for: .normal)
        phase1NameButton.backgroundColor = appColorDarkGreen
        phase2NameButton.setTitleColor(appColorGray, for: .normal)
        phase2NameButton.backgroundColor = appColorDarkGreen
        phase3NameButton.setTitleColor(appColorGray, for: .normal)
        phase3NameButton.backgroundColor = appColorDarkGreen
        phase4NameButton.setTitleColor(appColorBlack, for: .normal)
        phase4NameButton.backgroundColor = appColorBrightGreen
        phase5NameButton.setTitleColor(appColorGray, for: .normal)
        phase5NameButton.backgroundColor = appColorDarkGreen
        phase6NameButton.setTitleColor(appColorGray, for: .normal)
        phase6NameButton.backgroundColor = appColorDarkGreen
        phase7NameButton.setTitleColor(appColorGray, for: .normal)
        phase7NameButton.backgroundColor = appColorDarkGreen
        phase8NameButton.setTitleColor(appColorGray, for: .normal)
        phase8NameButton.backgroundColor = appColorDarkGreen
        phase9NameButton.setTitleColor(appColorGray, for: .normal)
        phase9NameButton.backgroundColor = appColorDarkGreen
        phase10NameButton.setTitleColor(appColorGray, for: .normal)
        phase10NameButton.backgroundColor = appColorDarkGreen
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            tappedPhase = 4
        case evenPhasesCode:
            tappedPhase = 8
        case oddPhasesCode:
            tappedPhase = 7
        default:
            _ = ""
        }
    }
    @IBAction func phase5NameButton(_ sender: Any) {
        phase1NameButton.setTitleColor(appColorGray, for: .normal)
        phase1NameButton.backgroundColor = appColorDarkGreen
        phase2NameButton.setTitleColor(appColorGray, for: .normal)
        phase2NameButton.backgroundColor = appColorDarkGreen
        phase3NameButton.setTitleColor(appColorGray, for: .normal)
        phase3NameButton.backgroundColor = appColorDarkGreen
        phase4NameButton.setTitleColor(appColorGray, for: .normal)
        phase4NameButton.backgroundColor = appColorDarkGreen
        phase5NameButton.setTitleColor(appColorBlack, for: .normal)
        phase5NameButton.backgroundColor = appColorBrightGreen
        phase6NameButton.setTitleColor(appColorGray, for: .normal)
        phase6NameButton.backgroundColor = appColorDarkGreen
        phase7NameButton.setTitleColor(appColorGray, for: .normal)
        phase7NameButton.backgroundColor = appColorDarkGreen
        phase8NameButton.setTitleColor(appColorGray, for: .normal)
        phase8NameButton.backgroundColor = appColorDarkGreen
        phase9NameButton.setTitleColor(appColorGray, for: .normal)
        phase9NameButton.backgroundColor = appColorDarkGreen
        phase10NameButton.setTitleColor(appColorGray, for: .normal)
        phase10NameButton.backgroundColor = appColorDarkGreen
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            tappedPhase = 5
        case evenPhasesCode:
            tappedPhase = 10
        case oddPhasesCode:
            tappedPhase = 9
        default:
            _ = ""
        }
    }
    @IBAction func phase6NameButton(_ sender: Any) {
        phase1NameButton.setTitleColor(appColorGray, for: .normal)
        phase1NameButton.backgroundColor = appColorDarkGreen
        phase2NameButton.setTitleColor(appColorGray, for: .normal)
        phase2NameButton.backgroundColor = appColorDarkGreen
        phase3NameButton.setTitleColor(appColorGray, for: .normal)
        phase3NameButton.backgroundColor = appColorDarkGreen
        phase4NameButton.setTitleColor(appColorGray, for: .normal)
        phase4NameButton.backgroundColor = appColorDarkGreen
        phase5NameButton.setTitleColor(appColorGray, for: .normal)
        phase5NameButton.backgroundColor = appColorDarkGreen
        phase6NameButton.setTitleColor(appColorBlack, for: .normal)
        phase6NameButton.backgroundColor = appColorBrightGreen
        phase7NameButton.setTitleColor(appColorGray, for: .normal)
        phase7NameButton.backgroundColor = appColorDarkGreen
        phase8NameButton.setTitleColor(appColorGray, for: .normal)
        phase8NameButton.backgroundColor = appColorDarkGreen
        phase9NameButton.setTitleColor(appColorGray, for: .normal)
        phase9NameButton.backgroundColor = appColorDarkGreen
        phase10NameButton.setTitleColor(appColorGray, for: .normal)
        phase10NameButton.backgroundColor = appColorDarkGreen
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            tappedPhase = 6
        case evenPhasesCode:
            tappedPhase = 0
        case oddPhasesCode:
            tappedPhase = 0
        default:
            _ = ""
        }
    }
    @IBAction func phase7NameButton(_ sender: Any) {
        phase1NameButton.setTitleColor(appColorGray, for: .normal)
        phase1NameButton.backgroundColor = appColorDarkGreen
        phase2NameButton.setTitleColor(appColorGray, for: .normal)
        phase2NameButton.backgroundColor = appColorDarkGreen
        phase3NameButton.setTitleColor(appColorGray, for: .normal)
        phase3NameButton.backgroundColor = appColorDarkGreen
        phase4NameButton.setTitleColor(appColorGray, for: .normal)
        phase4NameButton.backgroundColor = appColorDarkGreen
        phase5NameButton.setTitleColor(appColorGray, for: .normal)
        phase5NameButton.backgroundColor = appColorDarkGreen
        phase6NameButton.setTitleColor(appColorGray, for: .normal)
        phase6NameButton.backgroundColor = appColorDarkGreen
        phase7NameButton.setTitleColor(appColorBlack, for: .normal)
        phase7NameButton.backgroundColor = appColorBrightGreen
        phase8NameButton.setTitleColor(appColorGray, for: .normal)
        phase8NameButton.backgroundColor = appColorDarkGreen
        phase9NameButton.setTitleColor(appColorGray, for: .normal)
        phase9NameButton.backgroundColor = appColorDarkGreen
        phase10NameButton.setTitleColor(appColorGray, for: .normal)
        phase10NameButton.backgroundColor = appColorDarkGreen
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            tappedPhase = 7
        case evenPhasesCode:
            tappedPhase = 0
        case oddPhasesCode:
            tappedPhase = 0
        default:
            _ = ""
        }
    }
    @IBAction func phase8NameButton(_ sender: Any) {
        phase1NameButton.setTitleColor(appColorGray, for: .normal)
        phase1NameButton.backgroundColor = appColorDarkGreen
        phase2NameButton.setTitleColor(appColorGray, for: .normal)
        phase2NameButton.backgroundColor = appColorDarkGreen
        phase3NameButton.setTitleColor(appColorGray, for: .normal)
        phase3NameButton.backgroundColor = appColorDarkGreen
        phase4NameButton.setTitleColor(appColorGray, for: .normal)
        phase4NameButton.backgroundColor = appColorDarkGreen
        phase5NameButton.setTitleColor(appColorGray, for: .normal)
        phase5NameButton.backgroundColor = appColorDarkGreen
        phase6NameButton.setTitleColor(appColorGray, for: .normal)
        phase6NameButton.backgroundColor = appColorDarkGreen
        phase7NameButton.setTitleColor(appColorGray, for: .normal)
        phase7NameButton.backgroundColor = appColorDarkGreen
        phase8NameButton.setTitleColor(appColorBlack, for: .normal)
        phase8NameButton.backgroundColor = appColorBrightGreen
        phase9NameButton.setTitleColor(appColorGray, for: .normal)
        phase9NameButton.backgroundColor = appColorDarkGreen
        phase10NameButton.setTitleColor(appColorGray, for: .normal)
        phase10NameButton.backgroundColor = appColorDarkGreen
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            tappedPhase = 8
        case evenPhasesCode:
            tappedPhase = 0
        case oddPhasesCode:
            tappedPhase = 0
        default:
            _ = ""
        }
    }
    @IBAction func phase9NameButton(_ sender: Any) {
        phase1NameButton.setTitleColor(appColorGray, for: .normal)
        phase1NameButton.backgroundColor = appColorDarkGreen
        phase2NameButton.setTitleColor(appColorGray, for: .normal)
        phase2NameButton.backgroundColor = appColorDarkGreen
        phase3NameButton.setTitleColor(appColorGray, for: .normal)
        phase3NameButton.backgroundColor = appColorDarkGreen
        phase4NameButton.setTitleColor(appColorGray, for: .normal)
        phase4NameButton.backgroundColor = appColorDarkGreen
        phase5NameButton.setTitleColor(appColorGray, for: .normal)
        phase5NameButton.backgroundColor = appColorDarkGreen
        phase6NameButton.setTitleColor(appColorGray, for: .normal)
        phase6NameButton.backgroundColor = appColorDarkGreen
        phase7NameButton.setTitleColor(appColorGray, for: .normal)
        phase7NameButton.backgroundColor = appColorDarkGreen
        phase8NameButton.setTitleColor(appColorGray, for: .normal)
        phase8NameButton.backgroundColor = appColorDarkGreen
        phase9NameButton.setTitleColor(appColorBlack, for: .normal)
        phase9NameButton.backgroundColor = appColorBrightGreen
        phase10NameButton.setTitleColor(appColorGray, for: .normal)
        phase10NameButton.backgroundColor = appColorDarkGreen
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            tappedPhase = 9
        case evenPhasesCode:
            tappedPhase = 0
        case oddPhasesCode:
            tappedPhase = 0
        default:
            _ = ""
        }
    }
    @IBAction func phase10NameButton(_ sender: Any) {
        phase1NameButton.setTitleColor(appColorGray, for: .normal)
        phase1NameButton.backgroundColor = appColorDarkGreen
        phase2NameButton.setTitleColor(appColorGray, for: .normal)
        phase2NameButton.backgroundColor = appColorDarkGreen
        phase3NameButton.setTitleColor(appColorGray, for: .normal)
        phase3NameButton.backgroundColor = appColorDarkGreen
        phase4NameButton.setTitleColor(appColorGray, for: .normal)
        phase4NameButton.backgroundColor = appColorDarkGreen
        phase5NameButton.setTitleColor(appColorGray, for: .normal)
        phase5NameButton.backgroundColor = appColorDarkGreen
        phase6NameButton.setTitleColor(appColorGray, for: .normal)
        phase6NameButton.backgroundColor = appColorDarkGreen
        phase7NameButton.setTitleColor(appColorGray, for: .normal)
        phase7NameButton.backgroundColor = appColorDarkGreen
        phase8NameButton.setTitleColor(appColorGray, for: .normal)
        phase8NameButton.backgroundColor = appColorDarkGreen
        phase9NameButton.setTitleColor(appColorGray, for: .normal)
        phase9NameButton.backgroundColor = appColorDarkGreen
        phase10NameButton.setTitleColor(appColorBlack, for: .normal)
        phase10NameButton.backgroundColor = appColorBrightGreen
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            tappedPhase = 10
        case evenPhasesCode:
            tappedPhase = 0
        case oddPhasesCode:
            tappedPhase = 0
        default:
            _ = ""
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        let pcount = gdefault.playerIdxByButton[gdefault.clearPhaseButtonIndex]
        let bidx = pcount * 5
        //print("CaP cancelButton set gamesPlayerButtonStatus[\(bidx)] to e")
        gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeEnabled
        //print("CaP cancelButton gamesPlayerButtonStatus=\(gdefault.gamesPlayerButtonStatus)")
        
        // Update the Games file for this game's player

        //print("CaP cB updating game file due to clear phase status button change")
        // Get the offset of this game in the Games file
        let fileHandleCAP2GamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
        let fileContent:String=String(data:fileHandleCAP2GamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleCAP2GamesGet.closeFile()
        let gameFileSize = fileContent.count
        
        var gameRecordOffset = 0
        while gameRecordOffset < gameFileSize {
            //print("CaP cB scanning: offset is \(gameRecordOffset)")
            let tempGameRec = extractRecordField(recordIn: fileContent,  fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
            let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
            //print("CaP cB comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
            if thisGameName == gdefault.gamesGameName {
                //print("CaP cB found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                break
            }
            gameRecordOffset += gdefault.gamesRecordSize
        }
        
        // Update the record and recreate the file
        //print("CaP cB now calling updateGamesFile with offset \(gameRecordOffset)")
        updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
        
        // Always allow cancel request
        allowExitFromView = true
    }
    
    // This function builds a NSMutableAttributedString containing
    // the requested leading text, symbol, and trailing text. The symbol
    // must be an SF system symbol.
    // Input parameters:    textBeforeIn - the requested leading text
    //                      symbolNameIn - the requested SF symbol name
    //                      textAfterIn  - the trailing text
    
    func setUpCheckMark (textBeforeIn: String, textAfterIn: String, symbolNameIn: String) -> NSMutableAttributedString {
        
        let outputString = NSMutableAttributedString(string: textBeforeIn)
        let imageAttachment = NSTextAttachment()
        let heavyConfig = UIImage.SymbolConfiguration(scale: .large)
        let checkmarkImage = UIImage(systemName: symbolNameIn, withConfiguration: heavyConfig)
        let yellowCheckmarkImage = checkmarkImage?.withTintColor(appColorYellow)
        imageAttachment.image = yellowCheckmarkImage
        let imageString = NSAttributedString(attachment: imageAttachment)
        outputString.append(imageString)
        let finalString = NSMutableAttributedString(string: textAfterIn)
        outputString.append(finalString)
        return outputString
    }
    
    @IBAction func clearPhaseButton(_ sender: Any) {
        // Clear the phase number associated with the tapped button by summing
        // this phase plus 500 and placing the result in the tapped
        // phase's location.
        // Determine this player's index which was passed from TheGame.
        let pcount = gdefault.playerIdxByButton[gdefault.clearPhaseButtonIndex]
        let bidx = pcount * 5
        //print("CAP cPB setting pcount (player index) to \(pcount) from playerIndexByButton[\(gdefault.clearPhaseButtonIndex)], tag=gdefault.clearPhaseButtonIndex), button index to use = \(bidx), entry=\(gdefault.gamesPlayerEntryOrder[pcount])")
        errorMessage.text = ""
        
        // Determine which phase to update based on the number of the one
        // that was tapped. Also construct the history log record.
        let thisPlayerCode = createHistoryPlayerCode(playerIn: gdefault.gamesPlayerEntryOrder[pcount])
        switch tappedPhase {
        case 0:
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = "Choose a phase first"
        case 1:
            //print("CaP CPB phase1 was=\(gdefault.gamesPlayerPhase1[pcount])")
            gdefault.gamesPlayerPhase1[pcount] = String(Int(gdefault.gamesPhase1)! + intPhaseDivider)
            gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPhase1
            //print("CaP CPB phase1 now=\(gdefault.gamesPlayerPhase1[pcount])")
            logHistoryData = thisPlayerCode + historyClearPhaseCode + "01  "
        case 2:
            //print("CaP CPB phase2 was=\(gdefault.gamesPlayerPhase2[pcount])")
            gdefault.gamesPlayerPhase2[pcount] = String(Int(gdefault.gamesPhase2)! + intPhaseDivider)
            gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPhase2
            //print("CaP CPB phase2 now=\(gdefault.gamesPlayerPhase2[pcount])")
            logHistoryData = thisPlayerCode + historyClearPhaseCode + "02  "
        case 3:
            //print("CaP CPB phase3 was=\(gdefault.gamesPlayerPhase3[pcount])")
            gdefault.gamesPlayerPhase3[pcount] = String(Int(gdefault.gamesPhase3)! + intPhaseDivider)
            gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPhase3
            //print("CaP CPB phase3 now=\(gdefault.gamesPlayerPhase3[pcount])")
            logHistoryData = thisPlayerCode + historyClearPhaseCode + "03  "
        case 4:
            //print("CaP CPB phase4 was=\(gdefault.gamesPlayerPhase4[pcount])")
            gdefault.gamesPlayerPhase4[pcount] = String(Int(gdefault.gamesPhase4)! + intPhaseDivider)
            gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPhase4
            //print("CaP CPB phase4 now=\(gdefault.gamesPlayerPhase4[pcount])")
            logHistoryData = thisPlayerCode + historyClearPhaseCode + "04  "
        case 5:
            //print("CaP CPB phase5 was=\(gdefault.gamesPlayerPhase5[pcount])")
            gdefault.gamesPlayerPhase5[pcount] = String(Int(gdefault.gamesPhase5)! + intPhaseDivider)
            gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPhase5
            //print("CaP CPB phase5 now=\(gdefault.gamesPlayerPhase5[pcount])")
            logHistoryData = thisPlayerCode + historyClearPhaseCode + "05  "
        case 6:
            //print("CaP CPB phase6 was=\(gdefault.gamesPlayerPhase6[pcount])")
            gdefault.gamesPlayerPhase6[pcount] = String(Int(gdefault.gamesPhase6)! + intPhaseDivider)
            gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPhase6
            //print("CaP CPB phase6 now=\(gdefault.gamesPlayerPhase6[pcount])")
            logHistoryData = thisPlayerCode + historyClearPhaseCode + "06  "
        case 7:
            //print("CaP CPB phase7 was=\(gdefault.gamesPlayerPhase7[pcount])")
            gdefault.gamesPlayerPhase7[pcount] = String(Int(gdefault.gamesPhase7)! + intPhaseDivider)
            gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPhase7
            //print("CaP CPB phase7 now=\(gdefault.gamesPlayerPhase7[pcount])")
            logHistoryData = thisPlayerCode + historyClearPhaseCode + "07  "
        case 8:
            //print("CaP CPB phase8 was=\(gdefault.gamesPlayerPhase8[pcount])")
            gdefault.gamesPlayerPhase8[pcount] = String(Int(gdefault.gamesPhase8)! + intPhaseDivider)
            gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPhase8
            //print("CaP CPB phase8 now=\(gdefault.gamesPlayerPhase8[pcount])")
            logHistoryData = thisPlayerCode + historyClearPhaseCode + "08  "
        case 9:
            //print("CaP CPB phase9 was=\(gdefault.gamesPlayerPhase9[pcount])")
            gdefault.gamesPlayerPhase9[pcount] = String(Int(gdefault.gamesPhase9)! + intPhaseDivider)
            gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPhase9
            //print("CaP CPB phase9 now=\(gdefault.gamesPlayerPhase9[pcount])")
            logHistoryData = thisPlayerCode + historyClearPhaseCode + "09  "
        case 10:
            //print("CaP CPB phase10 was=\(gdefault.gamesPlayerPhase10[pcount])")
            gdefault.gamesPlayerPhase10[pcount] = String(Int(gdefault.gamesPhase10)! + intPhaseDivider)
            gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPhase10
            //print("CaP CPB phase10 now=\(gdefault.gamesPlayerPhase10[pcount])")
            logHistoryData = thisPlayerCode + historyClearPhaseCode + "10  "
        default:
            _ = ""
        }
        
        if errorMessage.text == "" {
            
            // Flag the round and game as now being in progress
            gdefault.gamesRoundStatus = inProgress
            gdefault.gamesGameStatus = inProgress

            //print("CaP tapped phase number=\(tappedPhase)")
            
            // Disable the associated clear phase button on the game screen
            //print("CaP set gamesPlayerButtonStatus[\(bidx)] to d")
            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeDisabled
            //print("CaP gamesPlayerButtonStatus=\(gdefault.gamesPlayerButtonStatus)")
            
            // Update the Games file for this game's player

            //print("CaP updating game file due to phase change")
            // Get the offset of this game in the Games file
            let fileHandleCAPGamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
            let fileContent:String=String(data:fileHandleCAPGamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleCAPGamesGet.closeFile()
            let gameFileSize = fileContent.count
            
            var gameRecordOffset = 0
            while gameRecordOffset < gameFileSize {
                //print("CaP scanning: offset is \(gameRecordOffset)")
                let tempGameRec = extractRecordField(recordIn: fileContent,  fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
                let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
                //print("CaP comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
                if thisGameName == gdefault.gamesGameName {
                    //print("CaP found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                    break
                }
                gameRecordOffset += gdefault.gamesRecordSize
            }
            
            // Update the record and recreate the file
            //print("CaP now calling updateGamesFile with offset \(gameRecordOffset)")
            updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)

            //print("CaP updating history file due to phase change")
            // Get the offset of this game in the History file
            let fileHandleCAPHistoryGet:FileHandle=FileHandle(forReadingAtPath: historyFileURL.path)!
            let fileContent2:String=String(data:fileHandleCAPHistoryGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleCAPHistoryGet.closeFile()
            let historyFileSize = fileContent2.count
            
            // Find the current game in the History file
            var historyRecordOffset = 0
            //print("CaP start game scan in history, file size=\(historyFileSize)")
            while historyRecordOffset < historyFileSize {
                //print("CaP scanning: current offset is \(historyRecordOffset)")
                let tempHistoryRec = extractRecordField(recordIn: fileContent2, fieldOffset: historyRecordOffset, fieldLength: gdefault.historyRecordSize)
                let thisGameName = extractRecordField(recordIn: tempHistoryRec, fieldOffset: gdefault.historyOffsetGameName, fieldLength: gdefault.historyLengthGameName)
                //print("CaP comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
                if thisGameName == gdefault.gamesGameName {
                    //print("CaP found matching file game \(thisGameName) at offset \(historyRecordOffset) and issued break command")
                    break
                }
                historyRecordOffset += gdefault.historyRecordSize
            }
            
            // Update the record and recreate the file
            //print("CaP now calling updateHistoryFile with offset \(historyRecordOffset)")
            updateHistoryFile(actionIn: updateFileUpdateCode, historyOffsetIn: historyRecordOffset, newHistoryDataIn: logHistoryData)
            
            // Set all clear phase button colors to the standard values
            //gdefault.clearPhaseTextColor = appColorBlack
            //gdefault.clearPhaseBackgroundColor = appColorBrightGreen
            gdefault.clearPhaseButtonColorStatus = "all green"

            allowExitFromView = true
        }
        else {
            allowExitFromView = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print("CaP vDL")
        // Do any additional setup after loading the view.
        
        // Initialize error message
        errorMessage.text = ""
           
        // Make the error message have bold text
        errorMessage.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
           
        // Round the button corners
        phase1NameButton.layer.cornerRadius = cornerRadiusStdButton
        phase2NameButton.layer.cornerRadius = cornerRadiusStdButton
        phase3NameButton.layer.cornerRadius = cornerRadiusStdButton
        phase4NameButton.layer.cornerRadius = cornerRadiusStdButton
        phase5NameButton.layer.cornerRadius = cornerRadiusStdButton
        phase6NameButton.layer.cornerRadius = cornerRadiusStdButton
        phase7NameButton.layer.cornerRadius = cornerRadiusStdButton
        phase8NameButton.layer.cornerRadius = cornerRadiusStdButton
        phase9NameButton.layer.cornerRadius = cornerRadiusStdButton
        phase10NameButton.layer.cornerRadius = cornerRadiusStdButton
        clearPhaseButton.layer.cornerRadius = cornerRadiusStdButton
        cancelButton.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //print("CaP vWA")
        aRefreshView()
    }
    
    func aRefreshView () {
        
        //print("CaP aRV")
        // Add phase names 1 - 10 (but only those in use based on the
        // phase modifier, i.e., show all, or just the odd phases, or
        // just the even phases as appropriate). Also disable the phases
        // that are not in use.
        var gamePhaseName = ""
        var gamePhaseNumber = ""
        let notInUse = "                            Not In Use"
        
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase1)
            gamePhaseName = "1 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase1NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase1NameButton.setTitleColor(appColorGray, for: .normal)
            phase1NameButton.backgroundColor = appColorDarkGreen
            phase1NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase2)
            gamePhaseName = "2 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase2NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase2NameButton.setTitleColor(appColorGray, for: .normal)
            phase2NameButton.backgroundColor = appColorDarkGreen
            phase2NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase3)
            gamePhaseName = "3 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase3NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase3NameButton.setTitleColor(appColorGray, for: .normal)
            phase3NameButton.backgroundColor = appColorDarkGreen
            phase3NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase4)
            gamePhaseName = "4 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase4NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase4NameButton.setTitleColor(appColorGray, for: .normal)
            phase4NameButton.backgroundColor = appColorDarkGreen
            phase4NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase5)
            gamePhaseName = "5 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase5NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase5NameButton.setTitleColor(appColorGray, for: .normal)
            phase5NameButton.backgroundColor = appColorDarkGreen
            phase5NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase6)
            gamePhaseName = "6 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase6NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase6NameButton.setTitleColor(appColorGray, for: .normal)
            phase6NameButton.backgroundColor = appColorDarkGreen
            phase6NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase7)
            gamePhaseName = "7 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase7NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase7NameButton.setTitleColor(appColorGray, for: .normal)
            phase7NameButton.backgroundColor = appColorDarkGreen
            phase7NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase8)
            gamePhaseName = "8 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase8NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase8NameButton.setTitleColor(appColorGray, for: .normal)
            phase8NameButton.backgroundColor = appColorDarkGreen
            phase8NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase9)
            gamePhaseName = "9 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase9NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase9NameButton.setTitleColor(appColorGray, for: .normal)
            phase9NameButton.backgroundColor = appColorDarkGreen
            phase9NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase10)
            gamePhaseName = "10 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase10NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase10NameButton.setTitleColor(appColorGray, for: .normal)
            phase10NameButton.backgroundColor = appColorDarkGreen
            phase10NameButton.isEnabled = true
            
        case oddPhasesCode:
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase1)
            gamePhaseName = "1 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase1NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase1NameButton.setTitleColor(appColorGray, for: .normal)
            phase1NameButton.backgroundColor = appColorDarkGreen
            phase1NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase3)
            gamePhaseName = "3 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase2NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase2NameButton.setTitleColor(appColorGray, for: .normal)
            phase2NameButton.backgroundColor = appColorDarkGreen
            phase2NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase5)
            gamePhaseName = "5 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase3NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase3NameButton.setTitleColor(appColorGray, for: .normal)
            phase3NameButton.backgroundColor = appColorDarkGreen
            phase3NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase7)
            gamePhaseName = "7 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase4NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase4NameButton.setTitleColor(appColorGray, for: .normal)
            phase4NameButton.backgroundColor = appColorDarkGreen
            phase4NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase9)
            gamePhaseName = "9 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase5NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase5NameButton.setTitleColor(appColorGray, for: .normal)
            phase5NameButton.backgroundColor = appColorDarkGreen
            phase5NameButton.isEnabled = true
            
            phase6NameButton.setTitle(notInUse, for: UIControl.State.normal)
            phase6NameButton.setTitleColor(appColorGray, for: .normal)
            phase6NameButton.backgroundColor = appColorDarkGreen
            phase6NameButton.isEnabled = false
            
            phase7NameButton.setTitle(notInUse, for: UIControl.State.normal)
            phase7NameButton.setTitleColor(appColorGray, for: .normal)
            phase7NameButton.backgroundColor = appColorDarkGreen
            phase7NameButton.isEnabled = false
            
            phase8NameButton.setTitle(notInUse, for: UIControl.State.normal)
            phase8NameButton.setTitleColor(appColorGray, for: .normal)
            phase8NameButton.backgroundColor = appColorDarkGreen
            phase8NameButton.isEnabled = false
            
            phase9NameButton.setTitle(notInUse, for: UIControl.State.normal)
            phase9NameButton.setTitleColor(appColorGray, for: .normal)
            phase9NameButton.backgroundColor = appColorDarkGreen
            phase9NameButton.isEnabled = false
            
            phase10NameButton.setTitle(notInUse, for: UIControl.State.normal)
            phase10NameButton.setTitleColor(appColorGray, for: .normal)
            phase10NameButton.backgroundColor = appColorDarkGreen
            phase10NameButton.isEnabled = false
        case evenPhasesCode:
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase2)
            gamePhaseName = "2 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase1NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase1NameButton.setTitleColor(appColorGray, for: .normal)
            phase1NameButton.backgroundColor = appColorDarkGreen
            phase1NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase4)
            gamePhaseName = "4 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase2NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase2NameButton.setTitleColor(appColorGray, for: .normal)
            phase2NameButton.backgroundColor = appColorDarkGreen
            phase2NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase6)
            gamePhaseName = "6 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase3NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase3NameButton.setTitleColor(appColorGray, for: .normal)
            phase3NameButton.backgroundColor = appColorDarkGreen
            phase3NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase8)
            gamePhaseName = "8 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase4NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase4NameButton.setTitleColor(appColorGray, for: .normal)
            phase4NameButton.backgroundColor = appColorDarkGreen
            phase4NameButton.isEnabled = true
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase10)
            gamePhaseName = "10 " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            phase5NameButton.setTitle(gamePhaseName, for: UIControl.State.normal)
            phase5NameButton.setTitleColor(appColorGray, for: .normal)
            phase5NameButton.backgroundColor = appColorDarkGreen
            phase5NameButton.isEnabled = true
            
            phase6NameButton.setTitle(notInUse, for: UIControl.State.normal)
            phase6NameButton.setTitleColor(appColorGray, for: .normal)
            phase6NameButton.backgroundColor = appColorDarkGreen
            phase6NameButton.isEnabled = false
            
            phase7NameButton.setTitle(notInUse, for:UIControl.State.normal)
            phase7NameButton.setTitleColor(appColorGray, for: .normal)
            phase7NameButton.backgroundColor = appColorDarkGreen
            phase7NameButton.isEnabled = false
            
            phase8NameButton.setTitle(notInUse, for: UIControl.State.normal)
            phase8NameButton.setTitleColor(appColorGray, for: .normal)
            phase8NameButton.backgroundColor = appColorDarkGreen
            phase8NameButton.isEnabled = false
            
            phase9NameButton.setTitle(notInUse, for: UIControl.State.normal)
            phase9NameButton.setTitleColor(appColorGray, for: .normal)
            phase9NameButton.backgroundColor = appColorDarkGreen
            phase9NameButton.isEnabled = false
            
            phase10NameButton.setTitle(notInUse, for: UIControl.State.normal)
            phase10NameButton.setTitleColor(appColorGray, for: .normal)
            phase10NameButton.backgroundColor = appColorDarkGreen
            phase10NameButton.isEnabled = false
            
        default:
            _ = ""
        }
        
        // Add checkmarks to the already-cleared phases and disable the
        // associated buttons
        let pcount = gdefault.playerIdxByButton[gdefault.clearPhaseButtonIndex]
        //print("CAP aRV setting pcount to \(pcount) from playerIndexByButton[\(gdefault.clearPhaseButtonIndex)]")
        // Adjust spacing preceding the checkmark based on the screen size
        var spacesBeforeCheckmark = ""
        if deviceCategoryWeAreRunningOn == iPhoneLargeConstant ||
            deviceCategoryWeAreRunningOn == iPadConstant {
                spacesBeforeCheckmark = " "
        }
        else {
                spacesBeforeCheckmark = " "
        }
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            if gdefault.gamesPlayerPhase1[pcount] > phaseDivider {
                phase1Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase1NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase2[pcount] > phaseDivider {
                phase2Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase2NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase3[pcount] > phaseDivider {
                phase3Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase3NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase4[pcount] > phaseDivider {
                phase4Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase4NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase5[pcount] > phaseDivider {
                phase5Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase5NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase6[pcount] > phaseDivider {
                phase6Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase6NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase7[pcount] > phaseDivider {
                phase7Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase7NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase8[pcount] > phaseDivider {
                phase8Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase8NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase9[pcount] > phaseDivider {
                phase9Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase9NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase10[pcount] > phaseDivider {
                phase10Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase10NameButton.isEnabled = false
            }
        case evenPhasesCode:
            if gdefault.gamesPlayerPhase2[pcount] > phaseDivider {
                phase1Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase1NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase4[pcount] > phaseDivider {
                phase2Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase2NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase6[pcount] > phaseDivider {
                phase3Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase3NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase8[pcount] > phaseDivider {
                phase4Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase4NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase10[pcount] > phaseDivider {
                phase5Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase5NameButton.isEnabled = false
            }
        case oddPhasesCode:
            if gdefault.gamesPlayerPhase1[pcount] > phaseDivider {
                phase1Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase1NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase3[pcount] > phaseDivider {
                phase2Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase2NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase5[pcount] > phaseDivider {
                phase3Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase3NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase7[pcount] > phaseDivider {
                phase4Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase4NameButton.isEnabled = false
            }
            if gdefault.gamesPlayerPhase9[pcount] > phaseDivider {
                phase5Check.attributedText = setUpCheckMark(textBeforeIn: spacesBeforeCheckmark, textAfterIn: "", symbolNameIn: "checkmark")
                phase5NameButton.isEnabled = false
            }
        default:
            _ = ""
        }            
        
        // Set the color of the tapped phase (if one was tapped already,
        // such as when returning from help)
        switch tappedPhase {
        case 1:
            phase1NameButton.setTitleColor(appColorBlack, for: .normal)
            phase1NameButton.backgroundColor = appColorBrightGreen
        case 2:
            phase2NameButton.setTitleColor(appColorBlack, for: .normal)
            phase2NameButton.backgroundColor = appColorBrightGreen
        case 3:
            phase3NameButton.setTitleColor(appColorBlack, for: .normal)
            phase3NameButton.backgroundColor = appColorBrightGreen
        case 4:
            phase4NameButton.setTitleColor(appColorBlack, for: .normal)
            phase4NameButton.backgroundColor = appColorBrightGreen
        case 5:
            phase5NameButton.setTitleColor(appColorBlack, for: .normal)
            phase5NameButton.backgroundColor = appColorBrightGreen
        case 6:
            phase6NameButton.setTitleColor(appColorBlack, for: .normal)
            phase6NameButton.backgroundColor = appColorBrightGreen
        case 7:
            phase7NameButton.setTitleColor(appColorBlack, for: .normal)
            phase7NameButton.backgroundColor = appColorBrightGreen
        case 8:
            phase8NameButton.setTitleColor(appColorBlack, for: .normal)
            phase8NameButton.backgroundColor = appColorBrightGreen
        case 9:
            phase9NameButton.setTitleColor(appColorBlack, for: .normal)
            phase9NameButton.backgroundColor = appColorBrightGreen
        case 10:
            phase10NameButton.setTitleColor(appColorBlack, for: .normal)
            phase10NameButton.backgroundColor = appColorBrightGreen
        default:
            _ = ""
        }
        
        // Construct the checkmark notification legend
        checkmarkLegend.attributedText = setUpCheckMark(textBeforeIn: "Phases marked with ", textAfterIn: " are cleared.", symbolNameIn: "checkmark")
    }

    @IBAction func aViewTutorial(_ sender: Any) {
        
        gdefault.helpCaller = helpSectionCodeClearAPhase
        
        // Set this flag to true so that the segue to the help screen is
        // allowed to process
        continueToHelp = true
    }
    
    // Prevent storyboard-defined segue from occurring if an error has been detected
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        //print("CAP sPS continuetohelp=\(continueToHelp) allowexitfromview=\(allowExitFromView)")
        if continueToHelp {
            continueToHelp = false
            return true
        }
        else {
            if !allowExitFromView {
                return false
            }
            return true
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
