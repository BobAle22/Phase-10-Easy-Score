//
//  GenHelp.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 1/28/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import UIKit

// The UIFont extension is used to create a bold font attribute
extension UIFont {
    func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
    let descriptor = fontDescriptor.withSymbolicTraits(traits)
    return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
}

class GenHelp: UIViewController, UITextViewDelegate {

    @IBOutlet weak var versionBuildLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var contentsButton: UIButton!
    @IBOutlet weak var helpTextView: UITextView!
    
    var callerHelpIndex = 0
    
    var helpLinkFontSize : CGFloat = 0
    var helpLinkFontSize20 : CGFloat = 20
    var helpLinkFontSize25 : CGFloat = 25
    var useFont = ""
    let arialFont = "Arial"
    let courierFont = "Courier"
    
    var theHelpType = ""
    var theHelpSection = ""
    var theHelpSectionName = ""
    var theHelpEntry = ""
    var theHelpText = ""
    var theCaller = ""
    var boldOrRegular = ""
    var theColor = appColorBlue
    var theFont = ""
    
    var currentHelpMode = "s"   // "s" means currently displaying standard help text
                                // "l" means currently processing a content link
                                // This is important because we don't want the help
                                // processor to follow a link that's not being displayed
                                // within the standard help text. (Originally, once the
                                // user pressed the Contents button and followed a link,
                                // the associated help text was displayed, but if the
                                // user touched an area on the screen that previously
                                // contained a link (but was no longer on the screen),
                                // the help processor would display the help text
                                // associated with that link.) This field was added
                                // to stop this from happening.
    
    var resetHelpPosition = 0   // Y coordinate of most-recently-loaded help text
    var twoThirdsScreen = 0     // Offset to subtract from Y position for end-of-help
    
    // This function splits the current help text line into two parts:
    // 1. All text preceding $!$
    // 2. All text following $!$
    // Input:  The entire text line
    // Output: Text part 1
    //         Text part 2
    
    func splitHelpText (textIn: String) -> (textPart1: String,  textPart2 : String) {
        var idx = 0
        var textPart1 = ""
        var textPart2 = ""
        let maxScanIdx = textIn.count - 2
        let maxPart2TextIndex = maxScanIdx - 1
        
        //print("GH sHT text in = [\(textIn)] length=\(textIn.count) maxScanIdx=\(maxScanIdx) max part 2 = \(maxPart2TextIndex)")
        // Find the $!$ flag
        while idx < maxScanIdx {
            let sidx = textIn.index(textIn.startIndex, offsetBy: idx)
            let eidx = textIn.index(textIn.startIndex, offsetBy: idx+2)
            let range = sidx ... eidx
            let possibleHelpFlag = String(textIn[range])
            if possibleHelpFlag == helpSymbolString {
                //print("GH sHT found $!$ at index \(idx)")
                break
            }
            idx += 1
        }
        
        //print("GH sHT after finding $!$, index = \(idx)")
        // As long as the index is beyond the first byte, there's data preceding the $!$
        // so extract it into text part 1
        if idx > 0 {
            let sidx = textIn.index(textIn.startIndex, offsetBy: 0)
            let eidx = textIn.index(textIn.startIndex, offsetBy: idx)
            let range = sidx ..< eidx
            textPart1 = String(textIn[range])
            //print("GH sHT idx>0 text 1 =[\(textPart1)]")
        }
        
        // As long as the index is not past the 3rd-last byte, there's data following the $!$
        if idx < maxPart2TextIndex {
            let sidx = textIn.index(textIn.startIndex, offsetBy: idx+3)
            let eidx = textIn.endIndex
            let range = sidx ..< eidx
            textPart2 = String(textIn[range])
            //print("GH sHT idx<maxPart2TextIndex text 2 =[\(textPart2)]")
        }
        
        return (textPart1, textPart2)
    }
    
    // This function builds an NSMutableAttributedString containing
    // the requested "help" symbol surrounded by all other text. The symbol is
    // the SF system symbol info.circle, which is a courier font i within a circle.
    // Input: this line of help text
    // Output: this line of text after converting $!$ to info.circle
    
    func setUpHelpSymbol (textIn: String) -> NSMutableAttributedString {
        
        let outputString = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        let heavyConfig = UIImage.SymbolConfiguration(scale: .large)
        let infoCircle = UIImage(systemName: "info.circle", withConfiguration: heavyConfig)
        let yellowInfoCircle = infoCircle?.withTintColor(appColorYellow)
        imageAttachment.image = yellowInfoCircle
        let imageNSString = NSAttributedString(attachment: imageAttachment)
        
        let splitTextResults = splitHelpText(textIn: textIn)
        let splitText1 = splitTextResults.textPart1
        let splitText2 = splitTextResults.textPart2
        
        var outputNSString = NSMutableAttributedString(string: splitText1)
        outputString.append(outputNSString)
        
        outputString.append(imageNSString)
        
        outputNSString = NSMutableAttributedString(string: splitText2)
        outputString.append(outputNSString)

        return outputString
    }
    
