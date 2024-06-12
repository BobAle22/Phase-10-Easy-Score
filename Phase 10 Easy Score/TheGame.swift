//
//  TheGame.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 3/29/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import SCLAlertView
import UIKit

class TheGame: UIViewController {
    
    public var returnToAvailableGames: (()->())? // This is a closure indicator
    public var returnToStartNewGame: (()->())? // This is a closure indicator
    let fireworks = FireworksParticleView()
    
    // Label for the current game name
    let gameBeingPlayed = UILabel()
    let gBPXposition = 17
    let gBPYposition = 50
    let gBPWidth = 253
    let gBPHeight = 25
    
    // Label for the current round
    let theRound = UILabel()
    let tRXposition = 275
    let tRYposition = 50
    let tRWidth = 117
    let tRHeight = 25
    
    // Label for the game version, phase modifier, and sort order
    let gameVersionAndSort = UILabel()
    let gVASXposition = 1
    let gVASYposition = 73
    let gVASWidth = 395
    let gVASHeight = 25
    
    // Scrolling player status area
    let gameStatusScrollView = UIScrollView()
    
    // Button for sort
    let aSortButton = UIButton()
    let aSBXposition = 30
    let aSBYposition = 520
    var aSBFontArial = "Arial"
    let aSBFontSize: CGFloat = 18
    
    // Button for add player
    let aAddPlayerButton = UIButton()
    let aAPBXposition = 112
    let aAPBYposition = 520
    var aAPBFontArial = "Arial"
    let aAPBFontSize: CGFloat = 18
    
    // Button for end round
    let aEndRoundButton = UIButton()
    let aERBXposition = 247
    let aERBYposition = 520
    let aERBFontArial = "Arial"
    let aERBFontSize: CGFloat = 18
    
    // Button for show phases
    let aShowPhasesButton = UIButton()
    let aSPBXposition = 10
    let aSPBYposition = 560
    let aSPBFontArial = "Arial"
    let aSPBFontSize: CGFloat = 18
    
    // Button for edit game
    let aEditGameButton = UIButton()
    let aEGBXposition = 140
    let aEGBYposition = 560
    let aEGBFontArial = "Arial"
    let aEGBFontSize: CGFloat = 18
    
    // Button for start over
    let aStartOverButton = UIButton()
    let aSOBXposition = 247
    let aSOBYposition = 560
    let aSOBFontArial = "Arial"
    let aSOBFontSize: CGFloat = 18
    
    // Button for view tutorial
    let aViewTutorialButton = UIButton()
    let aVTBXposition = 350
    let aVTBYposition = 555
    let aVTBFontCourier = "Courier"
    let aVTBFontSize: CGFloat = 30
    
    // Label for the upper error message
    let errorMessageTop = UILabel()
    let eMTXposition = 59
    let eMTYposition = 600
    let eMTWidth = 297
    let eMTHeight = 25
    
    // Label for the lower error message
    let errorMessage = UILabel()
    let eMXposition = 59
    let eMYposition = 625
    let eMWidth = 297
    let eMHeight = 25
    
    // Controls whether or not user is allowed to exit view
    var allowExitFromView = false
    
    // Used in conjunction with allowExitFromView -- specifically to allow
    // access to the help screen
    var continueToHelp = false
    
    // Array to hold the sorted player values - controls order in which players are displayed,
    // and that clear phase & add points data is kept
    var playerSortData = [String]()

    // Array to hold the phase names for display following the players
    var nextPhaseLine = [" ", " ", " ", " ", " ", " ", " ", " ", " ", " "]
    
    // History data being logged for a phase or point change
    var logHistoryData = ""
    
    // Indicates that the "end round" function detected that more than one player has zero points
    var endRoundOnly1Zero = "n"
    
    let only1ZeroMsg1 = "Only 1 player with zero points"
    let only1ZeroMsg2 = "is allowed in a round"
    
    // Controls the font size within a label
    var labelFontSize18: CGFloat = 18
    var labelFontSize20: CGFloat = 20
    var labelFontSize21: CGFloat = 21
    
    var playerLabelWidth = 0
    
    var resetGamePosition = 0   // Y coordinate of most-recently-loaded game display
    var twoThirdsScreen = 0     // Offset to subtract from Y position for end-of-game
    
    let horizontalSmall = 76    // Controls horizontal button spacing for small devices
    let horizontalLarge = 78    // Controls horizontal button spacing for large devices
    
    // Label names for player action buttons
    let clearPhaseText = "Clear\nPhase"
    let addPointsText = "Add\nPoints"
    let skipPlayerText = "Skip\nPlayer"
    let unskipPlayerText = "Unskip\nPlayer"
    let editPlayerText = "Edit\nPlayer"
    let viewHistoryText = "View\nHistory"
    let sortText = "Sort"
    let addPlayerText = "Add Player"
    let endRoundText = "End Round "
    let showPhasesText = "Show Phases"
    let editGameText = "Edit Game"
    let startOverText = "Start Over"
    let viewTutorialText = "i"
    
    // Selector function names
    let selectorNames = [
                    #selector(clearPhaseClicked),
                    #selector(addPointsClicked),
                    #selector(skipPlayerClicked),
                    #selector(editPlayerClicked),
                    #selector(viewHistoryClicked),
                    #selector(aSortClicked),
                    #selector(aAddPlayerClicked),
                    #selector(aEndRoundClicked),
                    #selector(aShowPhasesClicked),
                    #selector(aEditGameClicked),
                    #selector(aStartOverClicked),
                    #selector(aViewTutorialClicked)
                    ]
    
    // Selector function nsme indexes
    let clearPhaseClickedIdx = 0
    let addPointsClickedIdx = 1
    let skipPlayerClickedIdx = 2
    let editPlayerClickedIdx = 3
    let viewHistoryClickedIdx = 4
    let sortClickedIdx = 5
    let addPlayerClickedIdx = 6
    let endRoundClickedIdx = 7
    let showPhasesClickedIdx = 8
    let editGameClickedIdx = 9
    let startOverClickedIdx = 10
    let viewTutorialClickedIdx = 11
    
    // Font sizes to use for the game/version/sort label for small devices
    let gameVersionAndSortSmallDeviceFontSizes: [CGFloat] = [
        21,
        18,
        13,
        18,
        12,
        21,
        18,
        21,
        16,
        20,
        16,
        21,
        21,
        16,
        21
    ]
    
    // Font sizes to use for the game/version/sort label for large devices
    let gameVersionAndSortLargeDeviceFontSizes: [CGFloat] = [
        21,
        21,
        15,
        21,
        14,
        21,
        21,
        21,
        19,
        21,
        20,
        21,
        21,
        19,
        21
    ]
    
    var weHaveAnError = "n"     // Indicates whether or not an error has been detected
    
