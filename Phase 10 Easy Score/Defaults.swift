//
//  Defaults.swift
//  Phase 10 Easy Score
// 
//  Created by Robert J Alessi on 2/11/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import UIKit

class Defaults: UIViewController {

    @IBOutlet weak var trackDealerNo: UILabel!
    @IBOutlet weak var trackDealerYes: UILabel!
    @IBOutlet weak var trackDealerSlider: UISlider!
    @IBOutlet weak var gameVersionButton: UIButton!
    @IBOutlet weak var sortPlayerOrderButton: UIButton!
    @IBOutlet weak var aDoneButton: UIButton!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    
    var largerYesNoFont: CGFloat = 30
    
    // Anchor to return to this view from anywhere
    @IBAction func unwindToDefaults(sender: UIStoryboardSegue) {
    }
    
    @IBAction func aViewTutorialButton(_ sender: Any) {
        gdefault.helpCaller = helpSectionCodeDefaults
    }
    
    @IBAction func trackDealerSlider(_ sender: UISlider) {
        
        // Set value to the nearest 1
               
        sender.setValue((Float)((Int)((sender.value + 0.5) / 1) * 1), animated: false)
        let sval = Int(trackDealerSlider.value)
        if sval == 0 {
            gdefault.defaultsTrackDealer = notTrackingDealerConstant
            trackDealerNo.textColor = appColorBrightGreen
            trackDealerNo.font = UIFont.systemFont(ofSize: largerYesNoFont, weight: UIFont.Weight.heavy)
            trackDealerYes.textColor = appColorDarkGray
            trackDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        }
        else {
            gdefault.defaultsTrackDealer = trackingDealerConstant
            trackDealerNo.textColor = appColorDarkGray
            trackDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            trackDealerYes.textColor = appColorBrightGreen
            trackDealerYes.font = UIFont.systemFont(ofSize: largerYesNoFont, weight: UIFont.Weight.heavy)
        }
    }
    
    @IBAction func aDoneButton(_ sender: Any) {
        
        // Save all global memory values in the Defaults file, then dismiss view
         
        let defaultsText: String = loadDefaultsRecordFromGlobal(fileLevelIn: currentFileLevel)
         
        // First clear the file, then write the reconstructed record in its place
         
        let fileHandleDFDefaultsUpdate:FileHandle=FileHandle(forUpdatingAtPath:defaultsFileURL.path)!
        
        fileHandleDFDefaultsUpdate.truncateFile(atOffset: 0)
        fileHandleDFDefaultsUpdate.write(defaultsText.data(using: String.Encoding.utf8)!)
        fileHandleDFDefaultsUpdate.closeFile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
            largerYesNoFont = 25
        }
        else {
            largerYesNoFont = 30
        }
        
        // Initialize error message (it has been removed)
        //errorMessage.text = ""
        
        // Make the error message have bold text (it has been removed)
        //errorMessage.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
        