    // General function to dynamically configure and position a link
    // Note that the link is in reality a button
    // Input: button name,
    //        text to be displayed,
    //        text color,
    //        background color,
    //        x position,
    //        y position,
    //        textview
    //        font size
    //        font
    //        bold or regular
    // It is the caller's responsibility to define the link variable,
    // add it as a subview of the textview, and associate it with the
    // function to be invoked when it is pressed.
    
    func configureLink (linkNameIn: UIButton, xPositionIn: Int, yPositionIn: Int, textIn: String, textColorIn: UIColor, backgroundColorIn: UIColor, textViewIn: UITextView, fontSizeIn: CGFloat, fontIn: String, boldOrRegularIn: String) {
        
        //print("GH gen link \(textIn) at x/y \(xPositionIn)/\(yPositionIn) for length 0 color=\(backgroundColorIn)")
        
        // This is where the link will physically be relative to the
        // top left of the textview box, where x is the number of pixels
        // from the left, and y is the number of pixels from the top.
        linkNameIn.frame = CGRect(x: xPositionIn, y: yPositionIn, width: 0, height: 0)
        // This determines the location of the text within the link,
        // where top is the number of pixels from the top, left is the
        // number of pixels from the left, bottom is the number of
        // pixels from the bottom, and right is the number of pixels
        // from the right.
        
        linkNameIn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        linkNameIn.setTitle(textIn, for: UIControl.State.normal)
        linkNameIn.setTitleColor(textColorIn, for: .normal)
        linkNameIn.backgroundColor = backgroundColorIn
        if fontIn == "a" {
            useFont = arialFont
        }
        else {
            useFont = courierFont
        }
        if boldOrRegularIn == weightBold {
            linkNameIn.titleLabel!.font = UIFont(name: useFont, size: 20)!.bold()
        }
        else {
            linkNameIn.titleLabel!.font = UIFont(name: useFont, size: 20)
        }
        
        linkNameIn.sizeToFit()
        linkNameIn.layer.cornerRadius = cornerRadiusStdButton
        let linkFrame = CGRect(x: 0, y: 0, width: linkNameIn.frame.size.width, height: (textViewIn.font?.lineHeight)! as CGFloat)
        let exclusivePath = UIBezierPath(rect: linkFrame)
        textViewIn.textContainer.exclusionPaths = [exclusivePath]
        return
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
    //        font
    // It is the caller's responsibility to define the label variable
    // and then add it as a subview of the textview.
    //
    // Note that there is a special case when any part of the string to be displayed
    // contains the string "$!$". This function converts this to the
    // SF symbol info.circle, which is a courier font i within a circle.
    
    func configureLabel (labelNameIn: UILabel, textIn: String, textColorIn: UIColor, backgroundColorIn: UIColor, xPositionIn: Int, yPositionIn: Int, widthIn: Int, heightIn: Int, boldOrRegularIn: String, fontIn: String) {
        
        //print("TG gen label \(textIn) at x/y \(xPositionIn)/\(yPositionIn) for length \(heightIn)")
        
        // This sets the label's size and position, where x is
        // the number of pixels from the left, and y is the number
        // of pixels from the top. Width and height are self-explanatory.
        //print("TG cL create frame for \(textIn) x=\(xPositionIn) y=\(yPositionIn) w=\(widthIn) h=\(heightIn) color=\(backgroundColorIn)")
        var addSpace = ""
        if textIn.contains(helpSymbolString) {
            labelNameIn.attributedText = setUpHelpSymbol(textIn: textIn)
        }
        else {
            labelNameIn.text = addSpace + textIn
        }
        if fontIn == "a" {
            useFont = arialFont
            addSpace = " "
        }
        else {
            useFont = courierFont
        }
        labelNameIn.frame = CGRect(x: xPositionIn, y: yPositionIn, width: widthIn, height: heightIn)
        labelNameIn.textColor = textColorIn
        labelNameIn.backgroundColor = backgroundColorIn
        labelNameIn.textAlignment = NSTextAlignment.left
        
        if boldOrRegularIn == weightBold {
            labelNameIn.font = UIFont(name: useFont, size: 20)!.bold()
        }
        else {
            labelNameIn.font = UIFont(name: useFont, size: 20)
        }
        return
    }
    
    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // One of the content help links has been clicked
    // Extract the associated section number and display that section's help information
    @objc func helpLinkClicked(_ sender: UIButton) {
        // Note the tag-indexed helpAreaText is the full internal help line entry, e.g.,
        // s13ab5U Pick 10 Phase Selection Screen
        //print("GH you pressed a content link with tag \(sender.tag) - currentHelpMode=\(currentHelpMode)")
        
        // Only generate help for this link if we're currently in link mode
        if currentHelpMode == "l" {
            let helpEntry = helpAreaText[sender.tag]
            let sidx = helpEntry.index(helpEntry.startIndex, offsetBy: helpOffsetIdentifier)
            let eidx = helpEntry.index(helpEntry.startIndex, offsetBy: helpOffsetFont)
            let range = sidx ..< eidx
            gdefault.helpCaller = String(helpEntry[range])
            aRefreshView()
        }
    }
    
    // The user has pressed the Contents button to get links to all the help areas
    @IBAction func contentsButton(_ sender: Any) {
        
        //print("GH cB start")
        
        // Clear all help memory usage first
        let subViews = self.helpTextView.subviews
        for subview in subViews {
            subview.removeFromSuperview()
        }
        
        let Link1:UIButton = UIButton()
        let Link2:UIButton = UIButton()
        let Link3:UIButton = UIButton()
        let Link4:UIButton = UIButton()
        let Link5:UIButton = UIButton()
        let Link6:UIButton = UIButton()
        let Link7:UIButton = UIButton()
        let Link8:UIButton = UIButton()
        let Link9:UIButton = UIButton()
        let Link10:UIButton = UIButton()
        let Link11:UIButton = UIButton()
        let Link12:UIButton = UIButton()
        let Link13:UIButton = UIButton()
        let Link14:UIButton = UIButton()
        let Link15:UIButton = UIButton()
        let Link16:UIButton = UIButton()
        let Link17:UIButton = UIButton()
        let Link18:UIButton = UIButton()
        let Link19:UIButton = UIButton()
        let Link20:UIButton = UIButton()
        
        let linkNames = [Link1,  Link2,  Link3,  Link4,  Link5,
                     Link6,  Link7,  Link8,  Link9,  Link10,
                     Link11, Link12, Link13, Link14, Link15,
                     Link16, Link17, Link18, Link19, Link20]
        
        let LabelBG1:UILabel = UILabel()
        let LabelBG2:UILabel = UILabel()
        let LabelBG3:UILabel = UILabel()
        let LabelBG4:UILabel = UILabel()
        let LabelBG5:UILabel = UILabel()
        let LabelBG6:UILabel = UILabel()
        let LabelBG7:UILabel = UILabel()
        let LabelBG8:UILabel = UILabel()
        let LabelBG9:UILabel = UILabel()
        let LabelBG10:UILabel = UILabel()
        let LabelBG11:UILabel = UILabel()
        let LabelBG12:UILabel = UILabel()
        let LabelBG13:UILabel = UILabel()
        let LabelBG14:UILabel = UILabel()
        let LabelBG15:UILabel = UILabel()
        let LabelBG16:UILabel = UILabel()
        let LabelBG17:UILabel = UILabel()
        let LabelBG18:UILabel = UILabel()
        let LabelBG19:UILabel = UILabel()
        let LabelBG20:UILabel = UILabel()
        let LabelBG21:UILabel = UILabel()
        let LabelBG22:UILabel = UILabel()
        let LabelBG23:UILabel = UILabel()
        let LabelBG24:UILabel = UILabel()
        let LabelBG25:UILabel = UILabel()
        let LabelBG26:UILabel = UILabel()
        let LabelBG27:UILabel = UILabel()
        let LabelBG28:UILabel = UILabel()
        let LabelBG29:UILabel = UILabel()
        let LabelBG30:UILabel = UILabel()
        let LabelBG31:UILabel = UILabel()
        let LabelBG32:UILabel = UILabel()
        let LabelBG33:UILabel = UILabel()
        let LabelBG34:UILabel = UILabel()
        let LabelBG35:UILabel = UILabel()
        let LabelBG36:UILabel = UILabel()
        let LabelBG37:UILabel = UILabel()
        let LabelBG38:UILabel = UILabel()
        let LabelBG39:UILabel = UILabel()
        let LabelBG40:UILabel = UILabel()
        let LabelBG41:UILabel = UILabel()
        let LabelBG42:UILabel = UILabel()
        let LabelBG43:UILabel = UILabel()
        let LabelBG44:UILabel = UILabel()
        let LabelBG45:UILabel = UILabel()
        let LabelBG46:UILabel = UILabel()
        let LabelBG47:UILabel = UILabel()
        let LabelBG48:UILabel = UILabel()
        let LabelBG49:UILabel = UILabel()
        let LabelBG50:UILabel = UILabel()
        
        let labelBGNames = [LabelBG1,  LabelBG2,  LabelBG3,  LabelBG4,  LabelBG5,
                            LabelBG6,  LabelBG7,  LabelBG8,  LabelBG9,  LabelBG10,
                            LabelBG11, LabelBG12, LabelBG13, LabelBG14, LabelBG15,
                            LabelBG16, LabelBG17, LabelBG18, LabelBG19, LabelBG20,
                            LabelBG21, LabelBG22, LabelBG23, LabelBG24, LabelBG25,
                            LabelBG26, LabelBG27, LabelBG28, LabelBG29, LabelBG30,
                            LabelBG31, LabelBG32, LabelBG33, LabelBG34, LabelBG35,
                            LabelBG36, LabelBG37, LabelBG38, LabelBG39, LabelBG40,
                            LabelBG41, LabelBG42, LabelBG43, LabelBG44, LabelBG45,
                            LabelBG46, LabelBG47, LabelBG48, LabelBG49, LabelBG50]

        //print("GH cB clear the help area")
        var yPosition = 0
        var xPosition = 0
        var idx = 0
        
        // Center the label if we're on an iPad
        if deviceCategoryWeAreRunningOn == iPadConstant {
            xPosition = (deviceWidth - 300) / 2
        }
        else {
            xPosition = 0
        }
        
        while idx < maxGameClearing {
        // First clear the help area - note that the font is immaterial because
        // the area is being cleared (blue on blue)
            configureLabel(labelNameIn: labelBGNames[idx],
                           textIn: " ",
                           textColorIn: appColorBlue,
                           backgroundColorIn: appColorBlue,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: 400,
                           heightIn: 105,
                           boldOrRegularIn: weightRegular,
                           fontIn: arialFont)
            helpTextView.addSubview(labelBGNames[idx])
            
            yPosition += 105
            idx += 1
        }
        
        // Then find and display the section links
        idx = 0
        yPosition = 25
        var linkIndex = 0
        theHelpSectionName = ""
        theHelpEntry = ""
        while idx < helpAreaText.count {
            theHelpEntry = helpAreaText[idx]
            var sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetType)
            var eidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetIdentifier)
            var range = sidx ..< eidx
            theHelpType = String(theHelpEntry[range])
            if theHelpType == helpSectionIndicator {
                // theHelpType now points to the section indicator
                // So now get the font, bold/regular indicator, and color (note
                // that this is the color for section links)

                // First the font
                sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetFont)
                eidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetWeight)
                range = sidx ..< eidx
                theFont = String(theHelpEntry[range])
                
