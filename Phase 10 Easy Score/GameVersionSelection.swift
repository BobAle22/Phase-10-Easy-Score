//
//  GameVersionSelection.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 2/24/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import SCLAlertView
import UIKit

class GameVersionSelection: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var gameVersionPicker: UIPickerView!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    @IBOutlet weak var aQuickViewButton: UIButton!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!

    // Anchor to return to this view from anywhere
    @IBAction func unwindToGameVersionSelection(sender: UIStoryboardSegue) {
    }
    
    // Game version names are placed here to source the picker view
    
    var versions = [String]()
    var theRow = 0

    func numberOfComponents(in gameVersionPicker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ gameVersionPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return versions.count
    }

    func pickerView(_ gameVersionPicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return versions[row]
    }
       
    // This is the selected row from the picker view
       
    func pickerView(_ gameVersionPicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        theRow = row
    }
    
    // This is the picker view row height
    
    func pickerView(_ gameVersionPicker: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 56.0
    }
    
    // Give the picker view background a color from the icon's colors. There are five colors in the icon, so repeat the first color again after each set of five is used. Also set the text color to black or white depending on the background.
    
    func pickerView(_ gameVersionPicker: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
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
            
        let titleData:String = "     " + versions[row]

        pickerLabel?.text = titleData
        //pickerLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
            
        return pickerLabel!
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        //print("GVS vWA startOverTarget was \(gdefault.startOverTarget)")
        //print("GVS vWA updateTarget was \(gdefault.updateTarget)")
        if gdefault.startOverTarget == VCTarget ||
            gdefault.updateTarget == EGTarget ||
            gdefault.updateTarget == DSTarget {
                //print("GVS vWA hiding view (scrolling backward to the beginning)")
                self.view.isHidden = true
        }
        //else {
            //print("GVS vWA not hiding view (scrolling forward)")
        //}
        
        refreshView()
    
        super.viewWillAppear(animated)
    } // End viewWillAppear
    
    func refreshView () {
        
        versions.removeAll()
            
        // Retrieve all the game version names and store them in the versions array
        // Game versions are type G, Phases are type P, and the array end is type X
        
        var vcount = 0
        var nameType = ""
        repeat {
            let gamePhaseEntry = gamesAndPhases[vcount]
            var sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 0)
            var eidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
            var range = sidx ..< eidx
            nameType = String(gamePhaseEntry[range])
            if nameType == gamesAndPhasesGame {
                sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
                eidx = gamePhaseEntry.endIndex
                range = sidx ..< eidx
                versions.append(String(gamePhaseEntry[range]))
            }
            vcount += 1
        } // End search loop
        while !(nameType == gamesAndPhasesEnd)
        
        self.gameVersionPicker.reloadAllComponents()
    
        self.gameVersionPicker.selectRow(theRow, inComponent: 0, animated: false)
        self.pickerView(self.gameVersionPicker, didSelectRow: theRow, inComponent: 0)
    }
    
    // Show the phases of the game that's currently in the selection window
    // Overall, show the game name and all the phases
    @IBAction func aQuickViewButton(_ sender: Any) {
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
        
        var thisGame = "GAME"
        
        //let selectedRow = String(format: "%03d", theRow)
        //print("GVS aQV getting game version name for row \(selectedRow)")
        
        // First get the number associated with this row's game version name
        let thisGameVersion = retrieveActualGameVersionNumber(nameIn: versions[theRow])
        //print("GVS aQV converted row \(selectedRow) to game version number \(thisGameVersion)")
        
        // Then save this game's name from the picker array
        let gameVersionName = versions[theRow]
        
        thisGame = thisGame + "\n" + gameVersionName + "\n\nPHASES\n"
        
        // For all games except "U Pick 10", load associated phase names 1-10
        // But for "U Pickk 10", count the number of phases that are available
        // for selection and just show that number
        var nextPhaseLine = ""
        if !(gameVersionName == uPick10) {
            var thisPhaseNumber = Int(thisGameVersion)! + 1
            var gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
            nextPhaseLine = String("1  ") + gamePhaseName

            thisPhaseNumber = Int(thisGameVersion)! + 2
            gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
            nextPhaseLine = nextPhaseLine + String("\n2  ") + gamePhaseName
            
            thisPhaseNumber = Int(thisGameVersion)! + 3
            gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
            nextPhaseLine = nextPhaseLine + String("\n3  ") + gamePhaseName
            
            thisPhaseNumber = Int(thisGameVersion)! + 4
            gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
            nextPhaseLine = nextPhaseLine + String("\n4  ") + gamePhaseName
            
            thisPhaseNumber = Int(thisGameVersion)! + 5
            gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
            nextPhaseLine = nextPhaseLine + String("\n5  ") + gamePhaseName
            
            thisPhaseNumber = Int(thisGameVersion)! + 6
            gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
            nextPhaseLine = nextPhaseLine + String("\n6  ") + gamePhaseName
            
            thisPhaseNumber = Int(thisGameVersion)! + 7
            gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
            nextPhaseLine = nextPhaseLine + String("\n7  ") + gamePhaseName
            
            thisPhaseNumber = Int(thisGameVersion)! + 8
            gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
            nextPhaseLine = nextPhaseLine + String("\n8  ") + gamePhaseName
            
            thisPhaseNumber = Int(thisGameVersion)! + 9
            gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
            nextPhaseLine = nextPhaseLine + String("\n9  ") + gamePhaseName
            
            thisPhaseNumber = Int(thisGameVersion)! + 10
            gamePhaseName = retrieveGamePhaseName(numberIn: String(thisPhaseNumber))
            nextPhaseLine = nextPhaseLine + String("\n10  ") + gamePhaseName
        }
        else {
            // First acquire the U Pick 10 version number
                   
            var pcount = Int(retrieveActualGameVersionNumber(nameIn: uPick10))
            var phaseCount = 0

            // Now count its phases
                   
            var nameType = ""
            repeat {
                let gamePhaseEntry = gamesAndPhases[pcount!]
                let sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 0)
                let eidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
                let range = sidx ..< eidx
                nameType = String(gamePhaseEntry[range])
                if nameType == gamesAndPhasesPhase {
                    phaseCount += 1
                }
                pcount! += 1
            } // End search loop
            while !(nameType == gamesAndPhasesEnd)
            nextPhaseLine = "There are " + String(phaseCount) + " phases\navailable for selection."
        }
        
        thisGame = thisGame + nextPhaseLine
        
        // Show the alert
        alertView.showTitle(alertViewHeading, subTitle: thisGame, style: .info, colorStyle: alertViewBackgroundIconButtonColor, colorTextButton: UInt(appColorBlackHex), circleIconImage: alertViewIcon)
        
    }
    
    
    
    @IBAction func aViewTutorialButton(_ sender: Any) {
        gdefault.helpCaller = helpSectionCodeGameVersionSelection
    }
    
    @IBAction func returnButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    // The user has chosen a game version. If it is any version other than
    // "U Pick 10", proceed to GameVersionConfirmation via segue GVStoGVC.
    // However, if it is "U Pick 10", proceed to UPick10PhaseSelection
    // instead via link GVStoUP10PS.
    
    @IBAction func chooseButton(_ sender: Any) {

        // This module can run either on behalf of Defaults or EditGame.
        // This variable will be set for use within this module based
        // on which is the current environment.
        // Also save the game version for reiinstatememnt in case the user
        // cancels in UPick10
        let thisGameVersion = retrieveActualGameVersionNumber(nameIn: versions[theRow])
        
        switch gdefault.gameVersionConfirmationDecisionDriverView {
        case "Defaults":
            //print("GVS cB setting default version=\(thisGameVersion)")
            //print("GVS cB saving preUP10 default version of \(gdefault.defaultsGameVersion)")
            //print("GVS cB saving preUP10 default phase modifier=\(gdefault.defaultsPhaseModifier)")
            gdefault.preUP10Version = gdefault.defaultsGameVersion
            gdefault.preUP10PhaseModifier = gdefault.defaultsPhaseModifier
            gdefault.defaultsGameVersion = thisGameVersion
        case "EditGame":
            //print("GVS cB setting game ver=\(thisGameVersion)")
            //print("GVS cB saving preUP10 game version=\(gdefault.gamesGameVersion)")
            //print("GVS cB saving preUP10 game phase modifier=\(gdefault.gamesPhaseModifier)")
            gdefault.preUP10Version = gdefault.gamesGameVersion
            gdefault.preUP10PhaseModifier = gdefault.gamesPhaseModifier
            gdefault.gamesGameVersion = thisGameVersion
        default:
            _ = ""
        }
        
        if !(versions[theRow] == uPick10) {
            //print("GVS cB proceeding to GameVersionConfirmation")
            self.performSegue(withIdentifier: "GVStoGVC", sender: Any?.self)
        }
        else {
            //print("GVS cB proceeding to UPick10PhaseSelection")
            self.performSegue(withIdentifier: "GVStoUP10PS", sender: Any?.self)
        }
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
        returnButton.layer.cornerRadius = cornerRadiusStdButton
        chooseButton.layer.cornerRadius = cornerRadiusStdButton
        aQuickViewButton.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton

        gameVersionPicker.delegate = self
        gameVersionPicker.dataSource = self
        
    } // End viewDidLoad
     
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
