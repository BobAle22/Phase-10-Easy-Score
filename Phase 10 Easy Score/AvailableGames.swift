//
//  AvailableGames.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 4/10/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import SCLAlertView
import UIKit

class AvailableGames: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var chooseGameInstructions: UILabel!
    @IBOutlet weak var moreInstructions1: UILabel!
    @IBOutlet weak var moreInstructions2: UILabel!
    @IBOutlet weak var gameNamePicker: UIPickerView!
    @IBOutlet weak var aQuickViewButton: UIButton!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    var holdGamesFile = ""
    var tempGameRec = ""
    var thisGameName = ""
    var gameFileSize = 0
    var gameRecordToCopy = ""
    var theChosenGame = ""
    
    // Controls whether or not user is allowed to exit (via the Choose button)
    var allowExitFromView = false
  
    // Used in conjunction with allowExitFromView -- specifically to allow
    // access to the help screen
    var continueToHelp = false
    
    // Array to hold the sorted player values - controls order in which players are displayed,
    // and that clear phase & add points data is kept
    var playerSortData = [String]()

    // Array to hold the phase names for display following the players
    var nextPhaseLine = [" ", " ", " ", " ", " ", " ", " ", " ", " ", " "]
    
    // General function to remove a game from the games file as well as from the history file
    func removeThisGame() {
        theChosenGame = gameNames[theRow]
        // Get the offset of this game in the Games file
        let fileHandleAG2GamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
        let fileContent:String=String(data:fileHandleAG2GamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleAG2GamesGet.closeFile()
        let gameFileSize = fileContent.count
        
        var gameRecordOffset = 0
        while gameRecordOffset < gameFileSize {
            //print("AG rTG scanning games: offset is \(gameRecordOffset)")
            let tempGameRec = extractRecordField(recordIn: fileContent,  fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
            let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
            //print("UP comparing desired game \(theChosenGame) vs. file game \(thisGameName)")
            if thisGameName == theChosenGame {
                //print("AG rTG found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                break
            }
            gameRecordOffset += gdefault.gamesRecordSize
        }
        
        // Remove the record and recreate the file
        //print("AG rTG now calling updateGamesFile for removal with offset \(gameRecordOffset)")
        updateGamesFile(actionIn: updateFileRemovalCode, gameOffsetIn: gameRecordOffset)
        
        // Get the offset of this game in the History file
        let fileHandleAG2HistoryGet:FileHandle=FileHandle(forReadingAtPath: historyFileURL.path)!
        let fileContent2:String=String(data:fileHandleAG2HistoryGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleAG2HistoryGet.closeFile()
        let historyFileSize = fileContent2.count
        
        var historyRecordOffset = 0
        while historyRecordOffset < historyFileSize {
            //print("AG rTG scanning history: offset is \(historyRecordOffset)")
            //print("AG rTG first get the history record at offset \(historyRecordOffset) with length \(gdefault.historyRecordSize) within file length \(historyFileSize)")
            let tempHistoryRec = extractRecordField(recordIn: fileContent2,  fieldOffset: historyRecordOffset, fieldLength: gdefault.historyRecordSize)
            //print("AG rTG second get the game name at offset \(gdefault.historyOffsetGameName) with length \(gdefault.historyLengthGameName)")
            let thisGameName = extractRecordField(recordIn: tempHistoryRec, fieldOffset: gdefault.historyOffsetGameName, fieldLength: gdefault.historyLengthGameName)
            //print("UP comparing desired game \(theChosenGame) vs. file game \(thisGameName)")
            if thisGameName == theChosenGame {
                //print("AG rTG found matching file game \(thisGameName) at offset \(historyRecordOffset) and issued break command")
                break
            }
            historyRecordOffset += gdefault.historyRecordSize
        }
        
        // Remove the record and recreate the file
        //print("AG rTG now calling updateHistoryFile for removal of game \(theChosenGame) with offset \(historyRecordOffset)")
        updateHistoryFile(actionIn: updateFileRemovalCode, historyOffsetIn: historyRecordOffset, newHistoryDataIn: "")
    }
    
    // Show the contents of the game that's currently in the selection window
    // Overall, show the game name, version, version modifier, and player names
    // More data is acquired within this function in case it becomes desirable in the future
    @IBAction func aQuickViewButton(_ sender: Any) {
        
        gdefault.RemovePressed = "1"
        theChosenGame = gameNames[theRow]
        
        // Get this game from the Games file
        let fileHandleAG5GamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
        let fullGameFile:String=String(data:fileHandleAG5GamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleAG5GamesGet.closeFile()
        let gameFileSize = fullGameFile.count
        
        var gameRecordOffset = 0
        while gameRecordOffset < gameFileSize {
            checkGames = extractRecordField(recordIn: fullGameFile,  fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
            let thisGameName = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
            if thisGameName == theChosenGame {
                break
            }
            gameRecordOffset += gdefault.gamesRecordSize
        }

        // Parse this Games record into global storage
        extractGamesRecord ()

        // Set the width of the alert window to be most of the screen width
        let mostOfScreenWidth: Double = Double(deviceWidth) * 0.90
        
        // Set the icon image size
        let alertViewIconSize = 35.0
        
        // Set the alert window text size
        let alertViewFont = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        var alertFontSize : CGFloat = 0
        if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
            alertFontSize = 16
        }
        else {
            alertFontSize = 18
        }
        let alertViewPhaseFont = UIFont(name: "timesNewRomanPSMT", size: alertFontSize)
        
        // Customize the alert to be:
        // - 90% screen width
        // - font size as set above
        // - rounded dismissal button corners
        // - dark green icon outside circle
        // - bright green general background
        // - black dismissal button text
        let customizeTheAlert = SCLAlertView.SCLAppearance(kCircleIconHeight: alertViewIconSize, kWindowWidth: CGFloat(mostOfScreenWidth), kTitleFont: alertViewFont, kTextFont: alertViewPhaseFont!, kButtonFont: alertViewFont, buttonCornerRadius: cornerRadiusStdButton, circleBackgroundColor: appColorDarkGreen, contentViewColor: appColorBrightGreen, titleColor: appColorBlack)
        let alertView = SCLAlertView(appearance: customizeTheAlert)
        
        // Use the Phase 10 Easy Score icon as the alert icon
        let alertViewIcon = UIImage(named: "AppIcon")
        
        // Top heading
        let alertViewHeading = "Quick View"
        
        // Green icon and button background
        let alertViewBackgroundIconButtonColor = UInt(appColorGreenHex)
        
        // Build all the game information
        
        // Game name and round number
        //let showRoundNumber = Int(gdefault.gamesRoundNumber)
        //let gameRoundLine = "Game " + gdefault.gamesGameName + "   |   Round " + String(format: "% 2d", showRoundNumber!) + "\n"
        let gameRoundLine = "Game " + gdefault.gamesGameName + "\n"
        
        // Version and phase modifier
        var versionAndModifier = ""
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            versionAndModifier = allPhasesName
        case evenPhasesCode:
            versionAndModifier = evenPhasesName
        case oddPhasesCode:
            versionAndModifier = oddPhasesName
        default:
            _ = ""
        }
        var versionModifierLine = retrieveGameVersionName(numberIn: gdefault.gamesGameVersion)
        versionModifierLine = versionModifierLine + " / " + versionAndModifier + "\n\n"
        
        var thisGame = gameRoundLine + versionModifierLine
        
        // Sort player information in the order in which they were entered
        // The key, data, and field lengths are as follows:
        // key             | data             |
        // entry order (2) | player index (2) |

        playerSortData.removeAll()
        
        var pcount = 0
        while pcount < gdefault.gamesLengthPlayerNameOccurs  {
            if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                break
            }
            // Prepare data for the sort
            let stringPcount = String(format: "%02d", pcount)
            playerSortData.append(gdefault.gamesPlayerEntryOrder[pcount] + stringPcount)
            pcount += 1
        }
        // Now sort in ascending order
        playerSortData.sort()
        
        let numberOfPlayers = playerSortData.count

        var scount = 0

        if numberOfPlayers == 0 {
            thisGame = thisGame + "No players in this game"
        }
        else {
            while scount < numberOfPlayers {
                let rawSortData = playerSortData[scount]
                let sidx = rawSortData.index(rawSortData.startIndex, offsetBy: 2)
                let eidx = rawSortData.index(rawSortData.startIndex, offsetBy: 4)
                let range = sidx ..< eidx
                pcount = Int(String(rawSortData[range]))!
                
                // This is the player name and winner/dealer indicator (as appropriate)
                
                let thisPlayerName = gdefault.gamesPlayerName[pcount]
                let finalPlayerName = thisPlayerName
                //if gdefault.gamesTrackDealer == trackingDealerConstant {
                //    if gdefault.gamesPlayerEntryOrder[pcount] == gdefault.gamesCurrentDealer {
                //        finalPlayerName = thisPlayerName + " (Dealer)"
                //    }
                //}
                //if gdefault.gamesGameStatus == gameCompleteStatusCode {
                //    if gdefault.gamesPlayerWinner[pcount] == "y" {
                //        finalPlayerName = thisPlayerName + " WINNER! "
                //    }
                //}
                
                // Then the skip status to the immediate right of the player information
                
                //var skipText = ""
                //if gdefault.gamesPlayerSkipped[pcount] == playerIsSkipped {
                //    skipText = " Skipped"
                //}
                //finalPlayerName = finalPlayerName + skipText
                
                thisGame = thisGame + finalPlayerName + "\n"
                
                // This is a player's phase completion status and points
                
                // First the phase completion status
                
                //let returnedRawPhasePoints = determinePhaseAndPointsStatus(requestedFormatIn: dataFormatLabel,
                //                                                           indexIn: pcount)
                //let phaseText = returnedRawPhasePoints.rawDataOrPhaseText
                //let pointsText = returnedRawPhasePoints.pointsText
                
                //thisGame = thisGame + phaseText + " | " + pointsText + "\n"
                
                scount += 1
            }
        }

        // Show the alert
        alertView.showTitle(alertViewHeading, subTitle: thisGame, style: .info, colorStyle: alertViewBackgroundIconButtonColor, colorTextButton: UInt(appColorBlackHex), circleIconImage: alertViewIcon)
    }
    
    // This is either the "choose" or "remove" button. When removing, the user must
    // press it a second consecutive time to do the removal
    @IBAction func chooseButton(_ sender: Any) {
        switch gdefault.availableGameChoiceInstructions {
        case "Resume":
            gdefault.RemovePressed = "1"
            theChosenGame = gameNames[theRow]
            
            // Get this game from the Games file
            let fileHandleAG3GamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
            let fullGameFile:String=String(data:fileHandleAG3GamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleAG3GamesGet.closeFile()
            let gameFileSize = fullGameFile.count
            //print("AG cB Resume games file =<\(fullGameFile)>")
            
            var gameRecordOffset = 0
            while gameRecordOffset < gameFileSize {
                //print("AG cB Resume scanning: offset is \(gameRecordOffset)")
                checkGames = extractRecordField(recordIn: fullGameFile,  fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
                let thisGameName = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
                //print("AG cB Resume comparing desired game \(theChosenGame) vs. file game \(thisGameName)")
                if thisGameName == theChosenGame {
                    //print("AG cB Resume found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                    break
                }
                gameRecordOffset += gdefault.gamesRecordSize
            }

            // Parse this Games record into global storage
            //print("AG cB Resume games record =<\(checkGames)>")
            //print("AG cB Resume calling extractGamesRecord to parse into global storage, then proceed to resume game")
            extractGamesRecord ()
            
            // Generate TheGame screen
            aCreateView()
            aCreateController()

            allowExitFromView = true
        case "Restart":
            gdefault.RemovePressed = "1"
            theChosenGame = gameNames[theRow]

            // Get this game from the Games file
            let fileHandleAG4GamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
            let fullGameFile:String=String(data:fileHandleAG4GamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleAG4GamesGet.closeFile()
            let gameFileSize = fullGameFile.count
            //print("AG cB Restart games file =<\(fullGameFile)>")
            
            var gameRecordOffset = 0
            while gameRecordOffset < gameFileSize {
                //print("AG cB Restart scanning: offset is \(gameRecordOffset)")
                checkGames = extractRecordField(recordIn: fullGameFile,  fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
                let thisGameName = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
                //print("AG cB Restart comparing desired game \(theChosenGame) vs. file game \(thisGameName)")
                if thisGameName == theChosenGame {
                    //print("AG cB Restart found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                    break
                }
                gameRecordOffset += gdefault.gamesRecordSize
            }

            // Parse this Games record into global storage
            //print("AG cB Restart games record =<\(checkGames)>")
            //print("AG cB Restart calling extractGamesRecord to parse into global storage, then proceed to restart game")
            extractGamesRecord ()
            // Reset the following:
            // - all phases and points to start-of-game
            // - lowest dealer sequence is flagged as the current dealer
            // - no one chooses phases
            // - no one is the winner
            // - round number is 1
            // - round status is s
            // - game status is n
            // - skip status is n
            // - all phase clearing and point adding buttons are enabled
            // - all points buttons have standard colors
            var pcount = 0
            while pcount < gdefault.gamesLengthPlayerNameOccurs {
                if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                    break
                }
                gdefault.gamesPlayerPhase1[pcount] = gdefault.gamesPhase1
                gdefault.gamesPlayerPhase2[pcount] = gdefault.gamesPhase2
                gdefault.gamesPlayerPhase3[pcount] = gdefault.gamesPhase3
                gdefault.gamesPlayerPhase4[pcount] = gdefault.gamesPhase4
                gdefault.gamesPlayerPhase5[pcount] = gdefault.gamesPhase5
                gdefault.gamesPlayerPhase6[pcount] = gdefault.gamesPhase6
                gdefault.gamesPlayerPhase7[pcount] = gdefault.gamesPhase7
                gdefault.gamesPlayerPhase8[pcount] = gdefault.gamesPhase8
                gdefault.gamesPlayerPhase9[pcount] = gdefault.gamesPhase9
                gdefault.gamesPlayerPhase10[pcount] = gdefault.gamesPhase10
                if gdefault.gamesPhaseModifier == evenPhasesCode {
                    gdefault.gamesPlayerCurrentPhase[pcount] = "02"
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase2[pcount]
                }
                else {
                    gdefault.gamesPlayerCurrentPhase[pcount] = "01"
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase1[pcount]
                }
                gdefault.gamesPlayerPoints[pcount] = zeroPoints
                gdefault.gamesPlayerStartRoundPoints[pcount] = zeroPoints
                gdefault.gamesPlayerChoosesPhase[pcount] = playerDoesNotChoosePhaseConstant
                gdefault.gamesPlayerWinner[pcount] = "n"
                gdefault.gamesPlayerPointsStatus[pcount] = pointsStatusStandard
                gdefault.gamesPlayerPointsStatusEntry[pcount] = "00"
                gdefault.gamesPlayerSkipped[pcount] = playerIsNotSkipped
                pcount += 1
            }
            pcount = 0
            var lowestCurrentDealer = "99"
            var lowestDealerIndex = 0
            while pcount < gdefault.gamesLengthPlayerNameOccurs {
                if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                    break
                }
                if gdefault.gamesPlayerDealerOrder[pcount] < lowestCurrentDealer {
                    lowestCurrentDealer = gdefault.gamesPlayerDealerOrder[pcount]
                    lowestDealerIndex = pcount
                }
                pcount += 1
            }
            lowestDealerIndex += 1
            gdefault.gamesCurrentDealer = String(format: "%02d", lowestDealerIndex)
            gdefault.gamesRoundNumber = "01"
            gdefault.gamesRoundStatus = itIsStarting
            gdefault.gamesGameStatus = notStarted
            var bidx = 0
            while bidx < gdefault.gamesLengthPlayerButtonStatusOccurs {
                gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeEnabled
                bidx += 1
            }
            //print("AG cB Restart CP button status \(gdefault.gamesPlayerButtonStatus)")
            // Update the Games file
            //print("AG cB Restart updating game file")
            // No need to acquire offset because it was determined earlier in this function
            
            // Update the record and recreate the file
            //print("AG cB Restart now calling updateGamesFile with offset \(gameRecordOffset)")
            updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
            
            // Generate TheGame screen
            aCreateView()
            aCreateController()
            
            allowExitFromView = true
        case "Remove":
            switch gdefault.RemovePressed {
            case "1":
                gameNamePicker.isUserInteractionEnabled = false
                gdefault.RemovePressed = "2"
                errorMessage.textColor = appColorWhite
                errorMessage.backgroundColor = appColorMediumGreen
                errorMessage.text = "Press Remove again to verify choice"
                allowExitFromView = false
                continueToHelp = false
            case "2":
                gameNamePicker.isUserInteractionEnabled = true
                gdefault.RemovePressed = "1"
                removeThisGame()
                reloadGameNames()
                self.gameNamePicker.reloadAllComponents()
                self.gameNamePicker.selectRow(0, inComponent: 0, animated: false)
                self.pickerView(self.gameNamePicker, didSelectRow: 0, inComponent: 0)
                errorMessage.textColor = appColorWhite
                errorMessage.backgroundColor = appColorMediumGreen
                errorMessage.text = "Game " + theChosenGame + " removed"
                if gameNames.count == 0 {
                    gameNamePicker.isUserInteractionEnabled = false
                    chooseButton.isEnabled = false
                    aQuickViewButton.isEnabled = false
                    errorMessage.textColor = appColorRed
                    errorMessage.backgroundColor = appColorYellow
                    errorMessage.text = "No games on file - press Cancel"
                    allowExitFromView = false
                    continueToHelp = false
                }
                allowExitFromView = false
            default:
                _ = ""
            }
        case "Copy its Players":
            gdefault.RemovePressed = "1"
            gameNamePicker.isUserInteractionEnabled = true
            // Disallow "Choose" request if an error is pending
            if errorMessage.text == "" {
                allowExitFromView = true
            }
            else {
                allowExitFromView = false
            }
            
            if allowExitFromView {
                copyPlayersAndWriteNewGame()
                
                // Generate TheGame screen
                aCreateView()
                aCreateController()
            }
        default:
            _ = ""
        }
    }
    
    // Create view for TheGame screen
    func aCreateView() {
        scrollView.frame = view.frame
        view.addSubview(scrollView)
        NSLayoutConstraint.pin(view: scrollView, to: view)
    }

    // Create TheGame ViewController
    func aCreateController() {
        let vc = TheGame()
        add(child: vc, in: scrollView)
        vc.view.frame = view.frame
        vc.returnToAvailableGames = { [weak self] in
            // unwrap optional
            guard let self = self else { return }
            remove(child: vc)
            scrollView.removeFromSuperview()
        }
    }
    
    // Return to whatever was the previous screen
    @IBAction func cancelButton(_ sender: Any) {
        
        // Always allow cancel request
        allowExitFromView = true
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func aViewTutorialButton(_ sender: Any) {
        
        gdefault.RemovePressed = "1"
        gdefault.helpCaller = helpSectionCodeAvailableGames
        gameNamePicker.isUserInteractionEnabled = true
        errorMessage.text = ""
        // Set this flag to true so that the segue to the help screen is allowed
        // to process
        continueToHelp = true
    }
    
    // Game names are placed here to source the picker view
    
    var gameNames = [String]()
    var theRow = 0

    func numberOfComponents(in gameNamePicker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ gameNamePicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return gameNames.count
    }

    func pickerView(_ gameNamePicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return gameNames[row]
    }
       
    // This is the selected row from the picker view
       
    func pickerView(_ gameNamePicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        theRow = row
    }
    
    // This is the picker view row height
    
    func pickerView(_ gameNamePicker: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 56.0
    }
    
    // Give the picker view background a color from the icon's colors. There are five colors in the icon, so repeat the first color again after each set of five is used. Also set the text color to black or white depending on the background.
    
    func pickerView(_ gameNamePicker: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
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
        
        // Put the game version name in the pickerView
            
        let titleData:String = "     " + gameNames[row]

        pickerLabel?.text = titleData
            
        return pickerLabel!
    }
    
    // Create a new game, copying the players from the selected game
    func copyPlayersAndWriteNewGame () {
        
        //Procedure:
        // 1. Scan holdGamesFile to get Games record for thisGameName.
        // 2. Set this game record aside in gameRecordToCopy.
        // Do the following steps only if there are players in the chosen game.
        // 3. Build new game name.
        // 4. Load all global storage fields with constant and default data,
        //    except for the following:
        //    - game name (being generated).
        //    - player name from gameRecordToCopy.
        //    - player entry order from gameRecordToCopy.
        //    - player dealer order from gameRecordToCopy.
        //    - current dealer sequence is either the first player ("01") or
        //      is "00" if the dealer is not being tracked
        //    - player chooses phase all "n"
        //    - winner "n"
        //    - round number = "01"
        //    - round status = starting
        //    - game status = in progress
        //    - skip status = "n"
        // 5. Write the new game record at the end of the Games file.
        
        // Scan for the chosen game name
        theChosenGame = gameNames[theRow]
        var gameRecordOffset = 0
        while gameRecordOffset < gameFileSize {
            tempGameRec = extractRecordField(recordIn: holdGamesFile, fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
            let tempGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
            if theChosenGame == tempGameName {
                gameRecordToCopy = tempGameRec
                break
            }
            gameRecordOffset += gdefault.gamesRecordSize
        }
        
        //print("AG cPAWNG cpy rec =<\(gameRecordToCopy)>")
        let player1EntrySequence = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetPlayerEntryOrder, fieldLength: gdefault.gamesLengthPlayerEntryOrder)
        if player1EntrySequence == initZeroEntry {
            allowExitFromView = false
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = "This game has no players to copy"
        }
        
        if allowExitFromView {
            
            // Construct the new game name
            let gameName = makeAGameName()
            gdefault.gamesGameName = gameName
            
            // Load global storage with the standard constants and defaults

            gdefault.gamesGameVersion = gdefault.defaultsGameVersion
            gdefault.gamesPhase1 = gdefault.defaultsPhase1
            gdefault.gamesPhase2 = gdefault.defaultsPhase2
            gdefault.gamesPhase3 = gdefault.defaultsPhase3
            gdefault.gamesPhase4 = gdefault.defaultsPhase4
            gdefault.gamesPhase5 = gdefault.defaultsPhase5
            gdefault.gamesPhase6 = gdefault.defaultsPhase6
            gdefault.gamesPhase7 = gdefault.defaultsPhase7
            gdefault.gamesPhase8 = gdefault.defaultsPhase8
            gdefault.gamesPhase9 = gdefault.defaultsPhase9
            gdefault.gamesPhase10 = gdefault.defaultsPhase10
            gdefault.gamesPhaseModifier = gdefault.defaultsPhaseModifier
            gdefault.gamesTrackDealer = gdefault.defaultsTrackDealer
            gdefault.gamesPlayerSort = gdefault.defaultsPlayerSort
            var pcount = 0
            while pcount < gdefault.gamesLengthPlayerNameOccurs {
                gdefault.gamesPlayerChoosesPhase[pcount] = playerDoesNotChoosePhaseConstant
                pcount += 1
            }
            pcount = 0
            while pcount < gdefault.gamesLengthPlayerNameOccurs {
                gdefault.gamesPlayerPhase1[pcount] = gdefault.defaultsPhase1
                gdefault.gamesPlayerPhase2[pcount] = gdefault.defaultsPhase2
                gdefault.gamesPlayerPhase3[pcount] = gdefault.defaultsPhase3
                gdefault.gamesPlayerPhase4[pcount] = gdefault.defaultsPhase4
                gdefault.gamesPlayerPhase5[pcount] = gdefault.defaultsPhase5
                gdefault.gamesPlayerPhase6[pcount] = gdefault.defaultsPhase6
                gdefault.gamesPlayerPhase7[pcount] = gdefault.defaultsPhase7
                gdefault.gamesPlayerPhase8[pcount] = gdefault.defaultsPhase8
                gdefault.gamesPlayerPhase9[pcount] = gdefault.defaultsPhase9
                gdefault.gamesPlayerPhase10[pcount] = gdefault.defaultsPhase10
                pcount += 1
            }
            
            pcount = 0
            var useCurPhase = "01"
            if gdefault.gamesPhaseModifier == evenPhasesCode {
                useCurPhase = "02"
            }
            
            //print("AG cPAWNG cpy modifier=\(gdefault.gamesPhaseModifier) useCurPhase=\(useCurPhase)")
            while pcount < gdefault.gamesLengthPlayerCurrentPhaseOccurs {
                gdefault.gamesPlayerCurrentPhase[pcount] = useCurPhase
                pcount += 1
            }
            //print("AG cPAWNG cpy player current phases=<\(gdefault.gamesPlayerCurrentPhase)>")
            
            pcount = 0
            while pcount < gdefault.gamesLengthPlayerPointsOccurs {
                gdefault.gamesPlayerPoints[pcount] = zeroPoints
                pcount += 1
            }
            
            pcount = 0
            var useSORPhase = ""
            while pcount < gdefault.gamesLengthPlayerStartRoundPhasesOccurs {
                if gdefault.gamesPhaseModifier == evenPhasesCode {
                    useSORPhase = gdefault.gamesPlayerPhase2[pcount]
                }
                else {
                    useSORPhase = gdefault.gamesPlayerPhase1[pcount]
                }
                gdefault.gamesPlayerStartRoundPhases[pcount] = useSORPhase
                pcount += 1
            }
            
            pcount = 0
            while pcount < gdefault.gamesLengthPlayerStartRoundPointsOccurs {
                gdefault.gamesPlayerStartRoundPoints[pcount] = gdefault.gamesPlayerPoints[pcount]
            pcount += 1
            }
            
            pcount = 0
            while pcount < gdefault.gamesLengthPlayerWinnerOccurs {
                gdefault.gamesPlayerWinner[pcount] = "n"
                pcount += 1
            }
            
            gdefault.gamesRoundNumber = "01"
            gdefault.gamesRoundStatus = itIsStarting
            
            // Set the game status to be in progress - this prevents the user from changing the
            // game name and the game version
            gdefault.gamesGameStatus = inProgress
            
            // Copy the player names from the requested game
            pcount = 0
            while pcount < gdefault.gamesLengthPlayerNameOccurs {
                gdefault.gamesPlayerName[pcount] = extractRecordField(recordIn: gameRecordToCopy, fieldOffset: gdefault.gamesOffsetPlayerName + (pcount * gdefault.gamesLengthPlayerName), fieldLength: gdefault.gamesLengthPlayerName)
                pcount+=1
            }
           
            // Set the player entry order to be 01, 02, ... for all players being copied
            pcount = 0
            while pcount < gdefault.gamesLengthPlayerEntryOrderOccurs {
                gdefault.gamesPlayerEntryOrder[pcount] = extractRecordField(recordIn: gameRecordToCopy, fieldOffset: gdefault.gamesOffsetPlayerEntryOrder + (pcount * gdefault.gamesLengthPlayerEntryOrder), fieldLength: gdefault.gamesLengthPlayerEntryOrder)
                if gdefault.gamesPlayerEntryOrder[pcount] > "00" {
                    gdefault.gamesPlayerEntryOrder[pcount] = String(format: "%02d", pcount + 1)
                }
                pcount+=1
            }

            // Set the player dealer sequence to be 05, 10, ... for all players being copied
            pcount = 0
            while pcount < gdefault.gamesLengthPlayerDealerOrderOccurs {
                if gdefault.gamesPlayerEntryOrder[pcount] > "00" {
                    let useDealerSequence = (pcount + 1) * 5
                    gdefault.gamesPlayerDealerOrder[pcount] = String(format: "%02d", useDealerSequence)
                }
                else {
                    gdefault.gamesPlayerDealerOrder[pcount] = "00"
                }
                pcount+=1
            }
            
            // Set the current dealer to "01" or "00" if the dealer is notbeing tracked
            if gdefault.gamesTrackDealer == trackingDealerConstant {
                gdefault.gamesCurrentDealer = "01"
            }
            else {
                gdefault.gamesCurrentDealer = "00"
            }
            
            // Set all global player buttons status codes to e (enabled), set all player point status
            // codes to s (standard colors), and set all skipped indicators to n (not skipped)
            var bidx = 0
            while bidx < gdefault.gamesLengthPlayerButtonStatusOccurs {
                gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeEnabled
                bidx += 1
            }
            bidx = 0
            while bidx < gdefault.gamesLengthPlayerPointsStatusOccurs {
                gdefault.gamesPlayerPointsStatus[bidx] = pointsStatusStandard
                bidx += 1
            }
            bidx = 0
            while bidx < gdefault.gamesLengthPlayerPointsStatusEntryOccurs {
                gdefault.gamesPlayerPointsStatusEntry[bidx] = "00"
                bidx += 1
            }
            bidx = 0
            while bidx < gdefault.gamesLengthPlayerSkippedOccurs {
                gdefault.gamesPlayerSkipped[bidx] = playerIsNotSkipped
                bidx += 1
            }
            
            //print("AG cPAWNG EntryOrder=\(gdefault.gamesPlayerEntryOrder)")
            
            // Create the new Games record for this game
            let gamesText = loadGamesRecordFromGlobal(fileLevelIn: currentFileLevel, gameNameIn: gameName)
            //print("AG nGCP new game=<\(gamesText)>")
            // Write the new Games record at the end of the file
            let fileHandleAGGamesUpdate:FileHandle=FileHandle(forUpdatingAtPath:gamesFileURL.path)!
            fileHandleAGGamesUpdate.seekToEndOfFile()
            fileHandleAGGamesUpdate.write(gamesText.data(using: String.Encoding.utf8)!)
            fileHandleAGGamesUpdate.closeFile()
            //print("AG cPAWNG new Games rec =<\(gamesText)>")
            
            // Create a History file record for this game at the end of the History
            // file
            let historyText = initHistoryRecord(fileLevelIn: outputHistoryFileLevel, gameNameIn: gdefault.gamesGameName)
            let fileHandleAGHistoryUpdate:FileHandle=FileHandle(forUpdatingAtPath:historyFileURL.path)!
            fileHandleAGHistoryUpdate.seekToEndOfFile()
            fileHandleAGHistoryUpdate.write(historyText.data(using: String.Encoding.utf8)!)
            fileHandleAGHistoryUpdate.closeFile()
            //print("AG cPAWNG new History rec=\(historyText)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //print("AG start vWA")

        //print("AG vWA startOver was \(gdefault.startOverTarget)")
        if gdefault.startOverTarget == VCTarget {
            //print("AG vWA hiding view (scrolling backward to the beginning)")
            self.view.isHidden = true
        }
        //else {
            //print("AG vWA not hiding view (scrolling forward)")
        //}
        
        refreshView()
    
        super.viewWillAppear(animated)
        
        //print("AG end vWA")
    } // End viewWillAppear
    
    override func viewDidLoad() {
        
        //print("AG start vDL")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Force light mode in case dark mode is turned on
        overrideUserInterfaceStyle = .light
        
        // Reduce the extra instructions font size on smaller screens
        if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
            moreInstructions1.font = UIFont.systemFont(ofSize: 20)
            moreInstructions2.font = UIFont.systemFont(ofSize: 20)
        }
        // Initialize error message
            errorMessage.text = ""
                 
        // Make the error message have bold text
        errorMessage.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.heavy)
    
        // Round the button corners
        aQuickViewButton.layer.cornerRadius = cornerRadiusStdButton
        chooseButton.layer.cornerRadius = cornerRadiusStdButton
        cancelButton.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton
        
        gameNamePicker.delegate = self
        gameNamePicker.dataSource = self
        
        // Disallow exit and help unless verified first via code
        
        allowExitFromView = false
        continueToHelp = false
        gdefault.RemovePressed = "1"
        
        //print("AG end vDL")
    }// End viewDidLoad
    
    // Reload the pickerview
    func reloadGameNames () {
        gameNames.removeAll()
            
        // Retrieve all games from the Games file and store them in the
        // gameNames array
        let fileHandleAGGamesGet:FileHandle=FileHandle(forReadingAtPath:gamesFileURL.path)!
        let fileContent:String=String(data: fileHandleAGGamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleAGGamesGet.closeFile()
        holdGamesFile = fileContent
        //print("AG rGN games file=<\(holdGamesFile)>")
        gameFileSize = holdGamesFile.count
        //print("SG rGN Games file size=\(gameFileSize)")
        
        var gameRecordOffset = 0
        while gameRecordOffset < gameFileSize {

            //print("AG rGN extracting game at offset \(gameRecordOffset) with expected length \(gdefault.gamesRecordSize)")
            tempGameRec = extractRecordField(recordIn: holdGamesFile, fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
            thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
            //print("AG rGN game name=\(thisGameName)")
            if !(thisGameName == gdefault.dummyGamesName) {
                gameNames.append(thisGameName)
            }
            gameRecordOffset += gdefault.gamesRecordSize
        }
    }
    
    func refreshView () {
        // Disallow exit and help unless verified first via code
        allowExitFromView = false
        continueToHelp = false
        gdefault.RemovePressed = "1"
        
        // Load the 2nd half of the game choice instructions onto the screen
        // based on the data provided by the previous screen
        chooseGameInstructions.text = "Choose a Game to " +
            gdefault.availableGameChoiceInstructions
        
        // Provide additional instructional information
        switch gdefault.availableGameChoiceInstructions {
        case "Restart":
            moreInstructions1.text = "Upon restarting, players remain, but all"
            moreInstructions2.text = "completed phases & points are removed."
        case "Resume":
            moreInstructions1.text = "When you resume a game, the game is"
            moreInstructions2.text = "continued wherever you left off."
        default:
            moreInstructions1.text = ""
            moreInstructions2.text = ""
        }
        
        // If the game is to be removed, also change the text in the choose
        // button to be "Remove a Game"
        if gdefault.availableGameChoiceInstructions == "Remove" {
            chooseButton.setTitle(" Remove a Game ", for: UIControl.State.normal)
        }
        else {
            chooseButton.setTitle(" Choose a Game ", for: UIControl.State.normal)
        }
        
        reloadGameNames()
        
        // If no games exist, show this information and disallow choosing and viewing a game
        if gameNames.count == 0 {
            gameNames.append("No games on file. Press Cancel")
            gameNames.append("and then start a new game.")
            gameNamePicker.isUserInteractionEnabled = false
            aQuickViewButton.isEnabled = false
            chooseButton.isEnabled = false
            errorMessage.text = ""
            allowExitFromView = false
            continueToHelp = false
        }
        else {
            allowExitFromView = true
        }
        self.gameNamePicker.reloadAllComponents()
        self.gameNamePicker.selectRow(0, inComponent: 0, animated: false)
        self.pickerView(self.gameNamePicker, didSelectRow: 0, inComponent: 0)
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