                // Next the bold/regular indicator
                sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetWeight)
                eidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetStandardColor)
                range = sidx ..< eidx
                boldOrRegular = String(theHelpEntry[range])
                
                // Now the section color code
                sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetLinkColor)
                eidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetSectionText)
                range = sidx ..< eidx
                theHelpType = String(theHelpEntry[range])
                switch theHelpType {
                case helpColorYellow:
                    theColor = appColorYellow
                case helpColorBrightGreen:
                    theColor = appColorBrightGreen
                case helpColorRed:
                    theColor = appColorRed
                case helpColorOrange:
                    theColor = appColorOrange
                case helpColorWhite:
                    theColor = appColorWhite
                default:
                    theColor = appColorYellow
                }
                
                // Lastly get the text
                sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetSectionText)
                eidx = theHelpEntry.endIndex
                range = sidx ..< eidx
                theHelpSectionName = String(theHelpEntry[range])
                
                configureLink(linkNameIn: linkNames[linkIndex],
                                  xPositionIn: xPosition,
                                  yPositionIn: yPosition,
                                  textIn: theHelpSectionName,
                                  textColorIn: theColor,
                                  backgroundColorIn: appColorBlue,
                                  textViewIn: helpTextView,
                                  fontSizeIn: helpLinkFontSize,
                                  fontIn: theFont,
                                  boldOrRegularIn: boldOrRegular)
                linkNames[linkIndex].tag = idx
                linkNames[linkIndex].addTarget(self,
                                         action: #selector(helpLinkClicked(_ :)),
                                         for: .touchUpInside)
                helpTextView.addSubview(linkNames[linkIndex])
                yPosition += 40
                linkIndex += 1
            }
            idx += 1
        }
        
        // Force the help data textview to scroll to the beginning
        self.helpTextView.setContentOffset(CGPoint(x: 0, y:0), animated: false)
        
        // Set the mode indicator to identify the fact that we are processing
        // links now
        currentHelpMode = "l"
        
        if yPosition > twoThirdsScreen {
            resetHelpPosition = Int(Double(yPosition)) - twoThirdsScreen
        }
        else {
            resetHelpPosition = 0
        }
        
        //print("GH cB lines=\(linkIndex) yPos=\(yPosition) reset position to=\(resetHelpPosition)")

        //print("GH cB end")
    }
    
    override func viewDidLoad() {
        //print("GH vDL start")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Load version and build header
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        versionBuildLabel.text = "Version " + version + " Build " + build
        
        // Round the button corners
        doneButton.layer.cornerRadius = cornerRadiusStdButton
        contentsButton.layer.cornerRadius = cornerRadiusStdButton
        
        // Set font size for content links based on device size
        if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
            helpLinkFontSize = 20
        }
        else {
            helpLinkFontSize = 25
        }
        
        // Set 2/3 screen help offset based on device size
        if deviceCategoryWeAreRunningOn == iPhoneSmallConstant {
            twoThirdsScreen = twoThirdsSmallScreen
            //print("GH vDL set 2/3 screen for small screen value=\(twoThirdsScreen)")
        }
        else {
            twoThirdsScreen = twoThirdsLargeScreen
            //print("GH vDL set 2/3 screen for large screen value=\(twoThirdsScreen)")
        }
        
        helpTextView.delegate = self
        //print("GH vDL end")
    }

    func aRefreshView() {
        //print("GH aRV start aRefreshView")
        var xPosition = 0
        var yPosition = 0
        
        // Center the label if we're on an iPad
        if deviceCategoryWeAreRunningOn == iPadConstant {
            xPosition = (deviceWidth - 300) / 2
        }
        else {
            xPosition = 0
        }

        // Note that 176 labels allows for 175 lines of help text
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
        let Label67:UILabel = UILabel()
        let Label68:UILabel = UILabel()
        let Label69:UILabel = UILabel()
        let Label70:UILabel = UILabel()
        let Label71:UILabel = UILabel()
        let Label72:UILabel = UILabel()
        let Label73:UILabel = UILabel()
        let Label74:UILabel = UILabel()
        let Label75:UILabel = UILabel()
        let Label76:UILabel = UILabel()
        let Label77:UILabel = UILabel()
        let Label78:UILabel = UILabel()
        let Label79:UILabel = UILabel()
        let Label80:UILabel = UILabel()
        let Label81:UILabel = UILabel()
        let Label82:UILabel = UILabel()
        let Label83:UILabel = UILabel()
        let Label84:UILabel = UILabel()
        let Label85:UILabel = UILabel()
        let Label86:UILabel = UILabel()
        let Label87:UILabel = UILabel()
        let Label88:UILabel = UILabel()
        let Label89:UILabel = UILabel()
        let Label90:UILabel = UILabel()
        let Label91:UILabel = UILabel()
        let Label92:UILabel = UILabel()
        let Label93:UILabel = UILabel()
        let Label94:UILabel = UILabel()
        let Label95:UILabel = UILabel()
        let Label96:UILabel = UILabel()
        let Label97:UILabel = UILabel()
        let Label98:UILabel = UILabel()
        let Label99:UILabel = UILabel()
        let Label100:UILabel = UILabel()
        let Label101:UILabel = UILabel()
        let Label102:UILabel = UILabel()
        let Label103:UILabel = UILabel()
        let Label104:UILabel = UILabel()
        let Label105:UILabel = UILabel()
        let Label106:UILabel = UILabel()
        let Label107:UILabel = UILabel()
        let Label108:UILabel = UILabel()
        let Label109:UILabel = UILabel()
        let Label110:UILabel = UILabel()
        let Label111:UILabel = UILabel()
        let Label112:UILabel = UILabel()
        let Label113:UILabel = UILabel()
        let Label114:UILabel = UILabel()
        let Label115:UILabel = UILabel()
        let Label116:UILabel = UILabel()
        let Label117:UILabel = UILabel()
        let Label118:UILabel = UILabel()
        let Label119:UILabel = UILabel()
        let Label120:UILabel = UILabel()
        let Label121:UILabel = UILabel()
        let Label122:UILabel = UILabel()
        let Label123:UILabel = UILabel()
        let Label124:UILabel = UILabel()
        let Label125:UILabel = UILabel()
        let Label126:UILabel = UILabel()
        let Label127:UILabel = UILabel()
        let Label128:UILabel = UILabel()
        let Label129:UILabel = UILabel()
        let Label130:UILabel = UILabel()
        let Label131:UILabel = UILabel()
        let Label132:UILabel = UILabel()
        let Label133:UILabel = UILabel()
        let Label134:UILabel = UILabel()
        let Label135:UILabel = UILabel()
        let Label136:UILabel = UILabel()
        let Label137:UILabel = UILabel()
        let Label138:UILabel = UILabel()
        let Label139:UILabel = UILabel()
        let Label140:UILabel = UILabel()
        let Label141:UILabel = UILabel()
        let Label142:UILabel = UILabel()
        let Label143:UILabel = UILabel()
        let Label144:UILabel = UILabel()
        let Label145:UILabel = UILabel()
        let Label146:UILabel = UILabel()
        let Label147:UILabel = UILabel()
        let Label148:UILabel = UILabel()
        let Label149:UILabel = UILabel()
        let Label150:UILabel = UILabel()
        let Label151:UILabel = UILabel()
        let Label152:UILabel = UILabel()
        let Label153:UILabel = UILabel()
        let Label154:UILabel = UILabel()
        let Label155:UILabel = UILabel()
        let Label156:UILabel = UILabel()
        let Label157:UILabel = UILabel()
        let Label158:UILabel = UILabel()
        let Label159:UILabel = UILabel()
        let Label160:UILabel = UILabel()
        let Label161:UILabel = UILabel()
        let Label162:UILabel = UILabel()
        let Label163:UILabel = UILabel()
        let Label164:UILabel = UILabel()
        let Label165:UILabel = UILabel()
        let Label166:UILabel = UILabel()
        let Label167:UILabel = UILabel()
        let Label168:UILabel = UILabel()
        let Label169:UILabel = UILabel()
        let Label170:UILabel = UILabel()
        let Label171:UILabel = UILabel()
        let Label172:UILabel = UILabel()
        let Label173:UILabel = UILabel()
        let Label174:UILabel = UILabel()
        let Label175:UILabel = UILabel()
        let Label176:UILabel = UILabel()
        let Label177:UILabel = UILabel()
        let Label178:UILabel = UILabel()
        let Label179:UILabel = UILabel()
        let Label180:UILabel = UILabel()
        let Label181:UILabel = UILabel()
        let Label182:UILabel = UILabel()
        let Label183:UILabel = UILabel()
        let Label184:UILabel = UILabel()
        let Label185:UILabel = UILabel()
        let Label186:UILabel = UILabel()
        let Label187:UILabel = UILabel()
        let Label188:UILabel = UILabel()
        let Label189:UILabel = UILabel()
        let Label190:UILabel = UILabel()
        let Label191:UILabel = UILabel()
        let Label192:UILabel = UILabel()
        let Label193:UILabel = UILabel()
        let Label194:UILabel = UILabel()
        let Label195:UILabel = UILabel()
        let Label196:UILabel = UILabel()
        let Label197:UILabel = UILabel()
        let Label198:UILabel = UILabel()
        let Label199:UILabel = UILabel()
        let Label200:UILabel = UILabel()
        let Label201:UILabel = UILabel()
        let Label202:UILabel = UILabel()
        let Label203:UILabel = UILabel()
        let Label204:UILabel = UILabel()
        let Label205:UILabel = UILabel()
        let Label206:UILabel = UILabel()
        let Label207:UILabel = UILabel()
        let Label208:UILabel = UILabel()
        let Label209:UILabel = UILabel()
        let Label210:UILabel = UILabel()
        let Label211:UILabel = UILabel()
        let Label212:UILabel = UILabel()
        let Label213:UILabel = UILabel()
        let Label214:UILabel = UILabel()
        let Label215:UILabel = UILabel()
        let Label216:UILabel = UILabel()
        let Label217:UILabel = UILabel()
        let Label218:UILabel = UILabel()
        let Label219:UILabel = UILabel()
        let Label220:UILabel = UILabel()
        let Label221:UILabel = UILabel()
        let Label222:UILabel = UILabel()
        let Label223:UILabel = UILabel()
        let Label224:UILabel = UILabel()
        let Label225:UILabel = UILabel()
        let Label226:UILabel = UILabel()
        let Label227:UILabel = UILabel()
        let Label228:UILabel = UILabel()
        let Label229:UILabel = UILabel()
        let Label230:UILabel = UILabel()
        let Label231:UILabel = UILabel()
        
        let LabelBG1:UILabel = UILabel()
        let LabelBG2:UILabel = UILabel()
        let LabelBG3:UILabel = UILabel()
        let LabelBG4:UILabel = UILabel()
        let LabelBG5:UILabel = UILabel()
        let LabelBG6:UILabel = UILabel()
        let LabelBG7:UILabel = UILabel()
        let LabelBG8:UILabel = UILabel()
        let LabelBG9:UILabel = UILabel()
        let LabelBG10:UILabel = UILabel()
        let LabelBG11:UILabel = UILabel()
        let LabelBG12:UILabel = UILabel()
        let LabelBG13:UILabel = UILabel()
        let LabelBG14:UILabel = UILabel()
        let LabelBG15:UILabel = UILabel()
        let LabelBG16:UILabel = UILabel()
        let LabelBG17:UILabel = UILabel()
        let LabelBG18:UILabel = UILabel()
        let LabelBG19:UILabel = UILabel()
        let LabelBG20:UILabel = UILabel()
        let LabelBG21:UILabel = UILabel()
        let LabelBG22:UILabel = UILabel()
        let LabelBG23:UILabel = UILabel()
        let LabelBG24:UILabel = UILabel()
        let LabelBG25:UILabel = UILabel()
        let LabelBG26:UILabel = UILabel()
        let LabelBG27:UILabel = UILabel()
        let LabelBG28:UILabel = UILabel()
        let LabelBG29:UILabel = UILabel()
        let LabelBG30:UILabel = UILabel()
        let LabelBG31:UILabel = UILabel()
        let LabelBG32:UILabel = UILabel()
        let LabelBG33:UILabel = UILabel()
        let LabelBG34:UILabel = UILabel()
        let LabelBG35:UILabel = UILabel()
        let LabelBG36:UILabel = UILabel()
        let LabelBG37:UILabel = UILabel()
        let LabelBG38:UILabel = UILabel()
        let LabelBG39:UILabel = UILabel()
        let LabelBG40:UILabel = UILabel()
        let LabelBG41:UILabel = UILabel()
        let LabelBG42:UILabel = UILabel()
        let LabelBG43:UILabel = UILabel()
        let LabelBG44:UILabel = UILabel()
        let LabelBG45:UILabel = UILabel()
        let LabelBG46:UILabel = UILabel()
        let LabelBG47:UILabel = UILabel()
        let LabelBG48:UILabel = UILabel()
        let LabelBG49:UILabel = UILabel()
        let LabelBG50:UILabel = UILabel()
        
        let labelNames = [Label1,   Label2,  Label3,    Label4,   Label5,   Label6,
                          Label7,   Label8,  Label9,    Label10,  Label11,  Label12,
                          Label13,  Label14,  Label15,  Label16,  Label17,  Label18,
                          Label19,  Label20,  Label21,  Label22,  Label23,  Label24,
                          Label25,  Label26,  Label27,  Label28,  Label29,  Label30,
                          Label31,  Label32,  Label33,  Label34,  Label35,  Label36,
                          Label37,  Label38,  Label39,  Label40,  Label41,  Label42,
                          Label43,  Label44,  Label45,  Label46,  Label47,  Label48,
                          Label49,  Label50,  Label51,  Label52,  Label53,  Label54,
                          Label55,  Label56,  Label57,  Label58,  Label59,  Label60,
                          Label61,  Label62,  Label63,  Label64,  Label65,  Label66,
                          Label67,  Label68,  Label69,  Label70,  Label71,  Label72,
                          Label73,  Label74,  Label75,  Label76,  Label77,  Label78,
                          Label79,  Label80,  Label81,  Label82,  Label83,  Label84,
                          Label85,  Label86,  Label87,  Label88,  Label89,  Label90,
                          Label91,  Label92,  Label93,  Label94,  Label95,  Label96,
                          Label97,  Label98,  Label99,  Label100, Label101, Label102,
                          Label103, Label104, Label105, Label106, Label107, Label108,
                          Label109, Label110, Label111, Label112, Label113, Label114,
                          Label115, Label116, Label117, Label118, Label119, Label120,
                          Label121, Label122, Label123, Label124, Label125, Label126,
                          Label127, Label128, Label129, Label130, Label131, Label132,
                          Label133, Label134, Label135, Label136, Label137, Label138,
                          Label139, Label140, Label141, Label142, Label143, Label144,
                          Label145, Label146, Label147, Label148, Label149, Label150,
                          Label151, Label152, Label153, Label154, Label155, Label156,
                          Label157, Label158, Label159, Label160, Label161, Label162,
                          Label163, Label164, Label165, Label166, Label167, Label168,
                          Label169, Label170, Label171, Label172, Label173, Label174,
                          Label175, Label176, Label177, Label178, Label179, Label180,
                          Label181, Label182, Label183, Label184, Label185, Label186,
                          Label187, Label188, Label189, Label190, Label191, Label192,
                          Label193, Label194, Label195, Label196, Label197, Label198,
                          Label199, Label200, Label201, Label202, Label203, Label204,
                          Label205, Label206, Label207, Label208, Label209, Label210,
                          Label211, Label212, Label213, Label214, Label215, Label216,
                          Label217, Label218, Label219, Label220, Label221, Label222,
                          Label223, Label224, Label225, Label226, Label227, Label228,
                          Label229, Label230, Label231]
        
        let labelBGNames = [LabelBG1,  LabelBG2,  LabelBG3,  LabelBG4,  LabelBG5,
                            LabelBG6,  LabelBG7,  LabelBG8,  LabelBG9,  LabelBG10,
                            LabelBG11, LabelBG12, LabelBG13, LabelBG14, LabelBG15,
                            LabelBG16, LabelBG17, LabelBG18, LabelBG19, LabelBG20,
                            LabelBG21, LabelBG22, LabelBG23, LabelBG24, LabelBG25,
                            LabelBG26, LabelBG27, LabelBG28, LabelBG29, LabelBG30,
                            LabelBG31, LabelBG32, LabelBG33, LabelBG34, LabelBG35,
                            LabelBG36, LabelBG37, LabelBG38, LabelBG39, LabelBG40,
                            LabelBG41, LabelBG42, LabelBG43, LabelBG44, LabelBG45,
                            LabelBG46, LabelBG47, LabelBG48, LabelBG49, LabelBG50]
        
        //print("GH aRV clear the help area")
        // First clear the help area - note that the font is immaterial because
        // we are clearing the area (blue on blue)
        var idx = 0
        while idx < maxGameClearing {
            configureLabel(labelNameIn: labelBGNames[idx],
                           textIn: " ",
                           textColorIn: appColorBlue,
                           backgroundColorIn: appColorBlue,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: 400,
                           heightIn: 105,
                           boldOrRegularIn: weightRegular,
                           fontIn: arialFont)
            helpTextView.addSubview(labelBGNames[idx])
            yPosition += 105
            idx += 1
        }
        
        // Now extract the help information associated with the current section
        //print("GH aRV find the current section")
        
        // First find the current section
        idx = 0
        while idx < helpAreaText.count {
            theHelpEntry = helpAreaText[idx]
            var sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetType)
            var eidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetIdentifier)
            var range = sidx ..< eidx
            let theHelpType = String(theHelpEntry[range])
            if theHelpType == helpSectionIndicator {
                //print("GH aRV got an s type")
                sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetIdentifier)
                eidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetFont)
                range = sidx ..< eidx
                theHelpSection = String(theHelpEntry[range])
                theCaller = gdefault.helpCaller
                //print("GH aRV theHelpSection=\(theHelpSection) theCaller=\(theCaller)")
                if theCaller == theHelpSection {
                    //print("GH aRV got a match at idx=\(idx)")
                    break
                }
            }
            idx += 1
        }
        
        // Now idx points to the help section to be displayed
        
        yPosition = 0
        
        // So now get the font, bold/regular indicator, and color (note
        // that the color is for a section within a standard display)

        // First the font
        var sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetFont)
        var eidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetWeight)
        var range = sidx ..< eidx
        theFont = String(theHelpEntry[range])
        
        // Next the bold/regular indicator
        sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetWeight)
        eidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetStandardColor)
        range = sidx ..< eidx
        boldOrRegular = String(theHelpEntry[range])
        
        // Now the color code
        sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetStandardColor)
        eidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetRegularText)
        range = sidx ..< eidx
        theHelpType = String(theHelpEntry[range])
        switch theHelpType {
        case helpColorYellow:
            theColor = appColorYellow
        case helpColorBrightGreen:
            theColor = appColorBrightGreen
        case helpColorRed:
            theColor = appColorRed
        case helpColorOrange:
            theColor = appColorOrange
        case helpColorWhite:
            theColor = appColorWhite
        default:
            theColor = appColorYellow
        }
        
        // Now the section header text
        sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetSectionText)
        eidx = theHelpEntry.endIndex
        range = sidx ..< eidx
        theHelpSectionName = String(theHelpEntry[range])
        
        //print("GH aRV display section \(theHelpSectionName)")
        configureLabel(labelNameIn: labelNames[0],
                       textIn: theHelpSectionName,
                       textColorIn: theColor,
                       backgroundColorIn: appColorBlue,
                       xPositionIn: xPosition,
                       yPositionIn: yPosition,
                       widthIn: 400,
                       heightIn: 25,
                       boldOrRegularIn: boldOrRegular,
                       fontIn: theFont)
        helpTextView.addSubview(labelNames[0])
        
        var helpLineIndex = 1
        repeat {
            idx += 1
            //print("GH aRV display a help text line - idx=\(idx), helpLineIndex=\(helpLineIndex)")
            theHelpEntry = helpAreaText[idx]
            var sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetType)
            var eidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetIdentifier)
            var range = sidx ..< eidx
            var theHelpType = String(theHelpEntry[range])
            if theHelpType == helpSectionIndicator {
                //print("GH aRV break the loop - detected another section at index \(idx)")
                break
            }
            
            // theHelpType now points to the text indicator
            // So now get the font, bold/regular indicator, and color
            //
            // First the font
            sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetFont)
            eidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetWeight)
            range = sidx ..< eidx
            theFont = String(theHelpEntry[range])
            
            // Next the bold/regular indicator
            sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetWeight)
            eidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetStandardColor)
            range = sidx ..< eidx
            boldOrRegular = String(theHelpEntry[range])
            
            // Now the standard help text line color code
            sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetStandardColor)
            eidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetLinkColor)
            range = sidx ..< eidx
            theHelpType = String(theHelpEntry[range])
            switch theHelpType {
            case helpColorYellow:
                theColor = appColorYellow
            case helpColorBrightGreen:
                theColor = appColorBrightGreen
            case helpColorRed:
                theColor = appColorRed
            case helpColorOrange:
                theColor = appColorOrange
            case helpColorWhite:
                theColor = appColorWhite
            default:
                theColor = appColorYellow
            }
            
            // Lastly get the text
            sidx = theHelpEntry.index(theHelpEntry.startIndex, offsetBy: helpOffsetRegularText)
            eidx = theHelpEntry.endIndex
            range = sidx ..< eidx
            theHelpText = String(theHelpEntry[range])
            yPosition += 30
            
            // Finally display the help information line
            //print("GH aRV -- text=<\(theHelpText)>")
            configureLabel(labelNameIn: labelNames[helpLineIndex],
                           textIn: theHelpText,
                           textColorIn: theColor,
                           backgroundColorIn: appColorBlue,
                           xPositionIn: xPosition,
                           yPositionIn: yPosition,
                           widthIn: 400,
                           heightIn: 25,
                           boldOrRegularIn: boldOrRegular,
                           fontIn: theFont)
            helpTextView.addSubview(labelNames[helpLineIndex])
            helpLineIndex += 1
            //print("GH aRV at the end of the loop - idx=\(idx) limit=\(helpAreaText.count)")
        }
        while idx < helpAreaText.count - 1
        
        //print("GH aRF just displayed the help text, helpCaller is \(gdefault.helpCaller), currentHelpMode=\(currentHelpMode)")
        // Ensure that the help text always scrolls to the top to start
        self.helpTextView.setContentOffset(CGPoint(x: 0, y:0), animated: false)
        
        // Set the mode indicator to identify the fact that we are NOT processing
        // links now - just standard help text. This will prevent links from being processed
        // when they are no longer on the screen
        currentHelpMode = "s"
        
        if yPosition > twoThirdsScreen {
            resetHelpPosition = Int(Double(yPosition)) - twoThirdsScreen
        }
        else {
            resetHelpPosition = 0
        }
        
        //print("GH aRV lines=\(helpLineIndex) yPos=\(yPosition) reset position to=\(resetHelpPosition)")
        
        //print("GH aRV end aRefreshView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print("GH vWA start")
        aRefreshView()
        //print("GH vWA end")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("GH sVDS scroll y position =\(scrollView.contentOffset.y) compare to reset pos=\(resetHelpPosition)")
        if scrollView.contentOffset.y > CGFloat(resetHelpPosition) {
            //print("GH sVDS doing the reset")
            let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                scrollView.isScrollEnabled = false
                scrollView.setContentOffset(CGPoint(x: 0, y:self.resetHelpPosition), animated: false)
                scrollView.isScrollEnabled = true
            }
            anim.startAnimation()
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
