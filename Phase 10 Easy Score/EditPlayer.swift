//
//  EditPlayer.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 6/30/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import UIKit

class EditPlayer: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var phasesDone: UILabel!
    @IBOutlet weak var phase1: UITextField!
    @IBOutlet weak var phase2: UITextField!
    @IBOutlet weak var phase3: UITextField!
    @IBOutlet weak var phase4: UITextField!
    @IBOutlet weak var phase5: UITextField!
    @IBOutlet weak var phase6: UITextField!
    @IBOutlet weak var phase7: UITextField!
    @IBOutlet weak var phase8: UITextField!
    @IBOutlet weak var phase9: UITextField!
    @IBOutlet weak var phase10: UITextField!
    @IBOutlet weak var points: UITextField!
    @IBOutlet weak var dealerSequence: UITextField!
    @IBOutlet weak var markAsDealerSwitch: UISlider!
    @IBOutlet weak var markAsDealerMore1: UILabel!
    @IBOutlet weak var markAsDealerMore2: UILabel!
    @IBOutlet weak var markAsDealerNo: UILabel!
    @IBOutlet weak var markAsDealerYes: UILabel!
    @IBOutlet weak var playerChoosesPhaseSwitch: UISlider!
    @IBOutlet weak var playerChoosesPhaseMore1: UILabel!
    @IBOutlet weak var playerChoosesPhaseMore2: UILabel!
    @IBOutlet weak var playerChoosesPhaseNo: UILabel!
    @IBOutlet weak var playerChoosesPhaseYes: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var aUpdateButton: UIButton!
    @IBOutlet weak var aRemoveButton: UIButton!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    var gameRecordOffset = 0            // Offset of the game record in the file
    var thePlayerIndex = 0              // Index of the player being edited
    var thePlayerEntrySequence = 0      // Entry sequence associated with thePlayerIndex
    var thePlayerHistoryCode = ""       // History code associated with thePlayerIndex
    var gamePlayerLimit = 99            // Highest player slot with a player in it
    
    // Controls whether or not the mark as dealer switch may be changed
    var markAsDealerSwitchEnabled = "y"

    // Keeps track of whether or not any phase has been cleared, and is used when setting up
    // Player Chooses Phase
    var anyPhaseCleared = ""
    
    // Highest index in the history record that will be shifted when filling a removed player's entries
    var highestShiftableHistoryIndex = 0
    
    // Holding areas for the 10 screen phases
    // Note that if the player is not choosing phases, only one completed phase is on the screen, and
    // the user data is placed in phase 5
    var holdScreenPhase1 = ""
    var holdScreenPhase2 = ""
    var holdScreenPhase3 = ""
    var holdScreenPhase4 = ""
    var holdScreenPhase5 = ""
    var holdScreenPhase6 = ""
    var holdScreenPhase7 = ""
    var holdScreenPhase8 = ""
    var holdScreenPhase9 = ""
    var holdScreenPhase10 = ""
    
    // History data being logged for a phase and point change
    var logPlayerWasEdited = ""
    var logClearPhaseHistoryData = ""
    var logClearPointsHistoryData = ""
    var logResetPhasesHistoryData = ""
    var logResetPointsHistoryData = ""
    
    // Controls whether or not user is allowed to exit (via the Choose button)
    var allowExitFromView = false
    
    // Used in conjunction with allowExitFromView -- specifically to allow
    // access to the help screen
    var continueToHelp = false
    
    var integerDealerSequence = 0
    
    let badPhaseMessage = "Phases must use only 0-9"
    
    // Function to add a "done" button on the player name numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboard2() {
        let doneToolbar2: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar2.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done2: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditPlayer.doneButtonAction2))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done2)
        
        doneToolbar2.items = items
        doneToolbar2.sizeToFit()
        
        self.playerName.inputAccessoryView = doneToolbar2
    }
    
    // Make the keyboard for player name with the newly-added done button disappear
    @objc func doneButtonAction2 () {
        self.playerName.resignFirstResponder()
    }
    
    @IBAction func hidePlayerKeyboard(_ sender: Any) {
        playerName.resignFirstResponder()
    }
    
    // Player name is mandatory, maximum 20 characters, may contain only
    // letters, numbers, and spaces, and must be different from all other players.
    @IBAction func playerName(_ sender: Any) {
        // Clear the error message
        errorMessage.text = ""
        
        let tempPlayer = playerName.text
        var thePlayer = ""
        if tempPlayer!.count == 0 {
            errorMessage.textColor = appColorRed
            errorMessage.text = "Player name missing"
            errorMessage.backgroundColor = appColorYellow
        }
        else if tempPlayer!.count > gdefault.gamesLengthPlayerName {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = "Player name size max " + String(gdefault.gamesLengthPlayerName)
        }
        else {
            // Pad the player name with spaces to fill the field
            thePlayer = tempPlayer!.padding(toLength: gdefault.gamesLengthPlayerName, withPad: " ", startingAt: 0)
            //print("EP pN name=<\(String(describing: thePlayer)) len=\(thePlayer.count)")
            let regex = try! NSRegularExpression(pattern: " ")
            let numberOfBlanks = regex.numberOfMatches(in: thePlayer, range: NSRange((thePlayer.startIndex...), in: thePlayer))
            if numberOfBlanks == thePlayer.count {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Player name is blank"
            }
        }

        // Make sure only letters, numbers, and spaces are present
        if errorMessage.text == "" {
            if !isAlphaNumSpace(dataIn: thePlayer) {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text="Name may use A-Z a-z 0-9 or space"
            }
        }
        
        if errorMessage.text == "" {
            var pcount = 0
            //print("EP pN searching for dups for player name \(String(describing: thePlayer))")
            let thePlayerNoSpaces = thePlayer.replacingOccurrences(of: " ", with: "")
            let thePlayerUpperCase = thePlayerNoSpaces.uppercased()
            while pcount < gdefault.gamesLengthPlayerNameOccurs {
                //print("EP pN testing entered name \(String(describing: thePlayer)) vs GS name \(gdefault.gamesPlayerName[pcount]) at idx \(pcount)")
                let theFilePlayerNoSpaces = gdefault.gamesPlayerName[pcount].replacingOccurrences(of: " ", with: "")
                let theFilePlayerUpperCase = theFilePlayerNoSpaces.uppercased()
                if !(pcount == thePlayerIndex) &&
                    thePlayerUpperCase == theFilePlayerUpperCase {
                        break
                }
                pcount += 1
            }
            if pcount < gdefault.gamesLengthPlayerNameOccurs {
                //print("EP pN got duplicate at index \(pcount)")
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Duplicate player name"
            }
            else {
                gdefault.gamesPlayerName[thePlayerIndex] = thePlayer
                allowExitFromView = true
                //print("EP nP saving player \(String(describing: thePlayer)) in index \(thePlayerIndex)")
            }
        }
    }
    
    // Function to add a "done" button on the phase 1 numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboardP1() {
        let doneToolbarP1: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbarP1.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneP1: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditPlayer.doneButtonActionP1))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(doneP1)
        
        doneToolbarP1.items = items
        doneToolbarP1.sizeToFit()
        
        self.phase1.inputAccessoryView = doneToolbarP1
    }
    
    // Make the keyboard for phase 1 with the newly-added done button disappear
    @objc func doneButtonActionP1 () {
        self.phase1.resignFirstResponder()
    }
    
    // Function to add a "done" button on the phase 2 numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboardP2() {
        let doneToolbarP2: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbarP2.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneP2: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditPlayer.doneButtonActionP2))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(doneP2)
        
        doneToolbarP2.items = items
        doneToolbarP2.sizeToFit()
        
        self.phase2.inputAccessoryView = doneToolbarP2
    }
    
    // Make the keyboard for phase 2 with the newly-added done button disappear
    @objc func doneButtonActionP2 () {
        self.phase2.resignFirstResponder()
    }
    
    // Function to add a "done" button on the phase 3 numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboardP3() {
        let doneToolbarP3: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbarP3.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneP3: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditPlayer.doneButtonActionP3))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(doneP3)
        
        doneToolbarP3.items = items
        doneToolbarP3.sizeToFit()
        
        self.phase3.inputAccessoryView = doneToolbarP3
    }
    
    // Make the keyboard for phase 3 with the newly-added done button disappear
    @objc func doneButtonActionP3 () {
        self.phase3.resignFirstResponder()
    }
    
    // Function to add a "done" button on the phase 4 numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboardP4() {
        let doneToolbarP4: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbarP4.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneP4: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditPlayer.doneButtonActionP4))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(doneP4)
        
        doneToolbarP4.items = items
        doneToolbarP4.sizeToFit()
        
        self.phase4.inputAccessoryView = doneToolbarP4
    }
    
    // Make the keyboard for phase 4 with the newly-added done button disappear
    @objc func doneButtonActionP4 () {
        self.phase4.resignFirstResponder()
    }
    
    // Function to add a "done" button on the phase 5 numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboardP5() {
        let doneToolbarP5: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbarP5.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneP5: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditPlayer.doneButtonActionP5))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(doneP5)
        
        doneToolbarP5.items = items
        doneToolbarP5.sizeToFit()
        
        self.phase5.inputAccessoryView = doneToolbarP5
    }
    
    // Make the keyboard for phase 5 with the newly-added done button disappear
    @objc func doneButtonActionP5 () {
        self.phase5.resignFirstResponder()
    }
    
    // Function to add a "done" button on the phase 6 numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboardP6() {
        let doneToolbarP6: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbarP6.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneP6: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditPlayer.doneButtonActionP6))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(doneP6)
        
        doneToolbarP6.items = items
        doneToolbarP6.sizeToFit()
        
        self.phase6.inputAccessoryView = doneToolbarP6
    }
    
    // Make the keyboard for phase 6 with the newly-added done button disappear
    @objc func doneButtonActionP6 () {
        self.phase6.resignFirstResponder()
    }
    
    // Function to add a "done" button on the phase 7 numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboardP7() {
        let doneToolbarP7: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbarP7.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneP7: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditPlayer.doneButtonActionP7))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(doneP7)
        
        doneToolbarP7.items = items
        doneToolbarP7.sizeToFit()
        
        self.phase7.inputAccessoryView = doneToolbarP7
    }
    
    // Make the keyboard for phase 7 with the newly-added done button disappear
    @objc func doneButtonActionP7 () {
        self.phase7.resignFirstResponder()
    }
    
    // Function to add a "done" button on the phase 8 numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboardP8() {
        let doneToolbarP8: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbarP8.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneP8: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditPlayer.doneButtonActionP8))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(doneP8)
        
        doneToolbarP8.items = items
        doneToolbarP8.sizeToFit()
        
        self.phase8.inputAccessoryView = doneToolbarP8
    }
    
    // Make the keyboard for phase 8 with the newly-added done button disappear
    @objc func doneButtonActionP8 () {
        self.phase8.resignFirstResponder()
    }
    
    // Function to add a "done" button on the phase 9 numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboardP9() {
        let doneToolbarP9: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbarP9.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneP9: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditPlayer.doneButtonActionP9))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(doneP9)
        
        doneToolbarP9.items = items
        doneToolbarP9.sizeToFit()
        
        self.phase9.inputAccessoryView = doneToolbarP9
    }
    
    // Make the keyboard for phase 9 with the newly-added done button disappear
    @objc func doneButtonActionP9 () {
        self.phase9.resignFirstResponder()
    }
    
    // Function to add a "done" button on the phase 10 numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboardP10() {
        let doneToolbarP10: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbarP10.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneP10: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditPlayer.doneButtonActionP10))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(doneP10)
        
        doneToolbarP10.items = items
        doneToolbarP10.sizeToFit()
        
        self.phase10.inputAccessoryView = doneToolbarP10
    }
    
    // Make the keyboard for phase 10 with the newly-added done button disappear
    @objc func doneButtonActionP10 () {
        self.phase10.resignFirstResponder()
    }

    // General function to edit a phase - does not include duplicate checking
    // Input:   phase content
    //          phase number relative position on screen (1, 2, ..., 10) This is used for the error message
    //                                                                   but if it's 99, it's not used in the message
    //          phase modifier (a, e, o)
    // Output:  error message (null if no error)
    // If present, phase must range from 1 to 10 (note that the phase is optional)
    func basicPhaseEdit (phaseIn: String, phaseNumberIn: Int, modifierIn: String) -> String {
        
        // Clear the error message
        var errorMsg = ""
        let integerPhase = Int(phaseIn)
        var phaseNumberText = ""
        if phaseNumberIn == 99 {
            phaseNumberText = "Phase "
        }
        else {
            phaseNumberText = "Phase " + String(format: "% 2d", phaseNumberIn)
        }
        
        //print("EP bPE entered phase=\(phaseIn) number=\(phaseNumberIn) modifier=\(modifierIn)")

        switch modifierIn {
        case allPhasesCode:
            _ = ""
        case evenPhasesCode:
            if integerPhase == 1 ||
               integerPhase == 3 ||
               integerPhase == 5 ||
               integerPhase == 7 ||
                integerPhase == 9 {
                    //print("EP bPE must be even")
                    errorMsg = phaseNumberText + " must be even"
            }
        case oddPhasesCode:
            if integerPhase == 2 ||
               integerPhase == 4 ||
               integerPhase == 6 ||
               integerPhase == 8 ||
                integerPhase == 10 {
                //print("EP bPE must be odd")
                    errorMsg = phaseNumberText + " must be odd"
            }
        default:
            _ = ""
        }
        if errorMsg == "" {
            if phaseIn.count == 0 {
                errorMsg = ""
            }
            else if phaseIn.count > 2 {
                errorMsg = phaseNumberText + " size max 2"
            }
            else if integerPhase == 0 {
                errorMsg = phaseNumberText + " must not be zero"
            }
            else if integerPhase! > 10 {
                errorMsg = phaseNumberText + " must be 1-10"
            }
        }
        
        return errorMsg
    }

    // General function to prepare each phase for entry into the phase array
    // If it's empty, set the result to 99
    // If it contains a phase, set it to a leading zero-filled 3-digit number
    // NOTE THAT THE INPUT PHASE IS GUARANTEED TO BE EITHER A NUMBER OR EMPTY
    // BECAUSE IT WAS PROCESSED ALREADY BY THE BASIC PHASE EDIT FUNCTION
    // Input:   phase text field
    // Output:  phase text to load
    func prepPhase(phaseIn: String) -> String {
        if phaseIn.count == 0 {
            return "99"
        }
        let intPhase = Int(phaseIn)
        let outPhase = String(format: "%03d", intPhase!)
        return outPhase
    }
    
    // General function to create the duplicate phase error message
    // Input:   Index of first duplicate
    //          Index of second duplicate
    // Output:  Error message
    func makePhaseDupError(phase1In: Int, phase2In: Int) -> String {
        var firstIdentifier = ""
        var secondIdentifier = ""
        
        switch phase1In {
        case 1:
            firstIdentifier = "1st"
        case 2:
            firstIdentifier = "2nd"
        case 3:
            firstIdentifier = "3rd"
        case 4:
            firstIdentifier = "4th"
        case 5:
            firstIdentifier = "5th"
        case 6:
            firstIdentifier = "6th"
        case 7:
            firstIdentifier = "7th"
        case 8:
            firstIdentifier = "8th"
        case 9:
            firstIdentifier = "9th"
        default:
            _ = ""
        }
        
        switch phase2In {
        case 2:
            secondIdentifier = "2nd"
        case 3:
            secondIdentifier = "3rd"
        case 4:
            secondIdentifier = "4th"
        case 5:
            secondIdentifier = "5th"
        case 6:
            secondIdentifier = "6th"
        case 7:
            secondIdentifier = "7th"
        case 8:
            secondIdentifier = "8th"
        case 9:
            secondIdentifier = "9th"
        case 10:
            secondIdentifier = "10th"
        default:
            _ = ""
        }
        
        let errorMsg = firstIdentifier + " and " + secondIdentifier + " are duplicates"
        
        return errorMsg
    }
    
    // General function to search for any duplicate phases
    // Output:  error message (null if no error)
    // Note that all phases are checked to verify that they are numeric because, for
    // example, this function may be called by phase 1, but phase 2 might be invalid
    // and won't have been checked yet.
    func findPhaseDuplicates () -> String {
    
        // Clear the error message
        var errorMsg = ""
        var thePhase = ""
        var phaseArray = [String]()
        phaseArray.removeAll()

        var inPhase = phase1.text
        // Make sure only numbers are present
        if !isNum(dataIn: inPhase!) {
            errorMsg = badPhaseMessage
            return errorMsg
        }
        else {
            thePhase = prepPhase(phaseIn: inPhase!)
            phaseArray.append(thePhase)
        }
        
        inPhase = phase2.text
        // Make sure only numbers are present
        if !isNum(dataIn: inPhase!) {
            errorMsg = badPhaseMessage
            return errorMsg
        }
        else {
            thePhase = prepPhase(phaseIn: inPhase!)
            phaseArray.append(thePhase)
        }

        inPhase = phase3.text
        // Make sure only numbers are present
        if !isNum(dataIn: inPhase!) {
            errorMsg = badPhaseMessage
            return errorMsg
        }
        else {
            thePhase = prepPhase(phaseIn: inPhase!)
            phaseArray.append(thePhase)
        }
        
        inPhase = phase4.text
        // Make sure only numbers are present
        if !isNum(dataIn: inPhase!) {
            errorMsg = badPhaseMessage
            return errorMsg
        }
        else {
            thePhase = prepPhase(phaseIn: inPhase!)
            phaseArray.append(thePhase)
        }
        
        inPhase = phase5.text
        // Make sure only numbers are present
        if !isNum(dataIn: inPhase!) {
            errorMsg = badPhaseMessage
            return errorMsg
        }
        else {
            thePhase = prepPhase(phaseIn: inPhase!)
            phaseArray.append(thePhase)
        }
        
        inPhase = phase6.text
        // Make sure only numbers are present
        if !isNum(dataIn: inPhase!) {
            errorMsg = badPhaseMessage
            return errorMsg
        }
        else {
            thePhase = prepPhase(phaseIn: inPhase!)
            phaseArray.append(thePhase)
        }
        
        inPhase = phase7.text
        // Make sure only numbers are present
        if !isNum(dataIn: inPhase!) {
            errorMsg = badPhaseMessage
            return errorMsg
        }
        else {
            thePhase = prepPhase(phaseIn: inPhase!)
            phaseArray.append(thePhase)
        }
        
        inPhase = phase8.text
        // Make sure only numbers are present
        if !isNum(dataIn: inPhase!) {
            errorMsg = badPhaseMessage
            return errorMsg
        }
        else {
            thePhase = prepPhase(phaseIn: inPhase!)
            phaseArray.append(thePhase)
        }
        
        inPhase = phase9.text
        // Make sure only numbers are present
        if !isNum(dataIn: inPhase!) {
            errorMsg = badPhaseMessage
            return errorMsg
        }
        else {
            thePhase = prepPhase(phaseIn: inPhase!)
            phaseArray.append(thePhase)
        }
        
        inPhase = phase10.text
        // Make sure only numbers are present
        if !isNum(dataIn: inPhase!) {
            errorMsg = badPhaseMessage
            return errorMsg
        }
        else {
            thePhase = prepPhase(phaseIn: inPhase!)
            phaseArray.append(thePhase)
        }
        
        var idx1 = 0
        var idx2 = 0
        let skipPhase = "99"
        var foundDup = "n"
        
        while idx1 < 9 {
            idx2 = idx1 + 1
            while idx2 < 10 {
                if !(phaseArray[idx1] == skipPhase) {
                    if !(phaseArray[idx2] == skipPhase) {
                        if phaseArray[idx1] == phaseArray[idx2] {
                            errorMsg = makePhaseDupError(phase1In: idx1+1, phase2In: idx2+1)
                            foundDup = "y"
                            break
                        }
                    }
                }
                idx2 += 1
            }
            if foundDup == "n" {
                idx1 += 1
            }
            else {
                break
            }
        }

        return errorMsg
    }
    
    // General function to search for any odd phases if this is an "even" game,
    // or search for "even" phases if this is an "odd" game
    // Output:  error message (null if no error)
    // Note that there is no need to verify that each phase is numeric because
    // they were already verified in the findPhaseDuplicates function
    func doubleCheckOddEven () -> String {
    
        // Clear the error message
        var errorMsg = ""
        
        if gdefault.gamesPhaseModifier == allPhasesCode {
            return errorMsg
        }
            
        var phaseArray = [String]()
        phaseArray.removeAll()
        
        var inPhase = phase1.text
        var thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase2.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)

        inPhase = phase3.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase4.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase5.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase6.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase7.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase8.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase9.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase10.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        var pidx = 0
        while pidx < 10 {
            if gdefault.gamesPhaseModifier == evenPhasesCode {
                let thePhase = phaseArray[pidx]
                if thePhase == "001" ||
                   thePhase == "003" ||
                   thePhase == "005" ||
                   thePhase == "007" ||
                    thePhase == "009" {
                        errorMsg = "All phases must be even"
                        break
                }
            }
            if gdefault.gamesPhaseModifier == oddPhasesCode {
                let thePhase = phaseArray[pidx]
                if thePhase == "002" ||
                   thePhase == "004" ||
                   thePhase == "006" ||
                   thePhase == "008" ||
                    thePhase == "010" {
                        errorMsg = "All phases must be odd"
                        break
                }
            }
            pidx += 1
        }

        return errorMsg
    }
    
    // General function to search for any zero phases
    // Output:  error message (null if no error)
    // Note that there is no need to verify that each phase is numeric because
    // they were already verified in the findPhaseDuplicates function
    func doubleCheckZero () -> String {
    
        // Clear the error message
        var errorMsg = ""
        
        var phaseArray = [String]()
        phaseArray.removeAll()

        var inPhase = phase1.text
        var thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase2.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)

        inPhase = phase3.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase4.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase5.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase6.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase7.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase8.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase9.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        inPhase = phase10.text
        thePhase = prepPhase(phaseIn: inPhase!)
        phaseArray.append(thePhase)
        
        var pidx = 0
        while pidx < 10 {
            let thePhase = phaseArray[pidx]
            if thePhase == "000" {
                let phaseNumberText = "Phase " + String(format: "% 2d", pidx+1)
                errorMsg = phaseNumberText + " must not be zero"
                break
            }
            pidx += 1
        }

        return errorMsg
    }

    // Create error message for 3-digit phase
    // Input:   phase number
    // Output:  error message
    func make3DMessage(inPhase: Int) -> String {
        let phaseNumberText = "Phase " + String(format: "% 2d", inPhase)
        return phaseNumberText + " size max 2"
    }
    
    // General function to search for any 3-digit phases
    // Output:  error message (null if no error)
    // Note that there is no need to verify that each phase is numeric because
    // they were already verified in the findPhaseDuplicates function
    func doubleCheck3Digit () -> String {
    
        // Clear the error message
        var errorMsg = ""
        var thisPhaseNumber = 0
        
        if phase1.text!.count > 2 {
            thisPhaseNumber = 1
            errorMsg = make3DMessage(inPhase: thisPhaseNumber)
        }
        
        if errorMsg == "" {
            if phase2.text!.count > 2 {
                thisPhaseNumber = 2
                errorMsg = make3DMessage(inPhase: thisPhaseNumber)
            }
        }
        
        if errorMsg == "" {
            if phase3.text!.count > 2 {
                thisPhaseNumber = 3
                errorMsg = make3DMessage(inPhase: thisPhaseNumber)
            }
        }
        
        if errorMsg == "" {
            if phase4.text!.count > 2 {
                thisPhaseNumber = 4
                errorMsg = make3DMessage(inPhase: thisPhaseNumber)
            }
        }
        
        if errorMsg == "" {
            if phase5.text!.count > 2 {
                thisPhaseNumber = 5
                errorMsg = make3DMessage(inPhase: thisPhaseNumber)
            }
        }
        
        if errorMsg == "" {
            if phase6.text!.count > 2 {
                thisPhaseNumber = 6
                errorMsg = make3DMessage(inPhase: thisPhaseNumber)
            }
        }
        
        if errorMsg == "" {
            if phase7.text!.count > 2 {
                thisPhaseNumber = 7
                errorMsg = make3DMessage(inPhase: thisPhaseNumber)
            }
        }
        
        if errorMsg == "" {
            if phase8.text!.count > 2 {
                thisPhaseNumber = 8
                errorMsg = make3DMessage(inPhase: thisPhaseNumber)
            }
        }
        
        if errorMsg == "" {
            if phase9.text!.count > 2 {
                thisPhaseNumber = 9
                errorMsg = make3DMessage(inPhase: thisPhaseNumber)
            }
        }
        
        if errorMsg == "" {
            if phase10.text!.count > 2 {
                thisPhaseNumber = 10
                errorMsg = make3DMessage(inPhase: thisPhaseNumber)
            }
        }

        return errorMsg
    }
    
    // Create error message for 2-digit phase > 10
    // Input:   phase number
    // Output:  error message
    func make2DOver10Message(inPhase: Int) -> String {
        let phaseNumberText = "Phase " + String(format: "% 2d", inPhase)
        return phaseNumberText + " must be 1-10"
    }
    
    // General function to search for any 2-digit phases > 10
    // Output:  error message (null if no error)
    // Note that there is no need to verify that each phase is numeric because
    // they were already verified in the findPhaseDuplicates function
    func doubleCheck2DigitOver10 () -> String {
    
        // Clear the error message
        var errorMsg = ""
        var thisPhaseNumber = 0
        var integerPhase = 0

        var thePhase = phase1.text
        if thePhase!.count > 0 {
            integerPhase = Int(thePhase!)!
            if integerPhase > 10 {
                thisPhaseNumber = 1
                errorMsg = make2DOver10Message(inPhase: thisPhaseNumber)
            }
        }
        
        if errorMsg == "" {
            thePhase = phase2.text
            if thePhase!.count > 0 {
                integerPhase = Int(thePhase!)!
                if integerPhase > 10 {
                    thisPhaseNumber = 2
                    errorMsg = make2DOver10Message(inPhase: thisPhaseNumber)
                }
            }
        }
        
        if errorMsg == "" {
            thePhase = phase3.text
            if thePhase!.count > 0 {
                integerPhase = Int(thePhase!)!
                if integerPhase > 10 {
                    thisPhaseNumber = 3
                    errorMsg = make2DOver10Message(inPhase: thisPhaseNumber)
                }
            }
        }
        
        if errorMsg == "" {
            thePhase = phase4.text
            if thePhase!.count > 0 {
                integerPhase = Int(thePhase!)!
                if integerPhase > 10 {
                    thisPhaseNumber = 4
                    errorMsg = make2DOver10Message(inPhase: thisPhaseNumber)
                }
            }
        }
        
        if errorMsg == "" {
            thePhase = phase5.text
            if thePhase!.count > 0 {
                integerPhase = Int(thePhase!)!
                if integerPhase > 10 {
                    thisPhaseNumber = 5
                    errorMsg = make2DOver10Message(inPhase: thisPhaseNumber)
                }
            }
        }
        
        if errorMsg == "" {
            thePhase = phase6.text
            if thePhase!.count > 0 {
                integerPhase = Int(thePhase!)!
                if integerPhase > 10 {
                    thisPhaseNumber = 6
                    errorMsg = make2DOver10Message(inPhase: thisPhaseNumber)
                }
            }
        }
        
        if errorMsg == "" {
            thePhase = phase7.text
            if thePhase!.count > 0 {
                integerPhase = Int(thePhase!)!
                if integerPhase > 10 {
                    thisPhaseNumber = 7
                    errorMsg = make2DOver10Message(inPhase: thisPhaseNumber)
                }
            }
        }
        
        if errorMsg == "" {
            thePhase = phase8.text
            if thePhase!.count > 0 {
                integerPhase = Int(thePhase!)!
                if integerPhase > 10 {
                    thisPhaseNumber = 8
                    errorMsg = make2DOver10Message(inPhase: thisPhaseNumber)
                }
            }
        }
        
        if errorMsg == "" {
            thePhase = phase9.text
            if thePhase!.count > 0 {
                integerPhase = Int(thePhase!)!
                if integerPhase > 10 {
                    thisPhaseNumber = 9
                    errorMsg = make2DOver10Message(inPhase: thisPhaseNumber)
                }
            }
        }
        
        if errorMsg == "" {
            thePhase = phase10.text
            if thePhase!.count > 0 {
                integerPhase = Int(thePhase!)!
                if integerPhase > 10 {
                    thisPhaseNumber = 10
                    errorMsg = make2DOver10Message(inPhase: thisPhaseNumber)
                }
            }
        }

        return errorMsg
    }
    
    // Adjust the player chooses phase switch to yes (enabled) or no (disabled) depending on
    // whether or not a phase has been entered as being done as follows:
    // Not choosing phases:
    // - Show only one phase entry field (#5)
    // - Set player chooses phase switch to No
    // - If a phase has been entered, disable the switch, else enable it
    // Choosing phases:
    // - Show all 10 phase entry fields
    // - Set player chooses phase switch to Yes
    // - If any phase has been entered, disable the switch, else enable it
    func adjustPlayerChoosesPhase() {
        if phasesDone.text == "Phase Done" {
            playerChoosesPhaseSwitch.value = 0
            playerChoosesPhaseNo.textColor = appColorBrightGreen
            playerChoosesPhaseNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            playerChoosesPhaseYes.textColor = appColorDarkGray
            playerChoosesPhaseYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            if holdScreenPhase5 == "" {
                playerChoosesPhaseSwitch.isEnabled = true
            }
            else {
                playerChoosesPhaseSwitch.isEnabled = false
            }
        }
        else {
            playerChoosesPhaseSwitch.value = 1
            playerChoosesPhaseNo.textColor = appColorDarkGray
            playerChoosesPhaseNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            playerChoosesPhaseYes.textColor = appColorBrightGreen
            playerChoosesPhaseYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            if holdScreenPhase1 == "" &&
                holdScreenPhase2 == "" &&
                holdScreenPhase3 == "" &&
                holdScreenPhase4 == "" &&
                holdScreenPhase5 == "" &&
                holdScreenPhase6 == "" &&
                holdScreenPhase7 == "" &&
                holdScreenPhase8 == "" &&
                holdScreenPhase9 == "" &&
                holdScreenPhase10 == "" {
                    playerChoosesPhaseSwitch.isEnabled = true
            }
            else {
                    playerChoosesPhaseSwitch.isEnabled = false
            }
        }
    }
        
    // Edit phase 1
    @IBAction func phase1(_ sender: Any) {
        //print("EP P1  IN  phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
        let thePhase = phase1.text
        errorMessage.text = ""
        // Make sure only numbers are present
        if !isNum(dataIn: thePhase!) {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = badPhaseMessage
        }
        
        if errorMessage.text == "" {
            if thePhase == "" {
                holdScreenPhase1 = ""
            }
            else {
                let integerPhase = Int(thePhase!)
                holdScreenPhase1 = String(format: "%02d", integerPhase!)
            }
            errorMessage.text = basicPhaseEdit (phaseIn: thePhase!, phaseNumberIn: 1, modifierIn: gdefault.gamesPhaseModifier)
            if errorMessage.text == "" {
                errorMessage.text = findPhaseDuplicates()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckOddEven()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckZero()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck3Digit()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck2DigitOver10()
            }
            if errorMessage.text == "" {
                allowExitFromView = true
            }
            else {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
            }
        }
        
        // Reset the player chooses phase switch to enabled or disabled as appropriate
        adjustPlayerChoosesPhase()
        //print("EP P1  OUT phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
    }
    
    // Edit phase 2
    @IBAction func phase2(_ sender: Any) {
        //print("EP P2  IN  phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
        let thePhase = phase2.text
        errorMessage.text = ""
        // Make sure only numbers are present
        if !isNum(dataIn: thePhase!) {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = badPhaseMessage
        }
        
        if errorMessage.text == "" {
            if thePhase == "" {
                holdScreenPhase2 = ""
            }
            else {
                let integerPhase = Int(thePhase!)
                holdScreenPhase2 = String(format: "%02d", integerPhase!)
            }
            errorMessage.text = basicPhaseEdit (phaseIn: thePhase!, phaseNumberIn: 2, modifierIn: gdefault.gamesPhaseModifier)
            if errorMessage.text == "" {
                errorMessage.text = findPhaseDuplicates()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckOddEven()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckZero()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck3Digit()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck2DigitOver10()
            }
            if errorMessage.text == "" {
                allowExitFromView = true
            }
            else {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
            }
        }
        
        // Reset the player chooses phase switch to enabled or disabled as appropriate
        adjustPlayerChoosesPhase()
        //print("EP P2  OUT phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
    }
    
    // Edit phase 3
    @IBAction func phase3(_ sender: Any) {
        //print("EP P3  IN  phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
        let thePhase = phase3.text
        errorMessage.text = ""
        // Make sure only numbers are present
        if !isNum(dataIn: thePhase!) {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = badPhaseMessage
        }
        
        if errorMessage.text == "" {
            if thePhase == "" {
                holdScreenPhase3 = ""
            }
            else {
                let integerPhase = Int(thePhase!)
                holdScreenPhase3 = String(format: "%02d", integerPhase!)
            }
            errorMessage.text = basicPhaseEdit (phaseIn: thePhase!, phaseNumberIn: 3, modifierIn: gdefault.gamesPhaseModifier)
            if errorMessage.text == "" {
                errorMessage.text = findPhaseDuplicates()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckOddEven()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckZero()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck3Digit()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck2DigitOver10()
            }
            if errorMessage.text == "" {
                allowExitFromView = true
            }
            else {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
            }
        }
        
        // Reset the player chooses phase switch to enabled or disabled as appropriate
        adjustPlayerChoosesPhase()
        //print("EP P3  OUT phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
    }
    
    // Edit phase 4
    @IBAction func phase4(_ sender: Any) {
        //print("EP P4  IN  phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
        let thePhase = phase4.text
        errorMessage.text = ""
        // Make sure only numbers are present
        if !isNum(dataIn: thePhase!) {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = badPhaseMessage
        }
        
        if errorMessage.text == "" {
            if thePhase == "" {
                holdScreenPhase4 = ""
            }
            else {
                let integerPhase = Int(thePhase!)
                holdScreenPhase4 = String(format: "%02d", integerPhase!)
            }
            errorMessage.text = basicPhaseEdit (phaseIn: thePhase!, phaseNumberIn: 4, modifierIn: gdefault.gamesPhaseModifier)
            if errorMessage.text == "" {
                errorMessage.text = findPhaseDuplicates()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckOddEven()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckZero()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck3Digit()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck2DigitOver10()
            }
            if errorMessage.text == "" {
                allowExitFromView = true
            }
            else {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
            }
        }
        
        // Reset the player chooses phase switch to enabled or disabled as appropriate
        adjustPlayerChoosesPhase()
        //print("EP P4  OUT phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
    }
    
    // Phase 5 does double-duty. If the player is not choosing phases, then
    // phase5 is the only phase field accessible, and is used to specify the
    // highest completed phase for this player.
    // If the player chooses phases, then it is used to process phase 5 in
    // conjunction with the other 9 phases.
    // The phase is always optional, but if present it must be a maximum of
    // 2 digits ranging from 1 to 10. If it is being processed in conjunction
    // with the other 9 phases, then it must not duplicate any of them.
    @IBAction func phase5(_ sender: Any) {
        //print("EP P5  IN  phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
        let thePhase = phase5.text
        errorMessage.text = ""
        // Make sure only numbers are present
        if !isNum(dataIn: thePhase!) {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = badPhaseMessage
        }
        
        if errorMessage.text == "" {
            if thePhase == "" {
                holdScreenPhase5 = ""
            }
            else {
                let integerPhase = Int(thePhase!)
                holdScreenPhase5 = String(format: "%02d", integerPhase!)
            }
            if gdefault.gamesPlayerChoosesPhase[thePlayerIndex] == playerDoesNotChoosePhaseConstant {
                // This is when this phase is ALONE
                errorMessage.text = basicPhaseEdit (phaseIn: thePhase!, phaseNumberIn: 99, modifierIn: gdefault.gamesPhaseModifier)
                if errorMessage.text == "" {
                    allowExitFromView = true
                }
                else {
                    errorMessage.textColor = appColorRed
                    errorMessage.backgroundColor = appColorYellow
                }
            }
            else {
                // This is when this phase (#5) is just 1 of 10 phases being edited
                errorMessage.text = basicPhaseEdit (phaseIn: thePhase!, phaseNumberIn: 5, modifierIn: gdefault.gamesPhaseModifier)
                if errorMessage.text == "" {
                    errorMessage.text = findPhaseDuplicates()
                }
                if errorMessage.text == "" {
                    errorMessage.text = doubleCheckOddEven()
                }
                if errorMessage.text == "" {
                    errorMessage.text = doubleCheckZero()
                }
                if errorMessage.text == "" {
                    errorMessage.text = doubleCheck3Digit()
                }
                if errorMessage.text == "" {
                    errorMessage.text = doubleCheck2DigitOver10()
                }
                if errorMessage.text == "" {
                    allowExitFromView = true
                }
                else {
                    errorMessage.textColor = appColorRed
                    errorMessage.backgroundColor = appColorYellow
                }
            }
        }
        
        // Reset the player chooses phase switch to enabled or disabled as appropriate
        adjustPlayerChoosesPhase()
        //print("EP P5  OUT phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
    }
    
    // Edit phase 6
    @IBAction func phase6(_ sender: Any) {
        //print("EP P6  IN  phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
        let thePhase = phase6.text
        errorMessage.text = ""
        // Make sure only numbers are present
        if !isNum(dataIn: thePhase!) {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = badPhaseMessage
        }
        
        if errorMessage.text == "" {
            if thePhase == "" {
                holdScreenPhase6 = ""
            }
            else {
                let integerPhase = Int(thePhase!)
                holdScreenPhase6 = String(format: "%02d", integerPhase!)
            }
            errorMessage.text = basicPhaseEdit (phaseIn: thePhase!, phaseNumberIn: 6, modifierIn: gdefault.gamesPhaseModifier)
            if errorMessage.text == "" {
                errorMessage.text = findPhaseDuplicates()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckOddEven()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckZero()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck3Digit()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck2DigitOver10()
            }
            if errorMessage.text == "" {
                allowExitFromView = true
            }
            else {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
            }
        }
        
        // Reset the player chooses phase switch to enabled or disabled as appropriate
        adjustPlayerChoosesPhase()
        //print("EP P6  OUT phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
    }
    
    // Edit phase 7
    @IBAction func phase7(_ sender: Any) {
        //print("EP P7  IN  phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
        let thePhase = phase7.text
        errorMessage.text = ""
        // Make sure only numbers are present
        if !isNum(dataIn: thePhase!) {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = badPhaseMessage
        }
        
        if errorMessage.text == "" {
            if thePhase == "" {
                holdScreenPhase7 = ""
            }
            else {
                let integerPhase = Int(thePhase!)
                holdScreenPhase7 = String(format: "%02d", integerPhase!)
            }
            errorMessage.text = basicPhaseEdit (phaseIn: thePhase!, phaseNumberIn: 7, modifierIn: gdefault.gamesPhaseModifier)
            if errorMessage.text == "" {
                errorMessage.text = findPhaseDuplicates()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckOddEven()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckZero()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck3Digit()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck2DigitOver10()
            }
            if errorMessage.text == "" {
                allowExitFromView = true
            }
            else {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
            }
        }
        
        // Reset the player chooses phase switch to enabled or disabled as appropriate
        adjustPlayerChoosesPhase()
        //print("EP P7  OUT phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
    }
    
    // Edit phase 8
    @IBAction func phase8(_ sender: Any) {
        //print("EP P8  IN  phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
        let thePhase = phase8.text
        errorMessage.text = ""
        // Make sure only numbers are present
        if !isNum(dataIn: thePhase!) {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = badPhaseMessage
        }
        
        if errorMessage.text == "" {
            if thePhase == "" {
                holdScreenPhase8 = ""
            }
            else {
                let integerPhase = Int(thePhase!)
                holdScreenPhase8 = String(format: "%02d", integerPhase!)
            }
            errorMessage.text = basicPhaseEdit (phaseIn: thePhase!, phaseNumberIn: 8, modifierIn: gdefault.gamesPhaseModifier)
            if errorMessage.text == "" {
                errorMessage.text = findPhaseDuplicates()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckOddEven()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckZero()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck3Digit()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck2DigitOver10()
            }
            if errorMessage.text == "" {
                allowExitFromView = true
            }
            else {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
            }
        }
        
        // Reset the player chooses phase switch to enabled or disabled as appropriate
        adjustPlayerChoosesPhase()
        //print("EP P8  OUT phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
    }
    
    // Edit phase 9
    @IBAction func phase9(_ sender: Any) {
        //print("EP P9  IN  phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
        let thePhase = phase9.text
        errorMessage.text = ""
        // Make sure only numbers are present
        if !isNum(dataIn: thePhase!) {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = badPhaseMessage
        }
        
        if errorMessage.text == "" {
            if thePhase == "" {
                holdScreenPhase9 = ""
            }
            else {
                let integerPhase = Int(thePhase!)
                holdScreenPhase9 = String(format: "%02d", integerPhase!)
            }
            errorMessage.text = basicPhaseEdit (phaseIn: thePhase!, phaseNumberIn: 9, modifierIn: gdefault.gamesPhaseModifier)
            if errorMessage.text == "" {
                errorMessage.text = findPhaseDuplicates()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckOddEven()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckZero()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck3Digit()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck2DigitOver10()
            }
            if errorMessage.text == "" {
                allowExitFromView = true
            }
            else {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
            }
        }
        
        // Reset the player chooses phase switch to enabled or disabled as appropriate
        adjustPlayerChoosesPhase()
        //print("EP P9  OUT phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
    }
    
    // Edit phase 10
    @IBAction func phase10(_ sender: Any) {
        //print("EP P10 IN  phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
        let thePhase = phase10.text
        errorMessage.text = ""
        // Make sure only numbers are present
        if !isNum(dataIn: thePhase!) {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = badPhaseMessage
        }
        
        if errorMessage.text == "" {
            if thePhase == "" {
                holdScreenPhase10 = ""
            }
            else {
                let integerPhase = Int(thePhase!)
                holdScreenPhase10 = String(format: "%02d", integerPhase!)
            }
            errorMessage.text = basicPhaseEdit (phaseIn: thePhase!, phaseNumberIn: 10, modifierIn: gdefault.gamesPhaseModifier)
            if errorMessage.text == "" {
                errorMessage.text = findPhaseDuplicates()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckOddEven()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheckZero()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck3Digit()
            }
            if errorMessage.text == "" {
                errorMessage.text = doubleCheck2DigitOver10()
            }
            if errorMessage.text == "" {
                allowExitFromView = true
            }
            else {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
            }
        }
        
        // Reset the player chooses phase switch to enabled or disabled as appropriate
        adjustPlayerChoosesPhase()
        //print("EP P10 OUT phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
    }
    
    // Function to add a "done" button on the points numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboard4() {
        let doneToolbar4: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar4.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done4: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditPlayer.doneButtonAction4))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done4)
        
        doneToolbar4.items = items
        doneToolbar4.sizeToFit()
        
        self.points.inputAccessoryView = doneToolbar4
    }
    
    // Make the keyboard for points with the newly-added done button disappear
    @objc func doneButtonAction4 () {
        self.points.resignFirstResponder()
    }

    // Edit points
    @IBAction func points(_ sender: Any) {
        // Clear the error message
        errorMessage.text = ""
        
        //print("EP P entered points size=\(points.text!.count)")
        let pointsToSet = points.text
        
        if pointsToSet!.count == 0 {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = "Points are missing"
        }
        
        if errorMessage.text == "" {
            // Make sure only numbers are present
            if !isNum(dataIn: pointsToSet!) {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Points must use 0-9"
            }
            else if pointsToSet!.count > 4 {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Points size max 4"
            }
        }
        
        if errorMessage.text == "" {
            let integerPointsToSet = Int(pointsToSet!)
            if !(integerPointsToSet! / 5 * 5 == integerPointsToSet) {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Points must be 0 or a multiple of 5"
            }
            else {
                gdefault.gamesPlayerPoints[thePlayerIndex] = String(format: "%04d", integerPointsToSet!)
                gdefault.gamesPlayerStartRoundPoints[thePlayerIndex] = gdefault.gamesPlayerPoints[thePlayerIndex]
                // Always enable this player's add points button
                let bidx = (gdefault.playerIdxByButton[gdefault.editPlayerButtonIndex] * 5) + 1
                gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeEnabled
                allowExitFromView = true
            }
        }
    }
    
    // Function to add a "done" button on the dealer sequence numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboard3() {
        let doneToolbar3: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar3.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done3: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditPlayer.doneButtonAction3))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done3)
        
        doneToolbar3.items = items
        doneToolbar3.sizeToFit()
        
        self.dealerSequence.inputAccessoryView = doneToolbar3
    }
    
    // Make the keyboard for dealer sequence with the newly-added done button disappear
    @objc func doneButtonAction3 () {
        self.dealerSequence.resignFirstResponder()
    }
    
    // Edit dealer sequence
    @IBAction func dealerSequence(_ sender: Any) {
        
        // Clear the error message
        errorMessage.text = ""
        
        //print("EP dS entered sequence size=\(dealerSequence.text!.count)")
        let theDealerSequence = dealerSequence.text
        
        if errorMessage.text == "" {
            if theDealerSequence!.count == 0 {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Dealer sequence missing"
            }
            else if theDealerSequence == " " {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Dealer sequence is blank"
            }
            // Make sure only numbers are present
            else if !isNum(dataIn: theDealerSequence!) {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Dealer sequence must use 0-9"
            }
            else if theDealerSequence!.count > 2 {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Dealer sequence size max 2"
            }
            else if Int(theDealerSequence!) == 0 {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Dealer sequence must not be zero"
            }
        }

        if errorMessage.text == "" {
            var pcount = 0
            integerDealerSequence = Int(theDealerSequence!)!
            //print("EP dS searching for dups for dealer sequence \(String(describing: theDealerSequence))")
            while pcount < gdefault.gamesLengthPlayerNameOccurs {
                let integerDealerOrder = Int(gdefault.gamesPlayerDealerOrder[pcount])
                //print("EP dS testing entered dealer seq \(String(describing: integerDealerSequence)) vs GS seq \(String(describing: integerDealerOrder)) at idx \(pcount)")
                if !(pcount == thePlayerIndex) &&
                    integerDealerSequence == integerDealerOrder {
                        break
                }
                pcount += 1
            }
            if pcount < gdefault.gamesLengthPlayerNameOccurs {
                //print("EP dS got duplicate at index \(pcount)")
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Duplicate dealer sequence"
            }
            else {
                gdefault.gamesPlayerDealerOrder[thePlayerIndex] = String(format: "%02d", integerDealerSequence)
                allowExitFromView = true
            }
        }
    }
    
    // Edit mark as dealer switch
    
    @IBAction func markAsDealerSwitch(_ sender: UISlider) {
        // Set value to the nearest 1 and set fonts and colors of the
        // associated yes/no indicators. However, the user may not
        // unmark a player, because we don't know who to mark instead.
        // If this player is not the current dealer, it is allowable to mark this
        // player as the dealer because we can always unmark the current dealer
        // since we know who it is, but then it is not allowable to change the
        // player back to not being the dealer.
        sender.setValue((Float)((Int)((sender.value + 0.5) / 1) * 1), animated: false)
        //print("EP mADS my mads switch = \(markAsDealerSwitchEnabled)")
        //let sval = Int(markAsDealerSwitch.value)
        //print("EP mADS the value of the slider switch is \(sval)")
        if markAsDealerSwitchEnabled == "y" {
            // It is allowable to change the dealer switch (in this case, always from
            // not being the dealer to being the dealer). The switch is then set so that
            // the dealer cannot be reset.
            //print("AE mADS current dealer being set to \(thePlayerEntrySequence)")
            gdefault.gamesCurrentDealer = String(format: "%02d", thePlayerEntrySequence)
            markAsDealerNo.textColor = appColorDarkGray
            markAsDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            markAsDealerYes.textColor = appColorBrightGreen
            markAsDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            markAsDealerMore1.text = "To change dealer again,"
            markAsDealerMore2.text = "select another player."
            markAsDealerSwitchEnabled = "n"
        }
        // It is not allowable to change the dealer switch
        else {
            if gdefault.gamesTrackDealer == notTrackingDealerConstant {
                // The dealer is not being tracked, so this switch is set to NO
                markAsDealerSwitch.value = 0
            }
            else {
                // The dealer is being tracked, and this must be the dealer, so the switch is set to YES
                markAsDealerSwitch.value = 1
            }
        }
        allowExitFromView = true
    }
    
    // Edit player chooses phase switch
    @IBAction func playerChoosesPhaseSwitch(_ sender: UISlider) {
        // Set value to the nearest 1 and set fonts and colors of the
        // associated yes/no indicators. This switch may not be changed if this
        // player has cleared any phase. NOTE THAT IF THIS PLAYER CLEARED ANY PHASE,
        // THE PLAYER CHOOSES PHASE SWITCH WAS ALREADY DISABLED EARLIER AND A MESSAGE WAS
        // PROVIDED FOR THE USER.
        sender.setValue((Float)((Int)((sender.value + 0.5) / 1) * 1), animated: false)
        let sval = Int(playerChoosesPhaseSwitch.value)
        if sval == 0 {
            gdefault.gamesPlayerChoosesPhase[thePlayerIndex] = playerDoesNotChoosePhaseConstant
            playerChoosesPhaseSwitch.value = 0
            playerChoosesPhaseNo.textColor = appColorBrightGreen
            playerChoosesPhaseNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            playerChoosesPhaseYes.textColor = appColorDarkGray
            playerChoosesPhaseYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        }
        else {
            gdefault.gamesPlayerChoosesPhase[thePlayerIndex] = playerChoosesPhaseConstant
            playerChoosesPhaseSwitch.value = 1
            playerChoosesPhaseNo.textColor = appColorDarkGray
            playerChoosesPhaseNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            playerChoosesPhaseYes.textColor = appColorBrightGreen
            playerChoosesPhaseYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
        }
        
        // Reset the phase area from just one phase to all ten phases, or from
        // all ten phases to just one as appropriate
        setupPhaseFields ()
        allowExitFromView = true
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        gdefault.RemovePressed = "1"
        // Reinstate the original field values as they were before invoking edit player
        let pidx = gdefault.playerIdxByButton[gdefault.editPlayerButtonIndex]
        gdefault.gamesPlayerName[pidx] = gdefault.preEditPlayerPlayerName
        gdefault.gamesPlayerPhase1[pidx] = gdefault.preEditPlayerPhase1
        gdefault.gamesPlayerPhase2[pidx] = gdefault.preEditPlayerPhase2
        gdefault.gamesPlayerPhase3[pidx] = gdefault.preEditPlayerPhase3
        gdefault.gamesPlayerPhase4[pidx] = gdefault.preEditPlayerPhase4
        gdefault.gamesPlayerPhase5[pidx] = gdefault.preEditPlayerPhase5
        gdefault.gamesPlayerPhase6[pidx] = gdefault.preEditPlayerPhase6
        gdefault.gamesPlayerPhase7[pidx] = gdefault.preEditPlayerPhase7
        gdefault.gamesPlayerPhase8[pidx] = gdefault.preEditPlayerPhase8
        gdefault.gamesPlayerPhase9[pidx] = gdefault.preEditPlayerPhase9
        gdefault.gamesPlayerPhase10[pidx] = gdefault.preEditPlayerPhase10
        gdefault.gamesPlayerCurrentPhase[pidx] = gdefault.preEditPlayerCurrentPhase
        gdefault.gamesPlayerStartRoundPhases[pidx] = gdefault.preEditPlayerStartRoundPhase
        gdefault.gamesPlayerPoints[pidx] = gdefault.preEditPlayerPoints
        gdefault.gamesPlayerStartRoundPoints[pidx] = gdefault.preEditPlayerStartRoundPoints
        gdefault.gamesPlayerDealerOrder[pidx] = gdefault.preEditPlayerDealerOrder
        gdefault.gamesCurrentDealer = gdefault.preEditPlayerCurrentDealer
        gdefault.gamesPlayerChoosesPhase[pidx] = gdefault.preEditPlayerPlayerChoosesPhaseIndicator
        allowExitFromView = true
    }
    
    // General function to drive the update for a player who does not choose phases
    // See function aUpdateButton for the procedure
    func driveUpdateNoChoice () {
        
        let bidx = gdefault.playerIdxByButton[gdefault.editPlayerButtonIndex] * 5
        //print("EP dUNC button index before update is \(bidx)")
        //print("EP dUNC button status before update is \(gdefault.gamesPlayerButtonStatus[bidx])")
        //print("EP dUNC phase before update is \(gdefault.gamesPlayerCurrentPhase[thePlayerIndex])")
        //print("EP dUNC phase before update (pre-edit) is \(gdefault.preEditPlayerCurrentPhase)")
        
        // Initialize phases
        gdefault.gamesPlayerPhase1[thePlayerIndex] = gdefault.gamesPhase1
        gdefault.gamesPlayerPhase2[thePlayerIndex] = gdefault.gamesPhase2
        gdefault.gamesPlayerPhase3[thePlayerIndex] = gdefault.gamesPhase3
        gdefault.gamesPlayerPhase4[thePlayerIndex] = gdefault.gamesPhase4
        gdefault.gamesPlayerPhase5[thePlayerIndex] = gdefault.gamesPhase5
        gdefault.gamesPlayerPhase6[thePlayerIndex] = gdefault.gamesPhase6
        gdefault.gamesPlayerPhase7[thePlayerIndex] = gdefault.gamesPhase7
        gdefault.gamesPlayerPhase8[thePlayerIndex] = gdefault.gamesPhase8
        gdefault.gamesPlayerPhase9[thePlayerIndex] = gdefault.gamesPhase9
        gdefault.gamesPlayerPhase10[thePlayerIndex] = gdefault.gamesPhase10
        
        // Increment cleared phases
        if !(holdScreenPhase5 == "") {
            let phaseLimit = Int(holdScreenPhase5)
            var newPhaseValue = 0
            switch gdefault.gamesPhaseModifier {
            case oddPhasesCode:
                if phaseLimit! > 0 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase1[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase1[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 2 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase3[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase3[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 4 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase5[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase5[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 6 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase7[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase7[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 8 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase9[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase9[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
            case evenPhasesCode:
                if phaseLimit! > 1 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase2[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase2[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 3 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase4[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase4[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 5 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase6[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase6[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 7 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase8[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase8[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 9 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase10[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase10[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
            case allPhasesCode:
                if phaseLimit! > 0 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase1[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase1[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 1 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase2[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase2[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 2 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase3[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase3[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 3 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase4[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase4[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 4 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase5[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase5[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 5 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase6[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase6[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 6 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase7[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase7[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 7 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase8[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase8[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 8 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase9[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase9[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
                if phaseLimit! > 9 {
                    newPhaseValue = Int(gdefault.gamesPlayerPhase10[thePlayerIndex])! + intPhaseDivider
                    gdefault.gamesPlayerPhase10[thePlayerIndex] = String(format: "%03d", newPhaseValue)
                }
            default:
                _ = ""
            }
        }
        
        // Set start-of-round phase
        //print("EP dUNC setting start-of-round phase")
        switch holdScreenPhase5 {
        case "":
            //print("EP dUNC case null")
            switch gdefault.gamesPhaseModifier {
            case evenPhasesCode:
                //print("EP dUNC phase modifier is even - set to \(gdefault.gamesPhase2)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase2
            case oddPhasesCode:
                //print("EP dUNC phase modifier is odd - set to \(gdefault.gamesPhase1)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase1
            case allPhasesCode:
                //print("EP dUNC phase modifier is all - set to \(gdefault.gamesPhase1)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase1
            default:
                _=""
            }
        case "01":
            //print("EP dUNC case 01")
            switch gdefault.gamesPhaseModifier {
            case oddPhasesCode:
                //print("EP dUNC phase modifier is odd - set to \(gdefault.gamesPhase3)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase3
            case allPhasesCode:
                //print("EP dUNC phase modifier is all - set to \(gdefault.gamesPhase2)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase2
            default:
                _=""
            }
        case "02":
            //print("EP dUNC case 02")
            switch gdefault.gamesPhaseModifier {
            case evenPhasesCode:
                //print("EP dUNC phase modifier is even - set to \(gdefault.gamesPhase4)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase4
            case allPhasesCode:
                //print("EP dUNC phase modifier is all - set to \(gdefault.gamesPhase3)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase3
            default:
                _=""
            }
        case "03":
            //print("EP dUNC case 03")
            switch gdefault.gamesPhaseModifier {
            case oddPhasesCode:
                //print("EP dUNC phase modifier is odd - set to \(gdefault.gamesPhase5)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase5
            case allPhasesCode:
                //print("EP dUNC phase modifier is all - set to \(gdefault.gamesPhase4)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase4
            default:
                _=""
            }
        case "04":
            //print("EP dUNC case 04")
            switch gdefault.gamesPhaseModifier {
            case evenPhasesCode:
                //print("EP dUNC phase modifier is even - set to \(gdefault.gamesPhase6)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase6
            case allPhasesCode:
                //print("EP dUNC phase modifier is all - set to \(gdefault.gamesPhase5)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase5
            default:
                _=""
            }
        case "05":
            //print("EP dUNC case 05")
            switch gdefault.gamesPhaseModifier {
            case oddPhasesCode:
                //print("EP dUNC phase modifier is odd - set to \(gdefault.gamesPhase7)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase7
            case allPhasesCode:
                //print("EP dUNC phase modifier is all - set to \(gdefault.gamesPhase6)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase6
            default:
                _=""
            }
        case "06":
            //print("EP dUNC case 06")
            switch gdefault.gamesPhaseModifier {
            case evenPhasesCode:
                //print("EP dUNC phase modifier is even - set to \(gdefault.gamesPhase8)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase8
            case allPhasesCode:
                //print("EP dUNC phase modifier is all - set to \(gdefault.gamesPhase7)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase7
            default:
                _=""
            }
        case "07":
            //print("EP dUNC case 07")
            switch gdefault.gamesPhaseModifier {
            case oddPhasesCode:
                //print("EP dUNC phase modifier is odd - set to \(gdefault.gamesPhase9)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase9
            case allPhasesCode:
                //print("EP dUNC phase modifier is all - set to \(gdefault.gamesPhase8)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase8
            default:
                _=""
            }
        case "08":
            //print("EP dUNC case 08")
            switch gdefault.gamesPhaseModifier {
            case evenPhasesCode:
                //print("EP dUNC phase modifier is even - set to \(gdefault.gamesPhase10)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase10
            case allPhasesCode:
                //print("EP dUNC phase modifier is all - set to \(gdefault.gamesPhase9)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase9
            default:
                _=""
            }
        case "09":
            //print("EP dUNC case 09")
            switch gdefault.gamesPhaseModifier {
            case oddPhasesCode:
                //print("EP dUNC phase modifier is odd - set to \(constantPhase11)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = constantPhase11
            case allPhasesCode:
                //print("EP dUNC phase modifier is all - set to \(gdefault.gamesPhase10)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = gdefault.gamesPhase10
            default:
                _=""
            }
        case "10":
            //print("EP dUNC case 10")
            switch gdefault.gamesPhaseModifier {
            case evenPhasesCode:
                //print("EP dUNC phase modifier is even - set to \(constantPhase11)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = constantPhase11
            case allPhasesCode:
                //print("EP dUNC phase modifier is all - set to \(constantPhase11)")
                gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = constantPhase11
            default:
                _=""
            }
        default:
            _ = ""
        }
        
        // Set current phase
        if holdScreenPhase5 == "" {
            if gdefault.gamesPhaseModifier == evenPhasesCode {
                //print("EP dUNC setting current phase to 2")
                gdefault.gamesPlayerCurrentPhase[thePlayerIndex] = "02"
            }
            else {
                //print("EP dUNC setting current phase to 1")
                gdefault.gamesPlayerCurrentPhase[thePlayerIndex] = "01"
            }
        }
        else {
            var tempPhase = Int(holdScreenPhase5)
            if gdefault.gamesPhaseModifier == allPhasesCode {
                tempPhase! += 1
            }
            else {
                tempPhase! += 2
            }
            if tempPhase! > 10 {
                tempPhase = 10
            }
            gdefault.gamesPlayerCurrentPhase[thePlayerIndex] = String(format: "%02d", tempPhase!)
            //print("EP dUNC setting current phase to \(gdefault.gamesPlayerCurrentPhase[thePlayerIndex])")
        }
        // Always enable this player's clear phase button
        //print("EP dUNC updated current phase is \(gdefault.gamesPlayerCurrentPhase[thePlayerIndex])")
        //print("EP dUNC always resetting clear phase button status to e")
        gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeEnabled
    }
    
    // General function to set the value of a phase - used when the player chooses phases
    // Input:   phase to be set
    // Output:  phase 1, or 2, or ..., or 10 based on input phase
    //          The phase will be set to the game standard phase plus the divider
    //          Also, the actual standard phase is returned (it's used later to set the
    //          start-of-round phase)
    func setAChoicePhase (phaseIn: String) -> String {
        var newPhaseValue = 0
        switch phaseIn {
        case "01":
            newPhaseValue = Int(gdefault.gamesPhase1)! + intPhaseDivider
            gdefault.gamesPlayerPhase1[thePlayerIndex] = String(format: "%03d", newPhaseValue)
            return gdefault.gamesPhase1
        case "02":
            newPhaseValue = Int(gdefault.gamesPhase2)! + intPhaseDivider
            gdefault.gamesPlayerPhase2[thePlayerIndex] = String(format: "%03d", newPhaseValue)
            return gdefault.gamesPhase2
        case "03":
            newPhaseValue = Int(gdefault.gamesPhase3)! + intPhaseDivider
            gdefault.gamesPlayerPhase3[thePlayerIndex] = String(format: "%03d", newPhaseValue)
            return gdefault.gamesPhase3
        case "04":
            newPhaseValue = Int(gdefault.gamesPhase4)! + intPhaseDivider
            gdefault.gamesPlayerPhase4[thePlayerIndex] = String(format: "%03d", newPhaseValue)
            return gdefault.gamesPhase4
        case "05":
            newPhaseValue = Int(gdefault.gamesPhase5)! + intPhaseDivider
            gdefault.gamesPlayerPhase5[thePlayerIndex] = String(format: "%03d", newPhaseValue)
            return gdefault.gamesPhase5
        case "06":
            newPhaseValue = Int(gdefault.gamesPhase6)! + intPhaseDivider
            gdefault.gamesPlayerPhase6[thePlayerIndex] = String(format: "%03d", newPhaseValue)
            return gdefault.gamesPhase6
        case "07":
            newPhaseValue = Int(gdefault.gamesPhase7)! + intPhaseDivider
            gdefault.gamesPlayerPhase7[thePlayerIndex] = String(format: "%03d", newPhaseValue)
            return gdefault.gamesPhase7
        case "08":
            newPhaseValue = Int(gdefault.gamesPhase8)! + intPhaseDivider
            gdefault.gamesPlayerPhase8[thePlayerIndex] = String(format: "%03d", newPhaseValue)
            return gdefault.gamesPhase8
        case "09":
            newPhaseValue = Int(gdefault.gamesPhase9)! + intPhaseDivider
            gdefault.gamesPlayerPhase9[thePlayerIndex] = String(format: "%03d", newPhaseValue)
            return gdefault.gamesPhase9
        case "10":
            newPhaseValue = Int(gdefault.gamesPhase10)! + intPhaseDivider
            gdefault.gamesPlayerPhase10[thePlayerIndex] = String(format: "%03d", newPhaseValue)
            return gdefault.gamesPhase10
        default:
            _ = ""
            return initZeroPhase3
        }
    }
    
    // General function to drive the update for a player who does choose phases
    // See function aUpdateButton for the procedure
    func driveUpdateChoice () {
        let bidx = gdefault.playerIdxByButton[gdefault.editPlayerButtonIndex] * 5
        //print("EP dUC button index before update is \(bidx)")
        //print("EP dUC button status before update is \(gdefault.gamesPlayerButtonStatus[bidx])")
        
        // Initialize phases
        gdefault.gamesPlayerPhase1[thePlayerIndex] = initZeroPhase3
        gdefault.gamesPlayerPhase2[thePlayerIndex] = initZeroPhase3
        gdefault.gamesPlayerPhase3[thePlayerIndex] = initZeroPhase3
        gdefault.gamesPlayerPhase4[thePlayerIndex] = initZeroPhase3
        gdefault.gamesPlayerPhase5[thePlayerIndex] = initZeroPhase3
        gdefault.gamesPlayerPhase6[thePlayerIndex] = initZeroPhase3
        gdefault.gamesPlayerPhase7[thePlayerIndex] = initZeroPhase3
        gdefault.gamesPlayerPhase8[thePlayerIndex] = initZeroPhase3
        gdefault.gamesPlayerPhase9[thePlayerIndex] = initZeroPhase3
        gdefault.gamesPlayerPhase10[thePlayerIndex] = initZeroPhase3
        
        var highestStandardPhase = initZeroPhase3
        var thisPhase = ""

        // Increment cleared phases
        if !(holdScreenPhase1 == "") {
            thisPhase = setAChoicePhase(phaseIn: holdScreenPhase1)
            if thisPhase > highestStandardPhase {
                highestStandardPhase = thisPhase
            }
        }
        if !(holdScreenPhase2 == "") {
            thisPhase = setAChoicePhase(phaseIn: holdScreenPhase2)
            if thisPhase > highestStandardPhase {
                highestStandardPhase = thisPhase
            }
        }
        if !(holdScreenPhase3 == "") {
            thisPhase = setAChoicePhase(phaseIn: holdScreenPhase3)
            if thisPhase > highestStandardPhase {
                highestStandardPhase = thisPhase
            }
        }
        if !(holdScreenPhase4 == "") {
            thisPhase = setAChoicePhase(phaseIn: holdScreenPhase4)
            if thisPhase > highestStandardPhase {
                highestStandardPhase = thisPhase
            }
        }
        if !(holdScreenPhase5 == "") {
            thisPhase = setAChoicePhase(phaseIn: holdScreenPhase5)
            if thisPhase > highestStandardPhase {
                highestStandardPhase = thisPhase
            }
        }
        if !(holdScreenPhase6 == "") {
            thisPhase = setAChoicePhase(phaseIn: holdScreenPhase6)
            if thisPhase > highestStandardPhase {
                highestStandardPhase = thisPhase
            }
        }
        if !(holdScreenPhase7 == "") {
            thisPhase = setAChoicePhase(phaseIn: holdScreenPhase7)
            if thisPhase > highestStandardPhase {
                highestStandardPhase = thisPhase
            }
        }
        if !(holdScreenPhase8 == "") {
            thisPhase = setAChoicePhase(phaseIn: holdScreenPhase8)
            if thisPhase > highestStandardPhase {
                highestStandardPhase = thisPhase
            }
        }
        if !(holdScreenPhase9 == "") {
            thisPhase = setAChoicePhase(phaseIn: holdScreenPhase9)
            if thisPhase > highestStandardPhase {
                highestStandardPhase = thisPhase
            }
        }
        if !(holdScreenPhase10 == "") {
            thisPhase = setAChoicePhase(phaseIn: holdScreenPhase10)
            if thisPhase > highestStandardPhase {
                highestStandardPhase = thisPhase
            }
        }
        
        // Set start-of-round phase
        gdefault.gamesPlayerStartRoundPhases[thePlayerIndex] = highestStandardPhase
        
        // Set current phase
        gdefault.gamesPlayerCurrentPhase[thePlayerIndex] = initZeroPhase2
        
        // Always enable this player's clear phase button
        //print("EP dUC always resetting clear phase button status to e")
        gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeEnabled
    }
    
    // Update the phases as follows:
    //
    // If the player is not choosing phases:
    // - Set all phases to the game's standard phases.
    // - Increment either just the odd, even, or all phases by the phase divider based on the phase modifier.
    // - If there is no phase update, set the start-of-round phase to 2 if even, or 1 otherwise.
    //   If there is a phase update, set the start-of-round phase to the game standard phase that corresponds
    //   to the phase update.
    // - If there is no phase update, set the current phase to 2 for even, or 2 otherwise.
    //   If there is a phase update, set the current phase to the value of the phase update plus:
    //      1 if the phase modifier is all, or
    //      2 otherwise.
    //
    // If the player is choosing phases:
    // - Set all phases to 0.
    // - For each phase update that is not equal to "", use its value to increment the corresponding standard
    //   phase by the divider.
    // - If there is no phase update, set the start-of-round phase to 0.
    //   If there is a phase update, choose the highest non-null phase update, and use its value to set
    //   start-of-round.
    // - Set the current phase to 0.
    //
    // Finally update the games and history files
    @IBAction func aUpdateButton(_ sender: Any) {
        gdefault.RemovePressed = "1"
        //print("EP aUB IN  choice      =\(gdefault.gamesPlayerChoosesPhase[thePlayerIndex]) current phase=\(gdefault.gamesPlayerCurrentPhase[thePlayerIndex])")
        //print("EP aUB IN  Std phases  =\(gdefault.gamesPlayerPhase1[thePlayerIndex]) \(gdefault.gamesPlayerPhase2[thePlayerIndex]) \(gdefault.gamesPlayerPhase3[thePlayerIndex]) \(gdefault.gamesPlayerPhase4[thePlayerIndex]) \(gdefault.gamesPlayerPhase5[thePlayerIndex]) \(gdefault.gamesPlayerPhase6[thePlayerIndex]) \(gdefault.gamesPlayerPhase7[thePlayerIndex]) \(gdefault.gamesPlayerPhase8[thePlayerIndex]) \(gdefault.gamesPlayerPhase9[thePlayerIndex]) \(gdefault.gamesPlayerPhase10[thePlayerIndex])")
        //print("EP aUB IN  SOR phase   = \(gdefault.gamesPlayerStartRoundPhases[thePlayerIndex])")
        //print("EP aUB IN  phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
        
        
        if !(errorMessage.text == "") {
            allowExitFromView = false
        }
        else {
            if gdefault.gamesPlayerChoosesPhase[thePlayerIndex] == playerDoesNotChoosePhaseConstant {
                driveUpdateNoChoice()
            }
            else {
                driveUpdateChoice()
            }

            // Update the Games file for this game's player

            //print("EP updating game file due to player edit")
            // Get the offset of this game in the Games file
            let fileHandleEPGamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
            let fileContent:String=String(data:fileHandleEPGamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleEPGamesGet.closeFile()
            let gameFileSize = fileContent.count
            //print("EP aUB game file read size=\(gameFileSize)")
            
            var gameRecordOffset = 0
            while gameRecordOffset < gameFileSize {
                //print("EP aUB scanning: offset is \(gameRecordOffset)")
                let tempGameRec = extractRecordField(recordIn: fileContent,  fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
                let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
                //print("EP aUB comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
                if thisGameName == gdefault.gamesGameName {
                    //print("EP aUB found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                    break
                }
                gameRecordOffset += gdefault.gamesRecordSize
            }
            
            // Update the record and recreate the file
            //print("EP aUB now calling updateGamesFile from Edit Player with offset \(gameRecordOffset)")
            updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
            
            // Build and write history records
            // - log that this player was edited
            // - log that all points have been removed
            // - log that the points have been re-added
            // - log that all phases have been removed
            // - log the phase(s) that have been re-added
            
            let thisPlayerCode = createHistoryPlayerCode(playerIn: gdefault.gamesPlayerEntryOrder[thePlayerIndex])
            logPlayerWasEdited = thisPlayerCode + "g    "
            logClearPointsHistoryData = thisPlayerCode + "c0000"
            logResetPointsHistoryData = thisPlayerCode + historyAddPointsCode + gdefault.gamesPlayerPoints[thePlayerIndex]
            logClearPhaseHistoryData = thisPlayerCode + "f00  "
            logResetPhasesHistoryData = ""
            if Int(gdefault.gamesPlayerPhase1[thePlayerIndex])! > intPhaseDivider {
                logResetPhasesHistoryData = thisPlayerCode + historyClearPhaseCode + "01  "
            }
            if Int(gdefault.gamesPlayerPhase2[thePlayerIndex])! > intPhaseDivider {
                logResetPhasesHistoryData = logResetPhasesHistoryData + thisPlayerCode + historyClearPhaseCode + "02  "
            }
            if Int(gdefault.gamesPlayerPhase3[thePlayerIndex])! > intPhaseDivider {
                logResetPhasesHistoryData = logResetPhasesHistoryData + thisPlayerCode + historyClearPhaseCode + "03  "
            }
            if Int(gdefault.gamesPlayerPhase4[thePlayerIndex])! > intPhaseDivider {
                logResetPhasesHistoryData = logResetPhasesHistoryData + thisPlayerCode + historyClearPhaseCode + "04  "
            }
            if Int(gdefault.gamesPlayerPhase5[thePlayerIndex])! > intPhaseDivider {
                logResetPhasesHistoryData = logResetPhasesHistoryData + thisPlayerCode + historyClearPhaseCode + "05  "
            }
            if Int(gdefault.gamesPlayerPhase6[thePlayerIndex])! > intPhaseDivider {
                logResetPhasesHistoryData = logResetPhasesHistoryData + thisPlayerCode + historyClearPhaseCode + "06  "
            }
            if Int(gdefault.gamesPlayerPhase7[thePlayerIndex])! > intPhaseDivider {
                logResetPhasesHistoryData = logResetPhasesHistoryData + thisPlayerCode + historyClearPhaseCode + "07  "
            }
            if Int(gdefault.gamesPlayerPhase8[thePlayerIndex])! > intPhaseDivider {
                logResetPhasesHistoryData = logResetPhasesHistoryData + thisPlayerCode + historyClearPhaseCode + "08  "
            }
            if Int(gdefault.gamesPlayerPhase9[thePlayerIndex])! > intPhaseDivider {
                logResetPhasesHistoryData = logResetPhasesHistoryData + thisPlayerCode + historyClearPhaseCode + "09  "
            }
            if Int(gdefault.gamesPlayerPhase10[thePlayerIndex])! > intPhaseDivider {
                logResetPhasesHistoryData = logResetPhasesHistoryData + thisPlayerCode + historyClearPhaseCode + "10  "
            }
            
            //print("UP updating history file due to player edit of phases & points")
            // Get the offset of this game in the History file
            let fileHandleEPHistoryGet:FileHandle=FileHandle(forReadingAtPath: historyFileURL.path)!
            let fileContent2:String=String(data:fileHandleEPHistoryGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleEPHistoryGet.closeFile()
            let historyFileSize = fileContent2.count
            
            // Find the current game in the History file
            var historyRecordOffset = 0
            //print("EP start game scan in history, file size=\(historyFileSize)")
            while historyRecordOffset < historyFileSize {
                //print("EP scanning: current offset is \(historyRecordOffset)")
                let tempHistoryRec = extractRecordField(recordIn: fileContent2, fieldOffset: historyRecordOffset, fieldLength: gdefault.historyRecordSize)
                let thisGameName = extractRecordField(recordIn: tempHistoryRec, fieldOffset: gdefault.historyOffsetGameName, fieldLength: gdefault.historyLengthGameName)
                //print("EP comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
                if thisGameName == gdefault.gamesGameName {
                    //print("EP found matching file game \(thisGameName) at offset \(historyRecordOffset) and issued break command")
                    break
                }
                historyRecordOffset += gdefault.historyRecordSize
            }
            
            // Update the record and recreate the file
            //print("UP now calling updateHistoryFile with offset \(historyRecordOffset)")
            let editPlayerHistoryEntries = logPlayerWasEdited + logClearPhaseHistoryData + logClearPointsHistoryData + logResetPhasesHistoryData + logResetPointsHistoryData
            updateHistoryFile(actionIn: updateFileUpdateCode, historyOffsetIn: historyRecordOffset, newHistoryDataIn: editPlayerHistoryEntries)
            
            //print("EP aUB OUT choice      =\(gdefault.gamesPlayerChoosesPhase[thePlayerIndex]) current phase=\(gdefault.gamesPlayerCurrentPhase[thePlayerIndex])")
            //print("EP aUB OUT Std phases  =\(gdefault.gamesPlayerPhase1[thePlayerIndex]) \(gdefault.gamesPlayerPhase2[thePlayerIndex]) \(gdefault.gamesPlayerPhase3[thePlayerIndex]) \(gdefault.gamesPlayerPhase4[thePlayerIndex]) \(gdefault.gamesPlayerPhase5[thePlayerIndex]) \(gdefault.gamesPlayerPhase6[thePlayerIndex]) \(gdefault.gamesPlayerPhase7[thePlayerIndex]) \(gdefault.gamesPlayerPhase8[thePlayerIndex]) \(gdefault.gamesPlayerPhase9[thePlayerIndex]) \(gdefault.gamesPlayerPhase10[thePlayerIndex])")
            //print("EP aUB OUT SOR phase   = \(gdefault.gamesPlayerStartRoundPhases[thePlayerIndex])")
            //print("EP aUB OUT phases done = <\(holdScreenPhase1)> <\(holdScreenPhase2)> <\(holdScreenPhase3)> <\(holdScreenPhase4)> <\(holdScreenPhase5)> <\(holdScreenPhase6)> <\(holdScreenPhase7)> <\(holdScreenPhase8)> <\(holdScreenPhase9)> <\(holdScreenPhase10)>")
            allowExitFromView = true
        }
    }

    // This function advances the dealer flag to the next player in line if the player
    // being removed is the current dealer
    func adjustCurrentDealer(indexIn: Int) {
        if gdefault.gamesTrackDealer == trackingDealerConstant {
            if gdefault.gamesCurrentDealer == gdefault.gamesPlayerEntryOrder[indexIn] {
                //print("EP aUB calling advanceToNextDealer - due to deleting the current dealer")
                advanceToNextDealer()
            }
        }
    }
    
    // The dealer may or may not have been adjusted earlier. But now that the player has been
    // removed, double-check that there is still at least one player in the game. If not,
    // reset the current dealer to "00"
    func doubleCheckCurrentDealer(){
        var pcount = 0
        while pcount < gdefault.gamesLengthPlayerEntryOrderOccurs {
            if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                break
            }
            pcount += 1
        }
        if pcount == 0 {
            gdefault.gamesCurrentDealer = initZeroCurDealer
        }
    }
    
    // This function removes the requested player from the player name array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerName(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerName[pidx] = gdefault.gamesPlayerName[pidx+1]
            pidx += 1
        }
        if pidx < gdefault.gamesLengthPlayerNameOccurs {
            gdefault.gamesPlayerName[pidx] = "                    "
        }
    }
    
    // This function removes the requested player from the player entry order array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerEntry(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerEntryOrder[pidx] = gdefault.gamesPlayerEntryOrder[pidx+1]
            pidx += 1
        }
        if pidx < gdefault.gamesLengthPlayerEntryOrderOccurs {
            gdefault.gamesPlayerEntryOrder[pidx] = initZeroEntry
        }
    }
    
    // This function removes the requested player from the player dealer order array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerDealer(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerDealerOrder[pidx] = gdefault.gamesPlayerDealerOrder[pidx+1]
            pidx += 1
        }
        if pidx < gdefault.gamesLengthPlayerDealerOrderOccurs {
            gdefault.gamesPlayerDealerOrder[pidx] = initZeroDealer
        }
    }
    
    // This function removes the requested player from the player phase 1 array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerPhase1(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerPhase1[pidx] = gdefault.gamesPlayerPhase1[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerPhase1[pidx] = gdefault.gamesPhase1
    }
    
    // This function removes the requested player from the player phase 2 array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerPhase2(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerPhase2[pidx] = gdefault.gamesPlayerPhase2[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerPhase2[pidx] = gdefault.gamesPhase2
    }
    
    // This function removes the requested player from the player phase 3 array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerPhase3(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerPhase3[pidx] = gdefault.gamesPlayerPhase3[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerPhase3[pidx] = gdefault.gamesPhase3
    }
    
    // This function removes the requested player from the player phase 4 array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerPhase4(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerPhase4[pidx] = gdefault.gamesPlayerPhase4[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerPhase4[pidx] = gdefault.gamesPhase4
    }
    
    // This function removes the requested player from the player phase 5 array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerPhase5(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerPhase5[pidx] = gdefault.gamesPlayerPhase5[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerPhase5[pidx] = gdefault.gamesPhase5
    }
    
    // This function removes the requested player from the player phase 6 array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerPhase6(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerPhase6[pidx] = gdefault.gamesPlayerPhase6[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerPhase6[pidx] = gdefault.gamesPhase6
    }
    
    // This function removes the requested player from the player phase 7 array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerPhase7(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerPhase7[pidx] = gdefault.gamesPlayerPhase7[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerPhase7[pidx] = gdefault.gamesPhase7
    }
    
    // This function removes the requested player from the player phase 8 array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerPhase8(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerPhase8[pidx] = gdefault.gamesPlayerPhase8[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerPhase8[pidx] = gdefault.gamesPhase8
    }
    
    // This function removes the requested player from the player phase 9 array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerPhase9(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerPhase9[pidx] = gdefault.gamesPlayerPhase9[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerPhase9[pidx] = gdefault.gamesPhase9
    }
    
    // This function removes the requested player from the player phase 10 array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerPhase10(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerPhase10[pidx] = gdefault.gamesPlayerPhase10[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerPhase10[pidx] = gdefault.gamesPhase10
    }
    
    // This function removes the requested player from the player current phase array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerCurrentPhase(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerCurrentPhase[pidx] = gdefault.gamesPlayerCurrentPhase[pidx+1]
            pidx += 1
        }
        if pidx < gdefault.gamesLengthPlayerCurrentPhaseOccurs {
            gdefault.gamesPlayerCurrentPhase[pidx] = "01"
        }
    }
    
    // This function removes the requested player from the player SOR phase array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerSORPhase(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerStartRoundPhases[pidx] = gdefault.gamesPlayerStartRoundPhases[pidx+1]
            pidx += 1
        }
        if gdefault.gamesPhaseModifier == evenPhasesCode {
            gdefault.gamesPlayerStartRoundPhases[pidx] = gdefault.gamesPhase2
        }
        else {
            gdefault.gamesPlayerStartRoundPhases[pidx] = gdefault.gamesPhase1
        }
    }
    
    // This function removes the requested player from the player points array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerPoints(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerPoints[pidx] = gdefault.gamesPlayerPoints[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerPoints[pidx] = zeroPoints
    }
    
    // This function removes the requested player from the player SOR points array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerSORPoints(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerStartRoundPoints[pidx] = gdefault.gamesPlayerStartRoundPoints[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerStartRoundPoints[pidx] = zeroPoints
    }
    
    // This function removes the requested player from the player winner array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerWinner(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerWinner[pidx] = gdefault.gamesPlayerWinner[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerWinner[pidx] = "n"
    }
    
    // This function removes the requested player from the player points status array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerPointsStatus(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerPointsStatus[pidx] = gdefault.gamesPlayerPointsStatus[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerPointsStatus[pidx] = pointsStatusStandard
    }
    
    // This function removes the requested player from the player points status entry array
    // All players following it drop down one slot to fill the gap
    // The highest previously-used slot is reinitialized
    func removePlayerPointsStatusEntry(indexIn: Int) {
        var pidx = indexIn
        while pidx < gamePlayerLimit {
            gdefault.gamesPlayerPointsStatusEntry[pidx] = gdefault.gamesPlayerPointsStatusEntry[pidx+1]
            pidx += 1
        }
        gdefault.gamesPlayerPointsStatusEntry[pidx] = "00"
    }
    
    // This function removes the requested player from the player button status array
    // All players following it drop down 5 slots to fill the gap
    // The highest previously-used 5 slots are reinitialized
    func removePlayerButtonStatus(indexIn: Int) {
        var pidx = indexIn * 5
        let gameButtonLimit = gamePlayerLimit * 5
        //print("EP rPB start index=\(indexIn) gameButtonLimit=\(gameButtonLimit)")
        while pidx < gameButtonLimit {
            //print("EP rPB pidx=\(pidx)")
            gdefault.gamesPlayerButtonStatus[pidx] = gdefault.gamesPlayerButtonStatus[pidx+5]
            gdefault.gamesPlayerButtonStatus[pidx+1] = gdefault.gamesPlayerButtonStatus[pidx+6]
            gdefault.gamesPlayerButtonStatus[pidx+2] = gdefault.gamesPlayerButtonStatus[pidx+7]
            gdefault.gamesPlayerButtonStatus[pidx+3] = gdefault.gamesPlayerButtonStatus[pidx+8]
            gdefault.gamesPlayerButtonStatus[pidx+4] = gdefault.gamesPlayerButtonStatus[pidx+9]
            pidx += 5
        }
        gdefault.gamesPlayerButtonStatus[pidx] = buttonCodeEnabled
        gdefault.gamesPlayerButtonStatus[pidx+1] = buttonCodeEnabled
        gdefault.gamesPlayerButtonStatus[pidx+2] = buttonCodeEnabled
        gdefault.gamesPlayerButtonStatus[pidx+3] = buttonCodeEnabled
        gdefault.gamesPlayerButtonStatus[pidx+4] = buttonCodeEnabled
    }
    
    // Update this game after a player removal
    func updateTheGame() {

        //print("EP uTG updating game file due to player removal")
        // Get the offset of this game in the Games file
        let fileHandleEP2GamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
        let fileContent:String=String(data:fileHandleEP2GamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleEP2GamesGet.closeFile()
        let gameFileSize = fileContent.count
        
        var gameRecordOffset = 0
        while gameRecordOffset < gameFileSize {
            //print("EP uTG scanning: offset is \(gameRecordOffset)")
            let tempGameRec = extractRecordField(recordIn: fileContent,  fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
            let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
            //print("EP uTG comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
            if thisGameName == gdefault.gamesGameName {
                //print("EP uTG found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                break
            }
            gameRecordOffset += gdefault.gamesRecordSize
        }
        
        // Update the record and recreate the file
        //print("EP uTG now calling updateGamesFile for player removal from Edit Player with offset \(gameRecordOffset)")
        updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
    }
    
    // This function removes the requested player from the History file.
    // All players following it drop down as many slots as necessary to fill the gaps
    // of all the removed entries.
    // The highest previously-used slots are reinitialized.
    // Input:   code letter in history of the player being removed
    func updateTheHistory(historyIdentifierIn: String) {
        //print("EP uTH begin removal of history for player code \(historyIdentifierIn)")
        var historyRec1of3 = ""
        var historyRec2of3 = ""
        var historyRec3of3 = ""
        var hidx1 = 0
        var hidx2 = 0
        var playerHistoryEntry = ""
        var playerHistoryOffset = 0
        
        // First retrieve the full History file
        let fileHandleEPHUpdate:FileHandle=FileHandle(forUpdatingAtPath: historyFileURL.path)!
        let holdHistoryFile = String(data: fileHandleEPHUpdate.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        //print("EP uTH history in length=\(holdHistoryFile.count) record=<\(holdHistoryFile)>")
        let historyFileSize = holdHistoryFile.count
        let historyRecordSize = gdefault.historyRecordSize
        
        // Then find the current game in the history file
        var historyRecordOffset = 0
        //print("EP uTH looking for game \(gdefault.gamesGameName)")
        while historyRecordOffset < historyFileSize {
            let tempHistoryRec = extractRecordField(recordIn: holdHistoryFile, fieldOffset: historyRecordOffset, fieldLength: historyRecordSize)
            let thisGameName = extractRecordField(recordIn: tempHistoryRec, fieldOffset: gdefault.historyOffsetGameName, fieldLength: gdefault.historyLengthGameName)
            if thisGameName == gdefault.gamesGameName {
                //print("EP uTH got it at offset \(historyRecordOffset)")
                break
            }
            historyRecordOffset += historyRecordSize
        }
        
        // Extract the History file data up to but not including the
        // record containing the game in progress record 1 of 3)
        historyRec1of3 = extractRecordField(recordIn: holdHistoryFile, fieldOffset: 0, fieldLength: historyRecordOffset)
        
        // Unless the game is at the end of the History record, extract the
        // History file data immediately following the record containing
        // the game in progress (record 3 of 3)
        if (historyRecordOffset + historyRecordSize) < historyFileSize {
            historyRec3of3 = extractRecordField(recordIn: holdHistoryFile, fieldOffset: historyRecordOffset + historyRecordSize, fieldLength: historyFileSize - historyRecordOffset - historyRecordSize)
        }
        //else {
            //print("EP uTH record 3 of 3 is null")
        //}
        
        // Extract and then update the history file data for the record
        // containing the game in progress (record 2 of 3)
        
        // -- First extract the full history record
        historyRec2of3 = extractRecordField(recordIn: holdHistoryFile, fieldOffset: historyRecordOffset, fieldLength: historyRecordSize)
        //print("EP uTH starting history=<\(historyRec2of3)>")

        // -- Then extract the player history array into a separate storage area
        let playerHistory = extractRecordField(recordIn: historyRec2of3, fieldOffset: gdefault.historyOffsetPlayerHistory, fieldLength: gdefault.historyLengthPlayerHistoryOccurs * gdefault.historyLengthPlayerHistory)
        
        // -- Load all history for this game into the global storage history array except for the player being removed.
        //    Initialize as many entries at the end of the global storage history array as were just skipped.
        //    hidx1 is the index for the input player history storage area playerHistory.
        //    hidx2 is the index for the output global storage history area
        //    historyIdentifierIn is the id of the player being removed
        while hidx1 < gdefault.historyLengthPlayerHistoryOccurs {
            playerHistoryEntry = extractRecordField(recordIn: playerHistory, fieldOffset: playerHistoryOffset, fieldLength: gdefault.historyLengthPlayerHistory)
            let sidx = playerHistoryEntry.index(playerHistoryEntry.startIndex, offsetBy: 0)
            let eidx = playerHistoryEntry.index(playerHistoryEntry.startIndex, offsetBy: 1)
            let range = sidx ..< eidx
            if !(playerHistoryEntry[range] == historyIdentifierIn) {
                gdefault.historyPlayerHistory[hidx2] = playerHistoryEntry
                hidx2 += 1
            }
            hidx1 += 1
            playerHistoryOffset += gdefault.historyLengthPlayerHistory
        }
        
        // -- Now initialize as many entries at the end of global storage history as were skipped above
        //    Note that hidx2 starts at the point where loading left off
        while hidx2 < gdefault.historyLengthPlayerHistoryOccurs {
            gdefault.historyPlayerHistory[hidx2] = initHistoryConstant
            hidx2 += 1
        }
        //print("EP uTH global storage player history just loaded=<\(gdefault.historyPlayerHistory)>")
        
        // Reinstate the just-updated global storage history array into the current history record
        // instring                     - this game's history record
        // historyOffsetPlayerHistory   - offset within each game's history record where the history array starts
        // startReplacement-1           - position within this game's history record where the replacement history data starts
        // endReplacement-1             - position within this game's history record where the replacement history data ends
        // stringHistoryPlayerHistory   - history array converted to a string
        let instring: NSString = historyRec2of3 as NSString
        let startReplacement = gdefault.historyOffsetPlayerHistory + 1
        let endReplacement = startReplacement + (gdefault.historyLengthPlayerHistoryOccurs * gdefault.historyLengthPlayerHistory) - 1
        let stringHistoryPlayerHistory = gdefault.historyPlayerHistory.joined(separator: "")
        historyRec2of3 = instring.substring(to: startReplacement-1) + stringHistoryPlayerHistory + instring.substring(from: endReplacement)
        //print("EP uTH updated history=<\(historyRec2of3)>")
        let newHistoryFileRecord = historyRec1of3 + historyRec2of3 + historyRec3of3
        //print("EP uTH history out length=\(newHistoryFileRecord.count) record=<\(newHistoryFileRecord)>")
        //print("EP uTH end of removal of history for player code \(historyIdentifierIn)")
        
        // Clear the entire file
        try? fileHandleEPHUpdate.truncate(atOffset: 0)
            
        // Replace the entire file
        fileHandleEPHUpdate.write(newHistoryFileRecord.data(using: String.Encoding.utf8)!)
        fileHandleEPHUpdate.closeFile()
    }
    
    // Remove a player
    // This includes the following:
    // - Force the user to press the remove button twice in succession.
    // - Remove the entry and slide the following entries down 1 slot in the following arrays:
    //   - Player name
    //   - Player entry order
    //   - Player dealer order
    //   - Current phase
    //   - Start-of-round phases
    //   - Start-of-round points
    //   - Winner
    //   - Player points status
    //   - Note that the highest moved entries must be reinitialized to their original empty status
    // - Remove 4 entries and slide the following entries down 4 slots in the following arrays:
    //   - Player buttons
    //   - Note that the highest moved 4 entries must be reinitialized to their original empty status
    // - Remove all history entries for this game's player. Slide all following history entries down to
    //   fill the gaps of all the removed history entries.
    // - Exit the screen and return to TheGame.
    @IBAction func aRemoveButton(_ sender: Any) {
        switch gdefault.RemovePressed {
        case "1":
            gdefault.RemovePressed = "2"
            errorMessage.textColor = appColorWhite
            errorMessage.backgroundColor = appColorMediumGreen
            errorMessage.text = "Press Remove again for removal"
            allowExitFromView = false
        case "2":
            gdefault.RemovePressed = "1"
            thePlayerIndex = gdefault.playerIdxByButton[gdefault.editPlayerButtonIndex]
            thePlayerEntrySequence = Int(gdefault.gamesPlayerEntryOrder[thePlayerIndex])!
            let stringEntrySequence = String(format: "%02d", thePlayerEntrySequence)
            thePlayerHistoryCode = createHistoryPlayerCode(playerIn: stringEntrySequence)
            //print("EP aRB setting thePlayerIndex to \(thePlayerIndex) from playerIndexByButton[\(gdefault.editPlayerButtonIndex)]")
            //print("EP aRB setting thePlayerEntrySequence to \(thePlayerEntrySequence)")
            //print("EP aRB setting thePlayerHistoryCode to \(thePlayerHistoryCode)")
            // Determine and save the index of the highest player slot with a player in it
            var pcount = 0
            while pcount < gdefault.gamesLengthPlayerEntryOrderOccurs {
                if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                    break
                }
                pcount += 1
            }
            gamePlayerLimit = pcount - 1
            
            //print("EP aRB beginning of removal section")
            //print("EP aRB current dealer=\(gdefault.gamesCurrentDealer)")
            //print("EP aRB entry=\(gdefault.gamesPlayerEntryOrder)")
            //print("EP aRB name=\(gdefault.gamesPlayerName)")
            //print("EP aRB dealer=\(gdefault.gamesPlayerDealerOrder)")
            //print("EP aRB phase 1=\(gdefault.gamesPlayerPhase1)")
            //print("EP aRB phase 2=\(gdefault.gamesPlayerPhase2)")
            //print("EP aRB phase 3=\(gdefault.gamesPlayerPhase3)")
            //print("EP aRB phase 4=\(gdefault.gamesPlayerPhase4)")
            //print("EP aRB phase 5=\(gdefault.gamesPlayerPhase5)")
            //print("EP aRB phase 6=\(gdefault.gamesPlayerPhase6)")
            //print("EP aRB phase 7=\(gdefault.gamesPlayerPhase7)")
            //print("EP aRB phase 8=\(gdefault.gamesPlayerPhase8)")
            //print("EP aRB phase 9=\(gdefault.gamesPlayerPhase9)")
            //print("EP aRB phase 10=\(gdefault.gamesPlayerPhase10)")
            //print("EP aRB curphase=\(gdefault.gamesPlayerCurrentPhase)")
            //print("EP aRB SOR phase=\(gdefault.gamesPlayerStartRoundPhases)")
            //print("EP aRB points=\(gdefault.gamesPlayerPoints)")
            //print("EP aRB SOR points=\(gdefault.gamesPlayerStartRoundPoints)")
            //print("EP aRB winner=\(gdefault.gamesPlayerWinner)")
            //print("EP aRB points status=\(gdefault.gamesPlayerPointsStatus)")
            //print("EP aRB points status entry=\(gdefault.gamesPlayerPointsStatusEntry)")
            //print("EP aRB buttons=\(gdefault.gamesPlayerButtonStatus)")
            //print("EP aRB round status=\(gdefault.gamesRoundStatus)")
            
            adjustCurrentDealer(indexIn: thePlayerIndex)
            removePlayerName(indexIn: thePlayerIndex)
            removePlayerEntry(indexIn: thePlayerIndex)
            removePlayerDealer(indexIn: thePlayerIndex)
            removePlayerPhase1(indexIn: thePlayerIndex)
            removePlayerPhase2(indexIn: thePlayerIndex)
            removePlayerPhase3(indexIn: thePlayerIndex)
            removePlayerPhase4(indexIn: thePlayerIndex)
            removePlayerPhase5(indexIn: thePlayerIndex)
            removePlayerPhase6(indexIn: thePlayerIndex)
            removePlayerPhase7(indexIn: thePlayerIndex)
            removePlayerPhase8(indexIn: thePlayerIndex)
            removePlayerPhase9(indexIn: thePlayerIndex)
            removePlayerPhase10(indexIn: thePlayerIndex)
            removePlayerCurrentPhase(indexIn: thePlayerIndex)
            removePlayerSORPhase(indexIn: thePlayerIndex)
            removePlayerPoints(indexIn: thePlayerIndex)
            removePlayerSORPoints(indexIn: thePlayerIndex)
            removePlayerWinner(indexIn: thePlayerIndex)
            removePlayerPointsStatus(indexIn: thePlayerIndex)
            removePlayerPointsStatusEntry(indexIn: thePlayerIndex)
            removePlayerButtonStatus(indexIn: thePlayerIndex)
            doubleCheckCurrentDealer()
            
            //print("EP aRB end of removal section")
            //print("EP aRB current dealer=\(gdefault.gamesCurrentDealer)")
            //print("EP aRB entry=\(gdefault.gamesPlayerEntryOrder)")
            //print("EP aRB name=\(gdefault.gamesPlayerName)")
            //print("EP aRB dealer=\(gdefault.gamesPlayerDealerOrder)")
            //print("EP aRB phase 1=\(gdefault.gamesPlayerPhase1)")
            //print("EP aRB phase 2=\(gdefault.gamesPlayerPhase2)")
            //print("EP aRB phase 3=\(gdefault.gamesPlayerPhase3)")
            //print("EP aRB phase 4=\(gdefault.gamesPlayerPhase4)")
            //print("EP aRB phase 5=\(gdefault.gamesPlayerPhase5)")
            //print("EP aRB phase 6=\(gdefault.gamesPlayerPhase6)")
            //print("EP aRB phase 7=\(gdefault.gamesPlayerPhase7)")
            //print("EP aRB phase 8=\(gdefault.gamesPlayerPhase8)")
            //print("EP aRB phase 9=\(gdefault.gamesPlayerPhase9)")
            //print("EP aRB phase 10=\(gdefault.gamesPlayerPhase10)")
            //print("EP aRB curphase=\(gdefault.gamesPlayerCurrentPhase)")
            //print("EP aRB SOR phase=\(gdefault.gamesPlayerStartRoundPhases)")
            //print("EP aRB points=\(gdefault.gamesPlayerPoints)")
            //print("EP aRB SOR points=\(gdefault.gamesPlayerStartRoundPoints)")
            //print("EP aRB winner=\(gdefault.gamesPlayerWinner)")
            //print("EP aRB points status=\(gdefault.gamesPlayerPointsStatus)")
            //print("EP aRB points status=\(gdefault.gamesPlayerPointsStatusEntry)")
            //print("EP aRB buttons=\(gdefault.gamesPlayerButtonStatus)")
            //print("EP aRB round status=\(gdefault.gamesRoundStatus)")
            
            updateTheGame()
            updateTheHistory(historyIdentifierIn: thePlayerHistoryCode)
            allowExitFromView = true
        default:
            _ = ""
        }
    }
    
    @IBAction func aViewTutorialButton(_ sender: Any) {
        
        gdefault.RemovePressed = "1"
        gdefault.helpCaller = helpSectionCodeEditPlayer
        errorMessage.text = ""
        // Set this flag to true so that the segue to the help screen is allowed
        // to process
        continueToHelp = true
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
        cancelButton.layer.cornerRadius = cornerRadiusStdButton
        aUpdateButton.layer.cornerRadius = cornerRadiusStdButton
        aRemoveButton.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton
        
        // Activate all the popup keyboards
        self.playerName.delegate = self
        self.addDoneButtonOnKeyboard2 ()
        self.phase1.delegate = self
        self.addDoneButtonOnKeyboardP1 ()
        self.phase2.delegate = self
        self.addDoneButtonOnKeyboardP2 ()
        self.phase3.delegate = self
        self.addDoneButtonOnKeyboardP3 ()
        self.phase4.delegate = self
        self.addDoneButtonOnKeyboardP4 ()
        self.phase5.delegate = self
        self.addDoneButtonOnKeyboardP5 ()
        self.phase6.delegate = self
        self.addDoneButtonOnKeyboardP6 ()
        self.phase7.delegate = self
        self.addDoneButtonOnKeyboardP7 ()
        self.phase8.delegate = self
        self.addDoneButtonOnKeyboardP8 ()
        self.phase9.delegate = self
        self.addDoneButtonOnKeyboardP9 ()
        self.phase10.delegate = self
        self.addDoneButtonOnKeyboardP10 ()
        self.points.delegate = self
        self.addDoneButtonOnKeyboard4 ()
        self.dealerSequence.delegate = self
        self.addDoneButtonOnKeyboard3 ()
        
        // Disallow exit and help unless verified first via code
        
        allowExitFromView = false
        continueToHelp = false
        gdefault.RemovePressed = "1"
    }
    
    // Load the screen for a player who chooses phases
    // Input:   The phase to be loaded
    // Output:  The appropriate phase position on the screen
    //          For example, phase 3 goes in the 3rd position, phase 6 goes in the 6th position, etc.
    func loadPhaseAreaContent (phaseIn: String) {
        //print("EP lPA phaseIn=<\(phaseIn)>")
        let usePhase = Int(phaseIn)
        //print("EP lPAC loading phase \(phaseIn) position with \(phaseIn)")
        switch usePhase {
        case 1:
            phase1.text = String(format: "%02d", usePhase!)
            holdScreenPhase1 = String(format: "%02d", usePhase!)
        case 2:
            phase2.text = String(format: "%02d", usePhase!)
            holdScreenPhase2 = String(format: "%02d", usePhase!)
        case 3:
            phase3.text = String(format: "%02d", usePhase!)
            holdScreenPhase3 = String(format: "%02d", usePhase!)
        case 4:
            phase4.text = String(format: "%02d", usePhase!)
            holdScreenPhase4 = String(format: "%02d", usePhase!)
        case 5:
            phase5.text = String(format: "%02d", usePhase!)
            holdScreenPhase5 = String(format: "%02d", usePhase!)
        case 6:
            phase6.text = String(format: "%02d", usePhase!)
            holdScreenPhase6 = String(format: "%02d", usePhase!)
        case 7:
            phase7.text = String(format: "%02d", usePhase!)
            holdScreenPhase7 = String(format: "%02d", usePhase!)
        case 8:
            phase8.text = String(format: "%02d", usePhase!)
            holdScreenPhase8 = String(format: "%02d", usePhase!)
        case 9:
            phase9.text = String(format: "%02d", usePhase!)
            holdScreenPhase9 = String(format: "%02d", usePhase!)
        case 10:
            phase10.text = String(format: "%02d", usePhase!)
            holdScreenPhase10 = String(format: "%02d", usePhase!)
        default:
            _ = ""
        }
    }
    
    // Parse the string containing all completed phases for this player and return the requested phase
    // Input:   phase string to be loaded
    //          requested phase's position in the phase string
    // Output:  The phase
    func extractPhase (phasesIn: String, positionIn: Int) -> String {
        //print("EP eP phasesIn=<\(phasesIn)> positionIn=\(positionIn)")
        let sidx = phasesIn.index(phasesIn.startIndex, offsetBy: positionIn * 3)
        let eidx = phasesIn.index(phasesIn.startIndex, offsetBy: (positionIn * 3) + 3)
        let range = sidx ..< eidx
        let thePhase = phasesIn[range]
        let returnPhase = String(thePhase)
        //print("EP eP returnPhase=\(returnPhase)")
        return returnPhase
    }
    
    // If the player is not choosing phases, load singular heading "Phase Done", the most current phase completed,
    // and clear & disable the other 9 phases.
    // If the player is choosing phases, load plural heading "Phases Done", all completed phases, including all
    // 10 phase number fields.
    func setupPhaseFields () {
        //print("EP sPF start setupPhaseFields")
        if gdefault.gamesPlayerChoosesPhase[thePlayerIndex] == playerDoesNotChoosePhaseConstant {
            phasesDone.text = "Phase"
            let result = analyzeNoChoicePhaseCompletion(indexIn: thePlayerIndex)
            var highestPhase = 0
            let currentPhase = Int(result.phaseRaw)
            switch gdefault.gamesPhaseModifier {
            case allPhasesCode:
                highestPhase = currentPhase! - 1
            case evenPhasesCode:
                if currentPhase == 11 {
                    highestPhase = currentPhase! - 1
                }
                else {
                    highestPhase = currentPhase! - 2
                }
            case oddPhasesCode:
                if currentPhase == 1 {
                    highestPhase = currentPhase! - 1
                }
                else {
                    highestPhase = currentPhase! - 2
                }
            default:
                _ = ""
            }
            //print("EP sPF choice=n modifier=\(gdefault.gamesPhaseModifier) text=<\(result.phaseText)> raw=<\(result.phaseRaw)> highest phase=\(highestPhase)")
            if highestPhase == 0 {
                //print("EP sPF clearing phase 5 position")
                phase5.text = ""
                holdScreenPhase5 = ""
                anyPhaseCleared = "n"
            }
            else {
                //print("EP sPF loading phase 5 position with \(highestPhase)")
                phase5.text = String(format: "%02d", highestPhase)
                holdScreenPhase5 = String(format: "%02d", highestPhase)
                anyPhaseCleared = "y"
            }
            
            phase1.isEnabled = false
            phase2.isEnabled = false
            phase3.isEnabled = false
            phase4.isEnabled = false
            phase5.isEnabled = true
            phase6.isEnabled = false
            phase7.isEnabled = false
            phase8.isEnabled = false
            phase9.isEnabled = false
            phase10.isEnabled = false
            phase1.isHidden = true
            phase2.isHidden = true
            phase3.isHidden = true
            phase4.isHidden = true
            phase5.isHidden = false
            phase6.isHidden = true
            phase7.isHidden = true
            phase8.isHidden = true
            phase9.isHidden = true
            phase10.isHidden = true
        }
        else {
            phasesDone.text = "Phases"
            let result = analyzeChoicePhaseCompletion(indexIn: thePlayerIndex)
            let completedPhaseCount = Int(result.phaseRaw)! - 1
            //print("EP sPF choice=y modifier=\(gdefault.gamesPhaseModifier) text=<\(result.phaseText)> raw=<\(result.phaseRaw)> completedPhaseCount=\(completedPhaseCount)")
            if completedPhaseCount > 0 {
                anyPhaseCleared = "y"
            }
            else {
                anyPhaseCleared = "n"
            }
            var phaseCount = 0
            phase1.text = ""
            phase2.text = ""
            phase3.text = ""
            phase4.text = ""
            phase5.text = ""
            phase6.text = ""
            phase7.text = ""
            phase8.text = ""
            phase9.text = ""
            phase10.text = ""
            holdScreenPhase1 = ""
            holdScreenPhase2 = ""
            holdScreenPhase3 = ""
            holdScreenPhase4 = ""
            holdScreenPhase5 = ""
            holdScreenPhase6 = ""
            holdScreenPhase7 = ""
            holdScreenPhase8 = ""
            holdScreenPhase9 = ""
            holdScreenPhase10 = ""
            while phaseCount < completedPhaseCount {
                let nextPhase = extractPhase (phasesIn: result.phasesAllRaw, positionIn: phaseCount)
                //print("EP sPF nextPhase = <\(nextPhase)>")
                loadPhaseAreaContent (phaseIn: nextPhase)
                phaseCount += 1
            }
            phase1.isEnabled = true
            phase2.isEnabled = true
            phase3.isEnabled = true
            phase4.isEnabled = true
            phase5.isEnabled = true
            phase6.isEnabled = true
            phase7.isEnabled = true
            phase8.isEnabled = true
            phase9.isEnabled = true
            phase10.isEnabled = true
            phase1.isHidden = false
            phase2.isHidden = false
            phase3.isHidden = false
            phase4.isHidden = false
            phase5.isHidden = false
            phase6.isHidden = false
            phase7.isHidden = false
            phase8.isHidden = false
            phase9.isHidden = false
            phase10.isHidden = false
        }
    }

    func aRefreshView () {
        
        // Disallow exit and help unless verified first via code
        allowExitFromView = false
        continueToHelp = false
        gdefault.RemovePressed = "1"
        
        // errorMessage.text = ""

        //print("EP aRV")
        //print("EP aRV edit player button index is \(gdefault.editPlayerButtonIndex)")
        thePlayerIndex = gdefault.playerIdxByButton[gdefault.editPlayerButtonIndex]
        thePlayerEntrySequence = Int(gdefault.gamesPlayerEntryOrder[thePlayerIndex])!
        let stringEntrySequence = String(format: "%02d", thePlayerEntrySequence)
        thePlayerHistoryCode = createHistoryPlayerCode(playerIn: stringEntrySequence)
        //print("EP aRV setting thePlayerIndex to \(thePlayerIndex) from playerIndexByButton[\(gdefault.editPlayerButtonIndex)]")
        //print("EP aRV setting thePlayerEntrySequence to \(thePlayerEntrySequence)")
        //print("EP aRV setting thePlayerHistoryCode to \(thePlayerHistoryCode)")
        
        // Load the player name
        playerName.text = gdefault.gamesPlayerName[thePlayerIndex]
            
        // Load the phase(s)
        setupPhaseFields ()
        //print("EP aRV choice=\(gdefault.gamesPlayerChoosesPhase[thePlayerIndex]) current phase=\(gdefault.gamesPlayerCurrentPhase[thePlayerIndex])")
        //print("EP aRV Std phases=\(gdefault.gamesPlayerPhase1[thePlayerIndex]) \(gdefault.gamesPlayerPhase2[thePlayerIndex]) \(gdefault.gamesPlayerPhase3[thePlayerIndex]) \(gdefault.gamesPlayerPhase4[thePlayerIndex]) \(gdefault.gamesPlayerPhase5[thePlayerIndex]) \(gdefault.gamesPlayerPhase6[thePlayerIndex]) \(gdefault.gamesPlayerPhase7[thePlayerIndex]) \(gdefault.gamesPlayerPhase8[thePlayerIndex]) \(gdefault.gamesPlayerPhase9[thePlayerIndex]) \(gdefault.gamesPlayerPhase10[thePlayerIndex])")
        //print("EP aRV SOR phase= \(gdefault.gamesPlayerStartRoundPhases[thePlayerIndex])")

        // Load the points
        points.text = gdefault.gamesPlayerPoints[thePlayerIndex]
            
        // Load dealer sequence
        dealerSequence.text = gdefault.gamesPlayerDealerOrder[thePlayerIndex]
            
        // Load mark as dealer
            
        // Disallow access if we're not tracking the dealer
        if gdefault.gamesTrackDealer == notTrackingDealerConstant {
            markAsDealerSwitch.value = 0
            markAsDealerNo.textColor = appColorDarkGray
            markAsDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            markAsDealerYes.textColor = appColorDarkGray
            markAsDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            markAsDealerMore1.text = "Not tracking dealer in"
            markAsDealerMore2.text = "this game."
            markAsDealerSwitchEnabled = "n"
        }
        else {
            // Disallow any attempt to turn off the dealer flag - changing a dealer must
            // be done by marking the new dealer by editing that player
            let dealerIndex = Int(gdefault.gamesCurrentDealer)! - 1
            if thePlayerIndex == dealerIndex {
                markAsDealerSwitch.value = 1
                markAsDealerYes.textColor = appColorBrightGreen
                markAsDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
                markAsDealerNo.textColor = appColorDarkGray
                markAsDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
                markAsDealerMore1.text = "To change dealer, select"
                markAsDealerMore2.text = "another player."
                markAsDealerSwitchEnabled = "n"
            }
            else {
                // Ok, it's allowable to flag this player as the new dealer (and in the process
                // remove the flag from another player)
                markAsDealerSwitch.value = 0
                markAsDealerYes.textColor = appColorDarkGray
                markAsDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
                markAsDealerNo.textColor = appColorBrightGreen
                markAsDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
                markAsDealerMore1.text = ""
                markAsDealerMore2.text = ""
                markAsDealerSwitchEnabled = "y"
            }
        }
    
        // Load player chooses phase
        if gdefault.gamesPlayerChoosesPhase[thePlayerIndex] == playerDoesNotChoosePhaseConstant {
            playerChoosesPhaseSwitch.value = 0
            playerChoosesPhaseNo.textColor = appColorBrightGreen
            playerChoosesPhaseNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            playerChoosesPhaseYes.textColor = appColorDarkGray
            playerChoosesPhaseYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        }
        else {
            playerChoosesPhaseSwitch.value = 1
            playerChoosesPhaseNo.textColor = appColorDarkGray
            playerChoosesPhaseNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            playerChoosesPhaseYes.textColor = appColorBrightGreen
            playerChoosesPhaseYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
        }
        
        //print("EP aRV at end of function - anyPhaseCleared=\(anyPhaseCleared)")
        // Disallow phase choice selection if this player has cleared any phase already
        if anyPhaseCleared == "y" {
            playerChoosesPhaseSwitch.isEnabled = false
            playerChoosesPhaseMore1.text = "Cannot switch option"
            playerChoosesPhaseMore2.text = "if a phase is cleared."
        }
        else {
            playerChoosesPhaseSwitch.isEnabled = true
            playerChoosesPhaseMore1.text = ""
            playerChoosesPhaseMore2.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {

        aRefreshView()
            
    } // End viewWillAppear
    
    // Prevent storyboard-defined segue from occurring if an error has been detected
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if continueToHelp {
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
