//
//  EditGame.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 4/12/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
// 

import UIKit
import PDFKit

class CreatePDF: NSObject {
    let phaseSectionHeader: String
    let phaseSectionBody: String
    let imageSection: UIImage
  
    init(phasesHeader: String, phasesBody: String, image: UIImage) {
        self.phaseSectionHeader = phasesHeader
        self.phaseSectionBody = phasesBody
        self.imageSection = image
}
    
    // Generate the phase cards by building a PDF witrh images and text
    func createPhaseCardReport() -> Data {
        let pdfMetaData = [kCGPDFContextCreator: "Phase 10 Phase Cards",
                           kCGPDFContextAuthor: "Phase 10 Easy Score"]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        let data = renderer.pdfData { (context) in
            context.beginPage()
            addPhaseCardVerticalCutLine(pageRect: pageRect, dividerNumber: 1)
            addPhaseCardVerticalCutLine(pageRect: pageRect, dividerNumber: 2)
            addPhaseCardHorizontalCutLine(pageRect: pageRect)
            var imageBottom = addAnImage(pageRect: pageRect, imageTop: 0.0, columnNumber: 1)
            let _ = addAnImage(pageRect: pageRect, imageTop: 0.0, columnNumber: 2)
            let _ = addAnImage(pageRect: pageRect, imageTop: 0.0, columnNumber: 3)
            //print("After image additions ... imageBottom=\(imageBottom)")
            var textBottom = addPhaseText(pageRect: pageRect, textTop: imageBottom, topOrBottom: "t", columnNumber: 1)
            let _ = addPhaseText(pageRect: pageRect, textTop: imageBottom, topOrBottom: "t", columnNumber: 2)
            let _ = addPhaseText(pageRect: pageRect, textTop: imageBottom, topOrBottom: "t", columnNumber: 3)
            //print("After text addition ... textBottom=\(textBottom)")
            imageBottom = addAnImage(pageRect: pageRect, imageTop: textBottom + 0.0, columnNumber: 1)
            let _ = addAnImage(pageRect: pageRect, imageTop: textBottom + 0.0, columnNumber: 2)
            let _ = addAnImage(pageRect: pageRect, imageTop: textBottom + 0.0, columnNumber: 3)
            //print("After image additions 2 ... imageBottom=\(imageBottom)")
            textBottom = addPhaseText(pageRect: pageRect, textTop: imageBottom, topOrBottom: "b", columnNumber: 1)
            let _ = addPhaseText(pageRect: pageRect, textTop: imageBottom, topOrBottom: "b", columnNumber: 2)
            let _ = addPhaseText(pageRect: pageRect, textTop: imageBottom, topOrBottom: "b", columnNumber: 3)
            //print("After text addition 2 ... textBottom=\(textBottom)")
        }
        return data
    }
    
    // Draw a vertical cut line from the top to the bottom of the page at the requested horizontal position
    
    func addPhaseCardVerticalCutLine(pageRect: CGRect, dividerNumber: Int) {
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                              NSAttributedString.Key.font: textFont]
        var verticalDivider = ""
        var dividerCount = 0
        while dividerCount < 55 {
            verticalDivider = verticalDivider + "|\n"
            dividerCount += 1
        }
        let attributedText = NSAttributedString(string: verticalDivider, attributes: textAttributes)
        var textHeight: CGFloat = 0.0
        textHeight = pageRect.height
        
