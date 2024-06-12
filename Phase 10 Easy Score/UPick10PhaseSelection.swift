//
//  UPick10PhaseSelection.swift
//  Phase 10 Easy Score
// 
//  Created by Robert J Alessi on 3/10/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import UIKit

class UPick10PhaseSelection: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    @IBOutlet weak var gameVersion: UILabel!
    @IBOutlet weak var phaseChoices: UILabel!
    @IBOutlet weak var phasenamePicker: UIPickerView!
    @IBOutlet weak var phaseModifierSwitch: UISlider!
    @IBOutlet weak var phaseModifierAll: UILabel!
    @IBOutlet weak var phaseModifierEven: UILabel!
    @IBOutlet weak var phaseModifierOdd: UILabel!
    @IBOutlet weak var choosePhaseButton: UIButton!
    @IBOutlet weak var removeLastChoiceButton: UIButton!
    @IBOutlet weak var aReturnButton: UIButton!
    @IBOutlet weak var aReturnButton2: UIButton!
    @IBOutlet weak var aViewTutorial: UIButton!
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
    
    // Controls whether or not user is allowed to exit (via the return button)
    var allowExitFromView = false
    
    // Used in conjunction with allowExitFromView -- specifically to allow
    // access to the help screen
    var continueToHelp = false
    
    // Storage for the 10 phases being selected
    
    var newPhases = ["", "", "", "", "", "", "", "", "", ""]
    var nextNewPhaseIndex = 0
    
    // All available phase names are placed here to source the picker view
    
    var allPhases = [String]()
    var theRow = 0
    
    // Reload the showPhases string with the phase names associated with
    // all the phase numbers that are in the newPhases array. Load
    // blank lines for all empty entries. Set each phase line's color based
    // on the phase modifier (All/Even/Odd) and the relative line
    // position (1, 2, ...)

    func loadShowPhases() {
        var gamePhaseName = ""
        var showPhase = ""
        var npcount = 0
        var endCharacter = ""
        
        // Set up bold & normal attributes for phase descriptions
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        let attBoldBlue: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 17), .underlineStyle : 0, .paragraphStyle: style, .foregroundColor: appColorBlue]
        let attStdBlack: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 17), .underlineStyle: 0, .paragraphStyle: style, .foregroundColor: appColorBlack]
        
        // Set up the attribute storage area

        var attEntry = NSMutableAttributedString()
        let all10Lines = NSMutableAttributedString()
       
        while npcount < 10 {
            if npcount < 9 {
                endCharacter = String("\n")
            }
            else {
                endCharacter = ""
            }
            if !(newPhases[npcount] == "") {
                gamePhaseName = retrieveGamePhaseName(numberIn: newPhases[npcount])
                showPhase = String(" ") +
                            String(format: "%2d", npcount+1) +
                            " " +
                            gamePhaseName +
                            endCharacter
            }
            else {
                showPhase = " " +
                            endCharacter
            }
            
            let phaseLine = npcount + 1
            switch phaseLine {
            case 1, 3, 5, 7, 9:
                switch usePhaseModifier {
                case oddPhasesCode:
                    attEntry = NSMutableAttributedString(string:showPhase, attributes: attBoldBlue)
                case evenPhasesCode:
                    attEntry = NSMutableAttributedString(string:showPhase, attributes: attStdBlack)
                case allPhasesCode:
                    attEntry = NSMutableAttributedString(string:showPhase, attributes: attStdBlack)
                default:
                    _ = ""
                }
            case 2, 4, 6, 8, 10:
                  switch usePhaseModifier {
                  case oddPhasesCode:
                      attEntry = NSMutableAttributedString(string:showPhase, attributes: attStdBlack)
                  case evenPhasesCode:
                      attEntry = NSMutableAttributedString(string:showPhase, attributes: attBoldBlue)
                  case allPhasesCode:
                      attEntry = NSMutableAttributedString(string:showPhase, attributes: attStdBlack)
                  default:
                      _ = ""
                  }
            default:
                  _ = ""
            }
            all10Lines.append(attEntry)
            
            npcount += 1
        }
        
        // Put all the phases on the screen
        phaseChoices.attributedText = all10Lines
        
        return
    }
    
    func numberOfComponents(in phasenamePicker: UIPickerView) -> Int {
        return 1
    }
      
    func pickerView(_ phasenamePicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allPhases.count
    }
      
    func pickerView(_ phasenamePicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allPhases[row]
    }
    
    // This is the selected row from the picker view
    
    func pickerView(_ phasenamePicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        theRow = row
    }
    
    // Give the picker view background a color from the icon's colors. There are
    // five colors in the icon, so repeat the first color again after each set of
    // five is used. Also set the text color to black or white depending on the
    // background.
    
    func pickerView(_ phasenamePicker: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel?
        var tempRow = 0
        if view == nil { // if no label there yet
            pickerLabel = UILabel()
            // color the label's background
            tempRow = row
            while tempRow > 4 {
                tempRow -= 5
            }
            switch tempRow {
            case 0:
                pickerLabel?.backgroundColor = appColorBlue
                pickerLabel?.textColor = appColorWhite
            case 1:
                pickerLabel?.backgroundColor = appColorMediumRed
                pickerLabel?.textColor = appColorWhite
            case 2:
                pickerLabel?.backgroundColor = appColorOrange
                pickerLabel?.textColor = appColorWhite
            case 3:
                pickerLabel?.backgroundColor = appColorDarkGreen
                pickerLabel?.textColor = appColorWhite
            case 4:
                pickerLabel?.backgroundColor = appColorYellow
                pickerLabel?.textColor = appColorBlack
            default:
                pickerLabel?.backgroundColor = appColorYellow
                pickerLabel?.textColor = appColorBlack
            }
            tempRow += 1
        }
        
        // Put the phase name in the pickerView
            
        let titleData:String = "  " + allPhases[row]

        pickerLabel?.text = titleData
            
        return pickerLabel!
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Force light mode in case dark mode is turned on
        overrideUserInterfaceStyle = .light
        
        // Initialize error message
        
        errorMessage.text = ""
        
        // Make the error message have bold text
        
        errorMessage.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
    
        // Round the button corners
        
        choosePhaseButton.layer.cornerRadius = cornerRadiusStdButton
        removeLastChoiceButton.layer.cornerRadius = cornerRadiusStdButton
        aReturnButton.layer.cornerRadius = cornerRadiusStdButton
        aReturnButton2.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorial.layer.cornerRadius = cornerRadiusHelpButton
        
        // Disallow exit and help unless verified first via code
        
        allowExitFromView = false
        continueToHelp = false
        
        phasenamePicker.delegate = self
        phasenamePicker.dataSource = self
    }

    // Update screen and global storage with requested phase modifier
    
    @IBAction func phaseModifierSwitch(_ sender: UISlider) {
        
        // Set up bold attributes for version/modifier descriptions
        let styleV = NSMutableParagraphStyle()
        styleV.alignment = NSTextAlignment.center
        let attBoldBlueV: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 18), .underlineStyle : 0, .paragraphStyle: styleV, .foregroundColor: appColorBlue]
        let attBoldBlackV: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 18), .underlineStyle: 0, .paragraphStyle: styleV, .foregroundColor: appColorBlack]
        
        // Always reset the "return pressed" indicator to 1 when any action
        // is done on the screen, other than pressing the "return" button
        
        gdefault.UP10ReturnPressed = "1"
        errorMessage.text = ""
        
        // Game version & phase modifier
                 
        var phaseModifier = ""
        
        let gameVersionName = uPick10
         
        let attribVAPLeft = NSMutableAttributedString(string:gameVersionName + " / ", attributes:attBoldBlackV)
        var attribVAPRight = NSMutableAttributedString()
        
        // Set value to the nearest 1 set All/Even/Odd labels accordingly
           
        sender.setValue((Float)((Int)((sender.value + 0.5) / 1) * 1), animated: false)
        let sval = Int(phaseModifierSwitch.value)
        switch sval {
        case 0:
            usePhaseModifier = allPhasesCode
            phaseModifier = allPhasesName
            attribVAPRight = NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlackV)
            phaseModifierAll.textColor = appColorBrightGreen
            phaseModifierAll.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.heavy)
            phaseModifierEven.textColor = appColorDarkGray
            phaseModifierEven.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
            phaseModifierOdd.textColor = appColorDarkGray
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
        case 1:
            usePhaseModifier = evenPhasesCode
            phaseModifier = evenPhasesName
            attribVAPRight =
            NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlueV)
            phaseModifierAll.textColor = appColorDarkGray
            phaseModifierAll.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
            phaseModifierEven.textColor = appColorBlue
            phaseModifierEven.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.heavy)
            phaseModifierOdd.textColor = appColorDarkGray
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
        case 2:
            usePhaseModifier = oddPhasesCode
            phaseModifier = oddPhasesName
            attribVAPRight =
            NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlueV)
            phaseModifierAll.textColor = appColorDarkGray
            phaseModifierAll.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
            phaseModifierEven.textColor = appColorDarkGray
            phaseModifierEven.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
            phaseModifierOdd.textColor = appColorBlue
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.heavy)
        default:
            usePhaseModifier = allPhasesCode
            phaseModifier = allPhasesName
            attribVAPRight =
            NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlueV)
            phaseModifierAll.textColor = appColorBrightGreen
            phaseModifierAll.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.heavy)
            phaseModifierEven.textColor = appColorDarkGray
            phaseModifierEven.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
            phaseModifierOdd.textColor = appColorDarkGray
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
        }
        
        // Concatenate the left & right version and phase
                      
        let leftAndRight = NSMutableAttributedString()

        leftAndRight.append(attribVAPLeft)
        leftAndRight.append(attribVAPRight)

        gameVersion.attributedText = leftAndRight
        
        // Save the  new phase modifier
        
        switch gdefault.gameVersionConfirmationDecisionDriverView {
        case "Defaults":
            gdefault.defaultsPhaseModifier = usePhaseModifier
        case "EditGame":
            gdefault.gamesPhaseModifier = usePhaseModifier
        default:
            _ = ""
        }
        //print("UP10 pMS just set phase modifier to \(usePhaseModifier)")
        
        // Put the recreated showPhases string onto the screen
        loadShowPhases()
    }
    
    // The user is attempting to select (choose) a phase
    
    @IBAction func choosePhaseButton(_ sender: Any) {
        
        // Always reset the "return pressed" indicator to 1 when any action
        // is done on the screen, other than pressing the "return" button
          
        gdefault.UP10ReturnPressed = "1"
       
        errorMessage.text = ""
        var continueSelection = "y"
        
        // Acquire the selected phase's associated internal index
        
        let thisPhaseNumber = retrieveGamePhaseNumber (gameNameIn: uPick10, phaseNameIn: allPhases[theRow])
        
        // Ensure that the user is not trying to add an 11th phase
        
        if nextNewPhaseIndex > 9 {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = "Only 10 phases are allowed"
            continueSelection = "n"
        }
        
        // Ensure that the user is not attempting to add a phase that's
        // already been selected
        
        if continueSelection == "y" {
            
            var dcount = 0
            while dcount < 10 {
                if newPhases[dcount] == thisPhaseNumber {
                    errorMessage.textColor = appColorRed
                    errorMessage.backgroundColor = appColorYellow
                    errorMessage.text = "Duplicate phase selection"
                    continueSelection = "n"
                    dcount = 10
                }
                dcount += 1
            }
        }
        
        // Ok to add this phase to the selection array and show on the screen
        
        if continueSelection == "y" {
        
            // Put the user-selected phase number into the next available
            // slot in the newPhases array
        
            newPhases[nextNewPhaseIndex] = thisPhaseNumber
            nextNewPhaseIndex += 1
        
            // Put the recreated showPhases string onto the screen
        
            loadShowPhases()
        }
        
    }
    
    @IBAction func removeLastChoiceButton(_ sender: Any) {

        // Always reset the "return pressed" indicator to 1 when any action
        // is done on the screen, other than pressing the "return" button
        
        gdefault.UP10ReturnPressed = "1"
        errorMessage.text = ""

        var continueSelection = "y"
        
        // Ensure that the user is not attempting to remove a phase when none
        // have yet been selected
        
        if nextNewPhaseIndex == 0 {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = "No phases selected yet"
            continueSelection = "n"
        }
              
        // Ok to remove the phase most recently added to the selection array and
        // then re-show on the screen
        
        if continueSelection == "y" {
        
            nextNewPhaseIndex -= 1
            newPhases[nextNewPhaseIndex] = ""
        
            // Put the recreated showPhases string onto the screen
                   
            loadShowPhases()
        }
    }
    
    // There are 2 return buttons sharing the same space.
    // This return button (no number) is associated with EditDefaults.
    // The user pressed the return button. If 10 phases have been selected,
    // allow the exit (phases in global must be updated too). If fewer than 10
    // phases have been selected, let the user know and only allow the exit if
    // the return button is pressed again, at which time the game version and
    // phase modifier are reinstated to their pre-UPick10 values.

    @IBAction func aReturnButton(_ sender: Any) {
        //print("UP10 aReturnButton pressed - Edit Defaults mode - version=\(gdefault.gamesGameVersion)/\(gdefault.gamesPhaseModifier)")
        
        switch gdefault.UP10ReturnPressed {
        case "1":
            //print("UP10 return pressed=\(gdefault.UP10ReturnPressed), next new phase=\(nextNewPhaseIndex)")
            if nextNewPhaseIndex > 9 {
                //print("UP10 setting 10 default phases, allowing exit")
                gdefault.defaultsGameVersion = useGameVersion
                gdefault.defaultsPhase1 = newPhases[0]
                gdefault.defaultsPhase2 = newPhases[1]
                gdefault.defaultsPhase3 = newPhases[2]
                gdefault.defaultsPhase4 = newPhases[3]
                gdefault.defaultsPhase5 = newPhases[4]
                gdefault.defaultsPhase6 = newPhases[5]
                gdefault.defaultsPhase7 = newPhases[6]
                gdefault.defaultsPhase8 = newPhases[7]
                gdefault.defaultsPhase9 = newPhases[8]
                gdefault.defaultsPhase10 = newPhases[9]
                gdefault.defaultsPhaseModifier = usePhaseModifier
                gdefault.UP10ReturnPressed = "1"
                allowExitFromView = true
                continueToHelp = false
            }
            else {
                //print("UP10 switching return pressed to 2 - disallowing exit")
                gdefault.UP10ReturnPressed = "2"
                errorMessage.textColor = appColorWhite
                errorMessage.backgroundColor = appColorMediumGreen
                errorMessage.text = "Press Back again to exit/cancel"
                allowExitFromView = false
                continueToHelp = false
            }
        case "2":
            //print("UP10 return pressed=\(gdefault.UP10ReturnPressed), next new phase=\(nextNewPhaseIndex)")
            if nextNewPhaseIndex > 9 {
                //print("UP10 setting 10 default phases, allowing exit")
                gdefault.defaultsGameVersion = useGameVersion
                gdefault.defaultsPhase1 = newPhases[0]
                gdefault.defaultsPhase2 = newPhases[1]
                gdefault.defaultsPhase3 = newPhases[2]
                gdefault.defaultsPhase4 = newPhases[3]
                gdefault.defaultsPhase5 = newPhases[4]
                gdefault.defaultsPhase6 = newPhases[5]
                gdefault.defaultsPhase7 = newPhases[6]
                gdefault.defaultsPhase8 = newPhases[7]
                gdefault.defaultsPhase9 = newPhases[8]
                gdefault.defaultsPhase10 = newPhases[9]
                gdefault.defaultsPhaseModifier = usePhaseModifier
                gdefault.UP10ReturnPressed = "1"
                allowExitFromView = true
                continueToHelp = false
            }
            else {
                //print("UP10 setting return pressed to 1 - reinstating version & PM and allowing exit")
                //print("UP10 reinstating version/PM \(gdefault.preUP10Version)/\(gdefault.preUP10PhaseModifier)")
                gdefault.defaultsGameVersion = gdefault.preUP10Version
                gdefault.defaultsPhaseModifier = gdefault.preUP10PhaseModifier
                gdefault.UP10ReturnPressed = "1"
                allowExitFromView = true
                continueToHelp = false
            }
        default:
            _ = ""
        }
        //print("UP10 exiting ReturnButton - version=\(gdefault.gamesGameVersion)/\(gdefault.gamesPhaseModifier)")
    }
    
    // There are 2 return buttons sharing the same space.
    // This return button 2 is associated with EditGame.
    // The user pressed the return button. If 10 phases have been selected,
    // allow the exit (phases in global must be updated too). If fewer than 10
    // phases have been selected, let the user know and only allow the exit if
    // the return button is pressed again, at which time the game version and
    // phase modifier are reinstated to their pre-UPick10 values.
    @IBAction func aReturnButton2(_ sender: Any) {
        //print("UP10 aReturnButton2 pressed - EditGame mode - version=\(gdefault.gamesGameVersion)/\(gdefault.gamesPhaseModifier)")
        
        switch gdefault.UP10ReturnPressed {
        case "1":
            //print("UP10 return pressed=\(gdefault.UP10ReturnPressed), next new phase=\(nextNewPhaseIndex)")
            if nextNewPhaseIndex > 9 {
                //print("UP10 setting 10 games & player phases, allowing exit")
                gdefault.gamesGameVersion = useGameVersion
                gdefault.gamesPhase1 = newPhases[0]
                gdefault.gamesPhase2 = newPhases[1]
                gdefault.gamesPhase3 = newPhases[2]
                gdefault.gamesPhase4 = newPhases[3]
                gdefault.gamesPhase5 = newPhases[4]
                gdefault.gamesPhase6 = newPhases[5]
                gdefault.gamesPhase7 = newPhases[6]
                gdefault.gamesPhase8 = newPhases[7]
                gdefault.gamesPhase9 = newPhases[8]
                gdefault.gamesPhase10 = newPhases[9]
                
                var pcount = 0
                while pcount < gdefault.gamesLengthPlayerNameOccurs {
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase1[pcount] = newPhases[0]
                    }
                    else {
                        gdefault.gamesPlayerPhase2[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase2[pcount] = newPhases[1]
                    }
                    else {
                        gdefault.gamesPlayerPhase3[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase3[pcount] = newPhases[2]
                    }
                    else {
                        gdefault.gamesPlayerPhase4[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase4[pcount] = newPhases[3]
                    }
                    else {
                        gdefault.gamesPlayerPhase5[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase5[pcount] = newPhases[4]
                    }
                    else {
                        gdefault.gamesPlayerPhase6[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase6[pcount] = newPhases[5]
                    }
                    else {
                        gdefault.gamesPlayerPhase7[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase7[pcount] = newPhases[6]
                    }
                    else {
                        gdefault.gamesPlayerPhase8[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase8[pcount] = newPhases[7]
                    }
                    else {
                        gdefault.gamesPlayerPhase9[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase9[pcount] = newPhases[8]
                    }
                    else {
                        gdefault.gamesPlayerPhase10[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase10[pcount] = newPhases[9]
                    }
                    else {
                        gdefault.gamesPlayerPhase1[pcount] = initZeroPhase3
                    }
                    pcount += 1
                }
                
                gdefault.gamesPhaseModifier = usePhaseModifier
                gdefault.UP10ReturnPressed = "1"
                allowExitFromView = true
                continueToHelp = false
            }
            else {
                //print("UP10 switching return pressed to 2 - disallowing exit")
                gdefault.UP10ReturnPressed = "2"
                errorMessage.textColor = appColorWhite
                errorMessage.backgroundColor = appColorMediumGreen
                errorMessage.text = "Press Back again to exit/cancel"
                allowExitFromView = false
                continueToHelp = false
            }
        case "2":
            //print("UP10 return pressed=\(gdefault.UP10ReturnPressed), next new phase=\(nextNewPhaseIndex)")
            if nextNewPhaseIndex > 9 {
                //print("UP10 setting 10 games & player phases, allowing exit")
                gdefault.gamesGameVersion = useGameVersion
                gdefault.gamesPhase1 = newPhases[0]
                gdefault.gamesPhase2 = newPhases[1]
                gdefault.gamesPhase3 = newPhases[2]
                gdefault.gamesPhase4 = newPhases[3]
                gdefault.gamesPhase5 = newPhases[4]
                gdefault.gamesPhase6 = newPhases[5]
                gdefault.gamesPhase7 = newPhases[6]
                gdefault.gamesPhase8 = newPhases[7]
                gdefault.gamesPhase9 = newPhases[8]
                gdefault.gamesPhase10 = newPhases[9]
                
                var pcount = 0
                while pcount < gdefault.gamesLengthPlayerNameOccurs {
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase1[pcount] = newPhases[0]
                    }
                    else {
                        gdefault.gamesPlayerPhase2[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase2[pcount] = newPhases[1]
                    }
                    else {
                        gdefault.gamesPlayerPhase3[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase3[pcount] = newPhases[2]
                    }
                    else {
                        gdefault.gamesPlayerPhase4[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase4[pcount] = newPhases[3]
                    }
                    else {
                        gdefault.gamesPlayerPhase5[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase5[pcount] = newPhases[4]
                    }
                    else {
                        gdefault.gamesPlayerPhase6[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase6[pcount] = newPhases[5]
                    }
                    else {
                        gdefault.gamesPlayerPhase7[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase7[pcount] = newPhases[6]
                    }
                    else {
                        gdefault.gamesPlayerPhase8[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase8[pcount] = newPhases[7]
                    }
                    else {
                        gdefault.gamesPlayerPhase9[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase9[pcount] = newPhases[8]
                    }
                    else {
                        gdefault.gamesPlayerPhase10[pcount] = initZeroPhase3
                    }
                    if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                        gdefault.gamesPlayerPhase10[pcount] = newPhases[9]
                    }
                    else {
                        gdefault.gamesPlayerPhase1[pcount] = initZeroPhase3
                    }
                    pcount += 1
                }
                
                gdefault.gamesPhaseModifier = usePhaseModifier
                gdefault.UP10ReturnPressed = "1"
                allowExitFromView = true
                continueToHelp = false
            }
            else {
                //print("UP10 setting return pressed to 1 - allowing exit")
                //print("UP10 reinstating version/PM \(gdefault.preUP10Version)/\(gdefault.preUP10PhaseModifier)")
                gdefault.gamesGameVersion = gdefault.preUP10Version
                gdefault.gamesPhaseModifier = gdefault.preUP10PhaseModifier
                gdefault.UP10ReturnPressed = "1"
                allowExitFromView = true
                continueToHelp = false
            }
        default:
            _ = ""
        }
        //print("UP10 exiting ReturnButton2 - version=\(gdefault.gamesGameVersion)/\(gdefault.gamesPhaseModifier)")
    }
    
    @IBAction func aViewTutorial(_ sender: Any) {
        
        gdefault.UP10ReturnPressed = "1"
        errorMessage.text = ""
        allowExitFromView = false
        
        gdefault.helpCaller = helpSectionCodeUPick10PhaseSelection
        
        // Set this flag to true so that the segue to the help screen is allowed
        // to process
        continueToHelp = true
    }
    
    override func viewWillAppear(_ animated: Bool) {

        refreshView()
        
        super.viewWillAppear(animated)
        
    } // End viewWillAppear
    
    func refreshView () {
        
        // Set up the variables to be used in this module based on whether
        // we're in the Defaults or the EditGame environment.
        switch gdefault.gameVersionConfirmationDecisionDriverView {
        case "Defaults":
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
        case "EditGame":
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
        default:
            _ = ""
        }
        
        // Set up bold attributes for version/modifier descriptions
        let styleV = NSMutableParagraphStyle()
        styleV.alignment = NSTextAlignment.center
        let attBoldBlueV: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 18), .underlineStyle : 0, .paragraphStyle: styleV, .foregroundColor: appColorBlue]
        let attBoldBlackV: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 18), .underlineStyle: 0, .paragraphStyle: styleV, .foregroundColor: appColorBlack]
        
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
               
        // Concatenate the let & right version and phase
                     
        let leftAndRight = NSMutableAttributedString()

        leftAndRight.append(attribVAPLeft)
        leftAndRight.append(attribVAPRight)

        gameVersion.attributedText = leftAndRight
        
        // Load phase modifier slider and All/Even/Odd labels
       
        switch usePhaseModifier {
        case allPhasesCode:
            phaseModifierSwitch.value = 0
            phaseModifierAll.textColor = appColorBrightGreen
            phaseModifierAll.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.heavy)
            phaseModifierEven.textColor = appColorDarkGray
            phaseModifierEven.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
            phaseModifierOdd.textColor = appColorDarkGray
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
        case evenPhasesCode:
            phaseModifierSwitch.value = 1
            phaseModifierAll.textColor = appColorDarkGray
            phaseModifierAll.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
            phaseModifierEven.textColor = appColorBlue
            phaseModifierEven.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.heavy)
            phaseModifierOdd.textColor = appColorDarkGray
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
        case oddPhasesCode:
            phaseModifierSwitch.value = 2
            phaseModifierAll.textColor = appColorDarkGray
            phaseModifierAll.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
            phaseModifierEven.textColor = appColorDarkGray
            phaseModifierEven.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.regular)
            phaseModifierOdd.textColor = appColorBlue
            phaseModifierOdd.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.heavy)
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
        
        allPhases.removeAll()

        // Retrieve all the U Pick 10 phase names and store them in the allPhases
        // array. Game versions are type G, Phases are type P, and the array end
        // is type X
               
        // First acquire the U Pick 10 version number
               
        var pcount = Int(retrieveActualGameVersionNumber(nameIn: uPick10))

        // Now extract its phases
               
        var nameType = ""
        repeat {
            let gamePhaseEntry = gamesAndPhases[pcount!]
            var sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 0)
            var eidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
            var range = sidx ..< eidx
            nameType = String(gamePhaseEntry[range])
            if nameType == gamesAndPhasesPhase {
                sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
                eidx = gamePhaseEntry.endIndex
                range = sidx ..< eidx
                allPhases.append(String(gamePhaseEntry[range]))
            }
            pcount! += 1
        } // End search loop
        while !(nameType == gamesAndPhasesEnd)
               
        self.phasenamePicker.reloadAllComponents()
           
        self.phasenamePicker.selectRow(theRow, inComponent: 0, animated: false)
        self.pickerView(self.phasenamePicker, didSelectRow: theRow, inComponent: 0)
    }
    
    // Prevent storyboard-defined segue from occurring if an error has been detected
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        //print("UP10 sPS continueToHelp=\(continueToHelp) allowExitFromView=\(allowExitFromView)")
        if continueToHelp {
            //print("UP10 sPS continueToHelp is true - returning true")
            return true
        }
        else {
            if !allowExitFromView {
                //print("UP10 sPS allowExitFromView is false - returning false")
                return false
            }
            //print("UP10 sPS allowExitFromView is true - returning true")
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
