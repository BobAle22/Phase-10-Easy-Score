//
//  GameVersionConfirmation.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 3/3/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import UIKit

class GameVersionConfirmation: UIViewController {

    @IBOutlet weak var gameVersion: UILabel!
    @IBOutlet weak var phases: UILabel!
    @IBOutlet weak var phaseModifierSwitch: UISlider!
    @IBOutlet weak var phaseModifierAll: UILabel!
    @IBOutlet weak var phaseModifierEven: UILabel!
    @IBOutlet weak var phaseModifierOdd: UILabel!
    @IBOutlet weak var aReturnButton: UIButton!
    @IBOutlet weak var aReturnButton2: UIButton!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    // This module can run either on behalf of Defaults or EditGame.
    // The following variables will be set for use within this module based
    // on which is the current environment.
    var usePhaseModifier = ""
    var useGameVersion = ""
    var usePhase1 = ""
    var usePhase2 = ""
    var usePhase3 = ""
    var usePhase4 = ""
    var usePhase5 = ""
    var usePhase6 = ""
    var usePhase7 = ""
    var usePhase8 = ""
    var usePhase9 = ""
    var usePhase10 = ""
    
    @IBAction func aViewTutorialButton(_ sender: Any) {
        gdefault.helpCaller = helpSectionCodeGameVersionDisplay
    }
    
    
    // Return to the screen that started us down the path to game version
    // selection. Also load global storage with the appropriate data.
    @IBAction func aReturnButton(_ sender: Any) {
        //print("GVC aReturnButton pressed - Defaults mode")
        gdefault.defaultsPhaseModifier = usePhaseModifier
        gdefault.defaultsGameVersion = useGameVersion
        gdefault.defaultsPhase1 = usePhase1
        gdefault.defaultsPhase2 = usePhase2
        gdefault.defaultsPhase3 = usePhase3
        gdefault.defaultsPhase4 = usePhase4
        gdefault.defaultsPhase5 = usePhase5
        gdefault.defaultsPhase6 = usePhase6
        gdefault.defaultsPhase7 = usePhase7
        gdefault.defaultsPhase8 = usePhase8
        gdefault.defaultsPhase9 = usePhase9
        gdefault.defaultsPhase10 = usePhase10
        gdefault.updateTarget = DSTarget
    }
    