        let xPosition:CGFloat = pageRect.width / 3 * CGFloat(dividerNumber)
        let textRect = CGRect(x: xPosition, y: 0.0, width: 2,
                              height: textHeight)
        attributedText.draw(in: textRect)
        return
    }
    
    // Draw a horizontal cut line from the left to the right side of the page at the vertical midpoint of the page
    
    func addPhaseCardHorizontalCutLine(pageRect: CGRect) {
        let textTop = pageRect.height / 2.0
        let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textAttributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                              NSAttributedString.Key.font: textFont]
        var horizontalDivider = ""
        var dividerCount = 0
        while dividerCount < 109 {
            horizontalDivider = horizontalDivider + "-"
            dividerCount += 1
        }
        let attributedText = NSAttributedString(string: horizontalDivider, attributes: textAttributes)
        let textRect = CGRect(x: 0.0, y: textTop, width: pageRect.width,
                              height: 5.0)
        attributedText.draw(in: textRect)
        return
    }
    
    // Draw the Phase 10 Easy Score icon centered toward the top of the phase card
    // Use the page size and the requested column (1, 2, or 3) to determine the location
    // The bottom position of the image is returned
    func addAnImage (pageRect: CGRect, imageTop: CGFloat, columnNumber: Int) -> CGFloat {
        // Determine and set the location and size
        let adjustedTop = imageTop + 18.0
        let maxHeight = pageRect.height * 0.05
        let maxWidth = pageRect.width * 0.1
        let aspectWidth = maxWidth / imageSection.size.width
        let aspectHeight = maxHeight / imageSection.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)
        let scaledWidth = imageSection.size.width * aspectRatio
        let scaledHeight = imageSection.size.height * aspectRatio
        let imageXStart: CGFloat = ((pageRect.width / 3) - scaledWidth) / 2
        var imageX: CGFloat = 1.0
        switch columnNumber {
        case 1:
            imageX = imageXStart
        case 2:
            imageX = (imageXStart * 3) + scaledWidth
        case 3:
            imageX = (imageXStart * 5) + (scaledWidth * 2)
        default:
            _ = ""
        }
        //print("Image ... imageTop=\(imageTop) adjTop=\(adjustedTop) page height=\(pageRect.height)")
        //print("c=\(columnNumber) w=\(pageRect.width) sw=\(scaledWidth) sh=\(scaledHeight) ix=\(imageX)")
        let imageRect = CGRect(x: imageX, y: adjustedTop,
                               width: scaledWidth, height: scaledHeight)
        imageSection.draw(in: imageRect)
        return imageRect.origin.y + imageRect.size.height
    }
    
    // Draw a text box containing the game name, version, phase modifier, and phases
    // Locate it slightly below the requested top location
    // Use the page size, top/bottom page half, and the requested column (1, 2, or 3) to determine the location
    // The phase header area is bold, the phase body area is regular
    // The bottom position of the text is returned
    
    func addPhaseText(pageRect: CGRect, textTop: CGFloat, topOrBottom: String, columnNumber: Int) -> CGFloat {
        
        let adjustedTop = textTop + 18.0
        
        let textFontBold = UIFont(name: "Courier-Bold", size: 12)
        let textFontRegular = UIFont(name: "Courier", size: 12)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let textAttributesBold = [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                              NSAttributedString.Key.font: textFontBold]
        let textAttributesRegular = [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                              NSAttributedString.Key.font: textFontRegular]
        
        
        let attributedTextBold = NSMutableAttributedString(string: phaseSectionHeader, attributes: textAttributesBold as [NSAttributedString.Key : Any])
        let attributedTextRegular = NSAttributedString(string: phaseSectionBody, attributes: textAttributesRegular as [NSAttributedString.Key : Any])
        
        let combination = NSMutableAttributedString()
        
        combination.append(attributedTextBold)
        combination.append(attributedTextRegular)
        
        let imageXStart: CGFloat = pageRect.width / 3.0
        var imageX: CGFloat = 12.0
        switch columnNumber {
        case 1:
            imageX = 12.0
        case 2:
            imageX = imageXStart + 10.0
        case 3:
            imageX = (imageXStart * 2) + 10.0
        default:
            _ = ""
        }
        var textHeight: CGFloat = 0.0
        switch topOrBottom {
        case "t":
            textHeight = (pageRect.height / 2.0 - textTop)
        case "b":
            textHeight = pageRect.height - textTop
        default:
            _ = ""
        }
        let textRect = CGRect(x: imageX, y: adjustedTop, width: pageRect.width / 3.0,
                              height: textHeight)
        combination.draw(in: textRect)
        //print("Text ... textTop=\(textTop) adjTop=\(adjustedTop) page height=\(pageRect.height) text height=\(textHeight) xPos=\(imageX)")
        return textTop + (pageRect.height / 2.0 - textTop)
    }
}

