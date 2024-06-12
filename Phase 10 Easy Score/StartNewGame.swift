//
//  StartNewGame.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 3/25/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import UIKit

class StartNewGame: UIViewController {

    @IBOutlet weak var aStartFromScratch: UIButton!
    @IBOutlet weak var copyPlayers: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBAction func aViewTutorialButton(_ sender: Any) {
        gdefault.helpCaller = helpSectionCodeStartANewGame
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
        // Initialize error message
        errorMessage.text = ""
           
        // Make the error message have bold text
        errorMessage.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)

        // Round the button corners
        aStartFromScratch.layer.cornerRadius = cornerRadiusStdButton
        copyPlayers.layer.cornerRadius = cornerRadiusStdButton
        cancelButton.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton
    }

    override func viewWillAppear(_ animated: Bool) {
        
        //print("SNG start vWA")
        
        // Hide this view if we're scrolling backward to the beginning
        //print("SNG vWA startOver was \(gdefault.startOverTarget)")
        if gdefault.startOverTarget == VCTarget {
            //print("SNG vWA hiding view (scrolling backward to the beginning)")
            self.view.isHidden = true
        }
        //else {
            //print("SNG vWA not hiding view (scrolling forward)")
        //}
    
        super.viewWillAppear(animated)
        
        //print("SNG end vWA")
    } // End viewWillAppear
    
    @IBAction func aStartFromScratch(_ sender: Any) {
        
        // Get the dummy Games record and retrieve all the empty player data
        // to clear this game's global player storage.
        let fileHandleSNGGamesPDGet:FileHandle=FileHandle(forReadingAtPath:gamesFileURL.path)!
        let filePlayerContent:String=String(data: fileHandleSNGGamesPDGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleSNGGamesPDGet.closeFile()
        let holdFileForPlayerData = filePlayerContent
        
        // Extract the following cleared player fields from the dummy Games
        // record and put them into global storage: name, entry order, dealer
        // order, current dealer, choose phase, points, round number, round status,
        // and game status. Also enable all player buttons.
        
        var pcount = 0
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            gdefault.gamesPlayerName[pcount] = extractRecordField(recordIn: holdFileForPlayerData, fieldOffset: gdefault.gamesOffsetPlayerName + (pcount * gdefault.gamesLengthPlayerName), fieldLength: gdefault.gamesLengthPlayerName)
            //print("VC extracted player name \(pcount)=\(gdefault.gamesPlayerName[pcount])")
            pcount+=1
        }
        pcount = 0
        while pcount < gdefault.gamesLengthPlayerEntryOrderOccurs {
            gdefault.gamesPlayerEntryOrder[pcount] = extractRecordField(recordIn: holdFileForPlayerData, fieldOffset: gdefault.gamesOffsetPlayerEntryOrder + (pcount * gdefault.gamesLengthPlayerEntryOrder), fieldLength: gdefault.gamesLengthPlayerEntryOrder)
            //print("VC extracted player entry order \(pcount)=\(gdefault.gamesPlayerEntryOrder[pcount])")
            pcount+=1
        }
        pcount = 0
        while pcount < gdefault.gamesLengthPlayerDealerOrderOccurs {
            gdefault.gamesPlayerDealerOrder[pcount] = extractRecordField(recordIn: holdFileForPlayerData, fieldOffset: gdefault.gamesOffsetPlayerDealerOrder + (pcount * gdefault.gamesLengthPlayerDealerOrder), fieldLength: gdefault.gamesLengthPlayerDealerOrder)
            //print("VC extracted player Dealer order \(pcount)=\(gdefault.gamesPlayerDealerOrder[pcount])")
            pcount+=1
        }

        gdefault.gamesCurrentDealer = extractRecordField(recordIn: holdFileForPlayerData, fieldOffset: gdefault.gamesOffsetCurrentDealer, fieldLength: gdefault.gamesLengthCurrentDealer)
        //print("VC extracted dealer=\(gdefault.gamesCurrentDealer)")
        
        pcount = 0
        while pcount < gdefault.gamesLengthPlayerChoosesPhaseOccurs {
            gdefault.gamesPlayerChoosesPhase[pcount] = extractRecordField(recordIn: holdFileForPlayerData, fieldOffset: gdefault.gamesOffsetPlayerChoosesPhase + (pcount * gdefault.gamesLengthPlayerChoosesPhase), fieldLength: gdefault.gamesLengthPlayerChoosesPhase)
            //print("VC extracted player chooses phase \(pcount)=\(gdefault.gamesPlayerChoosesPhase[pcount])")
            pcount+=1
        }
        
        pcount = 0
        while pcount < gdefault.gamesLengthPlayerPointsOccurs {
            gdefault.gamesPlayerPoints[pcount] = extractRecordField(recordIn: holdFileForPlayerData, fieldOffset: gdefault.gamesOffsetPlayerPoints + (pcount * gdefault.gamesLengthPlayerPoints), fieldLength: gdefault.gamesLengthPlayerPoints)
            //print("VC extracted player points \(pcount)=\(gdefault.gamesPlayerPoints[pcount])")
            pcount+=1
        }
        
        gdefault.gamesRoundNumber = extractRecordField(recordIn: holdFileForPlayerData, fieldOffset: gdefault.gamesOffsetRoundNumber, fieldLength: gdefault.gamesLengthRoundNumber)
        //print("VC extracted round number=\(gdefault.gamesRoundNumber)")
        
        gdefault.gamesRoundStatus = extractRecordField(recordIn: holdFileForPlayerData, fieldOffset: gdefault.gamesOffsetRoundStatus, fieldLength: gdefault.gamesLengthRoundStatus)
        //print("VC extracted round status=\(gdefault.gamesRoundStatus)")
        
        gdefault.gamesGameStatus = extractRecordField(recordIn: holdFileForPlayerData, fieldOffset: gdefault.gamesOffsetGameStatus, fieldLength: gdefault.gamesLengthGameStatus)
        //print("VC extracted game status=\(gdefault.gamesGameStatus)")
        
        // Construct the new game name
        let gameName = makeAGameName()
        
        gdefault.gamesGameName = gameName

        // Load the default phases, phase modifier, dealer tracking indicator, and player sort
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

        pcount = 0
        //print("SNG setting all players phase 1 to \(gdefault.defaultsPhase1) and phase 2 to \(gdefault.defaultsPhase2)")
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
        //print("SNG set up SOR phases")
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            //print("SNG ix=\(pcount) choose=\(gdefault.gamesPlayerChoosesPhase[pcount])")
            if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                //print("SNG modifier=\(gdefault.gamesPhaseModifier)")
                if gdefault.gamesPhaseModifier == evenPhasesCode {
                    //print("SNG even phase2=\(gdefault.gamesPlayerPhase2[pcount]) SOR phase=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                    //print("SNG resetting SOR phase to phase 2 (\(gdefault.gamesPlayerPhase2[pcount]))")
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase2[pcount]
                }
                else {
                    //print("SNG odd/all phase1=\(gdefault.gamesPlayerPhase1[pcount]) SOR phase=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                    //print("SNG resetting SOR phase to phase 1 (\(gdefault.gamesPlayerPhase1[pcount]))")
                    gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase1[pcount]
                }
            }
            pcount += 1
        }
        
        // Initialize start-of-round points
        pcount = 0
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            gdefault.gamesPlayerStartRoundPoints[pcount] = zeroPoints
            pcount += 1
        }
        
        // Initialize player winner status indicator
        pcount = 0
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            gdefault.gamesPlayerWinner[pcount] = "n"
            pcount += 1
        }
        //gdefault.gamesGameStatus = "n"
        
        // Set all global player buttons status codes to e (enabled), all clear phase button status
        // colors to "all green" (standard colors), all player point status codes to s (standard colors),
        // and all player skipped indicators to n (not skipped)
        //print("SNG aSFS initialize all 60 playerbuttonstatus values to e")
        var bidx = 0
        while bidx < gdefault.gamesLengthPlayerButtonStatusOccurs {
            gdefault.gamesPlayerButtonStatus[bidx] = buttonCodeEnabled
            bidx += 1
        }
        bidx = 0
        while bidx < gdefault.gamesLengthPlayerPointsOccurs {
            gdefault.gamesPlayerPointsStatus[bidx] = pointsStatusStandard
            bidx += 1
        }
        bidx = 0
        while bidx < gdefault.gamesLengthPlayerPointsOccurs {
            gdefault.gamesPlayerPointsStatusEntry[bidx] = "00"
            bidx += 1
        }
        bidx = 0
        while bidx < gdefault.gamesLengthPlayerSkippedOccurs {
            gdefault.gamesPlayerSkipped[bidx] = playerIsNotSkipped
            bidx += 1
        }
        gdefault.clearPhaseButtonColorStatus = "all green"
        
        let gamesText = loadGamesRecordFromGlobal(fileLevelIn: outputGamesFileLevel, gameNameIn: gameName)
        
        // Write the new Games record at the end of the file
        let fileHandleSNGGamesUpdate:FileHandle=FileHandle(forUpdatingAtPath:gamesFileURL.path)!
        fileHandleSNGGamesUpdate.seekToEndOfFile()
        fileHandleSNGGamesUpdate.write(gamesText.data(using: String.Encoding.utf8)!)
        fileHandleSNGGamesUpdate.closeFile()
        //print("SNG writing new Games record at eof for game \(gameName)")
        
        // Create a History file record for this game at the end of the History file
        // file
        let historyText = initHistoryRecord(fileLevelIn: outputHistoryFileLevel, gameNameIn: gdefault.gamesGameName)
        let fileHandleSNGHistoryUpdate:FileHandle=FileHandle(forUpdatingAtPath:historyFileURL.path)!
        fileHandleSNGHistoryUpdate.seekToEndOfFile()
        fileHandleSNGHistoryUpdate.write(historyText.data(using: String.Encoding.utf8)!)
        fileHandleSNGHistoryUpdate.closeFile()
        //print("SNG writing new History record at eof for game \(gdefault.gamesGameName)")
        
        // Generate TheGame screen
        aCreateView()
        aCreateController()
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
        vc.returnToStartNewGame = { [weak self] in
            // unwrap optional
            guard let self = self else { return }
            remove(child: vc)
            scrollView.removeFromSuperview()
        }
    }

    // Set 2nd half of the instructions to appear on the next screen
    @IBAction func copyPlayersButton(_ sender: Any) {
        gdefault.availableGameChoiceInstructions = "Copy its Players"
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
