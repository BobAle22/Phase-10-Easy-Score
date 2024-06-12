//
//  AddPlayer.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 3/30/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import UIKit

class AddPlayer: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var theGame: UILabel!
    @IBOutlet weak var newPlayerName: UITextField!
    @IBOutlet weak var markAsDealerLabel: UILabel!
    @IBOutlet weak var markAsDealerSwitch: UISlider!
    @IBOutlet weak var markAsDealerNo: UILabel!
    @IBOutlet weak var markAsDealerYes: UILabel!
    @IBOutlet weak var entrySequence: UILabel!
    @IBOutlet weak var dealerSequence: UITextField!
    @IBOutlet weak var playerChoosesPhaseSwitch: UISlider!
    @IBOutlet weak var playerChoosesPhaseNo: UILabel!
    @IBOutlet weak var playerChoosesPhaseYes: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    var thisPlayerEntrySequence = 0     // The new player's entry sequence number
    var thisPlayerGameIndex = 0         // The new player's index in the Games rec
    var thisPlayerDealerSequence = 0    // The new player's dealer sequence number
    var gameRecordOffset = 0            // Offset of the game record in the file
    var setAsideThePlayer = ""          // Player name being added
    var setAsideMarkDealer = ""         // Mark as dealer indicator
    var setAsidePlayerChoosesPhase = "" // Player chooses phase indicator
    var setAsideDealerSequence = 0      // Dealer sequence
    
    // Controls whether or not user is allowed to exit (via the Add button)
    var allowExitFromView = false
   
    // Used in conjunction with allowExitFromView -- specifically to allow
    // access to the help screen
    var continueToHelp = false
    
    var integerDealerSequence = 0
    
    // Function to add a "done" button on the dealer sequence keyboard
    // (specifically for the numeric keyboard that has no "done" button - being
    // used for dealer sequence).
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(AddPlayer.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.dealerSequence.inputAccessoryView = doneToolbar
    }
    
    // Make the keyboard with the newly-added done button disappear
    @objc func doneButtonAction () {
        self.dealerSequence.resignFirstResponder()
    }
    
    // Function to add a "done" button on the player name numeric keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboard2() {
        let doneToolbar2: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar2.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done2: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(AddPlayer.doneButtonAction2))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done2)
        
        doneToolbar2.items = items
        doneToolbar2.sizeToFit()
        
        self.newPlayerName.inputAccessoryView = doneToolbar2
    }
    
    // Make the keyboard with the newly-added done button disappear
    @objc func doneButtonAction2 () {
        self.newPlayerName.resignFirstResponder()
    }
    
    // Adjust the position of the non-keyboard-covered portion of the
    // screen upwards so that the keyboard no longer covers the input text
    // field. The adjustment is equal to the vertical size of the keyboard.
    // Note this is being done only for the dealer sequence field because it
    // is near the bottom of the screen. The new player name does not require
    // this adjustment because it is near the top of the screen. At the same time,
    // disable the "player chooses phase" switch, and the cancel, add, & help buttons.
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
                if dealerSequence.isFirstResponder {
                    switch deviceCategoryWeAreRunningOn {
                    case iPadConstant:
                        view.frame.origin.y = -keyboardRect.height * 0.75
                    case iPhoneLargeConstant:
                        view.frame.origin.y = -keyboardRect.height
                    case iPhoneSmallConstant:
                        //view.frame.origin.y = -keyboardRect.height * 1.40
                        view.frame.origin.y = -keyboardRect.height * 1.20
                    default:
                        view.frame.origin.y = -keyboardRect.height
                    }
                    playerChoosesPhaseSwitch.isEnabled = false
                    cancelButton.isEnabled = false
                    addButton.isEnabled = false
                    aViewTutorialButton.isEnabled = false
                }
        }
    }

    // Stop listening for keyboard hide/show events
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @IBAction func aViewTutorialButton(_ sender: Any) {
        
        // Save the screen values before proceeding to help
        gdefault.awaitingHelpReturn = "y"
        gdefault.preHelpNewPlayerName = newPlayerName.text!
        gdefault.preHelpMarkAsDealer = Double(Float(markAsDealerSwitch.value))
        gdefault.preHelpPlayerChoosesPhaseValue = Double(Float(playerChoosesPhaseSwitch.value))
        gdefault.preHelpDealerOrder = dealerSequence.text!
        gdefault.preHelpErrorMessage = errorMessage.text!
        //print("AP aVTB before going to help player=\(gdefault.preHelpNewPlayerName), dealer=\(gdefault.preHelpMarkAsDealer), choose=\(gdefault.preHelpPlayerChoosesPhaseValue), dseq=\(gdefault.preHelpDealerOrder), error=\(gdefault.preHelpErrorMessage)")
        
        gdefault.helpCaller = helpSectionCodeAddPlayer
        
        // Set this flag to true so that the segue to the help screen is
        // allowed to process
        continueToHelp = true
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        // Always allow cancel request
        dismiss(animated: true, completion: nil)
        allowExitFromView = true
    }
    
    // Add this player to the game and return
    @IBAction func addButton(_ sender: Any) {
        // Disallow "add" request if an error is pending
        if errorMessage.text == "" {
            allowExitFromView = true
        }
        else {
            allowExitFromView = false
        }
        
        if allowExitFromView {
            // Ensure that global storage contains the fields from this screen
            let paddedName = setAsideThePlayer.padding(toLength: gdefault.gamesLengthPlayerName, withPad: " ", startingAt: 0)
            gdefault.gamesPlayerName[thisPlayerGameIndex] = paddedName
            if setAsideMarkDealer == "y" {
                //print("AP aP setting current dealer to \(thisPlayerEntrySequence)")
                gdefault.gamesCurrentDealer = String(format: "%02d", thisPlayerEntrySequence)
            }
            
            // Double-check that there's a player marked as the dealer, unless
            // the dealer is not being tracked for this game. If none is
            // marked and one should be, set the first player to be the dealer.
            if gdefault.gamesTrackDealer == trackingDealerConstant {
                if gdefault.gamesCurrentDealer == initZeroCurDealer {
                    //print("AP aP resetting dealer from 00 to 01 because none was marked")
                    gdefault.gamesCurrentDealer = "01"
                }
            }
            
            gdefault.gamesPlayerChoosesPhase[thisPlayerGameIndex] = setAsidePlayerChoosesPhase
            gdefault.gamesPlayerEntryOrder[thisPlayerGameIndex] = String(format: "%02d", thisPlayerEntrySequence)
            gdefault.gamesPlayerDealerOrder[thisPlayerGameIndex] = String(format: "%02d", setAsideDealerSequence)
            //print(" ")
            //print("AP aP adding player to main arrays: \(gdefault.gamesPlayerName[thisPlayerGameIndex]) entry=\(thisPlayerEntrySequence) dealer=\(setAsideDealerSequence)")
            //print(" ")
            
            // If the player is choosing phases, clear all the phase numbers that
            // had earlier been set to match the game being played. If the
            // player is not choosing phases, set the player up to be playing
            // the 1st phase (all or odd in use) or the 2nd phase (even in use).
            var useCurPhase = "01"
            if setAsidePlayerChoosesPhase == playerChoosesPhaseConstant {
                gdefault.gamesPlayerPhase1[thisPlayerGameIndex] = initZeroPhase3
                gdefault.gamesPlayerPhase2[thisPlayerGameIndex] = initZeroPhase3
                gdefault.gamesPlayerPhase3[thisPlayerGameIndex] = initZeroPhase3
                gdefault.gamesPlayerPhase4[thisPlayerGameIndex] = initZeroPhase3
                gdefault.gamesPlayerPhase5[thisPlayerGameIndex] = initZeroPhase3
                gdefault.gamesPlayerPhase6[thisPlayerGameIndex] = initZeroPhase3
                gdefault.gamesPlayerPhase7[thisPlayerGameIndex] = initZeroPhase3
                gdefault.gamesPlayerPhase8[thisPlayerGameIndex] = initZeroPhase3
                gdefault.gamesPlayerPhase9[thisPlayerGameIndex] = initZeroPhase3
                gdefault.gamesPlayerPhase10[thisPlayerGameIndex] = initZeroPhase3
                gdefault.gamesPlayerStartRoundPhases[thisPlayerGameIndex] = initZeroPhase3
                gdefault.gamesPlayerCurrentPhase[thisPlayerGameIndex] = initZeroPhase2
            }
            else {
                if gdefault.gamesPhaseModifier == evenPhasesCode {
                    useCurPhase = "02"
                }
                gdefault.gamesPlayerCurrentPhase[thisPlayerGameIndex] = useCurPhase
            }
            
            // Flag the game as having started
            gdefault.gamesGameStatus = inProgress
            
            updateGamesFile (actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    // This function makes the keyboard disappear when the done key is pressed
    // on the keyboard when entering the player name. This is used only for
    // the new player name.
    @IBAction func hideNewPlayerKeyboard(_ sender: Any) {
        newPlayerName.resignFirstResponder()
    }
    
    // Player name is mandatory, maximum 20 characters, may contain only
    // letters, numbers, and spaces, and must be different from all other players.
    @IBAction func newPlayerName(_ sender: Any) {
        
        // Clear the error message
        errorMessage.text = ""
        
        let tempPlayer = newPlayerName.text
        var thePlayer = ""
        if tempPlayer!.count == 0 {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = "Player name missing"
        }
        else if tempPlayer!.count > gdefault.gamesLengthPlayerName {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = "Player name size max " + String(gdefault.gamesLengthPlayerName)
        }
        else {
            thePlayer = tempPlayer!.padding(toLength: gdefault.gamesLengthPlayerName, withPad: " ", startingAt: 0)
            //print("AP NPN name=<\(String(describing: thePlayer)) len=\(thePlayer.count)")
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

        // Search for duplicate names
        // Both the entered name and all names on file are reduced by removing all spaces
        // and by making them upper case (for comparison only - the actual names are
        // left as is.
        if errorMessage.text == "" {
            var pcount = 0
            let thePlayerNoSpaces = thePlayer.replacingOccurrences(of: " ", with: "")
            let thePlayerUpperCase = thePlayerNoSpaces.uppercased()
            //print("AP aP searching for dups for player name \(String(describing: thePlayer))")
            //print("AP aP changed player name to \(thePlayerUpperCase)")
            while pcount < gdefault.gamesLengthPlayerNameOccurs {
                let theFilePlayerNoSpaces = gdefault.gamesPlayerName[pcount].replacingOccurrences(of: " ", with: "")
                let theFilePlayerUpperCase = theFilePlayerNoSpaces.uppercased()
                //print("AP aP testing entered name \(thePlayerUpperCase) vs GS name \(theFilePlayerUpperCase) at idx \(pcount)")
                if !(pcount == thisPlayerGameIndex) &&
                    thePlayerUpperCase == theFilePlayerUpperCase {
                        break
                }
                pcount += 1
            }
            if pcount < gdefault.gamesLengthPlayerNameOccurs {
                //print("AP DS got duplicate at index \(pcount)")
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Duplicate player name"
            }
            else {
                gdefault.gamesPlayerName[thisPlayerGameIndex] = thePlayer
                setAsideThePlayer = thePlayer
                //print("AP NPN from thePlayer setAsideThePlayer=\(setAsideThePlayer) size=\(setAsideThePlayer.count)")
                //print("AP NPN saving player \(String(describing: thePlayer)) in index \(thisPlayerGameIndex)")
            }
        }
        if !(errorMessage.text == "") {
            dealerSequence.isEnabled = false
        }
        else {
            dealerSequence.isEnabled = true
        }
    }
    
    @IBAction func markAsDealerSwitch(_ sender: UISlider) {
        
        // Set value to the nearest 1 and set fonts and colors of the
        // associated yes/no indicators.
        // If the value is yes, store the new player's sequence number (not
        // index) in the current dealer field. If the value is no, leave the
        // current dealer field as is.
        
        sender.setValue((Float)((Int)((sender.value + 0.5) / 1) * 1), animated: false)
        let sval = Int(markAsDealerSwitch.value)
        if sval == 0 {
            markAsDealerNo.textColor = appColorBrightGreen
            markAsDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            markAsDealerYes.textColor = appColorDarkGray
            markAsDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            //print("AP mADS setAsideMarkDealer being set to n")
            setAsideMarkDealer = "n"
        }
        else {
            //print("AP mADS current dealer being set to \(thisPlayerEntrySequence)")
            gdefault.gamesCurrentDealer = String(format: "%02d", thisPlayerEntrySequence)
            markAsDealerNo.textColor = appColorDarkGray
            markAsDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            markAsDealerYes.textColor = appColorBrightGreen
            markAsDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            //print("AP mADS setAsideMarkDealer being set to y")
            setAsideMarkDealer = "y"
        }
    }
    
    @IBAction func playerChoosesPhaseSwitch(_ sender: UISlider) {
        
        // Set value to the nearest 1 and set fonts and colors of the
        // associated yes/no indicators.
        // Store y or n as appropriate in the player chooses phase switch for
        // this player.
               
        sender.setValue((Float)((Int)((sender.value + 0.5) / 1) * 1), animated: false)
        let sval = Int(playerChoosesPhaseSwitch.value)
        if sval == 0 {
            gdefault.gamesPlayerChoosesPhase[thisPlayerGameIndex] = playerDoesNotChoosePhaseConstant
            playerChoosesPhaseNo.textColor = appColorBrightGreen
            playerChoosesPhaseNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            playerChoosesPhaseYes.textColor = appColorDarkGray
            playerChoosesPhaseYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            setAsidePlayerChoosesPhase = playerDoesNotChoosePhaseConstant
        }
        else {
            gdefault.gamesPlayerChoosesPhase[thisPlayerGameIndex] = playerChoosesPhaseConstant
            playerChoosesPhaseNo.textColor = appColorDarkGray
            playerChoosesPhaseNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            playerChoosesPhaseYes.textColor = appColorBrightGreen
            playerChoosesPhaseYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            setAsidePlayerChoosesPhase = playerChoosesPhaseConstant
        }
    }
    
    // Dealer sequence is mandatory, maximum 2 characters, and must be different
    // from the dealer sequences of all other players.
    @IBAction func dealerSequence(_ sender: Any) {
        
        // Clear the error message
        errorMessage.text = ""
        
        //print("AP DS entered sequence size=\(dealerSequence.text!.count) value=\(String(describing: dealerSequence.text))")
        
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
                errorMessage.text="Dealer sequence must use 0-9"
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
            //print("AP DS searching for dups for dealer sequence \(String(describing: theDealerSequence))")
            integerDealerSequence = Int(theDealerSequence!)!
            while pcount < gdefault.gamesLengthPlayerNameOccurs {
                let integerDealerOrder = Int(gdefault.gamesPlayerDealerOrder[pcount])
                //print("AP DS testing entered dealer seq \(String(describing: integerDealerSequence)) vs GS seq \(String(describing: integerDealerOrder)) at idx \(pcount)")
                if !(pcount == thisPlayerGameIndex) &&
                    integerDealerSequence == integerDealerOrder {
                        break
                }
                pcount += 1
            }
            if pcount < gdefault.gamesLengthPlayerNameOccurs {
                //print("AP DS got duplicate at index \(pcount)")
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Duplicate dealer sequence"
            }
            else {
                gdefault.gamesPlayerDealerOrder[thisPlayerGameIndex] = String(format: "%02d", integerDealerSequence)
                setAsideDealerSequence = integerDealerSequence
                //print("AP dS set dealer sequence to \(setAsideDealerSequence)")
            }
        }
        
        if !(errorMessage.text == "") {
            newPlayerName.isEnabled = false
        }
        else {
            newPlayerName.isEnabled = true
        }
        
        // Re-adjust the non-keyboard-covered portion of the screen downwards
        // to its original position when the keyboard is removed. Also re-enable
        // the "player chooses phase" switch, and the cancel, add, & help buttons.
        view.frame.origin.y = 0
        playerChoosesPhaseSwitch.isEnabled = true
        cancelButton.isEnabled = true
        addButton.isEnabled = true
        aViewTutorialButton.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print("AP starting vDL")
        
        // Force light mode in case dark mode is turned on
        overrideUserInterfaceStyle = .light
        
        // Initialize error message
        errorMessage.text = ""
                 
        // Make the error message have bold text
        errorMessage.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
                 
        // Round the button corners
        cancelButton.layer.cornerRadius = cornerRadiusStdButton
        addButton.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton
        
        self.dealerSequence.delegate = self
        self.addDoneButtonOnKeyboard ()
        self.newPlayerName.delegate = self
        self.addDoneButtonOnKeyboard2 ()
        
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // Disallow exit and help unless verified first via code
    
        allowExitFromView = false
        continueToHelp = false
        
    } // End viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {

        refreshView()
        
    } // End viewWillAppear
    
    // This function generates the player name being added
    // Input:   current player entry sequence number
    // Output:  new player name
    // The default name is "Player" followed by the 2-digit entry sequence number
    // However, if a player has been deleted, this name may now be a duplicate. If so,
    // an "a" is concatenated, or a "b", etc., until a unique name is found.
    func generatePlayerName(entryIn: Int) -> String {
        //print("AP gPN entry=\(entryIn)")
        let tempName1 = "Player" + String(format: "%02d", entryIn)
        // Pad the player name with spaces to fill the field
        let tryPlayerName1 = tempName1.padding(toLength: gdefault.gamesLengthPlayerName, withPad: " ", startingAt: 0)
        //print("AP gPN name1=\(tryPlayerName1)")
        var tryPlayerName2 = ""
        var pcount = 0
        var firstNameIsADuplicate = "n"
        while pcount < gdefault.gamesLengthPlayerEntryOrderOccurs {
            if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                break
            }
            //print("AP gPN scanning (1) <\(tryPlayerName1)> against <\(gdefault.gamesPlayerName[pcount])>")
            if tryPlayerName1 == gdefault.gamesPlayerName[pcount] {
                //print("AP gPN found a duplicate (1)")
                firstNameIsADuplicate = "y"
                break
            }
            pcount += 1
        }
        //print("AP gPN after first loop dup=\(firstNameIsADuplicate)")
        if firstNameIsADuplicate == "y" {
            let letterSet = "abcdefghijklmnopq"
            var lidx = 0
            var nextNameIsADuplicate = "n"
            while lidx < gdefault.gamesLengthPlayerNameOccurs {
                let sidx = letterSet.index(letterSet.startIndex, offsetBy: lidx)
                let eidx = letterSet.index(letterSet.startIndex, offsetBy: lidx+1)
                let range = sidx ..< eidx
                let nextLetter = letterSet[range]
                let stringNextLetter = String(nextLetter)
                let tempName2 = tempName1 + stringNextLetter
                // Pad the player name with spaces to fill the field
                tryPlayerName2 = tempName2.padding(toLength: gdefault.gamesLengthPlayerName, withPad: " ", startingAt: 0)
                //print("AP gPN name2=\(tryPlayerName2)")
                pcount = 0
                while pcount < gdefault.gamesLengthPlayerEntryOrderOccurs {
                    if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                        break
                    }
                    //print("AP gPN scanning (2) <\(tryPlayerName2)> against <\(gdefault.gamesPlayerName[pcount])>")
                    if tryPlayerName2 == gdefault.gamesPlayerName[pcount] {
                        //print("AP gPN found a duplicate (2)")
                        nextNameIsADuplicate = "y"
                        break
                    }
                    pcount += 1
                }
                if nextNameIsADuplicate == "n" {
                    break
                }
                nextNameIsADuplicate = "n"
                lidx += 1
            }
            return tryPlayerName2
        }
        else {
            return tryPlayerName1
        }
    }
    
    func refreshView () {
        
        errorMessage.text = ""
        
        // Show this game's name
        theGame.text = "Add A Player To Game " + gdefault.gamesGameName
            
        // Read the Games file into a holding area. Then load the game being
        // played into data area checkGames, and parse it into individual
        // global storage fields.
        
        let fileHandleAPGamesGet:FileHandle=FileHandle(forReadingAtPath:gamesFileURL.path)!
        let fileContent:String=String(data: fileHandleAPGamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleAPGamesGet.closeFile()
        let holdGamesFile = fileContent
        let gameFileSize = holdGamesFile.count
        //print("AP vWA Games File Length=\(gameFileSize) data=<\(holdGamesFile)>")
        
        var seekGame = ""
        var thisGameName = ""
        gameRecordOffset = 0
            
        while seekGame == "" {
            if gameRecordOffset > gameFileSize {
                seekGame = "$Failure"
                break
            }
            //print("AP vWA going to extract the whole game out of the Games file")
            checkGames = extractRecordField(recordIn: holdGamesFile, fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
            //print("AP vWA going to extract game name from Games record")
            thisGameName = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
            //print("AP vWA extracted game name \(thisGameName)")
            if thisGameName == gdefault.gamesGameName {
                seekGame = thisGameName
                break
            }
            gameRecordOffset += gdefault.gamesRecordSize
        }
        if seekGame == "$Failure" {
            //print("AP vWA did not find the game - fatal error")
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = "Fatal error can't find game"
        }
        else {
            //print("AP vWA found game at offset \(gameRecordOffset) game data=<\(checkGames)>")
        
            // Parse this Games record into global storage
            //print("AP vWA calling extractGamesRecord to parse into global storage")
            extractGamesRecord ()
               
            // Setup mark as dealer switch:
            // - See if anyone is already marked as the dealer. If so, set
            //   the switch to no, otherwise, set it to yes.
            //   If dealer tracking is not being done, disable the switch, and
            //   set the yes/no values and the "mark as dealer" label to
            //   dark gray.
                
            if  gdefault.gamesCurrentDealer == initZeroCurDealer {
                markAsDealerSwitch.value = 1
                markAsDealerNo.textColor = appColorDarkGray
                markAsDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
                markAsDealerYes.textColor = appColorBrightGreen
                markAsDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
                setAsideMarkDealer = "y"
            }
            else {
                markAsDealerSwitch.value = 0
                markAsDealerNo.textColor = appColorBrightGreen
                markAsDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
                markAsDealerYes.textColor = appColorDarkGray
                markAsDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
                setAsideMarkDealer = "n"
            }
                
            if gdefault.gamesTrackDealer == notTrackingDealerConstant {
                markAsDealerSwitch.value = 0
                markAsDealerNo.textColor = appColorDarkGray
                markAsDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
                markAsDealerYes.textColor = appColorDarkGray
                markAsDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
                markAsDealerSwitch.isEnabled = false
                markAsDealerLabel.textColor = appColorDarkGray
                setAsideMarkDealer = "n"
            }
            else {
                markAsDealerSwitch.isEnabled = true
            }
                
            // Setup player chooses phase:
            // - There is no configurable default. Assume player does not
            //   choose phase.
           
            playerChoosesPhaseSwitch.value = 0
            playerChoosesPhaseNo.textColor = appColorBrightGreen
            playerChoosesPhaseNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            playerChoosesPhaseYes.textColor = appColorDarkGray
            playerChoosesPhaseYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            setAsidePlayerChoosesPhase = playerDoesNotChoosePhaseConstant
            
            // Choose an entry sequence number that is one higher than the highest one on file.
            var pcount = 0
            thisPlayerEntrySequence = 0
            var highestEntrySoFar = initZeroEntry
            while pcount < gdefault.gamesLengthPlayerNameOccurs {
                if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                    break
                }
                if gdefault.gamesPlayerEntryOrder[pcount] > highestEntrySoFar {
                    highestEntrySoFar = gdefault.gamesPlayerEntryOrder[pcount]
                }
                pcount += 1
            }
            if pcount < gdefault.gamesLengthPlayerEntryOrderOccurs {
                let tempEntry = Int(highestEntrySoFar)
                thisPlayerGameIndex = pcount
                thisPlayerEntrySequence = tempEntry! + 1
                entrySequence.text = String(format: "%02d", thisPlayerEntrySequence)
            }
            else {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Fatal error can't set entry sequence"
            }
            
            // Set default player name
            let generatedPlayerName = generatePlayerName(entryIn: thisPlayerEntrySequence)
            newPlayerName.text = generatedPlayerName
            setAsideThePlayer = generatedPlayerName
            //print("AP NPN from generatedPlayerName setAsideThePlayer=\(setAsideThePlayer) size=\(setAsideThePlayer.count)")
            
            // Note that originally, the dealer sequence was set equal to the entry
            // sequence. Unfortuunately, this left no room between dealer sequence
            // numbers, so making a change to the dealer sequence was difficult. This
            // was changed so that the assigned dealer sequence would be equal to the
            // entry sequence times 5. This is fine as long as there are only 15 players,
            // so the highest dealer sequence is 75. However, it was later realized
            // that if any player from 1-14 is deleted, and then re-added, the new
            // player is entry sequence 16, followed by 17, up to 26. When the entry
            // sequence is 20 or more, the dealer sequence becomes 100 or more, which
            // is not valid (maximum is 99). So, the newest iteration of this logic
            // is that the dealer sequence is set to the entry sequence times 5 up
            // to an entry sequence of 15. Thereafter, it is set to 75 plus (the entry
            // sequence minus 15) times 2, which yields a maximum dealer sequence of 97.
            // This yields dealer sequence values of 77, 79, 81, ..., 97 when the entry
            // sequence is 16, 17, 18, ..., 26.

            // First set the potential dealer sequence number as described above
            var tryThisDealerSequence = 0
            if thisPlayerEntrySequence < 16 {
                tryThisDealerSequence = thisPlayerEntrySequence * 5
            }
            else {
                tryThisDealerSequence = 75 + ((thisPlayerEntrySequence - 15) * 2)
            }
            
            // See if any player is already using this potential dealer sequence as its
            // dealer sequence. Do so by scanning all the dealer sequence numbers
            // looking for a match. If the entire array is scanned without finding it,
            // the dealer sequence number set above is ok.
            pcount = 0
            while pcount < gdefault.gamesLengthPlayerDealerOrderOccurs  {
                if !(gdefault.gamesPlayerDealerOrder [pcount] == initZeroDealer) {
                    if tryThisDealerSequence == Int(gdefault.gamesPlayerDealerOrder [pcount]) {
                        break
                    }
                }
                pcount += 1
            }
            if pcount == gdefault.gamesLengthPlayerDealerOrderOccurs  {
                thisPlayerDealerSequence = tryThisDealerSequence
                dealerSequence.text = String(format: "%02d", thisPlayerDealerSequence)
                setAsideDealerSequence = thisPlayerDealerSequence
            }
            else {
                // A duplicate dealer sequence was found. Reset it to the lowest available
                // non-zero sequence number. To find it, initialize a 99-entry array
                // with 99 blanks (all possible sequence numbers). Then scan all the
                // used dealer sequences and mark their corresponding positions in the
                // 99-entry array with "u". Finally scan the 99-entry array and
                // determine the lowest slot that's blank. This is the next dealer
                // sequence.
                
                // Initialize the 99-entry "used dealer sequence" array to blanks
                var ucount = 0
                var usedDealers = [String]()
                while ucount < 99 {
                    usedDealers.append(" ")
                    ucount += 1
                }
                
                // Mark all positions with a "u" that correspond to used dealer
                // sequence numbers. Note that dealer sequence numbers range
                // from 1-99, but the corresponding used dealer array indexes
                // range from 0-98. This is why the used dealer array index
                // is always 1 less than the corresponding dealer sequence number.
                var dcount = 0
                while dcount < gdefault.gamesLengthPlayerDealerOrderOccurs {
                    if !(gdefault.gamesPlayerDealerOrder [dcount] == initZeroDealer) {
                        ucount = Int(gdefault.gamesPlayerDealerOrder [dcount])!
                        usedDealers [ucount-1] = usedDealerCode
                    }
                    dcount += 1
                }
                
                //print ("AP used dealer sequence array =<\(usedDealers)>")
                
                // Finally scan the used dealer sequence array and get the
                // first one that's not used (and thereby blank). The dealer
                // sequence to be assigned is the index incremented by 1.
                ucount = 0
                while ucount < 99 {
                    if usedDealers [ucount] == " " {
                        break
                    }
                    ucount += 1
                }
                if ucount < 99 {
                    thisPlayerDealerSequence = ucount + 1
                    dealerSequence.text = String(format: "%02d", ucount+1)
                    setAsideDealerSequence = thisPlayerDealerSequence
                }
                else {
                    errorMessage.textColor = appColorRed
                    errorMessage.backgroundColor = appColorYellow
                    errorMessage.text = "Fatal error can't set dealer seq"
                }
            } // End logic where dealer sequence was determined by looking
              // at all used dealer sequences.
        } // End logic where game record was acquired
    
        // If returning from help, and there's no other error, reinstate the
        // fields as they were before going to help
        if gdefault.awaitingHelpReturn == "y" && errorMessage.text == "" {
            gdefault.awaitingHelpReturn = "n"
            newPlayerName.text = gdefault.preHelpNewPlayerName
            if gdefault.preHelpMarkAsDealer == 1 {
                markAsDealerSwitch.value = 1
                markAsDealerNo.textColor = appColorDarkGray
                markAsDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
                markAsDealerYes.textColor = appColorBrightGreen
                markAsDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
                setAsideMarkDealer = "y"
            }
            else {
                markAsDealerSwitch.value = 0
                markAsDealerNo.textColor = appColorBrightGreen
                markAsDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
                markAsDealerYes.textColor = appColorDarkGray
                markAsDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
                setAsideMarkDealer = "n"
            }
            if gdefault.preHelpPlayerChoosesPhaseValue == 0 {
                playerChoosesPhaseSwitch.value = 0
                playerChoosesPhaseNo.textColor = appColorBrightGreen
                playerChoosesPhaseNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
                playerChoosesPhaseYes.textColor = appColorDarkGray
                playerChoosesPhaseYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
                setAsidePlayerChoosesPhase = playerDoesNotChoosePhaseConstant
            }
            else {
                playerChoosesPhaseSwitch.value = 1
                playerChoosesPhaseNo.textColor = appColorDarkGray
                playerChoosesPhaseNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
                playerChoosesPhaseYes.textColor = appColorBrightGreen
                playerChoosesPhaseYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
                setAsidePlayerChoosesPhase = playerChoosesPhaseConstant
            }
            dealerSequence.text = gdefault.preHelpDealerOrder
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = gdefault.preHelpErrorMessage
        }
        
        // Disallow exit and help unless verified first via code
        allowExitFromView = false
        continueToHelp = false
    }
    
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