class EditGame: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var gameName: UITextField!
    @IBOutlet weak var trackDealerSwitch: UISlider!
    @IBOutlet weak var trackDealerNo: UILabel!
    @IBOutlet weak var trackDealerYes: UILabel!
    @IBOutlet weak var gameVersionButton: UIButton!
    @IBOutlet weak var aDoneButton: UIButton!
    @IBOutlet weak var aPrintPhaseCardsButton: UIButton!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
        
    var holdGamesFile = ""
    var tempGameRec = ""
    var fileGameName = ""
    var gameFileSize = 0
    
    // This is the original name of the game being edited
    var originalGameName = ""
    
    // Controls whether or not user is allowed to exit (via the Choose button)
    var allowExitFromView = false
    
    // Used in conjunction with allowExitFromView -- specifically to allow
    // access to the help screen
    var continueToHelp = false
    
    // Controls whether or not game version button and game name text
    // field are active
    // e=enabled, d=disabled
    var gameVersionButtonStatus = buttonCodeEnabled
    
    var theGameName = ""
    var thisGameName = ""

    // Anchor to return to this view from anywhere
    @IBAction func unwindToEditGame(sender: UIStoryboardSegue) {
    }

    // Function to add a "done" button on the game name keyboard
    // (specifically for the numeric keyboard that has no "done" button.
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(EditGame.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.gameName.inputAccessoryView = doneToolbar
    }
    
    // Make the keyboard with the newly-added done button disappear
    @objc func doneButtonAction () {
        self.gameName.resignFirstResponder()
    }
    
    // This function makes the keyboard disappear when the done key is pressed
    // on the keyboard when entering the game name. This is used only for
    // the game name.
    @IBAction func hideGameNameKeyboard(_ sender: Any) {
        gameName.resignFirstResponder()
    }
    
    // Game name is mandatory, maximum 15 characters, must contain only
    // letters, numbers, and spaces, and must be different from all other
    // games. It may be changed at any time.
    @IBAction func gameName(_ sender: Any) {

        errorMessage.text = ""
        allowExitFromView = true
        continueToHelp = false
        
        let tempGameName = gameName.text
        theGameName = ""
        
        if errorMessage.text == "" {
            if tempGameName!.count == 0 {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Game name missing"
            }
            else if tempGameName!.count > gdefault.gamesLengthGameName {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text = "Game name size max " + String(gdefault.gamesLengthGameName)
            }
            else {
                theGameName = tempGameName!.padding(toLength: gdefault.gamesLengthGameName, withPad: " ", startingAt: 0)
                //print("EG gN name=<\(String(describing: theGameName)) len=\(theGameName.count)")
                let regex = try! NSRegularExpression(pattern: " ")
                let numberOfBlanks = regex.numberOfMatches(in: theGameName, range: NSRange((theGameName.startIndex...), in: theGameName))
                if numberOfBlanks == theGameName.count {
                    errorMessage.textColor = appColorRed
                    errorMessage.backgroundColor = appColorYellow
                    errorMessage.text = "Game name is blank"
                }
            }
        }
        
        // Make sure only letters, numbers, and spaces are present
        if errorMessage.text == "" {
            if !isAlphaNumSpace(dataIn: theGameName) {
                errorMessage.textColor = appColorRed
                errorMessage.backgroundColor = appColorYellow
                errorMessage.text="Name may use A-Z a-z 0-9 or space"
            }
        }

        if errorMessage.text == "" {
            // Retrieve all games from the Games file and ensure that this game
            // name is not a duplicate. A duplicate is allowed only if the
            // file game being examined is the one being edited on this screen.
            
            //print("EG gN game being played = \(gdefault.gamesGameName)")
            //print("EG gN while this game  is \(theGameName)")
            let fileHandleEGGamesGet:FileHandle=FileHandle(forReadingAtPath:gamesFileURL.path)!
            let fileContent:String=String(data: fileHandleEGGamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleEGGamesGet.closeFile()
            holdGamesFile = fileContent
            gameFileSize = holdGamesFile.count
            //print("EG gN gameFileSize=\(gameFileSize)")
            
            //print("EG gN looking for game name \(theGameName) in the file")
            var gameRecordOffset = 0
            let theGameNameNoSpaces = theGameName.replacingOccurrences(of: " ", with: "")
            let theGameNameUpperCase = theGameNameNoSpaces.uppercased()
            //print("EG gN actually looking for game name \(theGameNameUpperCase) in the file")
            while gameRecordOffset < gameFileSize {
                //print("EG gN extracting at offset \(gameRecordOffset)")
                tempGameRec = extractRecordField(recordIn: holdGamesFile, fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
                fileGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
                let theFileGameNameNoSpaces = fileGameName.replacingOccurrences(of: " ", with: "")
                let theFileGameNameUpperCase = theFileGameNameNoSpaces.uppercased()
                //print("EG gN read file game name \(fileGameName)")
                if !(fileGameName == gdefault.dummyGamesName) {
                    if !(fileGameName == gdefault.gamesGameName) {
                        if theFileGameNameUpperCase == theGameNameUpperCase {
                            //print("EG gN      found a duplicate game")
                            errorMessage.textColor = appColorRed
                            errorMessage.backgroundColor = appColorYellow
                            errorMessage.text = "Duplicate game name"
                            break
                        }
                    }
                }
                gameRecordOffset += gdefault.gamesRecordSize
            }
            if errorMessage.text == "" {
                // Save the new game name
                gdefault.gamesGameName = theGameName
                gdefault.historyGameName = theGameName
                //print("EG gN saving the new game name=\(gdefault.gamesGameName), len=\(gdefault.gamesGameName.count)")
            }
        }
    }
    
    @IBAction func trackDealerSwitch(_ sender: UISlider) {
        
        errorMessage.text = ""
        // Set value to the nearest 1
               
        sender.setValue((Float)((Int)((sender.value + 0.5) / 1) * 1), animated: false)
        let sval = Int(trackDealerSwitch.value)
        if sval == 0 {
            // Dealter tracking is being turned off
            gdefault.gamesTrackDealer = notTrackingDealerConstant
            trackDealerNo.textColor = appColorBrightGreen
            trackDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            trackDealerYes.textColor = appColorDarkGray
            trackDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        }
        else {
            // Dealer tracking is being turned on
            gdefault.gamesTrackDealer = trackingDealerConstant
            trackDealerNo.textColor = appColorDarkGray
            trackDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            trackDealerYes.textColor = appColorBrightGreen
            trackDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            // Always set the first player to be the current dealer
            gdefault.gamesCurrentDealer = gdefault.gamesPlayerEntryOrder[0]
        }
    }

    @IBAction func gameVersionButton(_ sender: Any) {
        if gameVersionButtonStatus == buttonCodeEnabled {
            //print("EG gVB gameVersionButtonStatus=\(gameVersionButtonStatus) - allow edit if status=\(buttonCodeEnabled)")
            errorMessage.text = ""
            allowExitFromView = true
            continueToHelp = false
        }
        else {
            //print("EG gVB gameVersionButtonStatus=\(gameVersionButtonStatus) - disallow edit if status not=\(buttonCodeEnabled)")
            errorMessage.textColor = appColorRed
            errorMessage.backgroundColor = appColorYellow
            errorMessage.text = "Game in progress - no game change"
            allowExitFromView = false
            continueToHelp = false
        }
    }
    
    @IBAction func aDoneButton(_ sender: Any) {
        //print("EG aDB update the Games file (Done button was clicked)")
        
        // First reset all the start-of-round player phases so that they
        // match their associated phases. This is only longer possible
        // when a game is being restarted. Then set the current phase
        // for all the players.
        
        var pcount = 0
        //print("EG aDB about to reset SOR phase(s) - gameVersionButtonStatus=\(gameVersionButtonStatus)")
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            if gameVersionButtonStatus == buttonCodeEnabled {
                if gdefault.gamesPlayerChoosesPhase[pcount] == playerDoesNotChoosePhaseConstant {
                    if gdefault.gamesPhaseModifier == evenPhasesCode {
                        //print("EG aDB modifier=even, original p2=\(gdefault.gamesPlayerPhase2[pcount]), original sor=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                        if !(gdefault.gamesPlayerPhase2[pcount] == gdefault.gamesPlayerStartRoundPhases[pcount]) {
                                //print("EG aDB resetting SOR phase[\(pcount)] to P2 \(gdefault.gamesPlayerPhase2[pcount])")
                                gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase2[pcount]
                        }
                    }
                    else {
                        //print("EG aDB modifier=all/odd, original p1=\(gdefault.gamesPlayerPhase1[pcount]), original sor=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
                        if !(gdefault.gamesPlayerPhase1[pcount] == gdefault.gamesPlayerStartRoundPhases[pcount]) {
                                //print("EG aDB resetting SOR phase[\(pcount)] to P1 \(gdefault.gamesPlayerPhase1[pcount])")
                                gdefault.gamesPlayerStartRoundPhases[pcount] = gdefault.gamesPlayerPhase1[pcount]
                        }
                    }
                }
            }
            pcount += 1
        }
        
        //print("EG aDB about to reset current phases")
        pcount = 0
        var useCurPhase = "01"
        if gdefault.gamesPhaseModifier == evenPhasesCode {
            useCurPhase = "02"
        }
        
        //print("EG aDB modifier=\(gdefault.gamesPhaseModifier) useCurPhase=\(useCurPhase)")
        while pcount < gdefault.gamesLengthPlayerCurrentPhaseOccurs {
            gdefault.gamesPlayerCurrentPhase[pcount] = useCurPhase
            pcount += 1
        }
        //print("EG aDB player current phases=<\(gdefault.gamesPlayerCurrentPhase)>")
        
        // Save all global memory values in the Games file for the current
        // game. Then if the game name has changed, do the same for the History file and dismiss the view.
        
        // Get the offset of this game in the Games file
        let fileHandleEGGamesGet:FileHandle=FileHandle(forReadingAtPath: gamesFileURL.path)!
        let fileContent:String=String(data:fileHandleEGGamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        fileHandleEGGamesGet.closeFile()
        let gameFileSize = fileContent.count
        //print("EG aDB original Games record=<\(fileContent)> len=\(gameFileSize)")
        //print("EG aDB first find game record offset for originalGameName=\(originalGameName)")
        
        var gameRecordOffset = 0
        while gameRecordOffset < gameFileSize {
            //print("EG aDB scanning: offset is \(gameRecordOffset)")
            let tempGameRec = extractRecordField(recordIn: fileContent,  fieldOffset: gameRecordOffset, fieldLength: gdefault.gamesRecordSize)
            thisGameName = extractRecordField(recordIn: tempGameRec, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
            //print("EG aDB comparing desired game \(originalGameName) vs. Game file game \(thisGameName)")
            if thisGameName == originalGameName {
                //print("EG aDB found matching file game \(thisGameName) at offset \(gameRecordOffset) and issued break command")
                break
            }
            gameRecordOffset += gdefault.gamesRecordSize
        }
        
        // Update the Games record and recreate the file
        //print("EG aDB now calling updateGamesFile from EditGame for game \(originalGameName) with offset \(gameRecordOffset), and the updated game name is \(gdefault.gamesGameName)")
        updateGamesFile(actionIn: updateFileUpdateCode, gameOffsetIn: gameRecordOffset)
        
        // If the game name has changed, update the history file, otherwise, leave it as is
        if !(gdefault.gamesGameName == originalGameName) {
            // Get the offset of this game in the History file
            let fileHandleEGHistoryGet:FileHandle=FileHandle(forReadingAtPath: historyFileURL.path)!
            let fileContent2:String=String(data:fileHandleEGHistoryGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleEGHistoryGet.closeFile()
            let historyFileSize = fileContent2.count
            //print("EG aDB original History record=<\(fileContent2)> len=\(historyFileSize)")
            //print("EG aDB first find history record offset for game \(originalGameName)")
            
            var historyRecordOffset = 0
            while historyRecordOffset < historyFileSize {
                //print("EG aDB scanning: offset is \(historyRecordOffset)")
                let tempHistoryRec = extractRecordField(recordIn: fileContent2,  fieldOffset: historyRecordOffset, fieldLength: gdefault.historyRecordSize)
                thisGameName = extractRecordField(recordIn: tempHistoryRec, fieldOffset: gdefault.historyOffsetGameName, fieldLength: gdefault.historyLengthGameName)
                //print("EG aDB comparing desired game \(originalGameName) vs. History file game \(thisGameName)")
                if thisGameName == originalGameName {
                    //print("EG aDB found matching file game \(thisGameName) at offset \(historyRecordOffset) and issued break command")
                    break
                }
                historyRecordOffset += gdefault.historyRecordSize
            }
            
            //print("EG aDB completed scan of history file")
            //print("EG aDB gdefault.historyGameName is \(gdefault.historyGameName)")
            //print("EG aDB gdefault.gamesGameName is \(gdefault.gamesGameName)")
            //print("EG aDB originalGameName is \(originalGameName)")
            // Update the game name in the History record and recreate the file
            //print("EG aDB now calling updateHistoryFile from EditGame with offset \(historyRecordOffset) to change the game name to \(gdefault.gamesGameName)")
            updateHistoryFile(actionIn: updateFileUpdateCode, historyOffsetIn: historyRecordOffset, newHistoryDataIn: "newname")
        }
        else {
            //print("EG aDB the game name did not change - do not update history")
        }

        allowExitFromView = true
        continueToHelp = false
    }
    
    // Build Phase Cards report and send it to a printer

    @IBAction func aPrintPhaseCardsButton(_ sender: UIButton) {
        
        let gameName = "Game: " + gdefault.gamesGameName
        let useGameName = addLeadingSpaces(dataIn: gameName, maxSizeIn: 27)
        var gameVersionName = retrieveGameVersionName(numberIn: gdefault.gamesGameVersion) + " / "
        var phaseModifier = ""
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            phaseModifier = allPhasesName
        case evenPhasesCode:
            phaseModifier = evenPhasesName
        case oddPhasesCode:
            phaseModifier = oddPhasesName
        default:
            _ = ""
        }
        gameVersionName = gameVersionName + phaseModifier
        let useGameVersionName = addLeadingSpaces(dataIn: gameVersionName, maxSizeIn: 27)
        let usePhases = getPhasesForPhaseCardReport()
        let phasesHeader = useGameName + "\n" + useGameVersionName + "\n\n Phases Being Played:\n"
        let phasesBody = usePhases
        
        // The image below is from xcassets (Phase10LargeImage)
        let image = UIImage(imageLiteralResourceName: "Phase10LargeImage")
        let createdPdf = CreatePDF(phasesHeader: phasesHeader, phasesBody: phasesBody, image: image)
        
        // This creates the report
        let pdfData = createdPdf.createPhaseCardReport()
        
        // This sends the report to the printer
        let vc = UIActivityViewController(activityItems: [pdfData], applicationActivities: [])
        
        // Exclude the other options that appear when requesting a printout:
        // - copy
        // - markup
        // - airDrop
        // - mail
        // - text messaging
        // - save to camera roll
        // As a result, only 2 options will appear:
        // - print
        // - save to a file
        vc.excludedActivityTypes = [UIActivity.ActivityType.copyToPasteboard,
                                    UIActivity.ActivityType.markupAsPDF,
                                    UIActivity.ActivityType.airDrop,
                                    UIActivity.ActivityType.mail,
                                    UIActivity.ActivityType.message,
                                    UIActivity.ActivityType.saveToCameraRoll]
        
        // An iPad requires that the the activity controller be presented in a popover. An
        // iPhone does not have this requirement. The iPhone controller will appear from the
        // bottom of the screen, and the iPad controller will appear with an arrow pointing
        // to the button that initiated the controller. The coding below forces the arrow to
        // point upward, thus keeping the controller in the bottom portion of the screen.
        if deviceCategoryWeAreRunningOn == iPadConstant {
            vc.modalPresentationStyle = .popover
            vc.popoverPresentationController?.sourceView = sender
            vc.popoverPresentationController?.permittedArrowDirections = .up
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func aViewTutorialButton(_ sender: Any) {
        gdefault.helpCaller = helpSectionCodeEditGame
        errorMessage.text = ""
        allowExitFromView = false
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
        gameVersionButton.layer.cornerRadius = cornerRadiusStdButton
        aDoneButton.layer.cornerRadius = cornerRadiusStdButton
        aPrintPhaseCardsButton.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton
        
        self.gameName.delegate = self
        self.addDoneButtonOnKeyboard ()

        // Save original game name in case the user changes it
        originalGameName = gdefault.gamesGameName
        
        allowExitFromView = false
        continueToHelp = false
        
    } // End of ViewDidLoad
        
    override func viewWillAppear(_ animated: Bool) {
            
        // Load the view data values from global storage
        
        //print("EG vWA updateTarget was \(gdefault.updateTarget)")
        gdefault.updateTarget = movingForward
            
        aRefreshView()
            
    } // End ViewWillAppear

    func aRefreshView () {
        
        // Game name
        
        gameName.text = gdefault.gamesGameName
        
        // Track dealer
         
        if gdefault.gamesTrackDealer == trackingDealerConstant {
            trackDealerSwitch.value = 1
            trackDealerNo.textColor = appColorDarkGray
            trackDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            trackDealerYes.textColor = appColorBrightGreen
            trackDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
        }
        else {
            trackDealerSwitch.value = 0
            trackDealerNo.textColor = appColorBrightGreen
            trackDealerNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
            trackDealerYes.textColor = appColorDarkGray
            trackDealerYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        }

        // Game version & phase modifier
         
        var phaseModifier = ""
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            phaseModifier = allPhasesName
        case evenPhasesCode:
            phaseModifier = evenPhasesName
        case oddPhasesCode:
            phaseModifier = oddPhasesName
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
        let attBoldBlue: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 17), .underlineStyle : 0, .paragraphStyle: style, .foregroundColor: appColorBlue]
        let attStdBlack: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 17), .underlineStyle: 0, .paragraphStyle: style, .foregroundColor: appColorBlack]
        
        let gameVersionName = retrieveGameVersionName(numberIn: gdefault.gamesGameVersion) + " / "

        // Make the version bold black.
        // If the phase modifier is "All", set it to be bold black.
        // Otherwise, make it bold blue
        let attribLine01Left = NSMutableAttributedString(string:gameVersionName, attributes:attBoldBlackV)
        var attribLine01Right = NSMutableAttributedString()
        if phaseModifier == allPhasesName {
            attribLine01Right = NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlackV)
        }
        else {
            attribLine01Right =
            NSMutableAttributedString(string:phaseModifier, attributes:attBoldBlueV)
        }

        // Add phase names 1 - 10
        var nextPhaseLine = ""
        
        var gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase1)
        nextPhaseLine = String("\n\n  1 ") + gamePhaseName
        var attribLine02 = NSMutableAttributedString()
        switch gdefault.gamesPhaseModifier {
        case oddPhasesCode:
            attribLine02 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine02 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine02 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase2)
        nextPhaseLine = String("\n  2 ") + gamePhaseName
        var attribLine03 = NSMutableAttributedString()
        switch gdefault.gamesPhaseModifier {
        case oddPhasesCode:
            attribLine03 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine03 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine03 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
                
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase3)
        nextPhaseLine = String("\n  3 ") + gamePhaseName
        var attribLine04 = NSMutableAttributedString()
        switch gdefault.gamesPhaseModifier {
        case oddPhasesCode:
            attribLine04 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine04 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine04 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase4)
        nextPhaseLine = String("\n  4 ") + gamePhaseName
        var attribLine05 = NSMutableAttributedString()
        switch gdefault.gamesPhaseModifier {
        case oddPhasesCode:
            attribLine05 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine05 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine05 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase5)
        nextPhaseLine = String("\n  5 ") + gamePhaseName
        var attribLine06 = NSMutableAttributedString()
        switch gdefault.gamesPhaseModifier {
        case oddPhasesCode:
            attribLine06 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine06 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine06 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
         
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase6)
        nextPhaseLine = String("\n  6 ") + gamePhaseName
        var attribLine07 = NSMutableAttributedString()
        switch gdefault.gamesPhaseModifier {
        case oddPhasesCode:
            attribLine07 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine07 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine07 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
         
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase7)
        nextPhaseLine = String("\n  7 ") + gamePhaseName
        var attribLine08 = NSMutableAttributedString()
        switch gdefault.gamesPhaseModifier {
        case oddPhasesCode:
            attribLine08 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine08 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine08 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
         
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase8)
        nextPhaseLine = String("\n  8 ") + gamePhaseName
        var attribLine09 = NSMutableAttributedString()
        switch gdefault.gamesPhaseModifier {
        case oddPhasesCode:
            attribLine09 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine09 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine09 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
         
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase9)
        nextPhaseLine = String("\n  9 ") + gamePhaseName
        var attribLine10 = NSMutableAttributedString()
        switch gdefault.gamesPhaseModifier {
        case oddPhasesCode:
            attribLine10 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case evenPhasesCode:
            attribLine10 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case allPhasesCode:
            attribLine10 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
         
        gamePhaseName = retrieveGamePhaseName(numberIn: gdefault.gamesPhase10)
        nextPhaseLine = String("\n10 ") + gamePhaseName
        var attribLine11 = NSMutableAttributedString()
        switch gdefault.gamesPhaseModifier {
        case oddPhasesCode:
            attribLine11 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        case evenPhasesCode:
            attribLine11 = NSMutableAttributedString(string:nextPhaseLine, attributes: attBoldBlue)
        case allPhasesCode:
            attribLine11 = NSMutableAttributedString(string:nextPhaseLine, attributes: attStdBlack)
        default:
            _ = ""
        }
        
        // Concatenate all the lines together
        
        let all11Lines = NSMutableAttributedString()
        
        all11Lines.append(attribLine01Left)
        all11Lines.append(attribLine01Right)
        all11Lines.append(attribLine02)
        all11Lines.append(attribLine03)
        all11Lines.append(attribLine04)
        all11Lines.append(attribLine05)
        all11Lines.append(attribLine06)
        all11Lines.append(attribLine07)
        all11Lines.append(attribLine08)
        all11Lines.append(attribLine09)
        all11Lines.append(attribLine10)
        all11Lines.append(attribLine11)
        gameVersionButton.setAttributedTitle(all11Lines, for: .normal)
        gameVersionButton.backgroundColor = appColorBrightGreen
        
        // Disable the game version button if the game has started already
        //print("EG aRV gamesGameStatus = \(gdefault.gamesGameStatus)")
        if gdefault.gamesGameStatus == inProgress {
            //print("EG aRV disabling gameVersionButtonStatus because gamesGameStatus=\(inProgress)")
            gameVersionButtonStatus = buttonCodeDisabled
            continueToHelp = false
        }
        else {
            //print("EG aRV enabling gameVersionButtonStatus because gamesGameStatus not=\(inProgress)")
            gameVersionButtonStatus = buttonCodeEnabled
            continueToHelp = false
        }
        
        // Store this view name in case the user proceeds to the game
        // version selection screen, so that the path back is known.
        gdefault.gameVersionConfirmationDecisionDriverView = "EditGame"
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
    
    // Add leading spaces to center the requested string within the column
    func addLeadingSpaces(dataIn: String, maxSizeIn: Int) -> String {
        var returnData = ""
        let inputData = dataIn.trimmingCharacters(in: .whitespacesAndNewlines)
        let dataInSize = inputData.count
        var spaceSize = 0
        var newSpaces = ""
        let oneSpace = " "
        if maxSizeIn > dataInSize {
            spaceSize = (maxSizeIn - dataInSize) / 2
            var spx = 0
            while spx < spaceSize {
                newSpaces = newSpaces + oneSpace
                spx += 1
            }
            returnData = newSpaces + dataIn
        }
        else {
            returnData = dataIn
        }
        return returnData
    }
    
    // There is limited space to print phase names on the phase card. This function
    // divides the requested name into two parts so that the name will fit on the print line.
    
    func adjustGamePhaseNameIfNecessary(phaseIn: String) -> String {
        //print("in=\(phaseIn) size=\(phaseIn.count)")
        var returnPhaseName = phaseIn
        if phaseIn.count < 26 {
            return returnPhaseName
        }
        var offsetIdx = 24
        while offsetIdx > 0 {
            let sidx = phaseIn.index(phaseIn.startIndex, offsetBy: offsetIdx)
            let eidx = phaseIn.index(phaseIn.startIndex, offsetBy: offsetIdx+1)
            let range = sidx ..< eidx
            if String(phaseIn[range]) == " " {
                break
            }
            offsetIdx -= 1
        }
        if offsetIdx > 0 {
            //print("found blank @ \(offsetIdx) - must insert newline")
            var sidx = phaseIn.index(phaseIn.startIndex, offsetBy: 0)
            let eidx = phaseIn.index(phaseIn.startIndex, offsetBy: offsetIdx)
            var range = sidx ..< eidx
            let phaseArea1 = phaseIn[range]
            let phaseArea2 = "\n     "
            sidx = phaseIn.index(phaseIn.startIndex, offsetBy: offsetIdx+1)
            range = sidx ..< phaseIn.endIndex
            let phaseArea3 = phaseIn[range]
            returnPhaseName = phaseArea1 + phaseArea2 + phaseArea3
        }
        //else {
            //print("did not find blank - make no insertion")
        //}
        return returnPhaseName
    }
    
    // Extract and return all the phases in use for this game. This is used
    // for the Phase Card report. If the phase modifier is all, then all 10
    // phases will be returned. If the phase modifier is even or odd, then only
    // the 5 even or odd phases will be returned.
    
    func getPhasesForPhaseCardReport () -> String {
        var gamePhaseName = ""
        var adjustedGamePhaseName = ""
        var gamePhaseNumber = ""
        var allPhases = ""
        
        switch gdefault.gamesPhaseModifier {
        case allPhasesCode:
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase1)
            gamePhaseName = "  1. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase2)
            gamePhaseName = "  2. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase3)
            gamePhaseName = "  3. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase4)
            gamePhaseName = "  4. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase5)
            gamePhaseName = "  5. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase6)
            gamePhaseName = "  6. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase7)
            gamePhaseName = "  7. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase8)
            gamePhaseName = "  8. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase9)
            gamePhaseName = "  9. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase10)
            gamePhaseName = " 10. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
        case oddPhasesCode:
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase1)
            gamePhaseName = "  1. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase3)
            gamePhaseName = "  3. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase5)
            gamePhaseName = "  5. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase7)
            gamePhaseName = "  7. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase9)
            gamePhaseName = "  9. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
        case evenPhasesCode:
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase2)
            gamePhaseName = "  2. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase4)
            gamePhaseName = "  4. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase6)
            gamePhaseName = "  6. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase8)
            gamePhaseName = "  8. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
            
            gamePhaseNumber = preparePhaseNumber(phaseIn: gdefault.gamesPhase10)
            gamePhaseName = " 10. " + retrieveGamePhaseName(numberIn: gamePhaseNumber)
            adjustedGamePhaseName = adjustGamePhaseNameIfNecessary(phaseIn: gamePhaseName)
            allPhases = allPhases + adjustedGamePhaseName + newLineConstant
        default:
            _ = ""
        }
        
        return allPhases
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