    // General function to see if anyone won the game yet
    func doWeHaveAWinner () {
        //print("\(self) \(#function) - see if we have a winner")
        var pcount = 0
        // Clear the array where we'll store the potential winners
        gdefault.gameWinnerPointsEntry.removeAll()
        
        // Add players to the potential winner array who have completed all phases.
        // Also store their index from the standard game player array.
        // As soon as a player is added, we are guaranteed to have at least one winner.
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                break
            }
            //print("\(self) \(#function) - note the current phase at \(pcount) is \(gdefault.gamesPlayerCurrentPhase[pcount])")
            let returnedRawPhasePoints = determinePhaseAndPointsStatus(requestedFormatIn: dataFormatRaw,
                                              indexIn: pcount)
            let rawPhasePoints = returnedRawPhasePoints.rawDataOrPhaseText
            var eidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 3)
            var range = rawPhasePoints.startIndex ..< eidx
            let thePhase = String(rawPhasePoints[range])
            //print("\(self) \(#function) - thePhase=\(thePhase)")
            let sidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 3)
            eidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 7)
            range = sidx ..< eidx
            let thePoints = String(rawPhasePoints[range])
            
            // A potential winner is identified as follows:
            // - Phase Modifier "all"
            //   - Player chooses or does not choose phases
            //     - Phase 011
            // Phase modifier "even" or "odd"
            //   - Player chooses phases
            //     - Phase 006
            //   - Player does not choose phases
            //     - Phase 011
            
            //print("\(self) \(#function) - player at \(pcount) modifier=\(gdefault.gamesPhaseModifier) choice=\(gdefault.gamesPlayerChoosesPhase[pcount]) phase=\(thePhase)")

            switch gdefault.gamesPhaseModifier {
            case allPhasesCode:
                if thePhase == constantPhase11 {
                    //print("\(self) \(#function) - modifier all, phase 011 is a potential winner")
                    let usePoints = 10000 - Int(thePoints)!
                    let usePointsEntry = String(format: "%05d", usePoints) + String(format: "%02d", pcount)
                    //print("\(self) \(#function) - adding \(usePointsEntry)")
                    gdefault.gameWinnerPointsEntry.append(usePointsEntry)
                    gdefault.gamesGameStatus = gameCompleteStatusCode
                }
                else {
                    //print("\(self) \(#function) - modifier all, phase not 011 is not a potential winner")
                }
            case evenPhasesCode, oddPhasesCode:
                if gdefault.gamesPlayerChoosesPhase[pcount] == playerChoosesPhaseConstant {
                    if thePhase == constantPhase6 {
                        //print("\(self) \(#function) - modifier even/odd, phase 006 is a potential winner")
                        let usePoints = 10000 - Int(thePoints)!
                        let usePointsEntry = String(format: "%05d", usePoints) + String(format: "%02d", pcount)
                        //print("\(self) \(#function) - adding \(usePointsEntry)")
                        gdefault.gameWinnerPointsEntry.append(usePointsEntry)
                        gdefault.gamesGameStatus = gameCompleteStatusCode
                    }
                    else {
                        //print("\(self) \(#function) - modifier even/odd, phase not 006 is not a potential winner")
                    }
                }
                else {
                    if thePhase == constantPhase11 {
                        //print("\(self) \(#function) - modifier even/odd, phase 011 is a potential winner")
                        let usePoints = 10000 - Int(thePoints)!
                        let usePointsEntry = String(format: "%05d", usePoints) + String(format: "%02d", pcount)
                        //print("\(self) \(#function) - adding \(usePointsEntry)")
                        gdefault.gameWinnerPointsEntry.append(usePointsEntry)
                        gdefault.gamesGameStatus = gameCompleteStatusCode
                    }
                    else {
                        //print("\(self) \(#function) - modifier even/odd, phase not 011 is not a potential winner")
                    }
                }
            default:
                //print("\(self) \(#function) - modifier unrecognized is not a potential winner")
                _ = ""
            }
            pcount += 1
        }
        
        // Sort the potential winner array from high-to-low by points
        // Then scan to see if there are multiple winners
        if gdefault.gamesGameStatus == gameCompleteStatusCode {
            //print("\(self) \(#function) - pre-sorted winners \(gdefault.gameWinnerPointsEntry)")
            gdefault.gameWinnerPointsEntry.sort(by: >)
            //print("\(self) \(#function) - sorted winners \(gdefault.gameWinnerPointsEntry)")
            // The first entry is a winner automatically.
            // Any other entries with points matching the first entry are also winners
            // Use the entry numbers to identify which players are to be flagged as the winners
            var scount = 0
            let maxWinners = gdefault.gameWinnerPointsEntry.count
            //print("\(self) \(#function) - max winners is \(maxWinners)")
            var winnerPoints = ""
            while scount < maxWinners {
                let sortedPointsEntry = gdefault.gameWinnerPointsEntry[scount]
                let eidx = sortedPointsEntry.index(sortedPointsEntry.startIndex, offsetBy: 5)
                var range = sortedPointsEntry.startIndex ..< eidx
                let thePoints = String(sortedPointsEntry[range])
                let sidx = sortedPointsEntry.index(sortedPointsEntry.startIndex, offsetBy: 5)
                range = sidx ..< sortedPointsEntry.endIndex
                let theEntry = String(sortedPointsEntry[range])
                let pcount = Int(theEntry)
                if scount == 0 {
                    gdefault.gamesPlayerWinner[pcount!] = "y"
                    //print("\(self) \(#function) - setting first game winner's gamewinners to y")
                    winnerPoints = thePoints
                }
                if thePoints == winnerPoints {
                    //print("\(self) \(#function) - setting subsequent game winner's gamewinners to y")
                    gdefault.gamesPlayerWinner[pcount!] = "y"
                }
                scount += 1
            }
        }
    }
    
    // Refresh this view
    func aRefreshView () {
        weHaveAnError = "n"
        //print("\(self) \(#function) - start for game \(gdefault.gamesGameName)")
        //print("\(self) \(#function) - button statuses=\(gdefault.gamesPlayerButtonStatus)")
        
        // Show this game's name, round, game version / phase modifier, and the current sort order
        // First is the game name
        configureLabel(labelNameIn: gameBeingPlayed,
                       textIn: "Game " + gdefault.gamesGameName,
                       textColorIn: appColorYellow,
                       backgroundColorIn: appColorMediumGreen,
                       xPositionIn: gBPXposition,
                       yPositionIn: gBPYposition,
                       widthIn: gBPWidth,
                       heightIn: gBPHeight,
                       boldOrRegularIn: weightRegular,
                       fontSizeIn: labelFontSize21,
                       justifyIn: justifyLeft)
        view.addSubview(gameBeingPlayed)
        
        // Next is the round number. Show it (within the end round button text and within the current round heading)
        let showRoundNumber = Int(gdefault.gamesRoundNumber)
        configureLabel(labelNameIn: theRound,
                       textIn: "Round " + String(format: "% 2d", showRoundNumber!),
                       textColorIn: appColorBrightGreen,
                       backgroundColorIn: appColorMediumGreen,
                       xPositionIn: tRXposition,
                       yPositionIn: tRYposition,
                       widthIn: tRWidth,
                       heightIn: tRHeight,
                       boldOrRegularIn: weightBold,
                       fontSizeIn: labelFontSize21,
                       justifyIn: justifyLeft)
        view.addSubview(theRound)
        
        // Next is the game version, phase modifier, and sort order
        //print("\(self) \(#function) - config label for game/version number = \(gdefault.gamesGameVersion)")
        let thisGameVersion = retrieveGameVersionName(numberIn: gdefault.gamesGameVersion)
        
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

        let thisGameVersionAndModifier = thisGameVersion + " / " + versionAndModifier
        
        let thisSortIdx = Int(gdefault.gamesPlayerSort)!
        let thisSortDescription = "Sort: " + playerShortSortDescription[thisSortIdx]
        
        // TEMPORARY LINES FOR TESTING
        //thisGameVersion = "Original"
        //thisGameVersion = "Ancient Greece"
        //thisGameVersion = "Candy Castle / Mountain Vista"
        //thisGameVersion = "Cocoa Canyon"
        //thisGameVersion = "Cupcake Lounge / Savannah Sunset"
        //thisGameVersion = "Disco Fever"
        //thisGameVersion = "Island Paradise"
        //thisGameVersion = "Jazz Club"
        //thisGameVersion = "Moonlight Drive-In"
        //thisGameVersion = "Ocean Reef"
        //thisGameVersion = "Prehistoric Valley"
        //thisGameVersion = "Southwest"
        //thisGameVersion = "Twist"
        //thisGameVersion = "Vintage Gas Station"
        //thisGameVersion = "U Pick 10"
        //thisGameVersionAndModifier = thisGameVersion + " / Even"
        //thisSortDescription = "Sort: Alphabetical"
        // END TEMPORARY TESTING LINES
        
        let gameVersionPhaseModifierSort = thisGameVersionAndModifier + thisSortDescription
        let gameVersionPhaseModifierSortLen = gameVersionPhaseModifierSort.count
        //print("\(self) \(#function) - gameVersionPhaseModifierSort=<\(gameVersionPhaseModifierSort)> size=\(gameVersionPhaseModifierSortLen)")
        
        var fontSizeForGameAndSort:CGFloat = 25
        
        let thisGameVersionAndSortIdx = retrieveRelativeGameVersionNumber(nameIn: thisGameVersion)
        //print("\(self) \(#function) - thisGameVersionAndSortIdx=\(thisGameVersionAndSortIdx)")
        
        if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
            fontSizeForGameAndSort = gameVersionAndSortSmallDeviceFontSizes[thisGameVersionAndSortIdx]
            //print("\(self) \(#function) - Small screen font size is \(fontSizeForGameAndSort)")
        }
        else {
            fontSizeForGameAndSort = gameVersionAndSortLargeDeviceFontSizes[thisGameVersionAndSortIdx]
            //print("\(self) \(#function) - Large screen font size is \(fontSizeForGameAndSort)")
        }
         
        let bothGameAndSort = thisGameVersionAndModifier + " " + thisSortDescription
        
        configureLabel(labelNameIn: gameVersionAndSort,
                       textIn: bothGameAndSort,
                       textColorIn: appColorBrightGreen,
                       backgroundColorIn: appColorMediumGreen,
                       xPositionIn: gVASXposition,
                       yPositionIn: gVASYposition,
                       widthIn: gVASWidth,
                       heightIn: gVASHeight,
                       boldOrRegularIn: weightRegular,
                       fontSizeIn: fontSizeForGameAndSort,
                       justifyIn: justifyCenter)
        view.addSubview(gameVersionAndSort)
        
        // Sort player information based on the current player sort status value
        // The sort key varies by the type of sort being done, but the data remains constant:
        // The key is as follows:
        // Sort code | Key (* below)
        //    00     | player name (20)
        //    01     | player entry order (2)
        //    02     | player dealer order (2)
        //    03     | player completed phases (3) & points (5) - total of 8
        //    04     | player completed phases (3) & 10000 minus points (5) - total of 8
        // key | player index | player button status (5 buttons for a player)
        //  *  |     2        |               5
        
        playerSortData.removeAll()
        
        var pcount = 0
        var bidx = 0
        //print("\(self) \(#function) - before sort button status = \(gdefault.gamesPlayerButtonStatus)")
        while pcount < gdefault.gamesLengthPlayerNameOccurs  {
            if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                break
            }
            let buttonStatus = gdefault.gamesPlayerButtonStatus[bidx] + gdefault.gamesPlayerButtonStatus[bidx+1] + gdefault.gamesPlayerButtonStatus[bidx+2] + gdefault.gamesPlayerButtonStatus[bidx+3] + gdefault.gamesPlayerButtonStatus[bidx+4]
            //print("\(self) \(#function) - button status for pcount \(pcount) is \(buttonStatus)")
            let stringPcount = String(format: "%02d", pcount)
            //print("\(self) \(#function) - gamesPlayerSort=\(gdefault.gamesPlayerSort)")
            switch gdefault.gamesPlayerSort {
            // By player name order
            case playerSortAlpha:
                //print("\(self) \(#function) - 00 adding \(gdefault.gamesPlayerName[pcount])")
                playerSortData.append(gdefault.gamesPlayerName[pcount] + stringPcount + buttonStatus)
            // By player entry order
            case playerSortEntry:
                //print("\(self) \(#function) - 01 adding \(gdefault.gamesPlayerEntryOrder[pcount])")
                playerSortData.append(gdefault.gamesPlayerEntryOrder[pcount] + stringPcount + buttonStatus)
            // By player dealer sequence order
            case playerSortDealer:
                //print("\(self) \(#function) - 02 adding \(gdefault.gamesPlayerDealerOrder[pcount])")
                playerSortData.append(gdefault.gamesPlayerDealerOrder[pcount] + stringPcount + buttonStatus)
                // By player phase & points (low-to-high)
            case playerSortLowToHigh:
                let returnedRawPhasePoints = determinePhaseAndPointsStatus(requestedFormatIn: dataFormatRaw,
                                                  indexIn: pcount)
                let rawPhasePoints = returnedRawPhasePoints.rawDataOrPhaseText
                var sidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 7)
                var range = sidx ..< rawPhasePoints.endIndex
                let theCompletedPhases = String(rawPhasePoints[range])
                sidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 3)
                let eidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 7)
                range = sidx ..< eidx
                let rawPoints = String(rawPhasePoints[range])
                let usePoints = 10000 - Int(rawPoints)!
                let usePhasePoints = theCompletedPhases + String(format: "%05d", usePoints)
                //print("\(self) \(#function) - 03 adding \(usePhasePoints)")
                playerSortData.append(usePhasePoints + stringPcount + buttonStatus)
                // By player phase & points (high-to-low)
            case playerSortHighToLow:
                let returnedRawPhasePoints = determinePhaseAndPointsStatus(requestedFormatIn: dataFormatRaw,
                                                  indexIn: pcount)
                let rawPhasePoints = returnedRawPhasePoints.rawDataOrPhaseText
                var sidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 7)
                var range = sidx ..< rawPhasePoints.endIndex
                let theCompletedPhases = String(rawPhasePoints[range])
                sidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 3)
                let eidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 7)
                range = sidx ..< eidx
                let rawPoints = String(rawPhasePoints[range])
                let usePoints = 10000 - Int(rawPoints)!
                let usePhasePoints = theCompletedPhases + String(format: "%05d", usePoints)
                //print("\(self) \(#function) - 04 adding \(usePhasePoints)")
                playerSortData.append(usePhasePoints + stringPcount + buttonStatus)
            default:
                _ = ""
            }
            pcount += 1
            bidx += 5
        }
        //print("\(self) \(#function) - playerSortData before sort \(playerSortData)")
        // Now sort ascending or descending depending on the requested order
        switch gdefault.gamesPlayerSort {
        // Ascending by player name
        case playerSortAlpha:
            playerSortData.sort()
        // Ascending by player entry order
        case playerSortEntry:
            playerSortData.sort()
        // Ascending by player dealer order
        case playerSortDealer:
            playerSortData.sort()
        // Ascending by player phase & points (low-to-high)
        case playerSortLowToHigh:
            playerSortData.sort()
        // Descending by player phase & points (high-to-low)
        case playerSortHighToLow:
            playerSortData.sort(by: >)
        default:
            _ = ""
        }
         
        // Clear all game status memory usage first
        let subViews = self.gameStatusScrollView.subviews
        for subview in subViews {
            subview.removeFromSuperview()
        }
         
        // Generate the scrollview
        gameStatusScrollView.frame = CGRect(x: 5, y: 100, width: 380, height: 412)
        gameStatusScrollView.translatesAutoresizingMaskIntoConstraints = false
        gameStatusScrollView.isUserInteractionEnabled = true
        gameStatusScrollView.isScrollEnabled = true
        gameStatusScrollView.backgroundColor = appColorMediumGreen
        gameStatusScrollView.contentInsetAdjustmentBehavior = .automatic
        view.addSubview(gameStatusScrollView)
        
        //print("\(self) \(#function) - after sort button status = \(gdefault.gamesPlayerButtonStatus)")
        //print("\(self) \(#function) - playerSortData after sort (code \(gdefault.gamesPlayerSort)) \(playerSortData)")
        let numberOfPlayers = playerSortData.count

        var scount = 0
        
        var yPosition = 0
        var xPosition = 0

        // Player labels (4 each = 60 plus 12 more for phase names & headings)
        let Label1:UILabel = UILabel()
        let Label2:UILabel = UILabel()
        let Label3:UILabel = UILabel()
        let Label4:UILabel = UILabel()
        let Label5:UILabel = UILabel()
        let Label6:UILabel = UILabel()
        let Label7:UILabel = UILabel()
        let Label8:UILabel = UILabel()
        let Label9:UILabel = UILabel()
        let Label10:UILabel = UILabel()
        let Label11:UILabel = UILabel()
        let Label12:UILabel = UILabel()
        let Label13:UILabel = UILabel()
        let Label14:UILabel = UILabel()
        let Label15:UILabel = UILabel()
        let Label16:UILabel = UILabel()
        let Label17:UILabel = UILabel()
        let Label18:UILabel = UILabel()
        let Label19:UILabel = UILabel()
        let Label20:UILabel = UILabel()
        let Label21:UILabel = UILabel()
        let Label22:UILabel = UILabel()
        let Label23:UILabel = UILabel()
        let Label24:UILabel = UILabel()
        let Label25:UILabel = UILabel()
        let Label26:UILabel = UILabel()
        let Label27:UILabel = UILabel()
        let Label28:UILabel = UILabel()
        let Label29:UILabel = UILabel()
        let Label30:UILabel = UILabel()
        let Label31:UILabel = UILabel()
        let Label32:UILabel = UILabel()
        let Label33:UILabel = UILabel()
        let Label34:UILabel = UILabel()
        let Label35:UILabel = UILabel()
        let Label36:UILabel = UILabel()
        let Label37:UILabel = UILabel()
        let Label38:UILabel = UILabel()
        let Label39:UILabel = UILabel()
        let Label40:UILabel = UILabel()
        let Label41:UILabel = UILabel()
        let Label42:UILabel = UILabel()
        let Label43:UILabel = UILabel()
        let Label44:UILabel = UILabel()
        let Label45:UILabel = UILabel()
        let Label46:UILabel = UILabel()
        let Label47:UILabel = UILabel()
        let Label48:UILabel = UILabel()
        let Label49:UILabel = UILabel()
        let Label50:UILabel = UILabel()
        let Label51:UILabel = UILabel()
        let Label52:UILabel = UILabel()
        let Label53:UILabel = UILabel()
        let Label54:UILabel = UILabel()
        let Label55:UILabel = UILabel()
        let Label56:UILabel = UILabel()
        let Label57:UILabel = UILabel()
        let Label58:UILabel = UILabel()
        let Label59:UILabel = UILabel()
        let Label60:UILabel = UILabel()
        let Label61:UILabel = UILabel()
        let Label62:UILabel = UILabel()
        let Label63:UILabel = UILabel()
        let Label64:UILabel = UILabel()
        let Label65:UILabel = UILabel()
        let Label66:UILabel = UILabel()
        let LabelBG:UILabel = UILabel()
        let labelNames = [Label1,  Label2,  Label3,  Label4,  Label5,  Label6,
                          Label7,  Label8,  Label9,  Label10, Label11, Label12,
                          Label13, Label14, Label15, Label16, Label17, Label18,
                          Label19, Label20, Label21, Label22, Label23, Label24,
                          Label25, Label26, Label27, Label28, Label29, Label30,
                          Label31, Label32, Label33, Label34, Label35, Label36,
                          Label37, Label38, Label39, Label40, Label41, Label42,
                          Label43, Label44, Label45, Label46, Label47, Label48,
                          Label49, Label50, Label51, Label52, Label53, Label54,
                          Label55, Label56, Label57, Label58, Label59, Label60,
                          Label61, Label62, Label63, Label64, Label65, Label66]
        let Button1:UIButton = UIButton()
        let Button2:UIButton = UIButton()
        let Button3:UIButton = UIButton()
        let Button4:UIButton = UIButton()
        let Button5:UIButton = UIButton()
        let Button6:UIButton = UIButton()
        let Button7:UIButton = UIButton()
        let Button8:UIButton = UIButton()
        let Button9:UIButton = UIButton()
        let Button10:UIButton = UIButton()
        let Button11:UIButton = UIButton()
        let Button12:UIButton = UIButton()
        let Button13:UIButton = UIButton()
        let Button14:UIButton = UIButton()
        let Button15:UIButton = UIButton()
        let Button16:UIButton = UIButton()
        let Button17:UIButton = UIButton()
        let Button18:UIButton = UIButton()
        let Button19:UIButton = UIButton()
        let Button20:UIButton = UIButton()
        let Button21:UIButton = UIButton()
        let Button22:UIButton = UIButton()
        let Button23:UIButton = UIButton()
        let Button24:UIButton = UIButton()
        let Button25:UIButton = UIButton()
        let Button26:UIButton = UIButton()
        let Button27:UIButton = UIButton()
        let Button28:UIButton = UIButton()
        let Button29:UIButton = UIButton()
        let Button30:UIButton = UIButton()
        let Button31:UIButton = UIButton()
        let Button32:UIButton = UIButton()
        let Button33:UIButton = UIButton()
        let Button34:UIButton = UIButton()
        let Button35:UIButton = UIButton()
        let Button36:UIButton = UIButton()
        let Button37:UIButton = UIButton()
        let Button38:UIButton = UIButton()
        let Button39:UIButton = UIButton()
        let Button40:UIButton = UIButton()
        let Button41:UIButton = UIButton()
        let Button42:UIButton = UIButton()
        let Button43:UIButton = UIButton()
        let Button44:UIButton = UIButton()
        let Button45:UIButton = UIButton()
        let Button46:UIButton = UIButton()
        let Button47:UIButton = UIButton()
        let Button48:UIButton = UIButton()
        let Button49:UIButton = UIButton()
        let Button50:UIButton = UIButton()
        let Button51:UIButton = UIButton()
        let Button52:UIButton = UIButton()
        let Button53:UIButton = UIButton()
        let Button54:UIButton = UIButton()
        let Button55:UIButton = UIButton()
        let Button56:UIButton = UIButton()
        let Button57:UIButton = UIButton()
        let Button58:UIButton = UIButton()
        let Button59:UIButton = UIButton()
        let Button60:UIButton = UIButton()
        let Button61:UIButton = UIButton()
        let Button62:UIButton = UIButton()
        let Button63:UIButton = UIButton()
        let Button64:UIButton = UIButton()
        let Button65:UIButton = UIButton()
        let Button66:UIButton = UIButton()
        let Button67:UIButton = UIButton()
        let Button68:UIButton = UIButton()
        let Button69:UIButton = UIButton()
        let Button70:UIButton = UIButton()
        let Button71:UIButton = UIButton()
        let Button72:UIButton = UIButton()
        let Button73:UIButton = UIButton()
        let Button74:UIButton = UIButton()
        let Button75:UIButton = UIButton()
        
        let buttonNames = [Button1, Button2,   Button3,  Button4,  Button5,  Button6,
                           Button7,  Button8,  Button9,  Button10, Button11, Button12,
                           Button13, Button14, Button15, Button16, Button17, Button18,
                           Button19, Button20, Button21, Button22, Button23, Button24,
                           Button25, Button26, Button27, Button28, Button29, Button30,
                           Button31, Button32, Button33, Button34, Button35, Button36,
                           Button37, Button38, Button39, Button40, Button41, Button42,
                           Button43, Button44, Button45, Button46, Button47, Button48,
                           Button49, Button50, Button51, Button52, Button53, Button54,
                           Button55, Button56, Button57, Button58, Button59, Button60,
                           Button61, Button62, Button63, Button64, Button65, Button66,
                           Button67, Button68, Button69, Button70, Button71, Button72,
                           Button73, Button74, Button75]
        
        //print("\(self) \(#function) - show the players ======================================")
        
        // Since the players may or may not be displayed in the same order as the last
        // time this function was executed, the player array and the button status array
        // may no longer be synchronized. So, set all the button status array entries
        // to "e", and then rebuild the button statuses for the players in use by
        // using the original button statuses stored in the sorted player data array.
        
        bidx = 0
        while bidx < gdefault.gamesLengthPlayerButtonStatusOccurs {
            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeEnabled
            bidx += 1
        }
        
        // Start player display with yellow for all 4 areas (player name, skip status, phase status, and points).
        // When phases are cleared, use light blue for the phase status area.
        var currentColor = appColorYellow

        while scount < numberOfPlayers {
            //print("\(self) \(#function) - sorted key index = \(scount)")
            switch gdefault.gamesPlayerSort {
            case playerSortAlpha:
                //print("\(self) \(#function) - case \(playerSortAlpha)")
                let rawSortData = playerSortData[scount]
                let sidx = rawSortData.index(rawSortData.startIndex, offsetBy: 20)
                let eidx = rawSortData.index(rawSortData.startIndex, offsetBy: 22)
                let range = sidx ..< eidx
                pcount = Int(String(rawSortData[range]))!
                //print("\(self) \(#function) - player index = \(pcount)")
                //print("\(self) \(#function) - key data \(rawSortData) / player data \(gdefault.gamesPlayerName[pcount])")
                var idx = rawSortData.index(rawSortData.startIndex, offsetBy: 22)
                gdefault.gamesPlayerButtonStatus[pcount*5] = String(rawSortData[idx])
                idx = rawSortData.index(rawSortData.startIndex, offsetBy: 23)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+1] = String(rawSortData[idx])
                idx = rawSortData.index(rawSortData.startIndex, offsetBy: 24)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+2] = String(rawSortData[idx])
                idx = rawSortData.index(rawSortData.startIndex, offsetBy: 25)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+3] = String(rawSortData[idx])
                idx = rawSortData.index(rawSortData.startIndex, offsetBy: 26)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+4] = String(rawSortData[idx])
            case playerSortEntry:
                //print("\(self) \(#function) - case \(playerSortEntry)")
                let rawSortData = playerSortData[scount]
                let sidx = rawSortData.index(rawSortData.startIndex, offsetBy: 2)
                let eidx = rawSortData.index(rawSortData.startIndex, offsetBy: 4)
                let range = sidx ..< eidx
                pcount = Int(String(rawSortData[range]))!
                //print("\(self) \(#function) - player index = \(pcount)")
                //print("\(self) \(#function) - key data \(rawSortData) / player data \(gdefault.gamesPlayerName[pcount])")
                var idx = rawSortData.index(rawSortData.startIndex, offsetBy: 4)
                gdefault.gamesPlayerButtonStatus[pcount*5] = String(rawSortData[idx])
                idx = rawSortData.index(rawSortData.startIndex, offsetBy: 5)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+1] = String(rawSortData[idx])
                idx = rawSortData.index(rawSortData.startIndex, offsetBy: 6)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+2] = String(rawSortData[idx])
                idx = rawSortData.index(rawSortData.startIndex, offsetBy: 7)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+3] = String(rawSortData[idx])
                idx = rawSortData.index(rawSortData.startIndex, offsetBy: 8)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+4] = String(rawSortData[idx])
            case playerSortDealer:
                //print("\(self) \(#function) - case \(playerSortDealer)")
                let rawSortData = playerSortData[scount]
                let sidx = rawSortData.index(rawSortData.startIndex, offsetBy: 2)
                let eidx = rawSortData.index(rawSortData.startIndex, offsetBy: 4)
                let range = sidx ..< eidx
                pcount = Int(String(rawSortData[range]))!
                //print("\(self) \(#function) - player index = \(pcount)")
                //print("\(self) \(#function) - key data \(rawSortData) / player data \(gdefault.gamesPlayerName[pcount])")
                var idx = rawSortData.index(rawSortData.startIndex, offsetBy: 4)
                gdefault.gamesPlayerButtonStatus[pcount*5] = String(rawSortData[idx])
                idx = rawSortData.index(rawSortData.startIndex, offsetBy: 5)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+1] = String(rawSortData[idx])
                idx = rawSortData.index(rawSortData.startIndex, offsetBy: 6)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+2] = String(rawSortData[idx])
                idx = rawSortData.index(rawSortData.startIndex, offsetBy: 7)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+3] = String(rawSortData[idx])
                idx = rawSortData.index(rawSortData.startIndex, offsetBy: 8)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+4] = String(rawSortData[idx])
            case playerSortLowToHigh:
                //print("\(self) \(#function) - case \(playerSortLowToHigh)")
                // Reconstruct the original phase and points contained in the
                // sorted data. Also reconstruct the phase and points
                // associated with each player entry.
                let rawPhasePoints = playerSortData[scount]
                let sidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 8)
                let eidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 10)
                let range = sidx ..< eidx
                pcount = Int(String(rawPhasePoints[range]))!
                //print("\(self) \(#function) - player index = \(pcount)")
                //print("\(self) \(#function) - key data \(rawPhasePoints) / player data \(gdefault.gamesPlayerName[pcount])")
                var idx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 10)
                gdefault.gamesPlayerButtonStatus[pcount*5] = String(rawPhasePoints[idx])
                idx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 11)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+1] = String(rawPhasePoints[idx])
                idx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 12)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+2] = String(rawPhasePoints[idx])
                idx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 13)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+3] = String(rawPhasePoints[idx])
                idx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 14)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+4] = String(rawPhasePoints[idx])
            case playerSortHighToLow:
                //print("\(self) \(#function) - case \(playerSortHighToLow)")
                // Reconstruct the original phase and points contained in the
                // sorted data. Also reconstruct the phase and points
                // associated with each player entry.
                let rawPhasePoints = playerSortData[scount]
                let sidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 8)
                let eidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 10)
                let range = sidx ..< eidx
                pcount = Int(String(rawPhasePoints[range]))!
                //print("\(self) \(#function) - player index = \(pcount)")
                //print("\(self) \(#function) - key data \(rawPhasePoints) / player data \(gdefault.gamesPlayerName[pcount])")
                var idx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 10)
                gdefault.gamesPlayerButtonStatus[pcount*5] = String(rawPhasePoints[idx])
                idx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 11)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+1] = String(rawPhasePoints[idx])
                idx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 12)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+2] = String(rawPhasePoints[idx])
                idx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 13)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+3] = String(rawPhasePoints[idx])
                idx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 14)
                gdefault.gamesPlayerButtonStatus[(pcount*5)+4] = String(rawPhasePoints[idx])
            default:
                _ = ""
            } // End switch on player sort code
            
            // Dynamically add this player to the textview, including:
            // - player name (possibly flag the dealer or flag the winner, or show as skipped),
            //   phase completed, and points
            // - clear phase, add points, skip player, edit player, & view history buttons

            if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
                xPosition = 7
            }
            else {
                xPosition = 0
            }
            
            // When the screen is first displayed before there are any players,
            // a message is shown. As soon as a player is added,
            // it is shown in the same place where the message was previously shown.
            // To stop the messages appearing in the background behind the
            // player (and for that matter each subsequent player), the label below
            // (LabelBG) is created green on green to clear the background.
            configureLabel(labelNameIn: LabelBG,
                           textIn: " ",
                           textColorIn: appColorMediumGreen,
                           backgroundColorIn: appColorMediumGreen,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: 400,
                           heightIn: 105,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyLeft)
            gameStatusScrollView.addSubview(LabelBG)
            
            // This is the player name and winner/dealer indicator (as appropriate)
            
            // Note that each scount (player) requires 4 indexes (idx), one index per label
            
            var idx = scount * 4
            let thisPlayerName = gdefault.gamesPlayerName[pcount]
            var finalPlayerName = thisPlayerName
            //print("\(self) \(#function) - adding player to textview: scount=\(scount) pcount=\(pcount) idx=\(idx) player=\(finalPlayerName) entry=\(gdefault.gamesPlayerEntryOrder[pcount]) dealer=\(gdefault.gamesPlayerDealerOrder[pcount]) game dealer=\(gdefault.gamesCurrentDealer)")
            if gdefault.gamesTrackDealer == trackingDealerConstant {
                if gdefault.gamesPlayerEntryOrder[pcount] == gdefault.gamesCurrentDealer {
                    //print("\(self) \(#function) - setting (dealer) indicator at because current dealer = entry order = \(gdefault.gamesCurrentDealer)")
                    finalPlayerName = thisPlayerName + " (Dealer)"
                }
            }
            if gdefault.gamesGameStatus == gameCompleteStatusCode {
                if gdefault.gamesPlayerWinner[pcount] == "y" {
                    finalPlayerName = thisPlayerName + " WINNER! "
                }
            }
            //print("\(self) \(#function) - adding player label idx=\(idx), sc=\(scount) xp=\(xPosition) yp=\(yPosition)")
            //print("\(self) \(#function) - adding labels & buttons for player index \(pcount) - \(thisPlayerName)")
            
            if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
                playerLabelWidth = 266
            }
            else {
                playerLabelWidth = 275
            }
            
            // For the player name area, always use a background of yellow
            configureLabel(labelNameIn: labelNames[idx],
                           textIn: finalPlayerName,
                           textColorIn: appColorBlack,
                           backgroundColorIn: appColorYellow,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: playerLabelWidth,
                           heightIn: 20,
                           boldOrRegularIn: weightBold,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyLeft)
            gameStatusScrollView.addSubview(labelNames[idx])
            
            // Then the skip status to the immediate right of the player information
             
            idx = scount * 4 + 3
            xPosition += playerLabelWidth
            var skipAreaSize = 0
            if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
                skipAreaSize = 105
            }
            else {
                skipAreaSize = 125
            }
            var skipText = ""
            currentColor = appColorYellow
            if gdefault.gamesPlayerSkipped[pcount] == playerIsSkipped {
                skipText = "Skipped"
                currentColor = appColorYellow
            }
            
            //print("\(self) \(#function) - adding skipped label idx=\(idx), sc=\(scount) xp=\(xPosition) yp=\(yPosition) skipText=\(skipText)")
            configureLabel(labelNameIn: labelNames[idx],
                           textIn: skipText,
                           textColorIn: appColorBlack,
                           backgroundColorIn: currentColor,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: skipAreaSize,
                           heightIn: 20,
                           boldOrRegularIn: weightBold,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyLeft)
            gameStatusScrollView.addSubview(labelNames[idx])
            
            // This is a player's phase completion status and points
            
            // First the phase completion status
            
            idx = scount * 4 + 1
            
            if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
                xPosition = 7
            }
            else {
                xPosition = 0
            }
            
            yPosition += 20

            let returnedRawPhasePoints = determinePhaseAndPointsStatus(requestedFormatIn: dataFormatLabel,
                                              indexIn: pcount)
            let phaseText = returnedRawPhasePoints.rawDataOrPhaseText
            let pointsText = returnedRawPhasePoints.pointsText
            
            // Adjust location and width of points area based on iPhone or iPad model
            var pointsAreaSize = 0
            if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
                pointsAreaSize = 266
            }
            else {
                pointsAreaSize = 275
            }
            
            // If the player has cleared phase, use a background of light blue. If not, use yellow.
            var bidx = pcount * 5
            //print("\(self) \(#function) - setting phase background, bidx=\(bidx)")
            if gdefault.gamesPlayerButtonStatus[bidx] == buttonCodeDisabled {
                currentColor = appColorLightBlue
                //print("\(self) \(#function) - it is disabled, so blue")
            }
            else {
                currentColor = appColorYellow
                //print("\(self) \(#function) - it is enabled, so yellow")
            }
            //print("\(self) \(#function) - adding phase label idx=\(idx), sc=\(scount) xp=\(xPosition) yp=\(yPosition) phaseText=\(phaseText) gamesPlayerButtonStatus[\(bidx)]=\(gdefault.gamesPlayerButtonStatus[bidx])")
            //print("\(self) \(#function) - adding phase label for \(finalPlayerName) pcount=\(pcount) sor=\(gdefault.gamesPlayerStartRoundPhases[pcount]) idx=\(idx), scount=\(scount) phaseText=\(phaseText) ")
            
            configureLabel(labelNameIn: labelNames[idx],
                           textIn: phaseText,
                           textColorIn: appColorBlack,
                           backgroundColorIn: currentColor,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: pointsAreaSize,
                           heightIn: 25,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyLeft)
            gameStatusScrollView.addSubview(labelNames[idx])
            
            // Then the points to the immediate right of the phase information
            
            idx = scount * 4 + 2
            xPosition += pointsAreaSize
            
            if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
                pointsAreaSize = 105
            }
            else {
                pointsAreaSize = 125
            }
            
            // If points have been added to the player, use a background of light blue. If not, use yellow.
            
            bidx = (pcount * 5) + 1
            //print("\(self) \(#function) - setting points background, bidx=\(bidx)")
            if gdefault.gamesPlayerButtonStatus[bidx] == buttonCodeDisabled {
                currentColor = appColorLightBlue
                //print("\(self) \(#function) - it is disabled, so blue")//
            }
            else {
                currentColor = appColorYellow
                //print("\(self) \(#function) - it is enabled, so yellow")
            }
            
            let phaseTextSize = phaseText.count
            let pointsTextSize = pointsText.count
            var labelFontSizeToUse: CGFloat = labelFontSize20
            if phaseTextSize > 28 || pointsTextSize > 10 {
                labelFontSizeToUse = labelFontSize18
            }
            //print("\(self) \(#function) - labelFontSizeToUse=\(labelFontSizeToUse)")
            //print("\(self) \(#function) - adding points label idx=\(idx), sc=\(scount) xp=\(xPosition) yp=\(yPosition)")
            //print("\(self) \(#function) -                     pointsText=\(pointsText) pointsAreaSize=\(pointsAreaSize)")
            //print("\(self) \(#function) - phase text size=\(phaseTextSize), points text size=\(pointsTextSize)")
            
            configureLabel(labelNameIn: labelNames[idx],
                           textIn: pointsText,
                           textColorIn: appColorBlack,
                           backgroundColorIn: currentColor,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: pointsAreaSize,
                           heightIn: 25,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSizeToUse,
                           justifyIn: justifyLeft)
            gameStatusScrollView.addSubview(labelNames[idx])
            
            // Next are the 5 buttons common for every player
            // Note that each scount (player) requires 5 indexes (idx), one index per button
            
            idx = scount * 5
            
            if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
                xPosition = 7
            }
            else {
                xPosition = 3
            }
            yPosition += 26
            
            // First is the clear phase button

            // Set the button colors based on any current errors (or lack of errors)
            switch gdefault.clearPhaseButtonColorStatus {
            case "all green":
                gdefault.clearPhaseTextColor = appColorBlack
                gdefault.clearPhaseBackgroundColor = appColorBrightGreen
            case "all red":
                gdefault.clearPhaseTextColor = appColorWhite
                gdefault.clearPhaseBackgroundColor = appColorRed
            case "one red":
                //print("\(self) \(#function) - pcount=\(pcount) specific index=\(gdefault.clearPhaseButtonSpecificIndex) entry order=\(gdefault.gamesPlayerEntryOrder[pcount]) for player \(gdefault.gamesPlayerName[pcount])")
                if gdefault.clearPhaseButtonSpecificIndex == Int(gdefault.gamesPlayerEntryOrder[pcount]) {
                    gdefault.clearPhaseTextColor = appColorWhite
                    gdefault.clearPhaseBackgroundColor = appColorRed
                }
                else {
                    gdefault.clearPhaseTextColor = appColorBlack
                    gdefault.clearPhaseBackgroundColor = appColorBrightGreen
                }
            default:
                _ = ""
            }

            configureButton(buttonNameIn: buttonNames[idx],
                            xPositionIn: xPosition,
                            yPositionIn: yPosition,
                            textIn: clearPhaseText,
                            textColorIn: gdefault.clearPhaseTextColor,
                            backgroundColorIn: gdefault.clearPhaseBackgroundColor,
                            selectorIdx: clearPhaseClickedIdx)

            //print("\(self) \(#function) - setting playerIndexByButton[\(idx)] to \(pcount) for CP")
            gdefault.playerIdxByButton[idx] = pcount
            //print("\(self) \(#function) - set buttonNames[\(idx)].tag (clear phase) to \(idx) sc=\(scount) for \(gdefault.gamesPlayerName[pcount]), pcount=\(pcount)")
            buttonNames[idx].tag = idx
            gameStatusScrollView.addSubview(buttonNames[idx])
            
            // Next is the add points button to the immediate right of the clear phase button
            
            idx = scount * 5 + 1
            if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
                xPosition += horizontalSmall
            }
            else {
                xPosition += horizontalLarge
            }

            if endRoundOnly1Zero == "y" {
                //print("\(self) \(#function) - we have an end round only 1 zero condition at pidx=\(pidx) pcount=\(pcount)")
                //print("\(self) \(#function) - - player \(gdefault.gamesPlayerName[pcount]) point status=\(gdefault.gamesPlayerPointsStatus[pcount]) status entry=\(gdefault.gamesPlayerPointsStatusEntry[pcount]) entry order=\(gdefault.gamesPlayerEntryOrder[pcount])")
                if gdefault.gamesPlayerPointsStatus[pcount] == pointsStatusRed &&
                    gdefault.gamesPlayerPointsStatusEntry[pcount] == gdefault.gamesPlayerEntryOrder[pcount] {
                        gdefault.addPointsTextColor = appColorWhite
                        gdefault.addPointsBackgroundColor = appColorRed
                        //print("\(self) \(#function) - setting add points button to white on red")
                }
                else {
                        gdefault.addPointsTextColor = appColorBlack
                        gdefault.addPointsBackgroundColor = appColorBrightGreen
                        //print("\(self) \(#function) - setting add points button to black on green")
                }
                let zeroCount = checkOnly1Zero()
                //print("\(self) \(#function) - zeroCount = \(zeroCount)")
                
                if zeroCount > 1 {
                    // Generate the upper and lower error messages
                    weHaveAnError = "y"
                    configureLabel(labelNameIn: errorMessageTop,
                                   textIn: only1ZeroMsg1,
                                   textColorIn: appColorRed,
                                   backgroundColorIn: appColorYellow,
                                   xPositionIn: eMTXposition,
                                   yPositionIn: eMTYposition,
                                   widthIn: eMTWidth,
                                   heightIn: eMTHeight,
                                   boldOrRegularIn: weightRegular,
                                   fontSizeIn: labelFontSize20,
                                   justifyIn: justifyCenter)
                    view.addSubview(errorMessageTop)
                    // Generate the lower error message
                    configureLabel(labelNameIn: errorMessage,
                                   textIn: only1ZeroMsg2,
                                   textColorIn: appColorRed,
                                   backgroundColorIn: appColorYellow,
                                   xPositionIn: eMXposition,
                                   yPositionIn: eMYposition,
                                   widthIn: eMWidth,
                                   heightIn: eMHeight,
                                   boldOrRegularIn: weightRegular,
                                   fontSizeIn: labelFontSize20,
                                   justifyIn: justifyCenter)
                    view.addSubview(errorMessage)
                    allowExitFromView = false
                }
                else {
                    //print("\(self) \(#function) - resetting add points button to black on green")
                    gdefault.addPointsTextColor = appColorBlack
                    gdefault.addPointsBackgroundColor = appColorBrightGreen
                    endRoundOnly1Zero = "n"
                }
            }
            else {
                //print("\(self) \(#function) - we do not have an end round only 1 zero condition - ensuring black on green")
                gdefault.addPointsTextColor = appColorBlack
                gdefault.addPointsBackgroundColor = appColorBrightGreen
            }
            configureButton(buttonNameIn: buttonNames[idx],
                            xPositionIn: xPosition,
                            yPositionIn: yPosition,
                            textIn: addPointsText,
                            textColorIn: gdefault.addPointsTextColor,
                            backgroundColorIn: gdefault.addPointsBackgroundColor,
                            selectorIdx: addPointsClickedIdx)
            //print("\(self) \(#function) - set buttonNames[\(idx)].tag (add points) to \(idx) sc=\(scount) expecting \(gdefault.gamesPlayerName[scount])")
            buttonNames[idx].tag = idx
            gdefault.playerIdxByButton[idx] = pcount
            gameStatusScrollView.addSubview(buttonNames[idx])
            // Next is the skip player button to the immediate right of the add points button
            idx = scount * 5 + 2
            if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
                xPosition += horizontalSmall
            }
            else {
                xPosition += horizontalLarge
            }
            var tempSkipText = ""
            if gdefault.gamesPlayerSkipped[pcount] == playerIsSkipped {
                tempSkipText = unskipPlayerText
            }
            else {
                tempSkipText = skipPlayerText
            }
            //print("\(self) \(#function) - adding skip player button idx=\(idx), sc=\(scount) xp=\(xPosition) yp=\(yPosition)")
            configureButton(buttonNameIn: buttonNames[idx],
                            xPositionIn: xPosition,
                            yPositionIn: yPosition,
                            textIn: tempSkipText,
                            textColorIn: appColorBlack,
                            backgroundColorIn: appColorBrightGreen,
                            selectorIdx: skipPlayerClickedIdx)
            //print("\(self) \(#function) - setting buttonNames[\(idx)].tag (skip player) to \(idx)")
            buttonNames[idx].tag = idx
            //print("\(self) \(#function) - setting playerIndexByButton[\(idx)] to \(pcount) for EP")
            gdefault.playerIdxByButton[idx] = pcount
            gameStatusScrollView.addSubview(buttonNames[idx])
            // Next is the edit player button to the immediate right of the skip player button
            idx = scount * 5 + 3
            if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
                xPosition += horizontalSmall
            }
            else {
                xPosition += horizontalLarge
            }
            //print("\(self) \(#function) - adding edit player button idx=\(idx), sc=\(scount) xp=\(xPosition) yp=\(yPosition)")
            configureButton(buttonNameIn: buttonNames[idx],
                            xPositionIn: xPosition,
                            yPositionIn: yPosition,
                            textIn: editPlayerText,
                            textColorIn: appColorBlack,
                            backgroundColorIn: appColorBrightGreen,
                            selectorIdx: editPlayerClickedIdx)
            //print("\(self) \(#function) - setting buttonNames[\(idx)].tag (edit player) to \(idx)")
            buttonNames[idx].tag = idx
            //print("\(self) \(#function) - setting playerIndexByButton[\(idx)] to \(pcount) for EP")
            gdefault.playerIdxByButton[idx] = pcount
            gameStatusScrollView.addSubview(buttonNames[idx])
            // And finally is the view history button to the immediate right of the edit player button
            idx = scount * 5 + 4
            if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
                xPosition += horizontalSmall
            }
            else {
                xPosition += horizontalLarge
            }
            //print("\(self) \(#function) - adding view history button idx=\(idx), sc=\(scount) xp=\(xPosition) yp=\(yPosition)")
            configureButton(buttonNameIn: buttonNames[idx],
                            xPositionIn: xPosition,
                            yPositionIn: yPosition,
                            textIn: viewHistoryText,
                            textColorIn: appColorBlack,
                            backgroundColorIn: appColorBrightGreen,
                            selectorIdx: viewHistoryClickedIdx)
            //print("\(self) \(#function) - setting buttonNames[\(idx)].tag (view history) to \(idx)")
            buttonNames[idx].tag = idx
            //print("\(self) \(#function) - setting playerIndexByButton[\(idx)] to \(pcount) for EH")
            gdefault.playerIdxByButton[idx] = pcount
            gameStatusScrollView.addSubview(buttonNames[idx])
            yPosition += 58
            scount += 1
        }
        
        // Make the player area scrollable
        gameStatusScrollView.contentSize = .init(width: 0, height: yPosition)

        // Generate sort button
        configureButtonMain(buttonNameIn: aSortButton,
                        xPositionIn: aSBXposition,
                        yPositionIn: aSBYposition,
                        fontIn: aSBFontArial,
                        fontSizeIn: aSBFontSize,
                        textIn: sortText,
                        textColorIn: appColorYellow,
                        backgroundColorIn: appColorDarkGreen,
                        cornerRadiusIn: cornerRadiusStdButton,
                        selectorIdx: sortClickedIdx)
        view.addSubview(aSortButton)
        
        // Generate add player button
        configureButtonMain(buttonNameIn: aAddPlayerButton,
                        xPositionIn: aAPBXposition,
                        yPositionIn: aAPBYposition,
                        fontIn: aAPBFontArial,
                        fontSizeIn: aAPBFontSize,
                        textIn: addPlayerText,
                        textColorIn: appColorYellow,
                        backgroundColorIn: appColorDarkGreen,
                        cornerRadiusIn: cornerRadiusStdButton,
                        selectorIdx: addPlayerClickedIdx)
        view.addSubview(aAddPlayerButton)
        
        // Generate end round button
        // Show the current round number (within the end round button text and within the current round heading)
        configureButtonMain(buttonNameIn: aEndRoundButton,
                        xPositionIn: aERBXposition,
                        yPositionIn: aERBYposition,
                        fontIn: aERBFontArial,
                        fontSizeIn: aERBFontSize,
                        textIn: endRoundText + String(format: "% 2d", showRoundNumber!),
                        textColorIn: appColorYellow,
                        backgroundColorIn: appColorDarkGreen,
                        cornerRadiusIn: cornerRadiusStdButton,
                        selectorIdx: endRoundClickedIdx)
        view.addSubview(aEndRoundButton)
        
        // Generate show phases button
        configureButtonMain(buttonNameIn: aShowPhasesButton,
                        xPositionIn: aSPBXposition,
                        yPositionIn: aSPBYposition,
                        fontIn: aSPBFontArial,
                        fontSizeIn: aSPBFontSize,
                        textIn: showPhasesText,
                        textColorIn: appColorYellow,
                        backgroundColorIn: appColorDarkGreen,
                        cornerRadiusIn: cornerRadiusStdButton,
                        selectorIdx: showPhasesClickedIdx)
        view.addSubview(aShowPhasesButton)
        
        // Generate edit game button
        configureButtonMain(buttonNameIn: aEditGameButton,
                        xPositionIn: aEGBXposition,
                        yPositionIn: aEGBYposition,
                        fontIn: aEGBFontArial,
                        fontSizeIn: aEGBFontSize,
                        textIn: editGameText,
                        textColorIn: appColorYellow,
                        backgroundColorIn: appColorDarkGreen,
                        cornerRadiusIn: cornerRadiusStdButton,
                        selectorIdx: editGameClickedIdx)
        view.addSubview(aEditGameButton)
        
        // Generate start over button
        configureButtonMain(buttonNameIn: aStartOverButton,
                        xPositionIn: aSOBXposition,
                        yPositionIn: aSOBYposition,
                        fontIn: aSOBFontArial,
                        fontSizeIn: aSOBFontSize,
                        textIn: startOverText,
                        textColorIn: appColorYellow,
                        backgroundColorIn: appColorDarkGreen,
                        cornerRadiusIn: cornerRadiusStdButton,
                        selectorIdx: startOverClickedIdx)
        view.addSubview(aStartOverButton)

        // Generate view tutorial button
        configureButtonMain(buttonNameIn: aViewTutorialButton,
                        xPositionIn: aVTBXposition,
                        yPositionIn: aVTBYposition,
                        fontIn: aVTBFontCourier,
                        fontSizeIn: aVTBFontSize,
                        textIn: viewTutorialText,
                        textColorIn: appColorYellow,
                        backgroundColorIn: appColorBlue,
                        cornerRadiusIn: cornerRadiusGameHelpButton,
                        selectorIdx: viewTutorialClickedIdx)
        view.addSubview(aViewTutorialButton)
        
        // This is the message about using Edit Game before any
        // players are added. Once a player is added, the message
        // is no longer displayed.
        
        if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
            xPosition = 7
        }
        else {
            xPosition = 0
        }
        // This is the optional message
        if gdefault.gamesGameStatus == notStarted {
            configureLabel(labelNameIn: Label61,
                           textIn: "Press the Edit Game button now if you",
                           textColorIn: appColorWhite,
                           backgroundColorIn: appColorMediumGreen,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: 400,
                           heightIn: 25,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyLeft)
            gameStatusScrollView.addSubview(Label61)
            yPosition += 25
            configureLabel(labelNameIn: Label62,
                           textIn: "want to change the game name or the",
                           textColorIn: appColorWhite,
                           backgroundColorIn: appColorMediumGreen,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: 400,
                           heightIn: 25,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyLeft)
            gameStatusScrollView.addSubview(Label62)
            yPosition += 25
            configureLabel(labelNameIn: Label63,
                           textIn: "game version, or to setup playing all,",
                           textColorIn: appColorWhite,
                           backgroundColorIn: appColorMediumGreen,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: 400,
                           heightIn: 25,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyLeft)
            gameStatusScrollView.addSubview(Label63)
            yPosition += 25
            configureLabel(labelNameIn: Label64,
                           textIn: "even, or odd phases. Once a player",
                           textColorIn: appColorWhite,
                           backgroundColorIn: appColorMediumGreen,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: 400,
                           heightIn: 25,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyLeft)
            gameStatusScrollView.addSubview(Label64)
            yPosition += 25
            
            configureLabel(labelNameIn: Label65,
                           textIn: "is added, only dealer tracking and the",
                           textColorIn: appColorWhite,
                           backgroundColorIn: appColorMediumGreen,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: 400,
                           heightIn: 25,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyLeft)
            gameStatusScrollView.addSubview(Label65)
            yPosition += 25
            configureLabel(labelNameIn: Label66,
                           textIn: "game name may be changed.",
                           textColorIn: appColorWhite,
                           backgroundColorIn: appColorMediumGreen,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: 400,
                           heightIn: 25,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyLeft)
            gameStatusScrollView.addSubview(Label66)
            yPosition += 25
        }
        if yPosition > twoThirdsScreen {
            resetGamePosition = Int(Double(yPosition)) - twoThirdsScreen
        }
        else {
            resetGamePosition = 0
        }
        
        //+++++++++++++++++++++++++++++
        // Update the Games file for this game's player

        //print("\(self) \(#function) - updating game file due to points status change")
        // Get the offset of this game in the Games file
        let fileHandleTG4GamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
        let fileContent:String=String(data:fileHandleTG4GamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleTG4GamesGet.closeFile()
        let gameFileSize = fileContent.count
        //print("\(self) \(#function) - reading entire games file, size=\(gameFileSize)")
        
        var gameRecordOffset = 0
        while gameRecordOffset < gameFileSize {
            //print("\(self) \(#function) - scanning: offset is \(gameRecordOffset)")
            let tempGameRec = extractRecordField(recordIn: fileContent,  fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
            let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
            //print("\(self) \(#function) - comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
            if thisGameName == gdefault.gamesGameName {
                //print("\(self) \(#function) - found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                break
            }
            gameRecordOffset += gdefault.gamesRecordSize
        }
        
        // Update the record and recreate the file
        //print("\(self) \(#function) - now calling updateGamesFile from TheGame with offset \(gameRecordOffset)")
        updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
        
        // Store this view name in case the user proceeds to the sort
        // selection screen. That screen's main text changes slightly
        // depending on the originating view.
        gdefault.playerSortDecisionDriverView = "TheGame"
        
        continueToHelp = false
        allowExitFromView = false
        //print("\(self) \(#function) - end")
        //print("\(self) \(#function) - button statuses=\(gdefault.gamesPlayerButtonStatus)")
    } // End aRefreshView
    
    // End-of-round processing is done here as follows:
    // - Increment round number by 1
    // - Set round status to s
    // - If the dealer is being tracked, flag the next player in dealer sequence
    // - Enable all action buttons
    // - Reset all start-of-round phases as follows:
    //   - If the player is choosing phases, set to 000
    //   - If the player is not choosing phases, set to their current phase value (index = raw phase - 1)
    // - Reset each player's start-of-round points to their current point total
    // - Reset all the player point status array entries to s
    // - Reset all player skipped indicators to not skipped
    // - Set phase button colors to standard (black on green)
    // - Update the Games file
    // - Write an end-of-round entry in the History file
    func doEndOfRoundUpdates() {
        
        //print("\(self) \(#function) - starting end-of-round updates")
        // Game round number
        let previousRoundNumber = gdefault.gamesRoundNumber
        let roundNumber = Int(gdefault.gamesRoundNumber)! + 1
        gdefault.gamesRoundNumber = String(format: "%02d", roundNumber)
        
        // Game round status
        gdefault.gamesRoundStatus = itIsStarting
        
        // Dealer indicator
        advanceToNextDealer()
        
        // Action buttons
        var pcount = 0
        while pcount < gdefault.gamesLengthPlayerButtonStatusOccurs {
            gdefault.gamesPlayerButtonStatus[pcount] = buttonCodeEnabled
            pcount += 1
        }
        
        // Start-of-round phases
        setNextStartRoundPhases()
        
        // Start-of-round points
        setNextStartRoundPoints()
        
        // Player point status
        pcount = 0
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            gdefault.gamesPlayerPointsStatus[pcount] = pointsStatusStandard
            pcount += 1
        }
        
        // Player point status entry
        pcount = 0
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            gdefault.gamesPlayerPointsStatusEntry[pcount] = "00"
            pcount += 1
        }
        
        // Player skipped indicator
        //print("\(self) \(#function) - reset skipped indicators to not skipped")
        pcount = 0
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            gdefault.gamesPlayerSkipped[pcount] = playerIsNotSkipped
            pcount += 1
        }
        
        // Standard button colors
        gdefault.clearPhaseButtonColorStatus = "all green"
        
        // Update the Games file
        //print("\(self) \(#function) - updating game file due to end-of-round")
        // Get the offset of this game in the Games file
        let fileHandleTG2GamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
        let fileContent:String=String(data:fileHandleTG2GamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleTG2GamesGet.closeFile()
        let gameFileSize = fileContent.count
        
        var gameRecordOffset = 0
        while gameRecordOffset < gameFileSize {
            //print("\(self) \(#function) - scanning: offset is \(gameRecordOffset)")
            let tempGameRec = extractRecordField(recordIn: fileContent, fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
            let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
            //print("\(self) \(#function) - comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
            if thisGameName == gdefault.gamesGameName {
                //print("\(self) \(#function) - found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                break
            }
            gameRecordOffset += gdefault.gamesRecordSize
        }
        
        // Update the record and recreate the file
        //print("\(self) \(#function) - now calling updateGamesFile from TheGame with offset \(gameRecordOffset)")
        updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
        
        // Build an end-of-round log entry for every player
        pcount = 0
        var logHistoryData = ""
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                break
            }
            let thePlayerHistoryCode = createHistoryPlayerCode(playerIn: gdefault.gamesPlayerEntryOrder[pcount])
            logHistoryData = logHistoryData + thePlayerHistoryCode + historyEndRoundCode + previousRoundNumber + "  "
            pcount += 1
        }
        //print("\(self) \(#function) - updating history file due to signal end-of-round for all players")
        // Get the offset of this game in the History file
        let fileHandleTG1HistoryGet:FileHandle=FileHandle(forReadingAtPath: historyFileURL.path)!
        let fileContent1:String=String(data:fileHandleTG1HistoryGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleTG1HistoryGet.closeFile()
        let historyFileSize = fileContent1.count
        
        // Find the current game in the History file
        var historyRecordOffset = 0
        //print("\(self) \(#function) - start game scan in history, file size=\(historyFileSize)")
        while historyRecordOffset < historyFileSize {
            //print("\(self) \(#function) - scanning: current offset is \(historyRecordOffset)")
            let tempHistoryRec = extractRecordField(recordIn: fileContent1, fieldOffset: historyRecordOffset, fieldLength: gdefault.historyRecordSize)
            let thisGameName = extractRecordField(recordIn: tempHistoryRec, fieldOffset: gdefault.historyOffsetGameName, fieldLength: gdefault.historyLengthGameName)
            //print("\(self) \(#function) - comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
            if thisGameName == gdefault.gamesGameName {
                //print("\(self) \(#function) - found matching file game \(thisGameName) at offset \(historyRecordOffset) and issued break command")
                break
            }
            historyRecordOffset += gdefault.historyRecordSize
        }
        
        // Update the record and recreate the file
        //print("\(self) \(#function) - now calling updateHistoryFile with offset \(historyRecordOffset)")
        updateHistoryFile(actionIn: updateFileUpdateCode, historyOffsetIn: historyRecordOffset, newHistoryDataIn: logHistoryData)

        //print("\(self) \(#function) - end of end-of-round updates")
    }
    
    // General function to determine if a player cleared phase.
    // Input:   player array index
    // Returns: y = player cleared phase
    //          n = player did not clear phase
    func didPlayerClearPhase(indexIn: Int) -> String {
        let startRoundPhase = String(Int(gdefault.gamesPlayerStartRoundPhases[indexIn])! + intPhaseDivider)
        if gdefault.gamesPlayerPhase1[indexIn] == startRoundPhase {
            return "y"
        }
        else if gdefault.gamesPlayerPhase2[indexIn] == startRoundPhase {
            return "y"
        }
        else if gdefault.gamesPlayerPhase3[indexIn] == startRoundPhase {
            return "y"
        }
        else if gdefault.gamesPlayerPhase4[indexIn] == startRoundPhase {
            return "y"
        }
        else if gdefault.gamesPlayerPhase5[indexIn] == startRoundPhase {
            return "y"
        }
        else if gdefault.gamesPlayerPhase6[indexIn] == startRoundPhase {
            return "y"
        }
        else if gdefault.gamesPlayerPhase7[indexIn] == startRoundPhase {
            return "y"
        }
        else if gdefault.gamesPlayerPhase8[indexIn] == startRoundPhase {
            return "y"
        }
        else if gdefault.gamesPlayerPhase9[indexIn] == startRoundPhase {
            return "y"
        }
        else if gdefault.gamesPlayerPhase10[indexIn] == startRoundPhase {
            return "y"
        }
        else {
            return "n"
        }
    }
    
    // General function to ensure that at least one player cleared phase
    // Input:   indexIn index of player
    func didOnePlayerClearPhase() -> String {
        
        var pcount = 0
        var clearedPhase = "n"

        while pcount < gdefault.gamesLengthPlayerNameOccurs  {
            if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                break
            }
            //print("\(self) \(#function) - \(pcount) \(gdefault.gamesPlayerName[pcount]) current phase=\(gdefault.gamesPlayerCurrentPhase[pcount])")
            //print("\(self) \(#function) - Std Phases: 01=\(gdefault.gamesPlayerPhase1[pcount]) 02=\(gdefault.gamesPlayerPhase2[pcount]) 03=\(gdefault.gamesPlayerPhase3[pcount]) 04=\(gdefault.gamesPlayerPhase4[pcount])  05=\(gdefault.gamesPlayerPhase5[pcount])  06=\(gdefault.gamesPlayerPhase6[pcount])  07=\(gdefault.gamesPlayerPhase7[pcount])  08=\(gdefault.gamesPlayerPhase8[pcount]) 09=\(gdefault.gamesPlayerPhase9[pcount])  10=\(gdefault.gamesPlayerPhase10[pcount]) SOR Phase: \(gdefault.gamesPlayerStartRoundPhases[pcount])")
            clearedPhase = didPlayerClearPhase(indexIn: pcount)
            //print("\(self) \(#function) - This player's phase clearing status=\(clearedPhase)")
            if clearedPhase == "y" {
                break
            }
            pcount += 1
        }
        return clearedPhase
    }
    
    // General function to set up each player's start-of-round point values in preparation
    // for the next round.
    // The procedure is as follows:
    // - Scan all active players in this game
    // - For each, set the start-of-round point value to be euqal to the current point value

    func setNextStartRoundPoints () {
        var pcount = 0
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                break
            }
            //print("\(self) \(#function) - \(pcount) \(gdefault.gamesPlayerName[pcount]) BEFORE points=\(gdefault.gamesPlayerPoints[pcount]) SOR points=\(gdefault.gamesPlayerStartRoundPoints[pcount])")
                gdefault.gamesPlayerStartRoundPoints[pcount] = gdefault.gamesPlayerPoints[pcount]
            //print("\(self) \(#function) - \(pcount) \(gdefault.gamesPlayerName[pcount]) AFTER points=\(gdefault.gamesPlayerPoints[pcount]) SOR points=\(gdefault.gamesPlayerStartRoundPoints[pcount])")
            pcount += 1
        }
    }
    
    // General function to set up each player's start-of-round phase values in preparation
    // for the next round.
    // The procedure is as follows:
    // - Scan all active players in this game
    // - For each:
    //   - Check if they're choosing phases or not
    //     - If they are, set the start-of-round phase to 000 and the current phase to 00
    //     - If they are not, determine their next phase and put it in the start-round phase,
    //       and put the corresponding relative phase # in the current phase

    func setNextStartRoundPhases () {
        var pcount = 0
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                break
            }
            if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                let returnedRawPhasePoints = determinePhaseAndPointsStatus(requestedFormatIn: dataFormatRaw,
                                                  indexIn: pcount)
                let rawPhasePoints = returnedRawPhasePoints.rawDataOrPhaseText
                //print("\(self) \(#function) - \(pcount) \(gdefault.gamesPlayerName[pcount]) raw=\(rawPhasePoints)")
                let sidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 1)
                let eidx = rawPhasePoints.index(rawPhasePoints.startIndex, offsetBy: 3)
                let range = sidx ..< eidx
                let rawPhase = rawPhasePoints[range]
                let relativePhase = String(rawPhase)
                let phaseIdx = Int(relativePhase)! - 1
                //print("\(self) \(#function) - relative phase=\(relativePhase) phase index=\(phaseIdx)")
                switch phaseIdx {
                case 0:
                    //print("\(self) \(#function) - setting sor[\(pcount)] to \(gdefault.gamesPlayerPhase1[pcount])")
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase1[pcount]
                case 1:
                    //print("\(self) \(#function) - setting sor[\(pcount)] to \(gdefault.gamesPlayerPhase2[pcount])")
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase2[pcount]
                case 2:
                    //print("\(self) \(#function) - setting sor[\(pcount)] to \(gdefault.gamesPlayerPhase3[pcount])")
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase3[pcount]
                case 3:
                    //print("\(self) \(#function) - setting sor[\(pcount)] to \(gdefault.gamesPlayerPhase4[pcount])")
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase4[pcount]
                case 4:
                    //print("\(self) \(#function) - setting sor[\(pcount)] to \(gdefault.gamesPlayerPhase5[pcount])")
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase5[pcount]
                case 5:
                    //print("\(self) \(#function) - setting sor[\(pcount)] to \(gdefault.gamesPlayerPhase6[pcount])")
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase6[pcount]
                case 6:
                    //print("\(self) \(#function) - setting sor[\(pcount)] to \(gdefault.gamesPlayerPhase7[pcount])")
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase7[pcount]
                case 7:
                    //print("\(self) \(#function) - setting sor[\(pcount)] to \(gdefault.gamesPlayerPhase8[pcount])")
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase8[pcount]
                case 8:
                    //print("\(self) \(#function) - setting sor[\(pcount)] to \(gdefault.gamesPlayerPhase9[pcount])")
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase9[pcount]
                case 9:
                    //print("\(self) \(#function) - setting sor[\(pcount)] to \(gdefault.gamesPlayerPhase10[pcount])")
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase10[pcount]
                case 10:
                    //print("\(self) \(#function) - setting sor[\(pcount)] to 999")
                    gdefault.gamesPlayerStartRoundPhases[pcount] = "999"
                default:
                    _ = ""
                }
                //print("\(self) \(#function) - setting current phase[\(pcount)] to \(relativePhase)")
                gdefault.gamesPlayerCurrentPhase[pcount] = relativePhase
            }
            else {
                //print("\(self) \(#function) - \(pcount) \(gdefault.gamesPlayerName[pcount]) raw=n/a (player chooses phase)")
                gdefault.gamesPlayerStartRoundPhases[pcount] = initZeroPhase3
                gdefault.gamesPlayerCurrentPhase[pcount] = initZeroPhase2
            }
            pcount += 1
        }
    }
    
    // General function to analyze if more than one player has zero points
    // Output: The number of players with zero points
    
    func checkOnly1Zero () -> Int {
        var pcount = 0
        var playersWithZeroPoints = 0
        //print("\(self) \(#function) - here are the player point status codes (before) \(gdefault.gamesPlayerPointsStatus)")
        //print("\(self) \(#function) - here are the player point status entry values (before) \(gdefault.gamesPlayerPointsStatusEntry)")
        // Ensure that exactly one player has zero points
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                break
            }
            //print("\(self) \(#function) - \(pcount) \(gdefault.gamesPlayerName[pcount]) current points=\(gdefault.gamesPlayerPoints[pcount]) SOR points=\(gdefault.gamesPlayerStartRoundPoints[pcount])")
            if gdefault.gamesPlayerPoints[pcount] == gdefault.gamesPlayerStartRoundPoints[pcount] {
                gdefault.gamesPlayerPointsStatus[pcount] = pointsStatusRed
                gdefault.gamesPlayerPointsStatusEntry[pcount] = gdefault.gamesPlayerEntryOrder[pcount]
                playersWithZeroPoints += 1
            }
            else {
                gdefault.gamesPlayerPointsStatus[pcount] = pointsStatusStandard
                gdefault.gamesPlayerPointsStatusEntry[pcount] = "00"
            }
            pcount += 1
        }
        //print("\(self) \(#function) - here are the player point status codes (after) \(gdefault.gamesPlayerPointsStatus)")
        //print("\(self) \(#function) - here are the player point status entry values (after) \(gdefault.gamesPlayerPointsStatusEntry)")
        
        return playersWithZeroPoints
    }
        
    // General function to determine the index of the one player with zero points
    // Output: The index of the player with zero points
    
    func whoHasZeroPoints () -> Int {
        var pcount = 0
        var playerWithZeroPoints = 0

        //print("\(self) \(#function) - check for the player with zero points")
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
                break
            }
            //print("\(self) \(#function) - points  for player \(pcount)=\(gdefault.gamesPlayerPoints[pcount])")
            //print("\(self) \(#function) - SOR pts for player \(pcount)=\(gdefault.gamesPlayerPoints[pcount])")
            if gdefault.gamesPlayerPoints[pcount] == gdefault.gamesPlayerStartRoundPoints[pcount] {
                playerWithZeroPoints = pcount
            }
            pcount += 1
        }
        //print("\(self) \(#function) - the player with zero points is at index \(pcount)")
        return playerWithZeroPoints
    }

    // General function to dynamically configure and position a label
    // Input: label name,
    //        text to be displayed,
    //        text color,
    //        background color,
    //        x position,
    //        y position,
    //        width,
    //        height of the label,
    //        bold or regular text (b or r),
    //        font size
    //        justification left, right, center (l, r, c)
    // It is the caller's responsibility to define the label variable
    // and then add it as a subview of the view.
    
    func configureLabel (labelNameIn: UILabel, textIn: String, textColorIn: UIColor, backgroundColorIn: UIColor, xPositionIn: Int, yPositionIn: Int, widthIn: Int, heightIn: Int, boldOrRegularIn: String, fontSizeIn: CGFloat, justifyIn: String) {
        
        //print("\(self) \(#function) - text=\(textIn) x=\(xPositionIn) y=\(yPositionIn)")
        
        // This sets the label's size and position, where x is
        // the number of pixels from the left, and y is the number
        // of pixels from the top. Width and height are self-explanatory.
        //print("\(self) \(#function) - create frame for \(textIn) x=\(xPositionIn) y=\(yPositionIn) w=\(widthIn) h=\(heightIn) color=\(backgroundColorIn)")
        labelNameIn.frame = CGRect(x: xPositionIn, y: yPositionIn, width: widthIn, height: heightIn)
        labelNameIn.text = textIn
        labelNameIn.textColor = textColorIn
        labelNameIn.backgroundColor = backgroundColorIn
        switch justifyIn {
        case justifyLeft:
            labelNameIn.textAlignment = NSTextAlignment.left
        case justifyRight:
            labelNameIn.textAlignment = NSTextAlignment.right
        case justifyCenter:
            labelNameIn.textAlignment = NSTextAlignment.center
        default:
            labelNameIn.textAlignment = NSTextAlignment.left
        }
        if boldOrRegularIn == weightBold {
            labelNameIn.font = UIFont.systemFont(ofSize: fontSizeIn, weight: UIFont.Weight.heavy)
        }
        else {
            labelNameIn.font = UIFont.systemFont(ofSize: fontSizeIn, weight: UIFont.Weight.regular)
        }
        return
    }
        
    // General function to dynamically configure and position a button within the scrolling player area
    // Input: button name,
    //        x position,
    //        y position,
    //        text to be displayed,
    //        text color,
    //        background color,
    //        index to selector function associated with this button
    // It is the caller's responsibility to define the button variable,
    // and add it as a subview of the view. This function will
    // associate the appropriate function with this button.
    
    func configureButton (buttonNameIn: UIButton, xPositionIn: Int, yPositionIn: Int, textIn: String, textColorIn: UIColor, backgroundColorIn: UIColor, selectorIdx: Int) {
        
        //print("\(self) \(#function) - gen button \(textIn) at x/y \(xPositionIn)/\(yPositionIn) for length 0 color=\(backgroundColorIn) device=\(deviceWeAreRunningOn)")
        var buttonFontSize: CGFloat = 0
        if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
            buttonFontSize = 15
        }
        else {
            buttonFontSize = 16
        }
        
        // This is where the button will physically be relative to the
        // top left of the button box, where x is the number of pixels
        // from the left, and y is the number of pixels from the top.
        buttonNameIn.frame = CGRect(x: xPositionIn, y: yPositionIn, width: 0, height: 0)
        
        // This determines the location of the text within the button,
        // where top is the number of pixels from the top, left is the
        // number of pixels from the left, bottom is the number of
        // pixels from the bottom, and right is the number of pixels
        // from the right.
        buttonNameIn.contentEdgeInsets = UIEdgeInsets(top: 6, left: 5, bottom: 6, right: 5)
        buttonNameIn.setTitle(textIn, for: UIControl.State.normal)
        buttonNameIn.titleLabel?.numberOfLines = 2
        buttonNameIn.titleLabel?.lineBreakMode = .byWordWrapping
        buttonNameIn.titleLabel?.textAlignment = .center
        buttonNameIn.setTitleColor(textColorIn, for: .normal)
        buttonNameIn.backgroundColor = backgroundColorIn
        buttonNameIn.titleLabel?.font = UIFont.systemFont(ofSize: buttonFontSize, weight: UIFont.Weight.regular)
        buttonNameIn.sizeToFit()
        buttonNameIn.layer.cornerRadius = cornerRadiusStdButton
        // Associate this button with the appropriate function
        buttonNameIn.addTarget(self,
                               action: selectorNames[selectorIdx],
                               for: .touchUpInside)
        return
    }
    
    // General function to dynamically configure and position a button on the main screen
    // Input: button name,
    //        x position,
    //        y position,
    //        font,
    //        font size,
    //        text to be displayed,
    //        text color,
    //        background color,
    //        corner radius size,
    //        index to selector function associated with this button
    // It is the caller's responsibility to define the button variable,
    // and add it as a subview of the view. This function will
    // associate the appropriate function with this button.
    
    func configureButtonMain (buttonNameIn: UIButton, xPositionIn: Int, yPositionIn: Int, fontIn: String, fontSizeIn: CGFloat, textIn: String, textColorIn: UIColor, backgroundColorIn: UIColor, cornerRadiusIn: CGFloat, selectorIdx: Int) {
        
        //print("\(self) \(#function) - gen button \(textIn) at x/y \(xPositionIn)/\(yPositionIn) for length 0 color=\(backgroundColorIn) device=\(deviceWeAreRunningOn)")
        
        // This is where the button will physically be relative to the
        // top left of the box, where x is the number of pixels
        // from the left, and y is the number of pixels from the top.
        buttonNameIn.frame = CGRect(x: xPositionIn, y: yPositionIn, width: 0, height: 0)
        
        // This determines the location of the text within the button,
        // where top is the number of pixels from the top, left is the
        // number of pixels from the left, bottom is the number of
        // pixels from the bottom, and right is the number of pixels
        // from the right.
        buttonNameIn.contentEdgeInsets = UIEdgeInsets(top: 6, left: 5, bottom: 6, right: 5)
        buttonNameIn.setTitle(textIn, for: UIControl.State.normal)
        buttonNameIn.titleLabel?.numberOfLines = 2
        buttonNameIn.titleLabel?.lineBreakMode = .byWordWrapping
        buttonNameIn.titleLabel?.textAlignment = .center
        buttonNameIn.setTitleColor(textColorIn, for: .normal)
        buttonNameIn.backgroundColor = backgroundColorIn
        buttonNameIn.titleLabel!.font = UIFont(name: fontIn, size: fontSizeIn)
        buttonNameIn.sizeToFit()
        buttonNameIn.layer.cornerRadius = cornerRadiusIn
        buttonNameIn.addTarget(self,
                                action: selectorNames[selectorIdx],
                                for: .touchUpInside)
        return
    }
    
    @objc func clearPhaseClicked(_ sender: UIButton) {
    /*
        // Clear any error message
        errorMessage.text = ""
        errorMessageTop.text = ""
        
        let pcount = gdefault.playerIdxByButton[sender.tag]
        let bidx = pcount * 5
        //print("\(self) \(#function) - You pressed Clear Phase, tag=\(sender.tag), player index=\(pcount) button index to use = \(bidx) entry=\(gdefault.gamesPlayerEntryOrder[pcount])")
        //print("\(self) \(#function) - gamesPlayerButtonStatus[\(bidx)]=\(gdefault.gamesPlayerButtonStatus[bidx])")
        //print ("\(self) \(#function) - choice indicator is \(gdefault.gamesPlayerChoosesPhase[pcount])")
        // Do no action if this button is marked as disabled
        if gdefault.gamesPlayerButtonStatus[bidx] == buttonCodeEnabled {
            
            //print("\(self) \(#function) - button was marked as enabled - processing continues")
            
            // Disallow clearing phase if only one player has been defined
            let playerCount = countThePlayers ()
            if playerCount < 2 {
                //print ("\(self) \(#function) - player count is only \(playerCount), no phase clearing allowed")
                errorMessageTop.textColor = appColorRed
                errorMessage.textColor = appColorRed
                errorMessageTop.backgroundColor = appColorYellow
                errorMessage.backgroundColor = appColorYellow
                errorMessageTop.text = "You may not clear phase if"
                errorMessage.text = "there's only one player"
                allowExitFromView = false
            }
            
            // Based on whether the player is choosing phases or not, either
            // update the phase as requested and subsequently disable the
            // clear phase button, or proceed to the screen for processing
            // phase choices, and then disable the clear phase button (unless
            // the user cancels the clearing request).
            //print("\(self) \(#function) - current phase for player at idx \(pcount) is \(gdefault.gamesPlayerCurrentPhase[pcount]), expecting 01-10")
            if errorMessage.text == "" {
                switch gdefault.gamesPlayerChoosesPhase[pcount] {
                case playerDoesNotChoosePhaseConstant:
                    // Flag the round and game as now being in progress
                    gdefault.gamesRoundStatus = inProgress
                    gdefault.gamesGameStatus = inProgress
                    
                    let thisPlayerCode = createHistoryPlayerCode(playerIn: gdefault.gamesPlayerEntryOrder[pcount])
                    //print("\(self) \(#function) - case n - player does not choose phase")
                    switch gdefault.gamesPlayerCurrentPhase[pcount] {
                    case "01":
                        //print("\(self) \(#function) - case 01, player phase 1=\(gdefault.gamesPlayerPhase1[pcount]), sor=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                        if gdefault.gamesPlayerPhase1[pcount] == gdefault.gamesPlayerStartRoundPhases[pcount] &&
                            gdefault.gamesPlayerPhase1[pcount] < phaseDivider {
                            gdefault.gamesPlayerPhase1[pcount] =  String(Int(gdefault.gamesPlayerPhase1[pcount])! + intPhaseDivider)
                            //print("\(self) \(#function) - resetting player phase1 to \(gdefault.gamesPlayerPhase1[pcount])")
                            //print("\(self) \(#function) - disabling button index \(bidx)")
                            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeDisabled
                            logHistoryData = thisPlayerCode + historyClearPhaseCode + "01  "
                        }
                        //else {
                            //print("\(self) \(#function) - did not reset phase 1 and did not disable clear phase button")
                            //print("\(self) \(#function) - these updates require that phase1 equal sor phase and phase1 < divider")
                        //}
                    case "02":
                        //print("\(self) \(#function) - case 02, player phase 2=\(gdefault.gamesPlayerPhase2[pcount]), sor=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                        if gdefault.gamesPlayerPhase2[pcount] == gdefault.gamesPlayerStartRoundPhases[pcount] &&
                            gdefault.gamesPlayerPhase2[pcount] < phaseDivider {
                            gdefault.gamesPlayerPhase2[pcount] =  String(Int(gdefault.gamesPlayerPhase2[pcount])! + intPhaseDivider)
                            //print("\(self) \(#function) - resetting player phase2 to \(gdefault.gamesPlayerPhase2[pcount])")
                            //print("\(self) \(#function) - disabling button index \(bidx)")
                            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeDisabled
                            logHistoryData = thisPlayerCode + historyClearPhaseCode + "02  "
                        }
                        //else {
                            //print("\(self) \(#function) - did not reset phase 2 and did not disable clear phase button")
                            //print("\(self) \(#function) - these updates require that phase2 equal sor phase and phase2 < divider")
                        //}
                    case "03":
                        //print("\(self) \(#function) - case 03, player phase 3=\(gdefault.gamesPlayerPhase3[pcount]), sor=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                        if gdefault.gamesPlayerPhase3[pcount] == gdefault.gamesPlayerStartRoundPhases[pcount] &&
                            gdefault.gamesPlayerPhase3[pcount] < phaseDivider {
                            gdefault.gamesPlayerPhase3[pcount] =  String(Int(gdefault.gamesPlayerPhase3[pcount])! + intPhaseDivider)
                            //print("\(self) \(#function) - resetting player phase3 to \(gdefault.gamesPlayerPhase3[pcount])")
                            //print("\(self) \(#function) - disabling button index \(bidx)")
                            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeDisabled
                            logHistoryData = thisPlayerCode + historyClearPhaseCode + "03  "
                        }
                        //else {
                            //print("\(self) \(#function) - did not reset phase 3 and did not disable clear phase button")
                            ///print("\(self) \(#function) - these updates require that phase3 equal sor phase and phase3 < divider")
                        //}
                    case "04":
                        //print("\(self) \(#function) - case 04, player phase 4=\(gdefault.gamesPlayerPhase4[pcount]), sor=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                        if gdefault.gamesPlayerPhase4[pcount] == gdefault.gamesPlayerStartRoundPhases[pcount] &&
                            gdefault.gamesPlayerPhase4[pcount] < phaseDivider {
                            gdefault.gamesPlayerPhase4[pcount] =  String(Int(gdefault.gamesPlayerPhase4[pcount])! + intPhaseDivider)
                            //print("\(self) \(#function) - resetting player phase4 to \(gdefault.gamesPlayerPhase4[pcount])")
                            //print("\(self) \(#function) - disabling button index \(bidx)")
                            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeDisabled
                            logHistoryData = thisPlayerCode + historyClearPhaseCode + "04  "
                        }
                        //else {
                            //print("\(self) \(#function) - did not reset phase 4 and did not disable clear phase button")
                            //print("\(self) \(#function) - these updates require that phase4 equal sor phase and phase4 < divider")
                        //}
                    case "05":
                        //print("\(self) \(#function) - case 05, player phase 5=\(gdefault.gamesPlayerPhase5[pcount]), sor=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                        if gdefault.gamesPlayerPhase5[pcount] == gdefault.gamesPlayerStartRoundPhases[pcount] &&
                            gdefault.gamesPlayerPhase5[pcount] < phaseDivider {
                            gdefault.gamesPlayerPhase5[pcount] =  String(Int(gdefault.gamesPlayerPhase5[pcount])! + intPhaseDivider)
                            //print("\(self) \(#function) - resetting player phase5 to \(gdefault.gamesPlayerPhase5[pcount])")
                            //print("\(self) \(#function) - disabling button index \(bidx)")
                            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeDisabled
                            logHistoryData = thisPlayerCode + historyClearPhaseCode + "05  "
                        }
                        //else {
                            //print("\(self) \(#function) - did not reset phase 5 and did not disable clear phase button")
                            //print("\(self) \(#function) - these updates require that phase5 equal sor phase and phase5 < divider")
                        //}
                    case "06":
                        //print("\(self) \(#function) - case 06, player phase 6=\(gdefault.gamesPlayerPhase6[pcount]), sor=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                        if gdefault.gamesPlayerPhase6[pcount] == gdefault.gamesPlayerStartRoundPhases[pcount] &&
                            gdefault.gamesPlayerPhase6[pcount] < phaseDivider {
                            gdefault.gamesPlayerPhase6[pcount] =  String(Int(gdefault.gamesPlayerPhase6[pcount])! + intPhaseDivider)
                            //print("\(self) \(#function) - resetting player phase6 to \(gdefault.gamesPlayerPhase6[pcount])")
                            //print("\(self) \(#function) - disabling button index \(bidx)")
                            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeDisabled
                            logHistoryData = thisPlayerCode + historyClearPhaseCode + "06  "
                        }
                        //else {
                            //print("\(self) \(#function) - did not reset phase 6 and did not disable clear phase button")
                            //print("\(self) \(#function) - these updates require that phase6 equal sor phase and phase6 < divider")
                        //}
                    case "07":
                        //print("\(self) \(#function) - case 07, player phase 7=\(gdefault.gamesPlayerPhase7[pcount]), sor=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                        if gdefault.gamesPlayerPhase7[pcount] == gdefault.gamesPlayerStartRoundPhases[pcount] &&
                            gdefault.gamesPlayerPhase7[pcount] < phaseDivider {
                            gdefault.gamesPlayerPhase7[pcount] =  String(Int(gdefault.gamesPlayerPhase7[pcount])! + intPhaseDivider)
                            //print("\(self) \(#function) - resetting player phase7 to \(gdefault.gamesPlayerPhase7[pcount])")
                            //print("\(self) \(#function) - disabling button index \(bidx)")
                            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeDisabled
                            logHistoryData = thisPlayerCode + historyClearPhaseCode + "07  "
                        }
                        //else {
                            //print("\(self) \(#function) - did not reset phase 7 and did not disable clear phase button")
                            //print("\(self) \(#function) - these updates require that phase7 equal sor phase and phase7 < divider")
                        //}
                    case "08":
                        //print("\(self) \(#function) - case 08, player phase 8=\(gdefault.gamesPlayerPhase8[pcount]), sor=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                        if gdefault.gamesPlayerPhase8[pcount] == gdefault.gamesPlayerStartRoundPhases[pcount] &&
                            gdefault.gamesPlayerPhase8[pcount] < phaseDivider {
                            gdefault.gamesPlayerPhase8[pcount] =  String(Int(gdefault.gamesPlayerPhase8[pcount])! + intPhaseDivider)
                            //print("\(self) \(#function) - resetting player phase8 to \(gdefault.gamesPlayerPhase8[pcount])")
                            //print("\(self) \(#function) - disabling button index \(bidx)")
                            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeDisabled
                            logHistoryData = thisPlayerCode + historyClearPhaseCode + "08  "
                        }
                        //else {
                            //print("\(self) \(#function) - did not reset phase 8 and did not disable clear phase button")
                            //print("\(self) \(#function) - these updates require that phase8 equal sor phase and phase8 < divider")
                        //}
                    case "09":
                        //print("\(self) \(#function) - case 09, player phase 9=\(gdefault.gamesPlayerPhase9[pcount]), sor=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                        if gdefault.gamesPlayerPhase9[pcount] == gdefault.gamesPlayerStartRoundPhases[pcount] &&
                            gdefault.gamesPlayerPhase9[pcount] < phaseDivider {
                            gdefault.gamesPlayerPhase9[pcount] =  String(Int(gdefault.gamesPlayerPhase9[pcount])! + intPhaseDivider)
                            //print("\(self) \(#function) - resetting player phase9 to \(gdefault.gamesPlayerPhase9[pcount])")
                            //print("\(self) \(#function) - disabling button index \(bidx)")
                            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeDisabled
                            logHistoryData = thisPlayerCode + historyClearPhaseCode + "09  "
                        }
                        //else {
                            //print("\(self) \(#function) - did not reset phase 9 and did not disable clear phase button")
                            //print("\(self) \(#function) - these updates require that phase9 equal sor phase and phase9 < divider")
                        //}
                    case "10":
                        //print("\(self) \(#function) - case 10, player phase 10=\(gdefault.gamesPlayerPhase10[pcount]), sor=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                        if gdefault.gamesPlayerPhase10[pcount] == gdefault.gamesPlayerStartRoundPhases[pcount] &&
                            gdefault.gamesPlayerPhase10[pcount] < phaseDivider {
                            gdefault.gamesPlayerPhase10[pcount] =  String(Int(gdefault.gamesPlayerPhase10[pcount])! + intPhaseDivider)
                            //print("\(self) \(#function) - resetting player phase10 to \(gdefault.gamesPlayerPhase10[pcount])")
                            //print("\(self) \(#function) - disabling button index \(bidx)")
                            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeDisabled
                            logHistoryData = thisPlayerCode + historyClearPhaseCode + "10  "
                        }
                        //else {
                            //print("\(self) \(#function) - did not reset phase 10 and did not disable clear phase button")
                            //print("\(self) \(#function) - these updates require that phase10 equal sor phase and phase10 < divider")
                        //}
                    default:
                        _ = ""
                    }

                    // Update the Games and History files for this game's player
                    // unless an error was detected

                    if errorMessage.text == "" {
                        //print("\(self) \(#function) - updating game file due to phase change")
                        // Get the offset of this game in the Games file
                        let fileHandleTG1GamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
                        let fileContent:String=String(data:fileHandleTG1GamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
                        fileHandleTG1GamesGet.closeFile()
                        let gameFileSize = fileContent.count
                        //print("\(self) \(#function) - game file size=\(gameFileSize)")
                        
                        var gameRecordOffset = 0
                        while gameRecordOffset < gameFileSize {
                            //print("\(self) \(#function) - scanning: offset is \(gameRecordOffset)")
                            let tempGameRec = extractRecordField(recordIn: fileContent, fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
                            let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
                            //print("\(self) \(#function) - comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
                            if thisGameName == gdefault.gamesGameName {
                                //print("\(self) \(#function) - found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                                break
                            }
                            gameRecordOffset += gdefault.gamesRecordSize
                        }
                        
                        // Update the record and recreate the file
                        //print("\(self) \(#function) - now calling updateGamesFile from TheGame with offset \(gameRecordOffset)")
                        updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
                        
                        //print("\(self) \(#function) - updating history file due to phase change")
                        // Get the offset of this game in the History file
                        let fileHandleTG2HistoryGet:FileHandle=FileHandle(forReadingAtPath: historyFileURL.path)!
                        let fileContent2:String=String(data:fileHandleTG2HistoryGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
                        fileHandleTG2HistoryGet.closeFile()
                        let historyFileSize = fileContent2.count
                        
                        // Find the current game in the History file
                        var historyRecordOffset = 0
                        //print("\(self) \(#function) - start game scan in history, file size=\(historyFileSize)")
                        while historyRecordOffset < historyFileSize {
                            //print("\(self) \(#function) - scanning: current offset is \(historyRecordOffset)")
                            let tempHistoryRec = extractRecordField(recordIn: fileContent2, fieldOffset: historyRecordOffset, fieldLength: gdefault.historyRecordSize)
                            let thisGameName = extractRecordField(recordIn: tempHistoryRec, fieldOffset: gdefault.historyOffsetGameName, fieldLength: gdefault.historyLengthGameName)
                            //print("\(self) \(#function) - comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
                            if thisGameName == gdefault.gamesGameName {
                                //print("\(self) \(#function) - found matching file game \(thisGameName) at offset \(historyRecordOffset) and issued break command")
                                break
                            }
                            historyRecordOffset += gdefault.historyRecordSize
                        }
                        
                        // Update the record and recreate the file
                        //print("\(self) \(#function) - now calling updateHistoryFile with offset \(historyRecordOffset)")
                        updateHistoryFile(actionIn: updateFileUpdateCode, historyOffsetIn: historyRecordOffset, newHistoryDataIn: logHistoryData)
                    }
                    
                    // Set all clear phase button colors to the standard values
                    gdefault.clearPhaseButtonColorStatus = "all green"
                    
                    //print("\(self) \(#function) - refreshing view")
                    aRefreshView()

                case playerChoosesPhaseConstant:
                    //print("\(self) \(#function) - case y - player does choose phase")
                    //print("\(self) \(#function) - going to screen T and setting tag \(sender.tag)")
                    // Identify the button associated with the clear phase request
                    // so that it can be disabled upon a successful clearing in
                    // ClearAPhase.

                    gdefault.clearPhaseButtonIndex = sender.tag
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "ClearAPhase")
                    //print("\(self) \(#function) - self presenting ClearAPhase controller")
                    self.present(controller, animated: true, completion: nil)
                    //print("\(self) \(#function) - returned from ClearAPhase controller")
                    aRefreshView()
                default:
                    _ = ""
                }
            }
        }
        else {
            
            // Disallow the clear phase button if the game is over
            if gdefault.gamesGameStatus == gameCompleteStatusCode {
                //print("\(self) \(#function) - games status was marked as complete - processing abandoned")
                errorMessage.textColor = appColorRed
                errorMessageTop.textColor = appColorRed
                errorMessageTop.backgroundColor = appColorYellow
                errorMessage.backgroundColor = appColorYellow
                errorMessageTop.text = "Clear Phase is not available"
                errorMessage.text = "The game has ended"
                allowExitFromView = false
            }
            else {
                //print("\(self) \(#function) - button was marked as disabled - processing abandoned")
                errorMessage.textColor = appColorRed
                errorMessageTop.textColor = appColorRed
                errorMessageTop.backgroundColor = appColorYellow
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Phase was cleared already"
                allowExitFromView = false
            }
        }
        //print("\(self) \(#function) - end of clearPhaseClicked function")
     */
    } // End clearPhaseClicked
    
    @objc func addPointsClicked(_ sender: UIButton) {
        /*
        // Clear any error message
        errorMessage.text = ""
        errorMessageTop.text = ""
        
        let pcount = gdefault.playerIdxByButton[sender.tag]
        let bidx = (pcount * 5) + 1
        //print("\(self) \(#function) - You pressed Add Points, tag=\(sender.tag), player index=\(pcount) button index to use = \(bidx) entry=\(gdefault.gamesPlayerEntryOrder[pcount])")
        //print("\(self) \(#function) - gamesPlayerButtonStatus[\(bidx)]=\(gdefault.gamesPlayerButtonStatus[bidx])")
        
        // Do no action if this button is marked as disabled
        if gdefault.gamesPlayerButtonStatus[bidx] == buttonCodeEnabled {
            
            // Disallow adding points if only one player has been defined
            let playerCount = countThePlayers ()
            if playerCount < 2 {
                errorMessageTop.textColor = appColorRed
                errorMessage.textColor = appColorRed
                errorMessageTop.backgroundColor = appColorYellow
                errorMessage.backgroundColor = appColorYellow
                errorMessageTop.text = "You may not add points"
                errorMessage.text = "if there's only one player"
                allowExitFromView = false
            }
            
            // Do no action if exactly one player has zero points
            if errorMessage.text == "" {
                let zeroCount = checkOnly1Zero()
                if zeroCount == 1 {
                    //print("\(self) \(#function) - only 1 player has 0 points already - processing abandoned")
                    errorMessage.textColor = appColorRed
                    errorMessageTop.textColor = appColorRed
                    errorMessageTop.backgroundColor = appColorYellow
                    errorMessage.backgroundColor = appColorYellow
                    errorMessageTop.text = "Adding points to this player would"
                    errorMessage.text = "leave no one with zero points"
                    allowExitFromView = false
                }
            }
            if errorMessage.text == "" {
                //print("\(self) \(#function) - going to screen J and setting tag \(sender.tag)")
                // Identify the button associated with the add points request
                // so that it can be disabled upon a successful update in
                // UpdatePoints.
                
                gdefault.addPointsButtonIndex = sender.tag

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "AddPoints")
                //print("\(self) \(#function) - self presenting AddPoints controller")
                self.present(controller, animated: true, completion: nil)
                //print("\(self) \(#function) - returned from AddPoints controller")
            }
        }
        else {
            
            // Disallow the add points button if the game is over
            if gdefault.gamesGameStatus == gameCompleteStatusCode {
                errorMessage.textColor = appColorRed
                errorMessageTop.textColor = appColorRed
                errorMessageTop.backgroundColor = appColorYellow
                errorMessage.backgroundColor = appColorYellow
                errorMessageTop.text = "Add Points is not available"
                errorMessage.text = "The game has ended"
                allowExitFromView = false
            }
            else {
                //print("\(self) \(#function) - button was marked as disabled - processing abandoned")
                errorMessage.textColor = appColorRed
                errorMessageTop.textColor = appColorRed
                errorMessageTop.backgroundColor = appColorYellow
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Points were added already"
                allowExitFromView = false
            }
        }
     */
    }
    
    @objc func skipPlayerClicked(_ sender: UIButton) {
        /*
        // Clear any error message
        errorMessage.text = ""
        errorMessageTop.text = ""
        
        //print("\(self) \(#function) - You pressed Skip Player, tag=\(sender.tag)")
        
        // Disallow the skip player button if the game is over
        if gdefault.gamesGameStatus == gameCompleteStatusCode {
            errorMessage.textColor = appColorRed
            errorMessageTop.textColor = appColorRed
            errorMessageTop.backgroundColor = appColorYellow
            errorMessage.backgroundColor = appColorYellow
            errorMessageTop.text = "Skip Player is not available"
            errorMessage.text = "The game has ended"
            allowExitFromView = false
        }
        
        // Disallow the skip player button if only one player has been defined
        let playerCount = countThePlayers ()
        //print("\(self) \(#function) - This game has \(playerCount) players")
        if playerCount < 2 {
            errorMessageTop.textColor = appColorRed
            errorMessage.textColor = appColorRed
            errorMessageTop.backgroundColor = appColorYellow
            errorMessage.backgroundColor = appColorYellow
            errorMessageTop.text = "You may not skip player"
            errorMessage.text = "if there's only one player"
            allowExitFromView = false
        }
        
        if errorMessage.text == "" {
            gdefault.skipPlayerButtonIndex = sender.tag
            let pidx = gdefault.playerIdxByButton[gdefault.skipPlayerButtonIndex]
            switch gdefault.gamesPlayerSkipped[pidx] {
            case playerIsNotSkipped:
                gdefault.gamesPlayerSkipped[pidx] = playerIsSkipped
            case playerIsSkipped:
                gdefault.gamesPlayerSkipped[pidx] = playerIsNotSkipped
            default:
                errorMessageTop.textColor = appColorRed
                errorMessage.textColor = appColorRed
                errorMessageTop.backgroundColor = appColorYellow
                errorMessage.backgroundColor = appColorYellow
                errorMessageTop.text = "Unable to process skip"
                errorMessage.text = "player request at this time"
                allowExitFromView = false
            }
        }
        
        // Update the Games file for this game's player
        // unless an error was detected
        if errorMessage.text == "" {
            //print("\(self) \(#function) - updating game file due to skipo/unskip player")
            // Get the offset of this game in the Games file
            let fileHandleTG5GamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
            let fileContent:String=String(data:fileHandleTG5GamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleTG5GamesGet.closeFile()
            let gameFileSize = fileContent.count
            //print("\(self) \(#function) - game file size=\(gameFileSize)")
            
            var gameRecordOffset = 0
            while gameRecordOffset < gameFileSize {
                //print("\(self) \(#function) - scanning: offset is \(gameRecordOffset)")
                let tempGameRec = extractRecordField(recordIn: fileContent, fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
                let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
                //print("\(self) \(#function) - comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
                if thisGameName == gdefault.gamesGameName {
                    //print("\(self) \(#function) - found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                    break
                }
                gameRecordOffset += gdefault.gamesRecordSize
            }
            
            // Update the record and recreate the file
            //print("\(self) \(#function) - now calling updateGamesFile from TheGame with offset \(gameRecordOffset)")
            updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
            aRefreshView()

            // Check if all players have been skipped. If so, unskip all of them,
            // updates the Games file, delay 3 seconds, and then redisplay the screen
            // with a message that all players are now fair game for skipping
            var skipIdx = 0
            var skippedCount = 0
            while skipIdx < playerCount {
                if gdefault.gamesPlayerSkipped[skipIdx] == playerIsSkipped {
                    skippedCount += 1
                }
                else {
                    break
                }
                skipIdx += 1
            }
            if skippedCount == playerCount {
                let delayInSeconds = 3.0
                DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
                    skipIdx = 0
                    while skipIdx < playerCount {
                        gdefault.gamesPlayerSkipped[skipIdx] = playerIsNotSkipped
                        skipIdx += 1
                    }
                    // Get the offset of this game in the Games file
                    let fileHandleTG6GamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
                    let fileContent:String=String(data:fileHandleTG6GamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
                    fileHandleTG6GamesGet.closeFile()
                    let gameFileSize = fileContent.count
                    //print("\(self) \(#function) - game file size=\(gameFileSize)")
                    
                    var gameRecordOffset = 0
                    while gameRecordOffset < gameFileSize {
                        //print("\(self) \(#function) - scanning: offset is \(gameRecordOffset)")
                        let tempGameRec = extractRecordField(recordIn: fileContent, fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
                        let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
                        //print("\(self) \(#function) - comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
                        if thisGameName == gdefault.gamesGameName {
                            //print("\(self) \(#function) - found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                            break
                        }
                        gameRecordOffset += gdefault.gamesRecordSize
                    }
                    
                    // Update the record and recreate the file
                    //print("\(self) \(#function) - now calling updateGamesFile from TheGame with offset \(gameRecordOffset)")
                    updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
                    
                    self.errorMessage.textColor = appColorWhite
                    self.errorMessageTop.textColor = appColorWhite
                    self.errorMessageTop.backgroundColor = appColorMediumGreen
                    self.errorMessage.backgroundColor = appColorMediumGreen
                    self.errorMessageTop.text = "All players have been skipped"
                    self.errorMessage.text = "Everyone is now fair game"
                    self.aRefreshView()
                }
            }
        }
         */
    }
    
    @objc func editPlayerClicked(_ sender: UIButton) {
        /*
        // Clear any error message
        errorMessage.text = ""
        errorMessageTop.text = ""
        
        //print("\(self) \(#function) - You pressed Edit Player, tag=\(sender.tag)")
        
        // Disallow the edit player button if the game is over
        if gdefault.gamesGameStatus == gameCompleteStatusCode {
            errorMessage.textColor = appColorRed
            errorMessageTop.textColor = appColorRed
            errorMessageTop.backgroundColor = appColorYellow
            errorMessage.backgroundColor = appColorYellow
            errorMessageTop.text = "Edit Player is not available"
            errorMessage.text = "The game has ended"
            allowExitFromView = false
        }
        
        if errorMessage.text == "" {
            //print("\(self) \(#function) - going to screen K and setting tag \(sender.tag)")
            
            gdefault.editPlayerButtonIndex = sender.tag
            
            // Save current field values so that edit player can reinstate them
            // if the user cancels
            let pidx = gdefault.playerIdxByButton[gdefault.editPlayerButtonIndex]
            gdefault.preEditPlayerPlayerName = gdefault.gamesPlayerName[pidx]
            gdefault.preEditPlayerPhase1 = gdefault.gamesPlayerPhase1[pidx]
            gdefault.preEditPlayerPhase2 = gdefault.gamesPlayerPhase2[pidx]
            gdefault.preEditPlayerPhase3 = gdefault.gamesPlayerPhase3[pidx]
            gdefault.preEditPlayerPhase4 = gdefault.gamesPlayerPhase4[pidx]
            gdefault.preEditPlayerPhase5 = gdefault.gamesPlayerPhase5[pidx]
            gdefault.preEditPlayerPhase6 = gdefault.gamesPlayerPhase6[pidx]
            gdefault.preEditPlayerPhase7 = gdefault.gamesPlayerPhase7[pidx]
            gdefault.preEditPlayerPhase8 = gdefault.gamesPlayerPhase8[pidx]
            gdefault.preEditPlayerPhase9 = gdefault.gamesPlayerPhase9[pidx]
            gdefault.preEditPlayerPhase10 = gdefault.gamesPlayerPhase10[pidx]
            gdefault.preEditPlayerCurrentPhase = gdefault.gamesPlayerCurrentPhase[pidx]
            gdefault.preEditPlayerStartRoundPhase = gdefault.gamesPlayerStartRoundPhases[pidx]
            gdefault.preEditPlayerPoints = gdefault.gamesPlayerPoints[pidx]
            gdefault.preEditPlayerStartRoundPoints = gdefault.gamesPlayerStartRoundPoints[pidx]
            gdefault.preEditPlayerDealerOrder = gdefault.gamesPlayerDealerOrder[pidx]
            gdefault.preEditPlayerCurrentDealer = gdefault.gamesCurrentDealer
            gdefault.preEditPlayerPlayerChoosesPhaseIndicator = gdefault.gamesPlayerChoosesPhase[pidx]

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "EditPlayer")
            //print("\(self) \(#function) - self presenting EditPlayer controller")
            self.present(controller, animated: true, completion: nil)
            //print("\(self) \(#function) - returned from EditPlayer controller")
        }
         */
    }

    @objc func viewHistoryClicked(_ sender: UIButton) {
        /*
        // Clear any error message
        errorMessage.text = ""
        errorMessageTop.text = ""
        
        //print("\(self) \(#function) -You pressed View History, tag=\(sender.tag)")
        
        // Disallow the view history button if the game is over
        if gdefault.gamesGameStatus == gameCompleteStatusCode {
            errorMessage.textColor = appColorRed
            errorMessageTop.textColor = appColorRed
            errorMessageTop.backgroundColor = appColorYellow
            errorMessage.backgroundColor = appColorYellow
            errorMessageTop.text = "View History is not available"
            errorMessage.text = "The game has ended"
            allowExitFromView = false
        }
        
        if errorMessage.text == "" {
            gdefault.viewHistoryButtonIndex = sender.tag
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ViewHistory")
            //print("\(self) \(#function) - self presenting ViewHistory controller")
            self.present(controller, animated: true, completion: nil)
        }
         */
    }

    @objc func aViewTutorialClicked(_ sender: Any) {
        weHaveAnError = "n"
        // Disallow the help button if the game is over
        if gdefault.gamesGameStatus == gameCompleteStatusCode {
            weHaveAnError = "y"
            // Generate the upper and lower error messages
            configureLabel(labelNameIn: errorMessageTop,
                           textIn: "Help is not available",
                           textColorIn: appColorYellow,
                           backgroundColorIn: appColorRed,
                           xPositionIn: eMTXposition,
                           yPositionIn: eMTYposition,
                           widthIn: eMTWidth,
                           heightIn: eMTHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessageTop)
            // Generate the lower error message
            configureLabel(labelNameIn: errorMessage,
                           textIn: "The game has ended",
                           textColorIn: appColorYellow,
                           backgroundColorIn: appColorRed,
                           xPositionIn: eMXposition,
                           yPositionIn: eMYposition,
                           widthIn: eMWidth,
                           heightIn: eMHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessage)
            allowExitFromView = false
        }
        else {
            
            gdefault.helpCaller = helpSectionCodeTheGame
            
            // Almost aways allow access to help
            continueToHelp = true
        }
    }
    
    // The sort button proceeds to PlayerSortSelection to select the desired order
    @objc func aSortClicked(_ sender: Any) {
        weHaveAnError = "n"
        // Disallow the sort button if the game is over
        if gdefault.gamesGameStatus == gameCompleteStatusCode {
            weHaveAnError = "y"
            // Generate the upper and lower error messages
            configureLabel(labelNameIn: errorMessageTop,
                           textIn: "Sort is not available",
                           textColorIn: appColorYellow,
                           backgroundColorIn: appColorRed,
                           xPositionIn: eMTXposition,
                           yPositionIn: eMTYposition,
                           widthIn: eMTWidth,
                           heightIn: eMTHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessageTop)
            // Generate the lower error message
            configureLabel(labelNameIn: errorMessage,
                           textIn: "The game has ended",
                           textColorIn: appColorYellow,
                           backgroundColorIn: appColorRed,
                           xPositionIn: eMXposition,
                           yPositionIn: eMYposition,
                           widthIn: eMWidth,
                           heightIn: eMHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessage)
            allowExitFromView = false
        }
        else {
            allowExitFromView = true
            weHaveAnError = "n"
        }
    }

    // The add player button proceeds to AddPlayer to add a new player
    @objc func aAddPlayerClicked(_ sender: Any) {
        weHaveAnError = "n"
            
        // Disallow the add player button if the game is over
        if gdefault.gamesGameStatus == gameCompleteStatusCode {
            // Generate the upper and lower error messages
            weHaveAnError = "y"
            configureLabel(labelNameIn: errorMessageTop,
                           textIn: "Add Player is not available",
                           textColorIn: appColorRed,
                           backgroundColorIn: appColorYellow,
                           xPositionIn: eMTXposition,
                           yPositionIn: eMTYposition,
                           widthIn: eMTWidth,
                           heightIn: eMTHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessageTop)
            // Generate the lower error message
            configureLabel(labelNameIn: errorMessage,
                           textIn: "The game has ended",
                           textColorIn: appColorRed,
                           backgroundColorIn: appColorYellow,
                           xPositionIn: eMXposition,
                           yPositionIn: eMYposition,
                           widthIn: eMWidth,
                           heightIn: eMHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessage)
            allowExitFromView = false
        }
        
        // Disallow adding a player if the maximum number of players has
        // been added already
        //print("\(self) \(#function) - entry=\(gdefault.gamesPlayerEntryOrder[gdefault.gamesLengthPlayerEntryOrderOccurs-1])")
        //print("\(self) \(#function) - idx=\(gdefault.gamesLengthPlayerEntryOrderOccurs-1)")
        if weHaveAnError == "n" {
            if !(gdefault.gamesPlayerEntryOrder [gdefault.gamesLengthPlayerEntryOrderOccurs-1] == initZeroEntry) {
                //print("\(self) \(#function) - set max player limit reached (because entry order of max index is not 0)")
                // Generate the upper and lower error messages
                weHaveAnError = "y"
                configureLabel(labelNameIn: errorMessageTop,
                                textIn: "",
                                textColorIn: appColorRed,
                                backgroundColorIn: appColorYellow,
                                xPositionIn: eMTXposition,
                                yPositionIn: eMTYposition,
                                widthIn: eMTWidth,
                                heightIn: eMTHeight,
                                boldOrRegularIn: weightRegular,
                                fontSizeIn: labelFontSize20,
                                justifyIn: justifyCenter)
                view.addSubview(errorMessageTop)
                // Generate the lower error message
                configureLabel(labelNameIn: errorMessage,
                                textIn: "Max player limit reached",
                                textColorIn: appColorRed,
                                backgroundColorIn: appColorYellow,
                                xPositionIn: eMXposition,
                                yPositionIn: eMYposition,
                                widthIn: eMWidth,
                                heightIn: eMHeight,
                                boldOrRegularIn: weightRegular,
                                fontSizeIn: labelFontSize20,
                                justifyIn: justifyCenter)
                view.addSubview(errorMessage)
                allowExitFromView = false
            }
        }
        
        // Disallow adding a player if the maximum entry code limit has been reached. This
        // is different from the maximum number of players, because the entry order number is used
        // to set the internal history code, i.e., 1 is a, 2 is b, ..., 26 is z. When 26 is reached
        // there are no more internal history codes available. This situation will occur if the user
        // repeatedly removes and then re-adds players. Doing this 11 times is ok, but no more.
        if weHaveAnError == "n" {
            var ecount = 0
            while ecount < gdefault.gamesLengthPlayerEntryOrderOccurs {
                if gdefault.gamesPlayerEntryOrder[ecount] == maxHistoryCodeEntryIndex {
                    break
                }
                ecount += 1
            }
            //print("\(self) \(#function) - ecount=\(ecount)")
            //print("\(self) \(#function) - max entry index allowed=\(maxHistoryCodeEntryIndex)")
            //print("\(self) \(#function) - entry codes=\(gdefault.gamesPlayerEntryOrder)")
            if !(ecount == gdefault.gamesLengthPlayerEntryOrderOccurs) {
                //print("\(self) \(#function) - set max player limit reached (because at least one entry order is 26")
                // Generate the upper and lower error messages
                weHaveAnError = "y"
                configureLabel(labelNameIn: errorMessageTop,
                               textIn: "It is not possible to add any",
                               textColorIn: appColorRed,
                               backgroundColorIn: appColorYellow,
                               xPositionIn: eMTXposition,
                               yPositionIn: eMTYposition,
                               widthIn: eMTWidth,
                               heightIn: eMTHeight,
                               boldOrRegularIn: weightRegular,
                               fontSizeIn: labelFontSize20,
                               justifyIn: justifyCenter)
                view.addSubview(errorMessageTop)
                // Generate the lower error message
                configureLabel(labelNameIn: errorMessage,
                               textIn: "more players at this time",
                               textColorIn: appColorRed,
                               backgroundColorIn: appColorYellow,
                               xPositionIn: eMXposition,
                               yPositionIn: eMYposition,
                               widthIn: eMWidth,
                               heightIn: eMHeight,
                               boldOrRegularIn: weightRegular,
                               fontSizeIn: labelFontSize20,
                               justifyIn: justifyCenter)
                view.addSubview(errorMessage)
                allowExitFromView = false
            }
            else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "AddPlayer")
                controller.modalPresentationStyle = .fullScreen
                controller.modalTransitionStyle = .crossDissolve
                self.present(controller, animated: true, completion: nil)
                allowExitFromView = true
            }
        }
    }

    // The end round button was pressed
    // This means that if there are no phase and point setting errors, it is time to move
    // to the next round and clear all the Skipped indicators. Also, if one or more players
    // have completed all their phases, the game ends and the winner is declared.
    
    @objc func aEndRoundClicked(_ sender: Any) {
        
        //print("\(self) \(#function) - starting aEndRoundButton")
        weHaveAnError = "n"
        
        // Disallow the end round button if the round has just started (and
        // thus is not yet in progress), or if the game has not yet started,
        // or if only one player has been added to the game, or if the game is over
        
        if gdefault.gamesGameStatus == gameCompleteStatusCode {
            weHaveAnError = "y"
            // Generate the upper and lower error messages
            configureLabel(labelNameIn: errorMessageTop,
                           textIn: "End round is not available",
                           textColorIn: appColorRed,
                           backgroundColorIn: appColorYellow,
                           xPositionIn: eMTXposition,
                           yPositionIn: eMTYposition,
                           widthIn: eMTWidth,
                           heightIn: eMTHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessageTop)
            // Generate the lower error message
            configureLabel(labelNameIn: errorMessage,
                           textIn: "The game has ended",
                           textColorIn: appColorRed,
                           backgroundColorIn: appColorYellow,
                           xPositionIn: eMXposition,
                           yPositionIn: eMYposition,
                           widthIn: eMWidth,
                           heightIn: eMHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessage)
            allowExitFromView = false
        }
        
        if gdefault.gamesGameStatus == notStarted {
            weHaveAnError = "y"
            // Generate the upper and lower error messages
            configureLabel(labelNameIn: errorMessageTop,
                           textIn: "",
                           textColorIn: appColorRed,
                           backgroundColorIn: appColorYellow,
                           xPositionIn: eMTXposition,
                           yPositionIn: eMTYposition,
                           widthIn: eMTWidth,
                           heightIn: eMTHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessageTop)
            // Generate the lower error message
            configureLabel(labelNameIn: errorMessage,
                           textIn: "Players need to be added",
                           textColorIn: appColorRed,
                           backgroundColorIn: appColorYellow,
                           xPositionIn: eMXposition,
                           yPositionIn: eMYposition,
                           widthIn: eMWidth,
                           heightIn: eMHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessage)
            allowExitFromView = false
        }
        else if gdefault.gamesRoundStatus == itIsStarting {
            weHaveAnError = "y"
            // Generate the upper and lower error messages
            configureLabel(labelNameIn: errorMessageTop,
                           textIn: "",
                           textColorIn: appColorRed,
                           backgroundColorIn: appColorYellow,
                           xPositionIn: eMTXposition,
                           yPositionIn: eMTYposition,
                           widthIn: eMTWidth,
                           heightIn: eMTHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessageTop)
            // Generate the lower error message
            configureLabel(labelNameIn: errorMessage,
                           textIn: "Please clear phases & add points",
                           textColorIn: appColorRed,
                           backgroundColorIn: appColorYellow,
                           xPositionIn: eMXposition,
                           yPositionIn: eMYposition,
                           widthIn: eMWidth,
                           heightIn: eMHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessage)
            allowExitFromView = false
        }

        if weHaveAnError == "n" {
            let clearedPhase = didOnePlayerClearPhase()
            if clearedPhase == "n" {
                weHaveAnError = "y"
                // Generate the upper and lower error messages
                configureLabel(labelNameIn: errorMessageTop,
                               textIn: "",
                               textColorIn: appColorRed,
                               backgroundColorIn: appColorYellow,
                               xPositionIn: eMTXposition,
                               yPositionIn: eMTYposition,
                               widthIn: eMTWidth,
                               heightIn: eMTHeight,
                               boldOrRegularIn: weightRegular,
                               fontSizeIn: labelFontSize20,
                               justifyIn: justifyCenter)
                view.addSubview(errorMessageTop)
                // Generate the lower error message
                configureLabel(labelNameIn: errorMessage,
                               textIn: "At least 1 player must clear phase",
                               textColorIn: appColorRed,
                               backgroundColorIn: appColorYellow,
                               xPositionIn: eMXposition,
                               yPositionIn: eMYposition,
                               widthIn: eMWidth,
                               heightIn: eMHeight,
                               boldOrRegularIn: weightRegular,
                               fontSizeIn: labelFontSize20,
                               justifyIn: justifyCenter)
                view.addSubview(errorMessage)
                allowExitFromView = false
                aRefreshView()
            }
        }
        
        if weHaveAnError == "n" {
            let playersWithZeroPoints = checkOnly1Zero()
            //print("\(self) \(#function) - playersWithZeroPoints = \(playersWithZeroPoints)")
            if playersWithZeroPoints > 1 {
                weHaveAnError = "y"
                // Generate the upper and lower error messages
                configureLabel(labelNameIn: errorMessageTop,
                               textIn: only1ZeroMsg1,
                               textColorIn: appColorRed,
                               backgroundColorIn: appColorYellow,
                               xPositionIn: eMTXposition,
                               yPositionIn: eMTYposition,
                               widthIn: eMTWidth,
                               heightIn: eMTHeight,
                               boldOrRegularIn: weightRegular,
                               fontSizeIn: labelFontSize20,
                               justifyIn: justifyCenter)
                view.addSubview(errorMessageTop)
                // Generate the lower error message
                configureLabel(labelNameIn: errorMessage,
                               textIn: only1ZeroMsg2,
                               textColorIn: appColorRed,
                               backgroundColorIn: appColorYellow,
                               xPositionIn: eMXposition,
                               yPositionIn: eMYposition,
                               widthIn: eMWidth,
                               heightIn: eMHeight,
                               boldOrRegularIn: weightRegular,
                               fontSizeIn: labelFontSize20,
                               justifyIn: justifyCenter)
                view.addSubview(errorMessage)
                endRoundOnly1Zero = "y"
                allowExitFromView = false
                aRefreshView()
            }
        }
            
        if weHaveAnError == "n" {
            let zidx = whoHasZeroPoints()
            let clearedPhase = didPlayerClearPhase(indexIn: zidx)
            if clearedPhase == "n" {
                weHaveAnError = "y"
                // Generate the upper and lower error messages
                configureLabel(labelNameIn: errorMessageTop,
                               textIn: "Player has zero points but did not",
                               textColorIn: appColorRed,
                               backgroundColorIn: appColorYellow,
                               xPositionIn: eMTXposition,
                               yPositionIn: eMTYposition,
                               widthIn: eMTWidth,
                               heightIn: eMTHeight,
                               boldOrRegularIn: weightRegular,
                               fontSizeIn: labelFontSize20,
                               justifyIn: justifyCenter)
                view.addSubview(errorMessageTop)
                // Generate the lower error message
                configureLabel(labelNameIn: errorMessage,
                               textIn: "clear phase - this is not possible",
                               textColorIn: appColorRed,
                               backgroundColorIn: appColorYellow,
                               xPositionIn: eMXposition,
                               yPositionIn: eMYposition,
                               widthIn: eMWidth,
                               heightIn: eMHeight,
                               boldOrRegularIn: weightRegular,
                               fontSizeIn: labelFontSize20,
                               justifyIn: justifyCenter)
                view.addSubview(errorMessage)
                gdefault.clearPhaseButtonColorStatus = "one red"
                gdefault.clearPhaseButtonSpecificIndex = Int(gdefault.gamesPlayerEntryOrder[zidx])!
                //print("\(self) \(#function) - setting specific index to \(gdefault.clearPhaseButtonSpecificIndex) for player \(gdefault.gamesPlayerName[zidx])")
                allowExitFromView = false
                aRefreshView()
            }
        }

        // See if we have a game winner. If so, the players have been flagged
        // already. Force sort option so that the winners will appear first.
        // Also disable all buttons except "start over".
        //print("\(self) \(#function) - about to run soWeHaveAWinner if no error, message=\(String(describing: errorMessage.text))")
        if weHaveAnError == "n" {
            //print("\(self) \(#function) - no error detected, so run doWeHaveAWinner")
            doWeHaveAWinner()
            if gdefault.gamesGameStatus == gameCompleteStatusCode {
                //print("\(self) \(#function) - we have a winner")
                gdefault.gamesPlayerSort = playerSortHighToLow
                //print("\(self) \(#function) - disable all buttons")
                var bidx = 0
                while bidx < gdefault.gamesLengthPlayerButtonStatusOccurs {
                    gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeDisabled
                    bidx += 1
                }

                //print("\(self) \(#function) - reset skipped indicators to not skipped")
                bidx = 0
                while bidx < gdefault.gamesLengthPlayerNameOccurs {
                    gdefault.gamesPlayerSkipped[bidx] = playerIsNotSkipped
                    bidx += 1
                }

                // Update the Games file
                //print("\(self) \(#function) - updating game file due to end-of-game")
                // Get the offset of this game in the Games file
                let fileHandleTG3GamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
                let fileContent:String=String(data:fileHandleTG3GamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
                fileHandleTG3GamesGet.closeFile()
                let gameFileSize = fileContent.count
                
                var gameRecordOffset = 0
                while gameRecordOffset < gameFileSize {
                    //print("\(self) \(#function) - scanning: offset is \(gameRecordOffset)")
                    let tempGameRec = extractRecordField(recordIn: fileContent, fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
                    let thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
                    //print("\(self) \(#function) - comparing desired game \(gdefault.gamesGameName) vs. file game \(thisGameName)")
                    if thisGameName == gdefault.gamesGameName {
                        //print("\(self) \(#function) - found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                        break
                    }
                    gameRecordOffset += gdefault.gamesRecordSize
                }
                
                // Update the record and recreate the file
                //print("\(self) \(#function) - now calling updateGamesFile from TheGame with offset \(gameRecordOffset)")
                updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
                
                // Generate the upper and lower error messages
                configureLabel(labelNameIn: errorMessageTop,
                               textIn: "",
                               textColorIn: appColorWhite,
                               backgroundColorIn: appColorMediumGreen,
                               xPositionIn: eMTXposition,
                               yPositionIn: eMTYposition,
                               widthIn: eMTWidth,
                               heightIn: eMTHeight,
                               boldOrRegularIn: weightRegular,
                               fontSizeIn: labelFontSize20,
                               justifyIn: justifyCenter)
                view.addSubview(errorMessageTop)
                // Generate the lower error message
                configureLabel(labelNameIn: errorMessage,
                               textIn: "The game is over!",
                               textColorIn: appColorWhite,
                               backgroundColorIn: appColorMediumGreen,
                               xPositionIn: eMXposition,
                               yPositionIn: eMYposition,
                               widthIn: eMWidth,
                               heightIn: eMHeight,
                               boldOrRegularIn: weightRegular,
                               fontSizeIn: labelFontSize20,
                               justifyIn: justifyCenter)
                view.addSubview(errorMessage)
                allowExitFromView = false
                aRefreshView()
            }
        }
        else {
            //print("\(self) \(#function) - error was detected, so no check for winner")
        }
        
        if weHaveAnError == "n" {
            doEndOfRoundUpdates()
            // Generate the upper and lower error messages
            configureLabel(labelNameIn: errorMessageTop,
                           textIn: "End round processing is complete",
                           textColorIn: appColorWhite,
                           backgroundColorIn: appColorMediumGreen,
                           xPositionIn: eMTXposition,
                           yPositionIn: eMTYposition,
                           widthIn: eMTWidth,
                           heightIn: eMTHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessageTop)
            // Generate the lower error message
            let showRoundNumber = Int(gdefault.gamesRoundNumber)
            configureLabel(labelNameIn: errorMessage,
                           textIn: "Now starting round " + String(format: "% 2d", showRoundNumber!),
                           textColorIn: appColorWhite,
                           backgroundColorIn: appColorMediumGreen,
                           xPositionIn: eMXposition,
                           yPositionIn: eMYposition,
                           widthIn: eMWidth,
                           heightIn: eMHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessage)
            gdefault.clearPhaseButtonColorStatus = "all green"
            allowExitFromView = false
            aRefreshView()
        }
    } // End end-round button
    
    // Show this game's phases as an alert. When the user dismisses the alert, they will be returned to the game display.
    @objc func aShowPhasesClicked(_ sender: Any) {
        //print("\(self) \(#function) - Show Phases tapped")
        
        // Clear any error message
        weHaveAnError = "n"
        
        // Disallow the show phases button if the game is over
        if gdefault.gamesGameStatus == gameCompleteStatusCode {
            weHaveAnError = "y"
            //print("\(self) \(#function) - game ended already - Show Phases disallowed")
            // Generate the upper and lower error messages
            configureLabel(labelNameIn: errorMessageTop,
                           textIn: "Show Phases is not available",
                           textColorIn: appColorYellow,
                           backgroundColorIn: appColorRed,
                           xPositionIn: eMTXposition,
                           yPositionIn: eMTYposition,
                           widthIn: eMTWidth,
                           heightIn: eMTHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessageTop)
            // Generate the lower error message
            configureLabel(labelNameIn: errorMessage,
                           textIn: "The game has ended",
                           textColorIn: appColorYellow,
                           backgroundColorIn: appColorRed,
                           xPositionIn: eMXposition,
                           yPositionIn: eMYposition,
                           widthIn: eMWidth,
                           heightIn: eMHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
            view.addSubview(errorMessage)
            allowExitFromView = false
        }
        
        if weHaveAnError == "n" {
        
            //print("\(self) \(#function) - no error message - Show Phases allowed")
            // Set the width of the alert window to be most of the screen width
            let mostOfScreenWidth: Double = Double(deviceWidth) * 0.90
            
            // Set the icon image size
            let alertViewIconSize = 35.0
            
            // Set the alert window text size
            let alertViewFont = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            var alertFontSize : CGFloat = 0
            if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
                alertFontSize = 14
            }
            else {
                alertFontSize = 16
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
            let alertViewHeading = "Current Phases In Use\n(To print: Use Edit Game / Print Phase Cards)\n"
            
            // Green icon and button background
            let alertViewBackgroundIconButtonColor = UInt(appColorGreenHex)
            
            // Generate the phases
            // Add phase names 1 - 10 (but only those in use based on the
            // phase modifier, i.e., show all, or just the odd phases, or
            // just the even phases as appropriate).
            var gamePhaseName = ""
            
            // Note that the spaces being pre- and post-pended to each phase could be changed
            // to a different character if desired
            switch gdefault.gamesPhaseModifier {
            case allPhasesCode:
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase1)
                nextPhaseLine[0] = String("  1. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase2)
                nextPhaseLine[1] = String("  2. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase3)
                nextPhaseLine[2] = String("  3. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase4)
                nextPhaseLine[3] = String("  4. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase5)
                nextPhaseLine[4] = String("  5. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase6)
                nextPhaseLine[5] = String("  6. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase7)
                nextPhaseLine[6] = String("  7. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase8)
                nextPhaseLine[7] = String("  8. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase9)
                nextPhaseLine[8] = String("  9. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase10)
                nextPhaseLine[9] = String("  10. ") + gamePhaseName + "  "
                
            case oddPhasesCode:
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase1)
                nextPhaseLine[0] = String("  1. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase3)
                nextPhaseLine[1] = String("  3. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase5)
                nextPhaseLine[2] = String("  5. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase7)
                nextPhaseLine[3] = String("  7. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase9)
                nextPhaseLine[4] = String("  9. ") + gamePhaseName + "  "
                nextPhaseLine[5] = " "
                nextPhaseLine[6] = " "
                nextPhaseLine[7] = " "
                nextPhaseLine[8] = " "
                nextPhaseLine[9] = " "
            case evenPhasesCode:
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase2)
                nextPhaseLine[0] = String("  2. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase4)
                nextPhaseLine[1] = String("  4. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase6)
                nextPhaseLine[2] = String("  6. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase8)
                nextPhaseLine[3] = String("  8. ") + gamePhaseName + "  "
                gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase10)
                nextPhaseLine[4] = String("  10. ") + gamePhaseName + "  "
                nextPhaseLine[5] = " "
                nextPhaseLine[6] = " "
                nextPhaseLine[7] = " "
                nextPhaseLine[8] = " "
                nextPhaseLine[9] = " "
            default:
                _ = ""
            }
            
            /*
            // This section (which is currently commented out) is used to pad each phase line with a non-blank character
            // at the beginning and end of each phase
             
            // Determine the length of the longest line
            var pidx = 0
            var longestPhaseName = 0
            var thisPhaseNameLength = 0
            var fillPhaseNameLength = 0
            var paddedPhaseName = ""
            var reversedPhaseName = ""
            while pidx < 10 {
                thisPhaseNameLength = nextPhaseLine[pidx].count
                if thisPhaseNameLength > longestPhaseName {
                    longestPhaseName = thisPhaseNameLength
                }
                pidx += 1
            }
            
            // Pad each end of the phase names with "~" characters so that they all have the same (longest) length
            // Note that the phase name itself will be centered (because that's what SCLAlertView does)
            // PADDINGPADDING
            pidx = 0
            while pidx < 10 {
                thisPhaseNameLength = nextPhaseLine[pidx].count
                if thisPhaseNameLength < longestPhaseName {
                    fillPhaseNameLength = ((longestPhaseName - thisPhaseNameLength) / 2) + thisPhaseNameLength
                    let originalPhaseName = nextPhaseLine[pidx]
                    paddedPhaseName = originalPhaseName.padding(toLength: fillPhaseNameLength, withPad: " ~", startingAt: 0)
                    reversedPhaseName = String(paddedPhaseName.reversed())
                    fillPhaseNameLength = longestPhaseName - fillPhaseNameLength
                    paddedPhaseName = reversedPhaseName.padding(toLength: longestPhaseName, withPad: "~ ", startingAt: 0)
                    reversedPhaseName = String(paddedPhaseName.reversed())
                    nextPhaseLine[pidx] = reversedPhaseName
                }
                pidx += 1
            }
             
            // This is the end of the phase line padding section
            */
            
            // Build all the phase information
            let thePhases = nextPhaseLine[0] + "\n" + nextPhaseLine[1] + "\n" + nextPhaseLine[2] + "\n" + nextPhaseLine[3] + "\n" + nextPhaseLine[4] + "\n" + nextPhaseLine[5] + "\n" + nextPhaseLine[6] + "\n" + nextPhaseLine[7] + "\n" + nextPhaseLine[8] + "\n" + nextPhaseLine[9] + "\n"
            
            // Show the alert
            alertView.showTitle(alertViewHeading, subTitle: thePhases, style: .info, colorStyle: alertViewBackgroundIconButtonColor, colorTextButton: UInt(appColorBlackHex), circleIconImage: alertViewIcon)
        }
        //else {
            //print("\(self) \(#function) - error message detected - Show Phases not allowed")
        //}
    }

    @objc func aEditGameClicked(_ sender: Any) {
        weHaveAnError = "n"
        // Disallow the edit game button if the game is over
        if gdefault.gamesGameStatus == gameCompleteStatusCode {
            weHaveAnError = "y"
            // Generate the upper and lower error messages
            configureLabel(labelNameIn: errorMessageTop,
                           textIn: "Edit Game is not available",
                           textColorIn: appColorYellow,
                           backgroundColorIn: appColorRed,
                           xPositionIn: eMTXposition,
                           yPositionIn: eMTYposition,
                           widthIn: eMTWidth,
                           heightIn: eMTHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
             view.addSubview(errorMessageTop)
             // Generate the lower error message
             configureLabel(labelNameIn: errorMessage,
                           textIn: "The game has ended",
                           textColorIn: appColorYellow,
                           backgroundColorIn: appColorRed,
                           xPositionIn: eMXposition,
                           yPositionIn: eMYposition,
                           widthIn: eMWidth,
                           heightIn: eMHeight,
                           boldOrRegularIn: weightRegular,
                           fontSizeIn: labelFontSize20,
                           justifyIn: justifyCenter)
             view.addSubview(errorMessage)
             allowExitFromView = false
        }
        else {
            allowExitFromView = true
            weHaveAnError = "n"
        }
    }

    @objc func aStartOverClicked(_ sender: Any) {
        //print("\(self) \(#function) - pressing Start Over button --")
        //print("\(self) \(#function) - setting backward movement direction to ViewController target")
        
        // If we have a winner and the user is exiting, ask for a rating
        if gdefault.gamesGameStatus == gameCompleteStatusCode {
            
            // Establish review service
            let reviewService = ReviewService.shared
                    
            // Send user to Apple to leave a written review (not just stars)
            // Note that this review may be done as often as the user desires
            let deadline = DispatchTime.now()
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                [weak self] in reviewService.requestReview(isWrittenReview: true)
            }
        }
        gdefault.startOverTarget = VCTarget
        // Always allow the user to start over
        allowExitFromView = true
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        
        //print("\(self) \(#function) - start vDL")
        super.viewDidLoad()
/*
        // Do any additional setup after loading the view.
        //print("\(self) \(#function) - clearing error message")
        // Initialize error message
        errorMessage.text = ""
        errorMessageTop.text = ""
           
        // Make the error message have bold text
        errorMessage.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
        errorMessageTop.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
        
        // Set 2/3 screen game offset based on device size
        if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
            twoThirdsScreen = twoThirdsSmallGameScreen
        }
        else {
            twoThirdsScreen = twoThirdsLargeGameScreen
        }
        
        gameStatusTextview.delegate = self
        */
        continueToHelp = false
        allowExitFromView = false
        
        //print("\(self) \(#function) - pts array \(gdefault.gamesPlayerPoints)")
        //print("\(self) \(#function) - SOR array \(gdefault.gamesPlayerStartRoundPoints)")
        
        //print("\(self) \(#function) - end vDL")
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
        //print("\(self) \(#function) - start vWA")
        //print("\(self) \(#function) - vWA button statuses=\(gdefault.gamesPlayerButtonStatus)")
        //print("\(self) \(#function) - calling aRefreshView")
        aRefreshView()
        //print("\(self) \(#function) - after calling aRefreshView")
    }
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > CGFloat(resetGamePosition) {
            let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                scrollView.isScrollEnabled = false
                scrollView.setContentOffset(CGPoint(x:0, y:self.resetGamePosition), animated: false)
                scrollView.isScrollEnabled = true
            }
            anim.startAnimation()
        }
    }
    */
    
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
