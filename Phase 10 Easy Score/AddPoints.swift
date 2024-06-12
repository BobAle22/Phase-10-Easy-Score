//
//  AddPoints.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 6/12/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
// 

import UIKit

class AddPoints: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var thePlayer: UILabel!
    @IBOutlet weak var currentPoints: UILabel!
    @IBOutlet weak var addPoints: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var aUpdateButton: UIButton!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var errorMessageBottom: UILabel!
    
    // Controls whether or not user is allowed to exit view
    var allowExitFromView = false
    
    // Used in conjunction with allowExitFromView -- specifically to allow
    // access to the help screen
    var continueToHelp = false
    
    // This controls whether or not the Update button is allowed to process
    // Pressing Done on the keyboard will enable (e) Update, otherwise, it's disabled (d)
    var updateButtonStatus = "d"
    
    // Array of all possible point values that may be added for a player
    let validPoints =   [5, 10, 15, 20, 25, 30, 35, 40, 45, 50,
                        55, 60, 65, 70, 75, 80, 85, 90, 95, 100,
                        105, 110, 115, 120, 125, 130, 135, 140, 145, 150,
                        155, 160, 165, 170, 175, 180, 185, 190, 195, 200,
                        205, 210, 215, 220, 225, 230, 235, 240, 250]
    
    var globalPointsToAdd = ""
    var globalIntegerPointsToAdd = 0
    
    // History data being logged for a phase or point change
    var logHistoryData = ""
    
    var thePlayerIndex = 99 // This player's internal index
    var thePlayerClearPhaseButtonStatusIndex = 99 // This player's index to the clear phase button status
    var thePlayerClearedPhase = false // Indicator as whether or not this player cleared phase in this round
    
    var integerPointsToAdd = 0
    
    // Edit add points
    // It must be in the set [5, 10, 15, ..., 235, 240, 250]
    // If this player did not clear phase, it must also be 50 or more
    // Add it to this player's current point total.
    // Disable this player's add points button.
    // Save the information in the Games file.
    @IBAction func addPoints(_ sender: Any) {
        //print("AP aP start")
        
        // Clear the error message and global points
        errorMessage.text = ""
        errorMessageBottom.text = ""
        globalPointsToAdd = ""
        globalIntegerPointsToAdd = 0
        
        //print("AP aP entered points size=\(addPoints.text!.count)")
        let pointsToAdd = addPoints.text
        
        if pointsToAdd!.count == 0 {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = "Points to add are missing"
        }
        
        if errorMessage.text == "" {
            // Make sure only numbers are present
            if !isNum(dataIn: pointsToAdd!) {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text="Points to add must use 0-9"
            }
            else if pointsToAdd!.count > 3 {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Points to add size max 3"
            }
        }
        
        if errorMessage.text == "" {
            integerPointsToAdd = Int(pointsToAdd!)!
            if integerPointsToAdd == 0 {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Points to add must not be zero"
            }
            else if integerPointsToAdd < 50 &&
                thePlayerClearedPhase == false {
                    errorMessage.textColor = appColorRed
                    errorMessage.backgroundColor = appColorYellow
                    errorMessage.text = "Points must be 50 or more"
            }
            else if !(validPoints.contains(integerPointsToAdd)) {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "This score is not possible"
            }
        }
        
        //print("AP aP current phase for \(gdefault.gamesPlayerName[thePlayerIndex]) is \(gdefault.gamesPlayerCurrentPhase[thePlayerIndex])")

        // Don't allow cumulative points to reach 10000 or more
        if errorMessage.text == "" {
            let tempPointsToAdd = Int(pointsToAdd!)!
            var tempCumulativePoints = Int(gdefault.gamesPlayerPoints[thePlayerIndex])!
            tempCumulativePoints += tempPointsToAdd
            if tempCumulativePoints > 9999 {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "New point max is 9999"
            }
        }
        
        // If all editing passed successfully, enable the Update button and save the points
        // Otherwise, disable the Update button
        if errorMessage.text == "" {
            globalPointsToAdd = String(format: "%04d", integerPointsToAdd)
            globalIntegerPointsToAdd = integerPointsToAdd
            updateButtonStatus = "e"
        }
        else {
            updateButtonStatus = "d"
        }
        //print("AP aP end")
    }
    
    // Function to add a "done" button on the add points keyboard
    // (specifically for the numeric keyboard that has no "done" button - being
    // used for add points).
    func addDoneButtonOnKeyboard() {
        //print("AP aDBOK start")
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(AddPoints.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.addPoints.inputAccessoryView = doneToolbar
        //print("AP aDBOK end")
    }
    
    // Make the keyboard with the newly-added done button disappear
    @objc func doneButtonAction () {
        self.addPoints.resignFirstResponder()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        //print("AP cB start")
        
        let pcount = gdefault.playerIdxByButton[gdefault.addPointsButtonIndex]
        let bidx = (pcount * 5) + 1
        //print("AP cB cancelButton set gamesPlayerButtonStatus[\(bidx)] to e")
        gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeEnabled
        
        //print("AP cB cancelButton gamesPlayerButtonStatus=\(gdefault.gamesPlayerButtonStatus)")
        
        // Update the Games file for this game's player

        //print("AP cB updating game file due to points status change")
        // Get the offset of this game in the Games file
        let fileHandleAPGamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
        let fileContent:String=String(data:fileHandleAPGamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleAPGamesGet.closeFile()
        let gameFileSize = fileContent.count
        
        var gameRecordOffset = 0
        while gameRecordOffset < gameFileSize {
            //print("AP cB scanning: offset is \(gameRecordOffset)")
            let tempGameRec = extractRecordField(recordIn: fileContent,  fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
            let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
            //print("AP cB comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
            if thisGameName == gdefault.gamesGameName {
                //print("AP cB found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                break
            }
            gameRecordOffset += gdefault.gamesRecordSize
        }
        
        // Update the record and recreate the file
        //print("AP cB now calling updateGamesFile with offset \(gameRecordOffset)")
        updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
        
        // Always allow cancel request
        allowExitFromView = true
        //print("AP cB end")
    }
    
    @IBAction func aUpdateButton(_ sender: Any) {
        //print("AP aUB start")
        //print("AP aUB pressed Update, message=\(String(describing: errorMessage.text)), global pts=\(globalIntegerPointsToAdd), button status = \(updateButtonStatus)")
        
        if updateButtonStatus == "d" {
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = "You must enter valid points, and"
            errorMessageBottom.textColor = appColorRed
            errorMessageBottom.backgroundColor = appColorYellow
            errorMessageBottom.text = "then press Done followed by Update"
        }
        
        if errorMessage.text == "" {
        
            // Flag the round and game as now being in progress
            gdefault.gamesRoundStatus = inProgress
            gdefault.gamesGameStatus = inProgress

            let bidx = (thePlayerIndex * 5) + 1
            
            // Build the history log record signifying the addition of points
            //print("AP aUB setting thePlayerIndex to \(thePlayerIndex) from playerIndexByButton[\(gdefault.addPointsButtonIndex)]")
            //print("AP aUB points (before) = \(gdefault.gamesPlayerPoints[thePlayerIndex])")
            gdefault.gamesPlayerPoints[thePlayerIndex] = String(format: "%04d", (Int(gdefault.gamesPlayerPoints[thePlayerIndex])! + globalIntegerPointsToAdd))
            //print("AP aUB points (after) = \(gdefault.gamesPlayerPoints[thePlayerIndex])")
            let thisPlayerCode = createHistoryPlayerCode(playerIn: gdefault.gamesPlayerEntryOrder[thePlayerIndex])
            logHistoryData = thisPlayerCode + historyAddPointsCode + globalPointsToAdd
            //print("AP new history = <\(logHistoryData)>")

            //print("AP aUB set gamesPlayerButtonStatus[\(bidx)] to d")
            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeDisabled
            //print("AP aUB gamesPlayerButtonStatus=\(gdefault.gamesPlayerButtonStatus)")

            gdefault.gamesPlayerPointsStatus[thePlayerIndex] = pointsStatusStandard
            gdefault.gamesPlayerPointsStatusEntry[thePlayerIndex] = "00"
            
            // Update the Games file for this game's player

            //print("AP aUB updating game file due to points change")
            // Get the offset of this game in the Games file
            let fileHandleUPGamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
            let fileContent:String=String(data:fileHandleUPGamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleUPGamesGet.closeFile()
            let gameFileSize = fileContent.count
            
            var gameRecordOffset = 0
            while gameRecordOffset < gameFileSize {
                //print("AP aUB scanning: offset is \(gameRecordOffset)")
                let tempGameRec = extractRecordField(recordIn: fileContent,  fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
                let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
                //print("AP aUB comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
                if thisGameName == gdefault.gamesGameName {
                    //print("AP aUB found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                    break
                }
                gameRecordOffset += gdefault.gamesRecordSize
            }
            
            // Update the record and recreate the file
            //print("UP now calling updateGamesFile with offset \(gameRecordOffset)")
            updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)

            //print("AP aUB updating history file due to points change")
            // Get the offset of this game in the History file
            let fileHandleUPHistoryGet:FileHandle=FileHandle(forReadingAtPath: historyFileURL.path)!
            let fileContent2:String=String(data:fileHandleUPHistoryGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleUPHistoryGet.closeFile()
            let historyFileSize = fileContent2.count
            
            // Find the current game in the History file
            var historyRecordOffset = 0
            //print("AP aUB start game scan in history, file size=\(historyFileSize)")
            while historyRecordOffset < historyFileSize {
                //print("AP aUB scanning: current offset is \(historyRecordOffset)")
                let tempHistoryRec = extractRecordField(recordIn: fileContent2, fieldOffset: historyRecordOffset, fieldLength: gdefault.historyRecordSize)
                let thisGameName = extractRecordField(recordIn: tempHistoryRec, fieldOffset: gdefault.historyOffsetGameName, fieldLength: gdefault.historyLengthGameName)
                //print("AP aUB comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
                if thisGameName == gdefault.gamesGameName {
                    //print("AP aUB found matching file game \(thisGameName) at offset \(historyRecordOffset) and issued break command")
                    break
                }
                historyRecordOffset += gdefault.historyRecordSize
            }
            
            // Update the record and recreate the file
            //print("AP aUB now calling updateHistoryFile with offset \(historyRecordOffset)")
            updateHistoryFile(actionIn: updateFileUpdateCode, historyOffsetIn: historyRecordOffset, newHistoryDataIn: logHistoryData)

            allowExitFromView = true
        }
        else {
            allowExitFromView = false
            globalPointsToAdd = ""
            globalIntegerPointsToAdd = 0
        }
        //print("AP aUB end")
    }
    
    @IBAction func aViewTutorialButton(_ sender: Any) {
        //print("AP vTB start")
        gdefault.helpCaller = helpSectionCodeAddPoints
        
        // Set this flag to true so that the segue to the help screen is
        // allowed to process
        continueToHelp = true
        //print("AP vTB end")
    }
    
    override func viewDidLoad() {
        //print("AP vDL start")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Force light mode in case dark mode is turned on
        overrideUserInterfaceStyle = .light
        
        // Initialize error message
        errorMessage.text = ""
        errorMessageBottom.text = ""
           
        // Make the error message have bold text
        errorMessage.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
        errorMessageBottom.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
           
        // Round the button corners
        cancelButton.layer.cornerRadius = cornerRadiusStdButton
        aUpdateButton.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton
        
        self.addPoints.delegate = self
        self.addDoneButtonOnKeyboard ()
        
        // Make keyboard appear immediately without user having to touch the add points field (since this is
        // the only input field on the screen)
        // Also disable all the buttons
        self.addPoints.becomeFirstResponder()
        
        // Disable the Update button
        updateButtonStatus = "d"
        
        continueToHelp = false
        allowExitFromView = false
        //print("AP vDL end")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //print("AP vWA start")
        aRefreshView()
        //print("AP vWA end")
    }
    
    func aRefreshView () {
        
        //print("AP aRV start")
        //print("AP add points button index is \(gdefault.addPointsButtonIndex)")
        thePlayerIndex = gdefault.playerIdxByButton[gdefault.addPointsButtonIndex]
        thePlayerClearPhaseButtonStatusIndex = thePlayerIndex * 5
        //print("AP aRV gamesPlayerButtonStatus[\(thePlayerClearPhaseButtonStatusIndex)]=\(gdefault.gamesPlayerButtonStatus[thePlayerClearPhaseButtonStatusIndex])")
        if gdefault.gamesPlayerButtonStatus[thePlayerClearPhaseButtonStatusIndex] == buttonCodeEnabled {
            //print("AP aRV clear phase button is enabled")
            thePlayerClearedPhase = false
        }
        else {
            //print("AP aRV clear phase button is disabled")
            thePlayerClearedPhase = true
        }
        //print("AP aRV setting thePlayerIndex to \(thePlayerIndex) from playerIndexByButton[\(gdefault.addPointsButtonIndex)]")
        thePlayer.text = "for player " + gdefault.gamesPlayerName[thePlayerIndex]
        currentPoints.text = gdefault.gamesPlayerPoints[thePlayerIndex]
        //print("AP aRV end")
    }
    
    // Prevent storyboard-defined segue from occurring if an error has been detected
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
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