    @IBAction func aReturnButton2(_ sender: Any) {
        //print("GVC aReturnButton2 pressed - EditGame mode")
        gdefault.gamesPhaseModifier = usePhaseModifier
        gdefault.gamesGameVersion = useGameVersion
        gdefault.gamesPhase1 = usePhase1
        gdefault.gamesPhase2 = usePhase2
        gdefault.gamesPhase3 = usePhase3
        gdefault.gamesPhase4 = usePhase4
        gdefault.gamesPhase5 = usePhase5
        gdefault.gamesPhase6 = usePhase6
        gdefault.gamesPhase7 = usePhase7
        gdefault.gamesPhase8 = usePhase8
        gdefault.gamesPhase9 = usePhase9
        gdefault.gamesPhase10 = usePhase10
        gdefault.updateTarget = EGTarget
        
        var pcount = 0
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                gdefault.gamesPlayerPhase1[pcount] = usePhase1
            }
            else {
                gdefault.gamesPlayerPhase2[pcount] = initZeroPhase3
            }
            if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                gdefault.gamesPlayerPhase2[pcount] = usePhase2
            }
            else {
                gdefault.gamesPlayerPhase3[pcount] = initZeroPhase3
            }
            if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                gdefault.gamesPlayerPhase3[pcount] = usePhase3
            }
            else {
                gdefault.gamesPlayerPhase4[pcount] = initZeroPhase3
            }
            if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                gdefault.gamesPlayerPhase4[pcount] = usePhase4
            }
            else {
                gdefault.gamesPlayerPhase5[pcount] = initZeroPhase3
            }
            if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                gdefault.gamesPlayerPhase5[pcount] = usePhase5
            }
            else {
                gdefault.gamesPlayerPhase6[pcount] = initZeroPhase3
            }
            if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                gdefault.gamesPlayerPhase6[pcount] = usePhase6
            }
            else {
                gdefault.gamesPlayerPhase7[pcount] = initZeroPhase3
            }
            if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                gdefault.gamesPlayerPhase7[pcount] = usePhase7
            }
            else {
                gdefault.gamesPlayerPhase8[pcount] = initZeroPhase3
            }
            if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                gdefault.gamesPlayerPhase8[pcount] = usePhase8
            }
            else {
                gdefault.gamesPlayerPhase9[pcount] = initZeroPhase3
            }
            if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                gdefault.gamesPlayerPhase9[pcount] = usePhase9
            }
            else {
                gdefault.gamesPlayerPhase10[pcount] = initZeroPhase3
            }
            if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                gdefault.gamesPlayerPhase10[pcount] = usePhase10
            }
            else {
                gdefault.gamesPlayerPhase1[pcount] = initZeroPhase3
            }
            pcount += 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        refreshView()
        
        super.viewWillAppear(animated)
     } // End viewWillAppear
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Initialize error message
        errorMessage.text = ""
        
        // Make the error message have bold text
        errorMessage.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
        
        // Round the button corners
        aReturnButton.layer.cornerRadius = cornerRadiusStdButton
        aReturnButton2.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton
        
    } // End ViewDidLoad
    
    func refreshView () {
        
        // Set up the variables to be used in this module based on whether
        // we're in the Defaults or the EditGame environment.
        //print("GVC vWA")
        switch gdefault.gameVersionConfirmationDecisionDriverView {
        case "Defaults":
           //print("setting use vars as defaults")
           usePhaseModifier = gdefault.defaultsPhaseModifier
           useGameVersion = gdefault.defaultsGameVersion
           usePhase1 = gdefault.defaultsPhase1
           usePhase2 = gdefault.defaultsPhase2
           usePhase3 = gdefault.defaultsPhase3
           usePhase4 = gdefault.defaultsPhase4
           usePhase5 = gdefault.defaultsPhase5
           usePhase6 = gdefault.defaultsPhase6
           usePhase7 = gdefault.defaultsPhase7
           usePhase8 = gdefault.defaultsPhase8
           usePhase9 = gdefault.defaultsPhase9
           usePhase10 = gdefault.defaultsPhase10
           //print("useGameVersion=\(useGameVersion), usePhaseModifier=\(usePhaseModifier)")
           //print("1=\(usePhase1),2=\(usePhase2),10=\(usePhase10)")
        case "EditGame":
           //print("setting use vars as games")
           usePhaseModifier = gdefault.gamesPhaseModifier
           useGameVersion = gdefault.gamesGameVersion
           usePhase1 = gdefault.gamesPhase1
           usePhase2 = gdefault.gamesPhase2
           usePhase3 = gdefault.gamesPhase3
           usePhase4 = gdefault.gamesPhase4
           usePhase5 = gdefault.gamesPhase5
           usePhase6 = gdefault.gamesPhase6
           usePhase7 = gdefault.gamesPhase7
           usePhase8 = gdefault.gamesPhase8
           usePhase9 = gdefault.gamesPhase9
           usePhase10 = gdefault.gamesPhase10
           //print("useGameVersion=\(useGameVersion), usePhaseModifier=\(usePhaseModifier)")
           //print("usePhase1=\(usePhase1),usePhase2=\(usePhase2),usePhase10=\(usePhase10)")
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
        let attBoldBlue: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 18), .underlineStyle : 0, .paragraphStyle: style, .foregroundColor: appColorBlue]
        let attStdBlack: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 18), .underlineStyle: 0, .paragraphStyle: style, .foregroundColor: appColorBlack]
       
        // Game version & phase modifier
        
        var phaseModifier = ""
        switch usePhaseModifier {
        case allPhasesCode:
            phaseModifier = allPhasesName
        case evenPhasesCode:
            phaseModifier = evenPhasesName
        case oddPhasesCode:
            phaseModifier = oddPhasesName
        default:
            _ = ""
        }
       
        let gameVersionName = retrieveGameVersionName(numberIn: useGameVersion)
        //print("gameVersionName=\(gameVersionName)")

        // Make the version bold black.
        // If the phase modifier is "All", set it to be bold black.
        // Otherwise, make it bold blue
        let attribVAPLeft = NSMutableAttributedString(string:gameVersionName + " / ", attributes:attBoldBlackV)
        var attribVAPRight = NSMutableAttributedString()
        if phaseModifier == allPhasesName {
            attribVAPRight = NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlackV)
        }
        else {
            attribVAPRight =
            NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlueV)
        }
       
        // Concatenate the left & right version and phase
             
        let leftAndRight = NSMutableAttributedString()

        leftAndRight.append(attribVAPLeft)
        leftAndRight.append(attribVAPRight)

        gameVersion.attributedText = leftAndRight
       
        // Load associated phase names (and numbers) 1-10

        var nextPhaseLine = ""
       
        var thisPhaseNumber = Int(useGameVersion)! + 1
        usePhase1 = String(format: "%03d", thisPhaseNumber)
        var gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        //print("thisPhaseNumber1=\(thisPhaseNumber) gamePhaseName1=\(gamePhaseName)")
        nextPhaseLine = String("1  ") + gamePhaseName
        var attribLine01 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine01 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine01 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine01 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        thisPhaseNumber = Int(useGameVersion)! + 2
        usePhase2 = String(format: "%03d", thisPhaseNumber)
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        //print("thisPhaseNumber2=\(thisPhaseNumber) gamePhaseName2=\(gamePhaseName)")
        nextPhaseLine = String("\n2  ") + gamePhaseName
        var attribLine02 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine02 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine02 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine02 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
       
        thisPhaseNumber = Int(useGameVersion)! + 3
        usePhase3 = String(format: "%03d", thisPhaseNumber)
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n3  ") + gamePhaseName
        var attribLine03 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine03 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine03 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine03 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
       
        thisPhaseNumber = Int(useGameVersion)! + 4
        usePhase4 = String(format: "%03d", thisPhaseNumber)
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n4  ") + gamePhaseName
        var attribLine04 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine04 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine04 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine04 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
       
        thisPhaseNumber = Int(useGameVersion)! + 5
        usePhase5 = String(format: "%03d", thisPhaseNumber)
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n5  ") + gamePhaseName
        var attribLine05 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine05 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine05 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine05 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
       
        thisPhaseNumber = Int(useGameVersion)! + 6
        usePhase6 = String(format: "%03d", thisPhaseNumber)
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n6  ") + gamePhaseName
        var attribLine06 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine06 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine06 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine06 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
       
        thisPhaseNumber = Int(useGameVersion)! + 7
        usePhase7 = String(format: "%03d", thisPhaseNumber)
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n7  ") + gamePhaseName
        var attribLine07 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine07 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine07 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine07 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
               
        thisPhaseNumber = Int(useGameVersion)! + 8
        usePhase8 = String(format: "%03d", thisPhaseNumber)
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n8  ") + gamePhaseName
        var attribLine08 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine08 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine08 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine08 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
       
        thisPhaseNumber = Int(useGameVersion)! + 9
        usePhase9 = String(format: "%03d", thisPhaseNumber)
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n9  ") + gamePhaseName
        var attribLine09 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine09 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine09 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine09 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
                       
        thisPhaseNumber = Int(useGameVersion)! + 10
        usePhase10 = String(format: "%03d", thisPhaseNumber)
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n10  ") + gamePhaseName
        var attribLine10 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine10 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine10 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine10 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
       
        // Concatenate all the lines together
       
        let all10Lines = NSMutableAttributedString()

        all10Lines.append(attribLine01)
        all10Lines.append(attribLine02)
        all10Lines.append(attribLine03)
        all10Lines.append(attribLine04)
        all10Lines.append(attribLine05)
        all10Lines.append(attribLine06)
        all10Lines.append(attribLine07)
        all10Lines.append(attribLine08)
        all10Lines.append(attribLine09)
        all10Lines.append(attribLine10)
       
        phases.attributedText = all10Lines
       
        // Load phase modifier slider and All/Even/Odd labels
       
        switch usePhaseModifier {
        case allPhasesCode:
            phaseModifierSwitch.value = 0
            phaseModifierAll.textColor = appColorBrightGreen
            phaseModifierAll.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            phaseModifierEven.textColor = appColorDarkGray
            phaseModifierEven.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            phaseModifierOdd.textColor = appColorDarkGray
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        case evenPhasesCode:
            phaseModifierSwitch.value = 1
            phaseModifierAll.textColor = appColorDarkGray
            phaseModifierAll.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            phaseModifierEven.textColor = appColorBlue
            phaseModifierEven.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            phaseModifierOdd.textColor = appColorDarkGray
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        case oddPhasesCode:
            phaseModifierSwitch.value = 2
            phaseModifierAll.textColor = appColorDarkGray
            phaseModifierAll.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            phaseModifierEven.textColor = appColorDarkGray
            phaseModifierEven.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            phaseModifierOdd.textColor = appColorBlue
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
        default:
            _ = ""
        }
       
        // Set up the two return buttons so that only one appears and is enabled
        switch gdefault.gameVersionConfirmationDecisionDriverView {
        case "Defaults":
            aReturnButton.isEnabled = true
            aReturnButton.setTitleColor(appColorYellow, for: .normal)
            aReturnButton.backgroundColor = appColorDarkGreen
            aReturnButton2.isEnabled = false
            aReturnButton2.setTitleColor(appColorClear, for: .normal)
            aReturnButton2.backgroundColor = appColorClear
        case "EditGame":
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
    
    // Update screen and global storage with requested phase modifier
    
    @IBAction func phaseModifierSwitch(_ sender: UISlider) {
    
        // Set up bold attributes for version/modifier descriptions
        let styleV = NSMutableParagraphStyle()
        styleV.alignment = NSTextAlignment.center
        let attBoldBlueV: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 18), .underlineStyle : 0, .paragraphStyle: styleV, .foregroundColor: appColorBlue]
        let attBoldBlackV: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 18), .underlineStyle: 0, .paragraphStyle: styleV, .foregroundColor: appColorBlack]
        
        // Set up bold & normal attributes for phase descriptions
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        let attBoldBlue: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 18), .underlineStyle : 0, .paragraphStyle: style, .foregroundColor: appColorBlue]
        let attStdBlack: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 18), .underlineStyle: 0, .paragraphStyle: style, .foregroundColor: appColorBlack]
        
        // Game version & phase modifier
                
        var phaseModifier = ""
       
        let gameVersionName = retrieveGameVersionName(numberIn: useGameVersion)
        
        let attribVAPLeft = NSMutableAttributedString(string:gameVersionName + " / ", attributes:attBoldBlackV)
        var attribVAPRight = NSMutableAttributedString()
        
        // Set value to the nearest 1 set All/Even/Odd labels accordingly
        // Also, make the version standard black.
        // If the phase modifier is "All", set it to be standard black.
        // Otherwise, make it bold blue
           
        sender.setValue((Float)((Int)((sender.value + 0.5) / 1) * 1), animated: false)
        let sval = Int(phaseModifierSwitch.value)
        switch sval {
        case 0:
            usePhaseModifier = allPhasesCode
            phaseModifier = allPhasesName
            attribVAPRight = NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlackV)
            phaseModifierAll.textColor = appColorBrightGreen
            phaseModifierAll.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            phaseModifierEven.textColor = appColorDarkGray
            phaseModifierEven.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            phaseModifierOdd.textColor = appColorDarkGray
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        case 1:
            usePhaseModifier = evenPhasesCode
            phaseModifier = evenPhasesName
            attribVAPRight =
            NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlueV)
            phaseModifierAll.textColor = appColorDarkGray
            phaseModifierAll.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            phaseModifierEven.textColor = appColorBlue
            phaseModifierEven.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            phaseModifierOdd.textColor = appColorDarkGray
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        case 2:
            usePhaseModifier = oddPhasesCode
            phaseModifier = oddPhasesName
            attribVAPRight =
            NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlueV)
            phaseModifierAll.textColor = appColorDarkGray
            phaseModifierAll.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            phaseModifierEven.textColor = appColorDarkGray
            phaseModifierEven.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            phaseModifierOdd.textColor = appColorBlue
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
        default:
            usePhaseModifier = allPhasesCode
            phaseModifier = allPhasesName
            attribVAPRight =
            NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlueV)
            phaseModifierAll.textColor = appColorBrightGreen
            phaseModifierAll.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            phaseModifierEven.textColor = appColorDarkGray
            phaseModifierEven.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            phaseModifierOdd.textColor = appColorDarkGray
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        }
        
        // Concatenate the left & right version and phase
                      
        let leftAndRight = NSMutableAttributedString()

        leftAndRight.append(attribVAPLeft)
        leftAndRight.append(attribVAPRight)

        gameVersion.attributedText = leftAndRight
        
        // Load associated phase names 1-10

        var nextPhaseLine = ""
        
        var thisPhaseNumber = Int(useGameVersion)! + 1
        var gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("1  ") + gamePhaseName
        var attribLine01 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine01 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine01 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine01 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        thisPhaseNumber = Int(useGameVersion)! + 2
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n2  ") + gamePhaseName
        var attribLine02 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine02 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine02 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine02 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        thisPhaseNumber = Int(useGameVersion)! + 3
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n3  ") + gamePhaseName
        var attribLine03 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine03 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine03 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine03 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        thisPhaseNumber = Int(useGameVersion)! + 4
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n4  ") + gamePhaseName
        var attribLine04 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine04 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine04 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine04 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        thisPhaseNumber = Int(useGameVersion)! + 5
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n5  ") + gamePhaseName
        var attribLine05 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine05 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine05 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine05 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        thisPhaseNumber = Int(useGameVersion)! + 6
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n6  ") + gamePhaseName
        var attribLine06 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine06 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine06 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine06 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        thisPhaseNumber = Int(useGameVersion)! + 7
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n7  ") + gamePhaseName
        var attribLine07 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine07 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine07 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine07 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
                
        thisPhaseNumber = Int(useGameVersion)! + 8
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n8  ") + gamePhaseName
        var attribLine08 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine08 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine08 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine08 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        thisPhaseNumber = Int(useGameVersion)! + 9
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n9  ") + gamePhaseName
        var attribLine09 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine09 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine09 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine09 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
                        
        thisPhaseNumber = Int(useGameVersion)! + 10
        gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
        nextPhaseLine = String("\n10  ") + gamePhaseName
        var attribLine10 = NSMutableAttributedString()
        switch usePhaseModifier {
        case oddPhasesCode:
            attribLine10 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine10 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine10 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        // Concatenate all the lines together
        
        let all10Lines = NSMutableAttributedString()

        all10Lines.append(attribLine01)
        all10Lines.append(attribLine02)
        all10Lines.append(attribLine03)
        all10Lines.append(attribLine04)
        all10Lines.append(attribLine05)
        all10Lines.append(attribLine06)
        all10Lines.append(attribLine07)
        all10Lines.append(attribLine08)
        all10Lines.append(attribLine09)
        all10Lines.append(attribLine10)
        
        phases.attributedText = all10Lines
        
        switch gdefault.gameVersionConfirmationDecisionDriverView {
        case "Defaults":
            //print("GVC pMS defaults phase modifier as \(usePhaseModifier)")
            gdefault.defaultsPhaseModifier = usePhaseModifier
        case "EditGame":
            //print("GVC pMS games phase modifier as \(usePhaseModifier)")
            gdefault.gamesPhaseModifier = usePhaseModifier
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