        // Round the button corners
        gameVersionButton.layer.cornerRadius = cornerRadiusStdButton
        sortPlayerOrderButton.layer.cornerRadius = cornerRadiusStdButton
        aDoneButton.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton
      
    } // End of ViewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        
        //print("DF vWA updateTarget was \(gdefault.updateTarget)")
        gdefault.updateTarget = movingForward
        
        refreshView ()
        
  } // End ViewWillAppear
    
    func refreshView() {
        
        // Load the view data values from global storage
             
        // Track dealer
         
        if gdefault.defaultsTrackDealer == trackingDealerConstant {
            trackDealerSlider.value = 1
            trackDealerNo.textColor = appColorDarkGray
            trackDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            trackDealerYes.textColor = appColorBrightGreen
            trackDealerYes.font = UIFont.systemFont(ofSize: largerYesNoFont, weight: UIFont.Weight.heavy)
        }
        else {
            trackDealerSlider.value = 0
            trackDealerNo.textColor = appColorBrightGreen
            trackDealerNo.font = UIFont.systemFont(ofSize: largerYesNoFont, weight: UIFont.Weight.heavy)
            trackDealerYes.textColor = appColorDarkGray
            trackDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        }
         
        // Game version & phase modifier
         
        var phaseModifier = ""
        switch gdefault.defaultsPhaseModifier {
        case allPhasesCode:
            phaseModifier = allPhasesName
        case evenPhasesCode:
            phaseModifier = evenPhasesName
        case oddPhasesCode:
            phaseModifier = oddPhasesName
        default:
            _ = ""
        }
        
        // Set up bold attributes for version/modifier descriptions
        let styleV = NSMutableParagraphStyle()
        styleV.alignment = NSTextAlignment.center
        let attBoldBlueV: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 18), .underlineStyle : 0, .paragraphStyle: styleV, .foregroundColor: appColorBlue]
        let attBoldBlackV: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 18), .underlineStyle: 0, .paragraphStyle: styleV, .foregroundColor: appColorBlack]
        
        // Set up bold & normal attributes for phase descriptions
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        let attBoldBlue: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 16), .underlineStyle : 0, .paragraphStyle: style, .foregroundColor: appColorBlue]
        let attStdBlack: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 16), .underlineStyle: 0, .paragraphStyle: style, .foregroundColor: appColorBlack]
        
        let gameVersionName = retrieveGameVersionName(numberIn: gdefault.defaultsGameVersion) + " / "

        // Make the version bold black.
        // If the phase modifier is "All", set it to be bold black.
        // Otherwise, make it bold blue
        let attribLine01Left = NSMutableAttributedString(string:gameVersionName, attributes:attBoldBlackV)
        var attribLine01Right = NSMutableAttributedString()
        if phaseModifier == allPhasesName {
            attribLine01Right = NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlackV)
        }
        else {
            attribLine01Right =
            NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlueV)
        }

        // Add phase names 1 - 10
        var nextPhaseLine = ""
        
        var gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.defaultsPhase1)
        //nextPhaseLine = String("\n\n  1 ") + gamePhaseName
        nextPhaseLine = String("\n  1 ") + gamePhaseName
        var attribLine02 = NSMutableAttributedString()
        switch gdefault.defaultsPhaseModifier {
        case oddPhasesCode:
            attribLine02 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine02 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine02 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.defaultsPhase2)
        nextPhaseLine = String("\n  2 ") + gamePhaseName
        var attribLine03 = NSMutableAttributedString()
        switch gdefault.defaultsPhaseModifier {
        case oddPhasesCode:
            attribLine03 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine03 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine03 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
                
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.defaultsPhase3)
        nextPhaseLine = String("\n  3 ") + gamePhaseName
        var attribLine04 = NSMutableAttributedString()
        switch gdefault.defaultsPhaseModifier {
        case oddPhasesCode:
            attribLine04 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine04 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine04 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.defaultsPhase4)
        nextPhaseLine = String("\n  4 ") + gamePhaseName
        var attribLine05 = NSMutableAttributedString()
        switch gdefault.defaultsPhaseModifier {
        case oddPhasesCode:
            attribLine05 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine05 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine05 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.defaultsPhase5)
        nextPhaseLine = String("\n  5 ") + gamePhaseName
        var attribLine06 = NSMutableAttributedString()
        switch gdefault.defaultsPhaseModifier {
        case oddPhasesCode:
            attribLine06 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine06 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine06 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
         
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.defaultsPhase6)
        nextPhaseLine = String("\n  6 ") + gamePhaseName
        var attribLine07 = NSMutableAttributedString()
        switch gdefault.defaultsPhaseModifier {
        case oddPhasesCode:
            attribLine07 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine07 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine07 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
         
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.defaultsPhase7)
        nextPhaseLine = String("\n  7 ") + gamePhaseName
        var attribLine08 = NSMutableAttributedString()
        switch gdefault.defaultsPhaseModifier {
        case oddPhasesCode:
            attribLine08 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine08 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine08 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
         
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.defaultsPhase8)
        nextPhaseLine = String("\n  8 ") + gamePhaseName
        var attribLine09 = NSMutableAttributedString()
        switch gdefault.defaultsPhaseModifier {
        case oddPhasesCode:
            attribLine09 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine09 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine09 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
         
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.defaultsPhase9)
        nextPhaseLine = String("\n  9 ") + gamePhaseName
        var attribLine10 = NSMutableAttributedString()
        switch gdefault.defaultsPhaseModifier {
        case oddPhasesCode:
            attribLine10 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine10 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine10 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
         
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.defaultsPhase10)
        nextPhaseLine = String("\n10 ") + gamePhaseName
        var attribLine11 = NSMutableAttributedString()
        switch gdefault.defaultsPhaseModifier {
        case oddPhasesCode:
            attribLine11 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine11 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine11 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        // Concatenate all the lines together
        
        let all11Lines = NSMutableAttributedString()
        
        all11Lines.append(attribLine01Left)
        all11Lines.append(attribLine01Right)
        all11Lines.append(attribLine02)
        all11Lines.append(attribLine03)
        all11Lines.append(attribLine04)
        all11Lines.append(attribLine05)
        all11Lines.append(attribLine06)
        all11Lines.append(attribLine07)
        all11Lines.append(attribLine08)
        all11Lines.append(attribLine09)
        all11Lines.append(attribLine10)
        all11Lines.append(attribLine11)
        gameVersionButton.setAttributedTitle(all11Lines, for: .normal)
    
        gameVersionButton.backgroundColor = appColorBrightGreen
        
        // Player sort order
         
        let psidx = Int(gdefault.defaultsPlayerSort)!
        let playerSort = playerSortDescription[psidx]
        let trimmedPlayerSort = playerSort.trimmingCharacters(in: .whitespacesAndNewlines)
        sortPlayerOrderButton.setTitle(trimmedPlayerSort, for: .normal)
        
        sortPlayerOrderButton.backgroundColor = appColorBrightGreen
        sortPlayerOrderButton.setTitleColor(appColorBlack, for: .normal)
         
        // Store this view name in case the user proceeds to the sort
        // selection screen. That screen's main text changes slightly
        // depending on the originating view.
        gdefault.playerSortDecisionDriverView = "Defaults"
        
        // Store this view name in case the user proceeds to the game
        // version selection screen, so that the path back is known.
        gdefault.gameVersionConfirmationDecisionDriverView = "Defaults"
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
