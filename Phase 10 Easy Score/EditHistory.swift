//
//  EditHistory.swift
//  Phase 10 Easy Score
// 
//  Created by Robert J Alessi on 7/27/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import UIKit

class EditHistory: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var gameBeingPlayed: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerHistoryPicker: UIPickerView!
    @IBOutlet weak var aReturnButton: UIButton!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    var thePlayerIndex = 0              // Index of the player whose history is being edited
    var thePlayerEntrySequence = 0      // Entry sequence associated with thePlayerIndex
    var thePlayerHistoryCode = ""       // History code associated with thePlayerIndex
    
    var holdHistoryFile = ""
    var tempHistoryRec = ""
    var thisGameName = ""
    var historyFileSize = 0
    
    // This player's history is placed here to source the picker view
    var thisPlayerInterpretedHistory = [String]()   // This holds the interpreted history entries
    
    @IBAction func aReturnButton(_ sender: Any) {
    }
    
    @IBAction func aViewTutorialButton(_ sender: Any) {
        gdefault.helpCaller = helpSectionCodeViewHistory
    }

    func numberOfComponents(in playerHistoryPicker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ playerHistoryPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return thisPlayerInterpretedHistory.count
    }

    // This is the picker view row height
    
    func pickerView(_ playerHistoryPicker: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 56.0
    }
    
    // Give the picker view background a color from the icon's colors. There are five colors in the icon, so repeat the first color again after each set of five is used. Also set the text color to black or white depending on the background.
    
    func pickerView(_ playerHistoryPicker: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
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
        
        // Put the interpreted history description in the pickerView
            
        let titleData:String = "     " + thisPlayerInterpretedHistory[row]

        pickerLabel?.text = titleData
            
        return pickerLabel!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Initialize error message
        errorMessage.text = ""
                 
        // Make the error message have bold text
        errorMessage.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
                 
        // Round the button corners
        aReturnButton.layer.cornerRadius = cornerRadiusStdButton
        aReturnButton.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton
        
        playerHistoryPicker.delegate = self
        playerHistoryPicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print("EH vWA refreshing view")
        aRefreshView()
    }
    
    // This functions examines the internal history data and converts it
    // into something more easily understood by the user.
    func interpretHistoryEntry (internalHistoryIn: String) -> String {
        var interpretedHistoryOut = ""
        var sidx = internalHistoryIn.index(internalHistoryIn.startIndex, offsetBy: 1)
        var eidx = internalHistoryIn.index(internalHistoryIn.startIndex, offsetBy: 2)
        var range = sidx ..< eidx
        let theHistoryCode = String(internalHistoryIn[range])
        switch theHistoryCode {
        case historyAddPointsCode:
            sidx = internalHistoryIn.index(internalHistoryIn.startIndex, offsetBy: 2)
            eidx = internalHistoryIn.endIndex
            range = sidx ..< eidx
            interpretedHistoryOut = "Add " + internalHistoryIn[range] + " points"
        case historyClearAllPointsCode:
            interpretedHistoryOut = "Clear all points"
        case historyClearPhaseCode:
            sidx = internalHistoryIn.index(internalHistoryIn.startIndex, offsetBy: 2)
            eidx = internalHistoryIn.index(internalHistoryIn.startIndex, offsetBy: 4)
            range = sidx ..< eidx
            interpretedHistoryOut = "Clear phase " + internalHistoryIn[range]
        case historyEndRoundCode:
            sidx = internalHistoryIn.index(internalHistoryIn.startIndex, offsetBy: 2)
            eidx = internalHistoryIn.index(internalHistoryIn.startIndex, offsetBy: 4)
            range = sidx ..< eidx
            interpretedHistoryOut = "End of round " + internalHistoryIn[range]
        case historyClearAllPhases:
            interpretedHistoryOut = "Clear all phases"
        case historyPlayerWasEdited:
            interpretedHistoryOut = "Player edited (pt/phase change)"
        default:
            _ = ""
        }
        return interpretedHistoryOut
    }
    
    // Retrieve this player's history and store the interpreted description in the thisPlayerInterpretedHistory array
    func reloadPlayerHistory () {
        
        thisPlayerInterpretedHistory.removeAll()
        
        let fileHandleEHHistoryGet:FileHandle=FileHandle(forReadingAtPath:historyFileURL.path)!
        let fileContent:String=String(data: fileHandleEHHistoryGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleEHHistoryGet.closeFile()
        holdHistoryFile = fileContent
        historyFileSize = holdHistoryFile.count
        
        // First find this game in the history file
        var historyRecordOffset = 0
        while historyRecordOffset < historyFileSize {
            tempHistoryRec = extractRecordField(recordIn: holdHistoryFile, fieldOffset: historyRecordOffset, fieldLength: gdefault.historyRecordSize)
            thisGameName = extractRecordField(recordIn: tempHistoryRec, fieldOffset: gdefault.historyOffsetGameName, fieldLength: gdefault.historyLengthGameName)
            if thisGameName == gdefault.gamesGameName {
                break
            }
            historyRecordOffset += gdefault.historyRecordSize
        }
        
        // Now retrieve this player's history for this game
        let playerHistory = extractRecordField(recordIn: tempHistoryRec, fieldOffset: gdefault.historyOffsetPlayerHistory, fieldLength: gdefault.historyLengthPlayerHistoryOccurs * gdefault.historyLengthPlayerHistory)
        
        //print("EH rPH history=\(playerHistory)")
        
        // Then load it into the array that sources the pickerview
        var hidx = 0
        var playerHistoryOffset = 0
        var playerHistoryEntry = ""
        while hidx < gdefault.historyLengthPlayerHistoryOccurs {
            playerHistoryEntry = extractRecordField(recordIn: playerHistory, fieldOffset: playerHistoryOffset, fieldLength: gdefault.historyLengthPlayerHistory)
            if playerHistoryEntry == initHistoryConstant {
                break
            }
            let sidx = playerHistoryEntry.index(playerHistoryEntry.startIndex, offsetBy: 0)
            let eidx = playerHistoryEntry.index(playerHistoryEntry.startIndex, offsetBy: 1)
            let range = sidx ..< eidx
            if playerHistoryEntry[range] == thePlayerHistoryCode {
                //thisPlayerInternalHistory.append(playerHistoryEntry)
                let historyInterpretation = interpretHistoryEntry(internalHistoryIn: playerHistoryEntry)
                thisPlayerInterpretedHistory.append(historyInterpretation)
            }
            hidx += 1
            playerHistoryOffset += gdefault.historyLengthPlayerHistory
        }
    }
    
    func aRefreshView () {
        
        // Show the game name
        gameBeingPlayed.text = "Game " + gdefault.gamesGameName
        
        thePlayerIndex = gdefault.playerIdxByButton[gdefault.viewHistoryButtonIndex]
        thePlayerEntrySequence = Int(gdefault.gamesPlayerEntryOrder[thePlayerIndex])!
        let stringEntrySequence = String(format: "%02d", thePlayerEntrySequence)
        thePlayerHistoryCode = createHistoryPlayerCode(playerIn: stringEntrySequence)
        //print("EH aRV setting thePlayerIndex to \(thePlayerIndex) from playerIndexByButton[\(gdefault.viewHistoryButtonIndex)]")
        //print("EP aRV setting thePlayerEntrySequence to \(thePlayerEntrySequence)")
        //print("EP aRV setting thePlayerHistoryCode to \(thePlayerHistoryCode)")
        
        // Load the player name
        playerName.text = "For " + gdefault.gamesPlayerName[thePlayerIndex]
        
        reloadPlayerHistory()
        
        // If no history exists, show this information
        if thisPlayerInterpretedHistory.count == 0 {
            thisPlayerInterpretedHistory.append("No history on file. Press Back.")
            playerHistoryPicker.isUserInteractionEnabled = false
            errorMessage.textColor = appColorRed
            errorMessage.text = "No history on file"
            errorMessage.backgroundColor = appColorYellow
        }
        
        self.playerHistoryPicker.reloadAllComponents()
        self.playerHistoryPicker.selectRow(0, inComponent: 0, animated: false)
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
