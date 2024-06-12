//
//  ViewController.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 1/28/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import UIKit

// Potential devices on which we could be running, including
// simulations of the same devices - this will be used to
// acquire the specific device on which we are running
public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String {
            #if os(iOS)
            switch identifier {
            case "iPod1,1":                                       return "iPod touch (1st generation)"
            case "iPod2,1":                                       return "iPod touch (2nd generation)"
            case "iPod3,1":                                       return "iPod touch (3rd generation)"
            case "iPod4,1":                                       return "iPod touch (4th generation)"
            case "iPod5,1":                                       return "iPod touch (5th generation)"
            case "iPod7,1":                                       return "iPod touch (6th generation)"
            case "iPod9,1":                                       return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":           return "iPhone 4"
            case "iPhone4,1":                                     return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                        return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                        return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                        return "iPhone 5s"
            case "iPhone7,2":                                     return "iPhone 6"
            case "iPhone7,1":                                     return "iPhone 6 Plus"
            case "iPhone8,1":                                     return "iPhone 6s"
            case "iPhone8,2":                                     return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                        return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                        return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                      return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                      return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                      return "iPhone X"
            case "iPhone11,2":                                    return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                      return "iPhone XS Max"
            case "iPhone11,8":                                    return "iPhone XR"
            case "iPhone12,1":                                    return "iPhone 11"
            case "iPhone12,3":                                    return "iPhone 11 Pro"
            case "iPhone12,5":                                    return "iPhone 11 Pro Max"
            case "iPhone13,1":                                    return "iPhone 12 mini"
            case "iPhone13,2":                                    return "iPhone 12"
            case "iPhone13,3":                                    return "iPhone 12 Pro"
            case "iPhone13,4":                                    return "iPhone 12 Pro Max"
            case "iPhone14,4":                                    return "iPhone 13 mini"
            case "iPhone14,5":                                    return "iPhone 13"
            case "iPhone14,2":                                    return "iPhone 13 Pro"
            case "iPhone14,3":                                    return "iPhone 13 Pro Max"
            case "iPhone14,7":                                    return "iPhone 14"
            case "iPhone14,8":                                    return "iPhone 14 Plus"
            case "iPhone15,2":                                    return "iPhone 14 Pro"
            case "iPhone15,3":                                    return "iPhone 14 Pro Max"
            case "iPhone15,4":                                    return "iPhone 15"
            case "iPhone15,5":                                    return "iPhone 15 Plus"
            case "iPhone16,1":                                    return "iPhone 15 Pro"
            case "iPhone16,2":                                    return "iPhone 15 Pro Max"
            case "iPhone8,4":                                     return "iPhone SE"
            case "iPhone12,8":                                    return "iPhone SE (2nd generation)"
            case "iPhone14,6":                                    return "iPhone SE (3rd generation)"
            case "iPad1,1", "iPad1,2":                            return "iPad 1"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":      return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":                 return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":                 return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                          return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                            return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                          return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7":                          return "iPad (8th generation)"
            case "iPad12,1", "iPad12,2":                          return "iPad (9th generation)"
            case "iPad13,18", "iPad13,19":                        return "iPad (10th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":                 return "iPad Air"
            case "iPad5,3", "iPad5,4":                            return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                          return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2":                          return "iPad Air (4th generation)"
            case "iPad13,16", "iPad13,17":                        return "iPad Air (5th generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":                 return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":                 return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":                 return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                            return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                          return "iPad mini (5th generation)"
            case "iPad14,1", "iPad14,2":                          return "iPad mini (6th generation)"
            case "iPad6,3", "iPad6,4":                            return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                            return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":      return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                           return "iPad Pro (11-inch) (2nd generation)"
            case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":  return "iPad Pro (11-inch) (3rd generation)"
            case "iPad14,3", "iPad14,4":                          return "iPad Pro (11-inch) (4th generation)"
            case "iPad6,7", "iPad6,8":                            return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                            return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":      return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                          return "iPad Pro (12.9-inch) (4th generation)"
            case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":return "iPad Pro (12.9-inch) (5th generation)"
            case "iPad14,5", "iPad14,6":                          return "iPad Pro (12.9-inch) (6th generation)"
            case "AppleTV5,3":                                    return "Apple TV"
            case "AppleTV6,2":                                    return "Apple TV 4K"
            case "AudioAccessory1,1":                             return "HomePod"
            case "AudioAccessory5,1":                             return "HomePod mini"
            case "i386", "x86_64", "arm64":                       return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                              return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}

// Larger screen iPhones
// (based on logical width >= 400 and logical height >= 736)
let largerScreeniPhones = [
                            "iPhone 15",
                            "iPhone 15 Plus",
                            "iPhone 15 Pro",
                            "iPhone 15 Pro Max",
                            "iPhone 14 Plus",
                            "iPhone 14 Pro",
                            "iPhone 14 Pro Max",
                            "iPhone 13 Pro Max",
                            "iPhone 12 Pro Max",
                            "iPhone 11 Pro Max",
                            "iPhone 11",
                            "iPhone XS Max",
                            "iPhone XR",
                            "iPhone 8 Plus",
                            "iPhone 7 Plus",
                            "iPhone 6S Plus",
                            "iPhone 6 Plus"]

// App colors
let appColorBlack = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
let appColorBlackHex = 0x000000
let appColorLightBlue = UIColor(red: 153.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
let appColorBlue = UIColor(red: 4.0/255.0, green: 51.0/255.0, blue: 255.0/255.0, alpha: 1.0)
let appColorClear = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.0)
let appColorGray = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 234.0/255.0, alpha: 1.0)
let appColorDarkGray = UIColor(red: 75.0/255.0, green: 75.0/255.0, blue: 75.0/255.0, alpha: 1.0)
let appColorBrightGreen = UIColor(red: 124.0/255.0, green: 255.0/255.0, blue: 103.0/255.0, alpha: 1.0)
let appColorGreenHex = 0x49cc34
let appColorDarkGreen = UIColor(red: 27.0/255.0, green: 99.0/255.0, blue: 21.0/255.0, alpha: 1.0)
let appColorMediumGreen = UIColor(red: 0.0/255.0, green: 155.0/255.0, blue: 0.0/255.0, alpha: 1.0)
let appColorOrange = UIColor(red: 255.0/255.0, green: 140.0/255.0, blue: 0.0/255.0, alpha: 1.0)
let appColorRed = UIColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
let appColorMediumRed = UIColor(red: 225.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
let appColorWhite = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
let appColorYellow = UIColor(red: 255.0/255.0, green: 251.0/255.0, blue: 0.0/255.0, alpha: 1.0)
let appColorYellowHex = 0xffff00

// Player sort descriptions
let playerSortDescription = ["Alphabetically by Name",
                            "In the Order They Were Added",
                            "In Order by Dealer",
                            "Low-to-High by Phase and Points",
                            "High-to-Low by Phase and Points"]
let playerShortSortDescription = ["Alphabetical",
                                  "Order Added",
                                  "Dealer Order",
                                  "Low-to-High",
                                  "High-to-Low"]

// Player sort codes (indexes) associated with above descriptions
let playerSortAlpha = "00"
let playerSortEntry = "01"
let playerSortDealer = "02"
let playerSortLowToHigh = "03"
let playerSortHighToLow = "04"

// These are all the Phase 10 games and associated phases
let gamesAndPhases = ["GOriginal",
"P2 sets of 3",
"P1 set of 3 + 1 run of 4",
"P1 set of 4 + 1 run of 4",
"P1 run of 7",
"P1 run of 8",
"P1 run of 9",
"P2 sets of 4",
"P7 cards of one color",
"P1 set of 5 + 1 set of 2",
"P1 set of 5 + 1 set of 3",
"GAncient Greece",
"P1 set of 2 + 1 run of 6",
"P1 color even or odd of 9",
"P1 color even or odd of 10",
"P1 color run of 3 + 1 set of 3",
"P1 set of 3 + 1 run of 5",
"P1 set of 5 + 1 run of 4",
"P1 color run of 5",
"P1 color even/odd of 3 + 1 even/odd of 5",
"P5 sets of 2",
"P2 sets of 3 + 2 sets of 2",
"GCandy Castle / Mountain Vista",
"P1 run of 3 + 3 sets of 2",
"P1 run of 8",
"P1 run of 9",
"P1 color run of 3 + 1 set of 3",
"P1 set of 2 + 2 sets of 3",
"P1 set of 2 + 1 set of 3 + 1 set of 4",
"P4 of one color + 6 of one color",
"P5 of one color + 5 of one color",
"P1 run of 5 + 1 set of 3 + 1 set of 2",
"P1 run of 3 + 1 set of 4 + 1 set of 3",
"GCocoa Canyon",
"P6 cards of one color",
"P7 cards of one color",
"P4 cards of one color + 5 of one color",
"P2 sets of 3",
"P1 run of 8",
"P1 run of 9",
"P1 set of 4 + 1 run of 4",
"P6 cards of even or odd",
"P1 set of 4 + 1 run of 6",
"P1 set of 5 + 1 run of 4",
"GCupcake Lounge / Savannah Sunset",
"P3 of 1 color + 3 of 1 color + 4 of 1 color",
"P1 color run of 3 + 2 sets of 2",
"P7 of one color",
"P1 set of 3 + 1 set of 3",
"P1 set of 4 + 1 set of 2",
"P1 set of 5",
"P2 color even or odd of 4",
"P1 run of 9",
"P1 color run of 5 + 2 sets of 2",
"P1 color run of 6 + 1 set of 2",
"GDisco Fever",
"P1 color even or odd of 8",
"P1 color even or odd of 9",
"P1 color run of 3 + 2 sets of 2",
"P7 of one color",
"P1 color run of 5 + 2 sets of 2",
"P1 color even/odd of 3 + 1 even/odd of 4",
"P1 color run of 4 + 1 set of 4",
"P1 color run of 4 + 3 sets of 2",
"P1 run of 3 + 2 sets of 3",
"P1 run of 3 + 1 set of 4 + 1 set of 3",
"GIsland Paradise",
"P1 run of 7",
"P1 set of 2 + 2 sets of 3",
"P1 run of 6 + 1 set of 2",
"P3 sets of 2 + 1 set of 3",
"P1 set of 3 + 1 run of 6",
"P2 runs of 4",
"P3 cards of one color + 1 set of 4",
"P8 cards of one color",
"P4 cards of one color + 1 set of 5",
"P9 cards of one color",
"GJazz Club",
"P1 color even or odd of 8",
"P1 color run of 3 + 1 set of 3",
"P1 color even or odd of 9",
"P1 color run of 4",
"P1 color even or odd of 10",
"P1 color run of 5",
"P1 color even or odd of 5",
"P1 color run of 5 + 1 set of 2",
"P1 color even or odd of 6",
"P1 color run of 5 + 3 of one color",
"GMoonlight Drive-In",
"P1 set of 4 + 1 set of 2",
"P2 sets of 3",
"P1 run of 7",
"P1 run of 8",
"P1 set of 2 + 2 sets of 3",
"P1 set of 5",
"P1 run of 9",
"P1 run of 6 + 2 sets of 2",
"P1 run of 8 + 1 set of 2",
"P1 set of 4 + 1 run of 6",
"GOcean Reef",
"P1 run of 7",
"P1 set of 4 + 1 set of 3",
"P1 color run of 5 + 1 set of 2",
"P1 color even or odd of 10",
"P2 runs of 5",
"P3 sets of 3",
"P1 color run of 4 + 1 set of 3",
"P1 color even/odd of 3 + 1 even/odd of 4",
"P1 run of 7 + 1 set of 2",
"P1 color run of 5 + 1 set of 3",
"GPrehistoric Valley",
"P1 color even or odd of 9",
"P1 color even or odd of 10",
"P1 run of 8",
"P1 run of 10",
"P2 sets of 3",
"P2 sets of 4",
"P1 color run of 4",
"P1 color run of 3 + 3 of one color",
"P1 set of 3 + 1 run of 4",
"P1 set of 4 + 1 run of 6",
"GSouthwest",
"P1 set of 2 + 1 run of 6",
"P1 color even or odd of 9",
"P1 color even or odd of 10",
"P1 color run of 3 + 1 set of 3",
"P1 set of 3 + 1 run of 5",
"P1 set of 5 + 1 run of 4",
"P1 color run of 5",
"P1 color even/odd of 3 + 1 even/odd of 5",
"P5 sets of 2",
"P2 sets of 3 + 2 sets of 2",
"GTwist",
"P3 sets of 3",
"P4 sets of 2",
"P1 set of 5 + 1 run of 4",
"P2 sets of 3 + 1 run of 3",
"P1 set of 3 + 1 run of 6",
"P2 runs of 4",
"P1 run of 4 + 4 cards of one color",
"P1 run of 5 of one color",
"P8 cards of one color",
"P9 cards of one color",
"GVintage Gas Station",
"P1 set of 3 + 1 run of 5",
"P1 run of 4 + 1 set of 3 + 1 set of 2",
"P1 run of 3 + 1 set of 3 + 2 sets of 2",
"P1 color run of 4",
"P1 color run of 4 + 1 set of 2",
"P1 color run of 4 + 2 sets of 2",
"P1 set of 5 + 1 run of 4",
"P1 color even or odd of 5",
"P1 color even or odd of 6",
"P1 color run/3 + 3 of 1 color + 1 set/2",
"GU Pick 10",
"P1 color even/odd of 3 + 1 even/odd of 4",
"P1 color even/odd of 3 + 1 even/odd of 5",
"P1 color even/odd of 5",
"P1 color even/odd of 6",
"P1 color run of 3 + 1 set of 3",
"P1 color run of 3 + 2 sets of 2",
"P1 color run of 3 + 3 cards of one color",
"P1 color run/3 + 3 cards 1 color + 1 set/2",
"P1 color run of 4",
"P1 color run of 4 + 1 set of 2",
"P1 color run of 4 + 1 set of 3",
"P1 color run of 4 + 1 set of 4",
"P1 color run of 4 + 2 sets of 2",
"P1 color run of 4 + 3 sets of 2",
"P1 color run of 5",
"P1 color run of 5 + 1 set of 2",
"P1 color run of 5 + 1 set of 3",
"P1 color run of 5 + 2 sets of 2",
"P1 color run of 5 + 3 cards of one color",
"P1 color run of 6 + 1 set of 2",
"P1 color even or odd of 10",
"P1 color even or odd of 8",
"P1 color even or odd of 9",
"P1 run of 10",
"P1 run of 3 + 1 set of 3 + 2 sets of 2",
"P1 run of 3 + 1 set of 4 + 1 set of 3",
"P1 run of 3 + 2 sets of 3",
"P1 run of 3 + 3 sets of 2",
"P1 run of 4 + 1 set of 3 + 1 set of 2",
"P1 run of 4 + 4 cards of one color",
"P1 run of 5 + 1 set of 3 + 1 set of 2",
"P1 run of 5 cards of one color",
"P1 run of 6 + 1 set of 2",
"P1 run of 6 + 2 sets of 2",
"P1 run of 7",
"P1 run of 7 + 1 set of 2",
"P1 run of 8",
"P1 run of 8 + 1 set of 2",
"P1 run of 9",
"P1 set of 2 + 1 run of 6",
"P1 set of 2 + 1 set of 3 + 1 set of 4",
"P1 set of 2 + 2 sets of 3",
"P1 set of 3 + 1 run of 4",
"P1 set of 3 + 1 run of 5",
"P1 set of 3 + 1 run of 6",
"P1 set of 3 + 1 set of 3",
"P1 set of 4 + 1 run of 4",
"P1 set of 4 + 1 run of 6",
"P1 set of 4 + 1 set of 2",
"P1 set of 4 + 1 set of 3",
"P1 set of 5",
"P1 set of 5 + 1 run of 4",
"P1 set of 5 + 1 set of 2",
"P1 set of 5 + 1 set of 3",
"P2 color even or odd of 4",
"P2 runs of 4",
"P2 runs of 5",
"P2 sets of 3",
"P2 sets of 3 + 1 run of 3",
"P2 sets of 3 + 2 sets of 2",
"P2 sets of 4",
"P3 cards of one color + 1 set of 4",
"P3 cards/1 color + 3 of 1 color + 4 of 1 color",
"P3 sets of 2 + 1 set of 3",
"P3 sets of 3",
"P4 cards of one color + 1 set of 5",
"P4 cards of one color + 5 cards of one color",
"P4 cards of one color + 6 cards of one color",
"P4 sets of 2",
"P5 cards of one color + 5 cards of one color",
"P5 sets of 2",
"P6 cards of even or odd",
"P6 cards of one color",
"P7 cards of one color",
"P8 cards of one color",
"P9 cards of one color",
"XThis is the end of the array"]

// Section codes for help invocation - These must match the section
// areas in the helpAreaText array below. Note that the numbers have
// been assigned in multiples of 5 to allow room for easily adding more
// sections without having to renumber all the entries.
let helpSectionCodeQuickStartGuide = "03"
let helpSectionCodePhaseDescriptions = "05"
let helpSectionCodeVersionHistory = "06"
let helpSectionCodeAddPlayer = "08"
let helpSectionCodeAddPoints = "10"
let helpSectionCodeAvailableGames = "15"
let helpSectionCodeClearAPhase = "20"
let helpSectionCodeDefaults = "25"
let helpSectionCodeEditGame = "30"
let helpSectionCodeEditPlayer = "35"
let helpSectionCodeTheGame = "40"
let helpSectionCodeGameVersionDisplay = "45"
let helpSectionCodeGameVersionSelection = "50"
let helpSectionCodePlayAGame = "55"
let helpSectionCodePlayerSortSelection = "60"
let helpSectionCodeStartANewGame = "65"
let helpSectionCodeUPick10PhaseSelection = "70"
let helpSectionCodeViewHistory = "75"
let helpSectionCodeWelcome = "80"

// Help data offsets - see below for how they're used
let helpOffsetType = 0
let helpOffsetIdentifier = 1
let helpOffsetFont = 3
let helpOffsetWeight = 4
let helpOffsetStandardColor = 5
let helpOffsetLinkColor = 6
let helpOffsetSectionText = 7
let helpOffsetRegularText = 6

// This identifier is translated to the info.circle symbol wherever it appears in help text
let helpSymbolString = "$!$"

// The following array contains all the help information for the app.
// Note that a maximum of 230 lines of help are allowed per section (not
// including the section header), and a maximum of 20 sections can be handled.
// To increase these limits if necessary, define more labels within arrays
// labelNames and linkNames in GenHelp. There must be one more label in labelNames
// than the line capacity. There must be the same number of labels in linkNames
// as the section capacity. 
// Entries are subdivided as follows:
//
// Offset Value Content
//
// ---- Section ----
// 0      s     new section
// 1-2    nn    2-digit section identifier (starting at 00)
// 3      a     arial font -or-
//        c     courier font
// 4      b     display bold text -or-
//        r     display regular text
// 5      n     color for text within standard help display
//        1     yellow -or-
//        2     green -or-
//        3     red -or-
//        4     orange -or-
//        5     white
// 6      n     color for text when displaying section heading link
//        1     yellow -or-
//        2     green -or-
//        3     red -or-
//        4     orange -or-
//        5     white
// 7-38   x...x 32 characters of section name to be displayed
// 39           not used
//
// ---- Text ----
// 0      t     text line within the current section
// 1-2    nn    2-digit section identifier (just for
//              section / text format standardization,
//              it's set to the current section number,
//              but it's not used)
// 3      a     arial font -or-
//        c     courier font
// 4      b     display bold text -or-
//        r     display regular text
// 5      1     yellow -or-
//        2     green -or-
//        3     red -or-
//        4     orange -or-
//        5     white
// 6-39   x...x 34 characters of regular text to be displayed -or-
// 6-35   x...x 30 characters of bold text to be displayed
// 36-39        not used
// Note that a text line of "$!$" is automatically converted to
// the SF symbol info.circle, which is a courier font i within a circle
//
let helpAreaText = ["s03ab54Quick Start Guide",
                    "t03ar2 ",
                    "t03ar2Follow these steps to start a game",
                    "t03ar2for the first time:",
                    "t03ar21. Press Play A Game.",
                    "t03ar22. Press Start A New Game.",
                    "t03ar23. Press Start From Scratch.",
                    "t03ar24. Press Add Player. For each",
                    "t03ar2    player, press the player name",
                    "t03ar2    and change it as you like, and",
                    "t03ar2    press Add.",
                    "t03ar2 ",
                    "t03ar2That's it!",
                    "t03ar2 ",
                    "t03ar2All the players are now listed on",
                    "t03ar2the Game screen, and you are ready",
                    "t03ar2to play the classic Original Phase 10",
                    "t03ar2game. Deal the cards and begin your",
                    "t03ar2first round.",
                    "t03ar2 ",
                    "t03ar2Press the Clear Phase button for",
                    "t03ar2each player as soon as they clear",
                    "t03ar2phase. Then, when someone goes",
                    "t03ar2out, press Add Points for each",
                    "t03ar2player and enter their points.",
                    "t03ar2Finally, press End Round to tell",
                    "t03ar2Phase 10 Easy Score that a new",
                    "t03ar2round is beginning, and it will",
                    "t03ar2advance the dealer indicator",
                    "t03ar2automatically.",
                    "t03ar2 ",
                    "t03ar2Continue playing until someone",
                    "t03ar2wins!",
                    "t03ar2 ",
                    "t03ar2There are numerous other features",
                    "t03ar2and options available in Phase 10",
                    "t03ar2Easy Score. Either explore them on",
                    "t03ar2your own, or press the $!$ key at",
                    "t03ar2any time for detailed information.",
                    "t03ar2 ",
                    "t03ar2Enjoy!",
                    
                    "s05ab54Phase Descriptions",
                    "t05ar2 ",
                    "t05ar2There are over 75 different phases",
                    "t05ar2that can be used in Phase 10 Easy",
                    "t05ar2Score. These can be reduced to a",
                    "t05ar2few categories as follows:",
                    "t05ar2 ",
                    "t05ar5Sets",
                    "t05ar2  This is a grouping of 2 or more",
                    "t05ar2  cards of the same number in any",
                    "t05ar2  combination of colors. If more",
                    "t05ar2  than one set is required for a",
                    "t05ar2  phase, each set must be different,",
                    "t05ar2  such as three 7s and three 9s.",
                    "t05ar2 ",
                    "t05ar5Runs",
                    "t05ar2  This is a grouping of 3 or more",
                    "t05ar2  cards of any colors in consecutive",
                    "t05ar2  order like 11, 12, 13.",
                    "t05ar2 ",
                    "t05ar5All One Color",
                    "t05ar2  All the cards must be the same",
                    "t05ar2  color. The number of cards that",
                    "t05ar2  constitutes a group will vary. If",
                    "t05ar2  more than one such grouping is",
                    "t05ar2  specified in a phase, each group",
                    "t05ar2  must be a different color.",
                    "t05ar2 ",
                    "t05ar5Color Run",
                    "t05ar2  This is a grouping of 4 or more",
                    "t05ar2  cards like 8, 9, 10, 11, all of the",
                    "t05ar2  same color and in consecutive",
                    "t05ar2  order.",
                    "t05ar2 ",
                    "t05ar5Even or Odd",
                    "t05ar2  All the cards must be even, like",
                    "t05ar2  4, 6, 8, 10, 12, of any colors.",
                    "t05ar2  Or they must all be odd, like",
                    "t05ar2  7, 9, 11, 13, of any colors. The",
                    "t05ar2  number of even or odd cards that",
                    "t05ar2  constitutes a group will vary.",
                    "t05ar2 ",
                    "t05ar5Even/Odd/One Color",
                    "t05ar2  This is a grouping of 3 or more",
                    "t05ar2  cards that are all odd and of the",
                    "t05ar2  same color, like green 1, 7, 11, 13",
                    "t05ar2  or 3 or more cards that are all",
                    "t05ar2  even and of the same color, like",
                    "t05ar2  red 2, 4, 6, 8, 12.",
                    
                    "s06ab54Version History",
                    "t06ar2 ",
                    "t06ar5Version 7.0 November 2023",
                    "t06ar2- Add support for IOS 17.0 and",
                    "t06ar2  iPhone 15.",
                    "t06ar2- Add the current sort order to",
                    "t06ar2  the top of the Game screen.",
                    "t06ar2- When adding a player, correct",
                    "t06ar2  the screen display when editing",
                    "t06ar2  the dealer sequence number.",
                    "t06ar2- When restarting a game and then",
                    "t06ar2  changing the phase modifier to",
                    "t06ar2  odd or even, the clear phase",
                    "t06ar2  button did not work for existing",
                    "t06ar2  players.",
                    "t06ar2- 4-digit point totals on the Game",
                    "t06ar2  screen were truncated on certain",
                    "t06ar2  devices.",
                    "t06ar2- The cumulative point total for",
                    "t06ar2  any player was allowed to exceed",
                    "t06ar2  9999.",
                    "t06ar2- Shorten the history message",
                    "t06ar2  that a player has been edited so",
                    "t06ar2  that it is no longer truncated.",
                    "t06ar2  ",
                    "t06ar5Version 6.0 April 2023",
                    "t06ar2- Add support for IOS 16.4 and",
                    "t06ar2  iPhone 14.",
                    "t06ar2- Prevent quick intermediate",
                    "t06ar2  screen displays whenever",
                    "t06ar2  pressing the Update button",
                    "t06ar2  on a Game Version",
                    "t06ar2  Confirmation screen.",
                    "t06ar2- Add Quick View button to the",
                    "t06ar2  Available Games screen.",
                    "t06ar2  Pressing it displays",
                    "t06ar2  the currently-centered",
                    "t06ar2  game's version and",
                    "t06ar2  associated phases.",
                    "t06ar2- On the Default Settings and",
                    "t06ar2  Edit Game screens, for clarity,",
                    "t06ar2  the Game Version heading has",
                    "t06ar2  been changed from 'Game",
                    "t06ar2  Version' to 'Game Version",
                    "t06ar2  (Tap below to change)'.",
                    "t06ar2- On the Welcome screen, the",
                    "t06ar2  message that suggests deleting",
                    "t06ar2  some games has been changed",
                    "t06ar2  from 'There are nn games on",
                    "t06ar2  file' to 'You have nn games on",
                    "t06ar2  file'. This is to provide clarity",
                    "t06ar2  that these are games created",
                    "t06ar2  by the user, not the game",
                    "t06ar2  versions provided by the app.",
                    "t06ar2- Add Quick View and Version",
                    "t06ar2  History to help.",
                    "t06ar2 ",
                    "t06ar5Version 5.0 August 2022",
                    "t06ar2- Fix a bug where the Clear Phase",
                    "t06ar2  button was not recognized after",
                    "t06ar2  editing a player.",
                    "t06ar2- Fix a bug where player(s) were",
                    "t06ar2  sometimes marked as skipped",
                    "t06ar2  when starting a game.",
                    "t06ar2 ",
                    "t06ar5Version 4.0 June 2022",
                    "t06ar2- No longer show the game's",
                    "t06ar2  phases on the Game screen.",
                    "t06ar2- Add the round number to the",
                    "t06ar2  top of the Game screen.",
                    "t06ar2- Fix a bug to prevent quick",
                    "t06ar2  intermediate screens from",
                    "t06ar2  flashing whenever pressing",
                    "t06ar2  the Start Over button.",
                    "t06ar2- Provide support for new",
                    "t06ar2  iPhone and iPad models.",
                    "t06ar2- Add a facility for the user to",
                    "t06ar2  quickly rate the app with",
                    "t06ar2  1-5 stars, or to provide a",
                    "t06ar2  more detailed rating in the",
                    "t06ar2  App Store as desired.",
                    "t06ar2- Fix a bug so that skipped",
                    "t06ar2  players are now 'unskipped'",
                    "t06ar2  when restarting a game or",
                    "t06ar2  when copying players to a",
                    "t06ar2  new game.",
                    "t06ar2 ",
                    "t06ar5Version 3.0 September 2021",
                    "t06ar2- Provide option to prevent",
                    "t06ar2  the screen from shutting off",
                    "t06ar2  while the app is running.",
                    "t06ar2- Add Skip button to all players",
                    "t06ar2  to keep track to who has been",
                    "t06ar2  skipped in a round.",
                    "t06ar2- Change the help display so that",
                    "t06ar2  if the text does not fill it, the",
                    "t06ar2  ability to scroll will stop at the",
                    "t06ar2  end of the text, nbot scroll",
                    "t06ar2  (emptily) until the end of",
                    "t06ar2  the window.",
                    "t06ar2- Change the Game display so that",
                    "t06ar2  if the data does not fill it, the",
                    "t06ar2  ability to scroll will stop at the",
                    "t06ar2  end of the game, not scroll",
                    "t06ar2  (emptily) until the end of the",
                    "t06ar2  window.",
                    "t06ar2- Fix memory leak when using help.",
                    "t06ar2- Dynamicall acquire the screen",
                    "t06ar2  width and use this to fix the",
                    "t06ar2  problem where an iPad's help",
                    "t06ar2  text was offset too far to the",
                    "t06ar2  right.",
                    "t06ar2- Fix a bug that caused the app to",
                    "t06ar2  crash after turning dealer",
                    "t06ar2  tracking back on and then ending",
                    "t06ar2  a round.",
                    "t06ar2  ",
                    "t06ar5Version 2.0 February 2021",
                    "t06ar2- Added support for IOS 14.2.",
                    "t06ar2- Enhanced Game screen ease of",
                    "t06ar2  use by moving the top row of",
                    "t06ar2  buttons to directly above the",
                    "t06ar2  bottom row of buttons.",
                    "t06ar2- Fixed bug where history file",
                    "t06ar2  access would crash in certain",
                    "t06ar2  situations.",
                    "t06ar2- Fixed bug where the dealer",
                    "t06ar2  sequence could be set beyond",
                    "t06ar2  its maximum value of 99.",
                    "t06ar2- Made some minor help",
                    "t06ar2  documentation changes.",
                    "t06ar2- Enhanced the Edit Game screen",
                    "t06ar2  to include a new option Print",
                    "t06ar2  Phase Cards. The associated",
                    "t06ar2  help has been uopdated too.",
                    "t06ar2  ",
                    "t06ar5Version 1.0 November 2020",
                    "t06ar2- Initial version.",

                    "s08ab55Add A Player Screen",
                    "t08ar2 ",
                    "t08ar2This screen appears when you",
                    "t08ar2want to add a player to your",
                    "t08ar2game. It allows you to add a",
                    "t08ar2player quickly by accepting all the",
                    "t08ar2defaults or by tailoring the",
                    "t08ar2options provided.",
                    "t08ar2 ",
                    "t08ab1Player Name",
                    "t08ar2The system will automatically",
                    "t08ar2provide a name of Player01,",
                    "t08ar2Player02, etc. You may change",
                    "t08ar2the name as desired, as long as it",
                    "t08ar2is different from all the other",
                    "t08ar2players in this game.",
                    "t08ar2 ",
                    "t08ab1Mark As Dealer",
                    "t08ar2This option is used only if you are",
                    "t08ar2tracking the dealer in this game.",
                    "t08ar2The system will automatically",
                    "t08ar2mark the first player being added",
                    "t08ar2to the game as the dealer. Any",
                    "t08ar2player entered thereafter may be",
                    "t08ar2designated as the dealer if",
                    "t08ar2desired. Note that while playing",
                    "t08ar2the game, the system will",
                    "t08ar2advance the dealer after the",
                    "t08ar2completion of every round.",
                    "t08ar2 ",
                    "t08ab1Player Chooses Phase",
                    "t08ar2The default for this switch is set",
                    "t08ar2to no, which means that the",
                    "t08ar2player will proceed through the",
                    "t08ar2phases sequentially. They start",
                    "t08ar2with phase 1, advance to phase",
                    "t08ar22, phase 3, etc. However, a player",
                    "t08ar2may opt to choose the phase",
                    "t08ar2they want to play based on the",
                    "t08ar2hand they are dealt. If you set",
                    "t08ar2this option to yes, then you will",
                    "t08ar2be able to specify the chosen",
                    "t08ar2phase when you press the Clear",
                    "t08ar2Phase Button.",
                    "t08ar2 ",
                    "t08ab1Entry Sequence",
                    "t08ar2This field is not changeable. It is",
                    "t08ar2simply provided to show the",
                    "t08ar2order in which each player is",
                    "t08ar2added to the game.",
                    "t08ar2 ",
                    "t08ab1Dealer Sequence",
                    "t08ar2The system automatically sets the",
                    "t08ar2dealer sequence to the order in which",
                    "t08ar2players were entered. Entry sequence",
                    "t08ar2numbers are set to 1, 2, 3, ... while",
                    "t08ar2dealer sequence numbers are set to",
                    "t08ar25, 10, 15, ... to allow more room to",
                    "t08ar2change them. If you want to change",
                    "t08ar2the dealer order you may use any",
                    "t08ar2numbers from 1-99. However, if you",
                    "t08ar2are not sure of the specific order in",
                    "t08ar2which the players will deal, just",
                    "t08ar2accept the default dealer sequence",
                    "t08ar2now, and use Edit Player later to",
                    "t08ar2change it. Please refer to the Edit",
                    "t08ar2Player help screen for an example of",
                    "t08ar2how to accomplish this. In either",
                    "t08ar2case, note that this option is used",
                    "t08ar2only if you are tracking the dealer",
                    "t08ar2in this game.",
                    "t08ar2 ",
                    "t08ab1Cancel",
                    "t08ar2This button exits this screen and",
                    "t08ar2returns to the Game Screen without",
                    "t08ar2adding a new player.",
                    "t08ar2 ",
                    "t08ab1Add",
                    "t08ar2This button adds the new player",
                    "t08ar2and returns to the Game screen.",
                    "t08ar2 ",
                    "t08cb1$!$",
                    "t08ar2This button provides help for the",
                    "t08ar2current screen throughout the",
                    "t08ar2app. Press Contents for links to",
                    "t08ar2all available help, and press Done",
                    "t08ar2when you are finished.",
                    
                    "s10ab55Add Points Screen",
                    "t10ar2 ",
                    "t10ar2It is on this screen that you add",
                    "t10ar2points to each player when",
                    "t10ar2someone goes out at the end of a",
                    "t10ar2round. This screen shows how",
                    "t10ar2many points the player already",
                    "t10ar2has and provides a blank space",
                    "t10ar2to enter the points left in the",
                    "t10ar2player's hand at the end of the",
                    "t10ar2current round.",
                    "t10ar2 ",
                    "t10ab1Add Points",
                    "t10ar2Using the keyboard, enter the",
                    "t10ar2appropriate number of points left",
                    "t10ar2in the player's hand at the end of",
                    "t10ar2the current round. You may enter",
                    "t10ar2any multiple of 5 ranging from 5",
                    "t10ar2to 250 with the exception of 245",
                    "t10ar2points (this score is not possible",
                    "t10ar2to achieve). If the player has not",
                    "t10ar2cleared phase, you must enter 50",
                    "t10ar2points or more.",
                    "t10ar2 ",
                    "t10ab1Cancel",
                    "t10ar2This button returns you to the",
                    "t10ar2Game screen without adding any",
                    "t10ar2points.",
                    "t10ar2 ",
                    "t10ab1Update",
                    "t10ar2This button adds the new points",
                    "t10ar2entered on the screen for this",
                    "t10ar2round to the player's current",
                    "t10ar2total and returns to the Game",
                    "t10ar2screen.",
                    "t10ar2 ",
                    "t10cb1$!$",
                    "t10ar2This button provides help for the",
                    "t10ar2current screen throughout the",
                    "t10ar2app. Press Contents for links to",
                    "t10ar2all available help, and press Done",
                    "t10ar2when you are finished.",
                    
                    "s15ab55Available Games Screen",
                    "t15ar2 ",
                    "t15ar2This screen will appear whenever",
                    "t15ar2you have selected an option that",
                    "t15ar2requires you to perform an action",
                    "t15ar2on a game, including copying",
                    "t15ar2players, restarting, resuming, or",
                    "t15ar2removing a game. The spinning",
                    "t15ar2wheel in the center will show all",
                    "t15ar2the games from which you may",
                    "t15ar2choose. Line up your choice with",
                    "t15ar2the arrows.",
                    "t15ar2 ",
                    "t15ar2Only one of the following two",
                    "t15ar2buttons will appear at a time.",
                    "t15ar2 ",
                    "t15ab1Choose a Game",
                    "t15ar2Use this button to select the",
                    "t15ar2game that lines up with the",
                    "t15ar2arrows. The action (copy players,",
                    "t15ar2restart, or resume) will then be",
                    "t15ar2done.",
                    "t15ar2 ",
                    "t15ab1Quick View",
                    "t15ar2This button provides a quick look",
                    "t15ar2at the game that lines up with the",
                    "t15ar2arrows. It includes the game name,",
                    "t15ar2game version, all/even/odd phases",
                    "t15ar2being played, and all the players.",
                    "t15ar2No copy, restart, resume, or",
                    "t15ar2removal is done. Its purpose is to",
                    "t15ar2allow you to look at the game",
                    "t15ar2first in case you are not sure which",
                    "t15ar2one to select.",
                    "t15ar2 ",
                    "t15ab1Remove a Game",
                    "t15ar2Use this button to remove a",
                    "t15ar2game by selecting the game that",
                    "t15ar2lines up with the arrows. Before",
                    "t15ar2the game is removed, you will be",
                    "t15ar2asked to confirm your choice.",
                    "t15ar2 ",
                    "t15ab1Cancel",
                    "t15ar2This button returns you to the",
                    "t15ar2last screen you were on before",
                    "t15ar2arriving at the Available Games",
                    "t15ar2screen. No players will be copied,",
                    "t15ar2and no games will be restarted,",
                    "t15ar2resumed, or removed.",
                    "t15ar2 ",
                    "t15cb1$!$",
                    "t15ar2This button provides help for the",
                    "t15ar2current screen throughout the",
                    "t15ar2app. Press Contents for links to",
                    "t15ar2all available help, and press Done",
                    "t15ar2when you are finished.",
                    
                    "s20ab55Clear A Phase Screen",
                    "t20ar2 ",
                    "t20ar2This screen is shown when you",
                    "t20ar2press the Clear Phase button for",
                    "t20ar2a player who is choosing their",
                    "t20ar2own phases. If they are not",
                    "t20ar2choosing their own phases, the",
                    "t20ar2system simply advances them to",
                    "t20ar2the next phase immediately, and",
                    "t20ar2this screen will not appear.",
                    "t20ar2 ",
                    "t20ab1Phases",
                    "t20ar2When you press the phase being",
                    "t20ar2cleared from the list of all",
                    "t20ar2available phases, the system will",
                    "t20ar2automatically highlight it. Note",
                    "t20ar2that any phases that have already",
                    "t20ar2been cleared by this player will",
                    "t20ar2be flagged with a checkmark.",
                    "t20ar2 ",
                    "t20ab1Clear Phase",
                    "t20ar2Use this button to clear the",
                    "t20ar2phase that you highlighted as",
                    "t20ar2described above.",
                    "t20ar2 ",
                    "t20ab1Cancel",
                    "t20ar2This button returns you to the",
                    "t20ar2Game screen without clearing a",
                    "t20ar2phase.",
                    "t20ar2 ",
                    "t20cb1$!$",
                    "t20ar2This button provides help for the",
                    "t20ar2current screen throughout the",
                    "t20ar2app. Press Contents for links to",
                    "t20ar2all available help, and press Done",
                    "t20ar2when you are finished.",
                    
                    "s25ab55Default Settings Screen",
                    "t25ar2 ",
                    "t25ar2The default settings that appear",
                    "t25ar2the first time you use Phase 10",
                    "t25ar2Easy Score are just suggestions",
                    "t25ar2and may be altered at any time.",
                    "t25ar2Your changes will remain in effect",
                    "t25ar2until you alter them again.",
                    "t25ar2 ",
                    "t25ab1Track Dealer",
                    "t25ar2This yes/no option tells Phase 10",
                    "t25ar2Easy Score whether or not you",
                    "t25ar2would like it to keep track of the",
                    "t25ar2person dealing for each round",
                    "t25ar2throughout the game.",
                    "t25ar2 ",
                    "t25ab1Game Version",
                    "t25ar2Use this button to move to the",
                    "t25ar2Game Version Selection screen",
                    "t25ar2where you will be given the",
                    "t25ar2opportunity to select the game",
                    "t25ar2version you wish to set as the",
                    "t25ar2default. There are 14 versions to",
                    "t25ar2choose from, along with 3",
                    "t25ar2options per choice (play all",
                    "t25ar2phases, even-numbered phases",
                    "t25ar2only, or odd-numbered phases",
                    "t25ar2only). You may also create your",
                    "t25ar2own game by selecting any 10",
                    "t25ar2phases from the list of over 75",
                    "t25ar2phases listed in the U Pick 10",
                    "t25ar2version.",
                    "t25ar2 ",
                    "t25ab1Sort Players",
                    "t25ar2Use this button to move to the",
                    "t25ar2Player Sort Selection screen",
                    "t25ar2where you will be given the",
                    "t25ar2opportunity to select the default",
                    "t25ar2order in which the players will be",
                    "t25ar2displayed on the Game screen.",
                    "t25ar2Choose one from the 5 different",
                    "t25ar2sequences offered.",
                    "t25ar2 ",
                    "t25ab1Done",
                    "t25ar2This button takes you back to the",
                    "t25ar2Welcome screen.",
                    "t25ar2 ",
                    "t25cb1$!$",
                    "t25ar2This button provides help for the",
                    "t25ar2current screen throughout the",
                    "t25ar2app. Press Contents for links to",
                    "t25ar2all available help, and press Done",
                    "t25ar2when you are finished.",
                    
                    "s30ab55Edit Game Screen",
                    "t30ar2 ",
                    "t30ar2Use this screen to change the name",
                    "t30ar2of the game, to determine whether",
                    "t30ar2or not to keep track of the dealer,",
                    "t30ar2or to change the game version.",
                    "t30ar2Note that only dealer tracking and",
                    "t30ar2the game name may be changed",
                    "t30ar2once game scoring has started.",
                    "t30ar2 ",
                    "t30ab1Game Name",
                    "t30ar2Phase 10 Easy Score automatically",
                    "t30ar2assigns a unique game name",
                    "t30ar2whenever you start a new game. It",
                    "t30ar2consists of $YYYYMMDDHHMMSS,",
                    "t30ar2where YYYYMMDD is the current",
                    "t30ar2year, month, and day, and HHMMSS",
                    "t30ar2is the current hour, minute, and",
                    "t30ar2second when the game was created.",
                    "t30ar2You may replace the system-",
                    "t30ar2generated name with the name of",
                    "t30ar2your choice. Enter any name",
                    "t30ar2consisting of letters, digits, or",
                    "t30ar2spaces that does not duplicate any",
                    "t30ar2other game name.",
                    "t30ar2 ",
                    "t30ab1Track Dealer",
                    "t30ar2This yes/no option tells Phase 10",
                    "t30ar2Easy Score whether or not you",
                    "t30ar2would like it to keep track of the",
                    "t30ar2person dealing for each round",
                    "t30ar2throughout the game.",
                    "t30ar2 ",
                    "t30ab1Game Version",
                    "t30ar2Use this button to select the",
                    "t30ar2game version you wish to play.",
                    "t30ar2There are 14 versions to choose",
                    "t30ar2from, along with 3 options per",
                    "t30ar2choice (play all phases, even-",
                    "t30ar2numbered phases only, or odd-",
                    "t30ar2numbered phases only). You may",
                    "t30ar2also create your own game by",
                    "t30ar2selecting any 10 phases from the",
                    "t30ar2list of over 75 phases listed in the",
                    "t30ar2U Pick 10 version.",
                    "t30ar2 ",
                    "t30ab1Done",
                    "t30ar2This button saves your changes",
                    "t30ar2and returns you to the Game screen.",
                    "t30ar2 ",
                    "t30ab1Print Phase Cards",
                    "t30ar2Use this button to print a set of",
                    "t30ar2six phase cards specifically",
                    "t30ar2tailored for the game version you",
                    "t30ar2selected. Your Phase 10 card game",
                    "t30ar2provides phase cards for the",
                    "t30ar2original version of the game.",
                    "t30ar2However, Phase 10 Easy Score",
                    "t30ar2offers you the option of printing",
                    "t30ar2phase cards for any version of the",
                    "t30ar2game on an AirPrint-compatible",
                    "t30ar2wireless printer by following a few",
                    "t30ar2simple steps. Begin by pressing",
                    "t30ar2Print on the next screen, which",
                    "t30ar2will take you to the Printer",
                    "t30ar2Options screen. Select the printer",
                    "t30ar2on your WiFi network, change the",
                    "t30ar2number of copies if one page of six",
                    "t30ar2cards is not enough, adjust your",
                    "t30ar2options as needed, and press Print",
                    "t30ar2at the top of the screen.",
                    "t30ar2For additional information, please",
                    "t30ar2use your browser to access",
                    "t30ar2support.apple.com/en-us/HT201311",
                    "t30ar2to view a list of all the current",
                    "t30ar2AirPrint devices.",
                    "t30ar2 ",
                    "t30cb1$!$",
                    "t30ar2This button provides help for the",
                    "t30ar2current screen throughout the",
                    "t30ar2app. Press Contents for links to",
                    "t30ar2all available help, and press Done",
                    "t30ar2when you are finished.",
                    
                    "s35ab55Edit Player Screen",
                    "t35ar2 ",
                    "t35ar2This screen allows you to make",
                    "t35ar2changes to a player's options, to",
                    "t35ar2correct any scoring errors, or to",
                    "t35ar2remove this player from the",
                    "t35ar2game.",
                    "t35ar2 ",
                    "t35ab1Player Name",
                    "t35ar2You may change the player's",
                    "t35ar2name as desired, as long as it is",
                    "t35ar2different from all the other",
                    "t35ar2players in this game.",
                    "t35ar2 ",
                    "t35ab1Phase(s) Done",
                    "t35ar2If the player is not choosing",
                    "t35ar2phases, only the highest phase",
                    "t35ar2they have completed will be",
                    "t35ar2shown. For example, if phase 4",
                    "t35ar2is shown, the player is currently",
                    "t35ar2working to clear phase 5. You",
                    "t35ar2may change this to any phase from",
                    "t35ar21 to 10, or remove it. If the",
                    "t35ar2player is choosing phases, every",
                    "t35ar2phase they have completed will be",
                    "t35ar2shown, as well as room to enter",
                    "t35ar2additional completed phases for a",
                    "t35ar2maximum total of 10 phases. You",
                    "t35ar2may change any phases, add new",
                    "t35ar2phases, or remove any phases from",
                    "t35ar21 to 10. Note that if you press",
                    "t35ar2the Update button, this player's",
                    "t35ar2Clear Phase button will always ",
                    "t35ar2become enabled.",
                    "t35ar2 ",
                    "t35ab1Points",
                    "t35ar2This player's current point total",
                    "t35ar2will be shown. You may change it",
                    "t35ar2to any multiple of 5 or to a value",
                    "t35ar2of zero.",
                    "t35ar2 ",
                    "t35ab1Dealer Sequence",
                    "t35ar2If you want to set up the order in",
                    "t35ar2which the players will deal, and",
                    "t35ar2make it different from the entry",
                    "t35ar2sequence, you may provide your",
                    "t35ar2own numbers from 1-99 here.",
                    "t35ar2For example, if you enter the",
                    "t35ar2players into the game as they",
                    "t35ar2walk into the room, and they sit",
                    "t35ar2down at the table in random",
                    "t35ar2order, by default, the dealer",
                    "t35ar2sequence numbers will be",
                    "t35ar2assigned in the same order. This",
                    "t35ar2means that the dealer in the next",
                    "t35ar2round could be sitting anywhere",
                    "t35ar2at the table. To fix this, use the",
                    "t35ar2Edit Player option to reassign the",
                    "t35ar2dealer sequence numbers so that",
                    "t35ar2they proceed around the table in",
                    "t35ar2the order the players are sitting.",
                    "t35ar2The above scenario is shown in",
                    "t35ar2the following diagram in which E",
                    "t35ar2represents the entry sequence, D",
                    "t35ar2represents the dealer sequence,",
                    "t35ar2and each player is shown where",
                    "t35ar2they sat down at the table:",
                    "t35cb4 E1/D5              E3/D15",
                    "t35cb3 +-----------------------+",
                    "t35cb3 |         table         |",
                    "t35cb3 +-----------------------+",
                    "t35cb4 E2/D10             E4/D20",
                    "t35ar2As you can see, dealing would",
                    "t35ar2bounce across the table and from",
                    "t35ar2corner to corner. To fix this, use",
                    "t35ar2Edit Player and change D15 to 7",
                    "t35ar2and D20 to 9.",
                    "t35ar2This yields the following results:",
                    "t35cb4 E1/D5               E3/D7",
                    "t35cb3 +-----------------------+",
                    "t35cb3 |         table         |",
                    "t35cb3 +-----------------------+",
                    "t35cb4 E2/D10              E4/D9",
                    "t35ar2Now, dealing will proceed",
                    "t35ar2clockwise around the table.",
                    "t35ar2Note that this option is used only",
                    "t35ar2if you are tracking the dealer in",
                    "t35ar2this game.",
                    "t35ar2 ",
                    "t35ab1Mark As Dealer",
                    "t35ar2This is used to change the current",
                    "t35ar2dealer to a different player, if",
                    "t35ar2dealer tracking is in use for this",
                    "t35ar2game. Simply edit the player you",
                    "t35ar2would like to become the new",
                    "t35ar2dealer and set the Mark As",
                    "t35ar2Dealer option to yes for that",
                    "t35ar2player. Once the dealer is",
                    "t35ar2assigned in this way, the system",
                    "t35ar2will automatically remove the",
                    "t35ar2dealer designation from the",
                    "t35ar2original player. Note that you",
                    "t35ar2may not change the dealer by",
                    "t35ar2editing the player who is the",
                    "t35ar2current dealer and switching the",
                    "t35ar2Mark As Dealer option to No",
                    "t35ar2because the system would not",
                    "t35ar2know which player is to become",
                    "t35ar2the new dealer.",
                    "t35ar2 ",
                    "t35ab1Player Chooses Phase",
                    "t35ar2Use this option to change a",
                    "t35ar2player from/to choosing phases if",
                    "t35ar2the player has not yet cleared",
                    "t35ar2any phases.",
                    "t35ar2 ",
                    "t35ab1Cancel",
                    "t35ar2This button returns you to the",
                    "t35ar2Game screen without making any",
                    "t35ar2changes.",
                    "t35ar2 ",
                    "t35ab1Update",
                    "t35ar2This button applies all the",
                    "t35ar2requested changes and returns to",
                    "t35ar2the Game screen.",
                    "t35ar2 ",
                    "t35ab1Remove",
                    "t35ar2Use this button to remove this",
                    "t35ar2player from the game. When you",
                    "t35ar2press this button, you will be",
                    "t35ar2prompted to press it a second",
                    "t35ar2time to verify that you want to",
                    "t35ar2remove the player before the",
                    "t35ar2actual removal occurs.",
                    "t35ar2 ",
                    "t35cb1$!$",
                    "t35ar2This button provides help for the",
                    "t35ar2current screen throughout the",
                    "t35ar2app. Press Contents for links to",
                    "t35ar2all available help, and press Done",
                    "t35ar2when you are finished.",
                    
                    "s40ab55Game Screen",
                    "t40ar2 ",
                    "t40ar2This is the screen that you will",
                    "t40ar2use the most. It displays all the",
                    "t40ar2players' names, their phases and",
                    "t40ar2points, as well as the game name,",
                    "t40ar2current round number, game",
                    "t40ar2version, and sort order as follows:",
                    "t40ar2- Alphabetical for alphabetical by ",
                    "t40ar2  name,",
                    "t40ar2- Order Added for the order in",
                    "t40ar2  which players were added,",
                    "t40ar2- Dealer Order for dealer sequence",
                    "t40ar2  order,",
                    "t40ar2- Low-to-High for the standings",
                    "t40ar2  from last place to first place,",
                    "t40ar2- High-to-Low for the standings",
                    "t40ar2  from first place to last place.",
                    "t40ar2It also provides access to view",
                    "t40ar2the current phases. As the game",
                    "t40ar2progresses, the screen also",
                    "t40ar2indicates the dealer, skipped",
                    "t40ar2players, and the game winner.",
                    "t40ar2It is here that you keep track of",
                    "t40ar2everyone's score. Note that if a",
                    "t40ar2player is playing phases in order",
                    "t40ar2from 1 to 10, only the current",
                    "t40ar2phase is shown. However, if a",
                    "t40ar2player is choosing a phase each",
                    "t40ar2round, all completed phases are",
                    "t40ar2shown. The phase(s) will appear",
                    "t40ar2on a blue background for any",
                    "t40ar2player who cleared phase in the",
                    "t40ar2current round. Phase(s) will",
                    "t40ar2appear on a yellow background if",
                    "t40ar2the player did not yet clear",
                    "t40ar2phase in this round. Points will",
                    "t40ar2appear on a blue background for",
                    "t40ar2any player who has received",
                    "t40ar2points in the current round.",
                    "t40ar2Points will appear on a yellow",
                    "t40ar2background if the player did not",
                    "t40ar2receive any points in this round.",
                    "t40ar2 ",
                    "t40ab1Clear Phase",
                    "t40ar2Press this button when a player",
                    "t40ar2clears their current phase. You",
                    "t40ar2may do so only once per player",
                    "t40ar2per round. In the next round you",
                    "t40ar2may clear phase for this player",
                    "t40ar2again. If a player is simply",
                    "t40ar2following the phases in order",
                    "t40ar2from 1 to 10, Phase 10 Easy Score",
                    "t40ar2will advance the player to the",
                    "t40ar2next phase in sequence. If a",
                    "t40ar2player is choosing their phase",
                    "t40ar2each round, pressing the Clear",
                    "t40ar2Phase button will take them to",
                    "t40ar2the Clear A Phase screen where",
                    "t40ar2they can select the phase that",
                    "t40ar2has been cleared. In either case,",
                    "t40ar2phase(s) will appear on a blue",
                    "t40ar2background for any player who",
                    "t40ar2cleared phase in the current",
                    "t40ar2round. Phase(s) will appear on a",
                    "t40ar2yellow background if the player",
                    "t40ar2did not yet clear phase in this",
                    "t40ar2round.",
                    "t40ar2 ",
                    "t40ab1Add Points",
                    "t40ar2Use this button to move to the",
                    "t40ar2Add Points screen where you",
                    "t40ar2may update a player's points at",
                    "t40ar2the end of a round. You may do",
                    "t40ar2so only once per player per",
                    "t40ar2round. Points for this player may",
                    "t40ar2be updated again in the next",
                    "t40ar2round. Points will appear on a",
                    "t40ar2blue background for any player",
                    "t40ar2who received points in the",
                    "t40ar2current round. Points will appear",
                    "t40ar2on a yellow background if the",
                    "t40ar2player did not receive points in",
                    "t40ar2this round.",
                    "t40ar2 ",
                    "t40ab1Skip Player / Unskip Player",
                    "t40ar2Use this button to indicate that a",
                    "t40ar2skip card has been played on this",
                    "t40ar2player. The word Skipped will",
                    "t40ar2appear to the right of the player's",
                    "t40ar2name. Since each player may be",
                    "t40ar2skipped only once in a round",
                    "t40ar2(unless every player has been",
                    "t40ar2skipped already), this makes it",
                    "t40ar2easy to remember who has been",
                    "t40ar2skipped and who has not. When",
                    "t40ar2you press Skip Player, the button",
                    "t40ar2will automatically change to the",
                    "t40ar2words Unskip Player. This button",
                    "t40ar2allows you to correct the Skipped",
                    "t40ar2indicator if you pressed the",
                    "t40ar2button for the wrong player.",
                    "t40ar2When there is only one",
                    "t40ar2remaining player who has not",
                    "t40ar2been skipped, and you press the",
                    "t40ar2Skip Player button for that",
                    "t40ar2player, after three seconds your",
                    "t40ar2screen will display three changes:",
                    "t40ar2- all Skipped indicators will be",
                    "t40ar2  removed from all players",
                    "t40ar2- all Unskip Player buttons will",
                    "t40ar2  be changed to Skip Player",
                    "t40ar2  buttons",
                    "t40ar2- a message will tell you that",
                    "t40ar2  everyone in the game may now be",
                    "t40ar2  skipped again.",
                    "t40ar2 ",
                    "t40ab1Edit Player",
                    "t40ar2Use this button to move to the",
                    "t40ar2Edit Player screen. This screen",
                    "t40ar2allows you to change a player's",
                    "t40ar2name, to make phase and point",
                    "t40ar2corrections, to change the dealer",
                    "t40ar2sequence, to mark a player as the",
                    "t40ar2dealer, to specify whether or not",
                    "t40ar2a player is choosing the order in",
                    "t40ar2which to play their phases, or",
                    "t40ar2to remove a player.",
                    "t40ar2 ",
                    "t40ab1View History",
                    "t40ar2Use this button to move to the",
                    "t40ar2View History screen to see all the",
                    "t40ar2phase and point changes saved",
                    "t40ar2for this player, as well as how",
                    "t40ar2many rounds it took this player to",
                    "t40ar2complete each phase.",
                    "t40ar2 ",
                    "t40ab1Sort",
                    "t40ar2Use this button to move to the",
                    "t40ar2Player Sort Selection screen",
                    "t40ar2where you will be given the",
                    "t40ar2opportunity to select the order in",
                    "t40ar2which the players will be",
                    "t40ar2displayed on the Game screen.",
                    "t40ar2Anytime you change the sort order",
                    "t40ar2it will be updated at the top of",
                    "t40ar2the screen.",
                    "t40ar2 ",
                    "t40ab1Add Player",
                    "t40ar2Use this button to move to the",
                    "t40ar2Add A Player screen where you",
                    "t40ar2can quickly add players to the",
                    "t40ar2game by accepting all the game",
                    "t40ar2defaults or by tailoring the",
                    "t40ar2options provided.",
                    "t40ar2 ",
                    "t40ab1End Round",
                    "t40ar2This button automatically",
                    "t40ar2displays the current round",
                    "t40ar2number. When a player discards",
                    "t40ar2all their cards, you should update",
                    "t40ar2each player's score using the",
                    "t40ar2Clear Phase button and/or the",
                    "t40ar2Add Points button. After",
                    "t40ar2updating the phases and points",
                    "t40ar2for all players, press the End",
                    "t40ar2Round button to advance to the",
                    "t40ar2next round. Phase 10 Easy Score",
                    "t40ar2will automatically verify that",
                    "t40ar2everyone's scores have been",
                    "t40ar2updated, will clear all Skipped",
                    "t40ar2indicators, or note any scoring",
                    "t40ar2that still needs to be completed.",
                    "t40ar2After you correct any errors,",
                    "t40ar2press the End Round button again.",
                    "t40ar2You will know that the round",
                    "t40ar2ended successfully when the",
                    "t40ar2message \"End round processing is",
                    "t40ar2complete\" appears at the bottom",
                    "t40ar2of the screen. The updated round",
                    "t40ar2number will also appear at the",
                    "t40ar2top right on the screen.",
                    "t40ar2 ",
                    "t40ab1Show Phases",
                    "t40ar2Use this button to display all the",
                    "t40ar2phases that are currently in use",
                    "t40ar2in this game. After viewing these",
                    "t40ar2phases, press Done to return to",
                    "t40ar2scoring the game.",
                    "t40ar2 ",
                    "t40ab1Edit Game",
                    "t40ar2Use this button to move to the",
                    "t40ar2Edit Game screen which allows",
                    "t40ar2you to change the name of the",
                    "t40ar2game, to determine whether or",
                    "t40ar2not to keep track of the dealer, or",
                    "t40ar2to change the game version.",
                    "t40ar2Note, however, that only the Track",
                    "t40ar2Dealer option and the game name",
                    "t40ar2may be changed once game scoring",
                    "t40ar2has begun.",
                    "t40ar2 ",
                    "t40ab1Start Over",
                    "t40ar2This button returns you to the",
                    "t40ar2Welcome screen. The game is",
                    "t40ar2automatically saved, which",
                    "t40ar2allows you to resume it later.",
                    "t40ar2 ",
                    "t40cb1$!$",
                    "t40ar2This button provides help for the",
                    "t40ar2current screen throughout the",
                    "t40ar2app. Press Contents for links to",
                    "t40ar2all available help, and press Done",
                    "t40ar2when you are finished.",
                    
                    "s45ab55Game Version Display Screen",
                    "t45ar2 ",
                    "t45ar2This screen appears whenever",
                    "t45ar2you select or change a game version.",
                    "t45ar2It shows you the name of the game",
                    "t45ar2and all the phases it contains. It",
                    "t45ar2also lets you choose if you want",
                    "t45ar2to play all the phases, just the",
                    "t45ar2even-numbered ones, or just the",
                    "t45ar2odd-numbered ones.",
                    "t45ar2 ",
                    "t45ab1Play Phases",
                    "t45ar2Use this slider to choose to play",
                    "t45ar2all phases, or just the even-",
                    "t45ar2numbered or odd-numbered",
                    "t45ar2ones. If you choose even or odd,",
                    "t45ar2your choice and the associated",
                    "t45ar2phases will be highlighted in blue.",
                    "t45ar2 ",
                    "t45ab1Update",
                    "t45ar2This button saves any changes you",
                    "t45ar2made and returns you to the last",
                    "t45ar2screen you were on before arriving",
                    "t45ar2at the Game Version Selection",
                    "t45ar2screen.",
                    "t45ar2 ",
                    "t45cb1$!$",
                    "t45ar2This button provides help for the",
                    "t45ar2current screen throughout the",
                    "t45ar2app. Press Contents for links to",
                    "t45ar2all available help, and press Done",
                    "t45ar2when you are finished.",
                    
                    "s50ab55Game Version Selection Screen",
                    "t50ar2 ",
                    "t50ar2This screen appears when you",
                    "t50ar2are being asked to select a game",
                    "t50ar2version. It is used when you are",
                    "t50ar2changing the default game or",
                    "t50ar2changing the version of an actual",
                    "t50ar2game. Note, however, an actual",
                    "t50ar2game's version may be changed",
                    "t50ar2only before its first player is",
                    "t50ar2added. The spinning wheel in the",
                    "t50ar2center will show all the game",
                    "t50ar2versions from which you may choose.",
                    "t50ar2Line up your choice with the",
                    "t50ar2arrows.",
                    "t50ar2 ",
                    "t50ab1Choose Version",
                    "t50ar2Use this button to select the",
                    "t50ar2game version that lines up with",
                    "t50ar2the arrows. This will take you to",
                    "t50ar2the Game Version Display screen",
                    "t50ar2which displays the version name",
                    "t50ar2and the phases associated with it.",
                    "t50ar2It also allows you to choose",
                    "t50ar2which phases you want to play",
                    "t50ar2(all, even-numbered, or odd-",
                    "t50ar2numbered).",
                    "t50ar2 ",
                    "t50ab1Quick View",
                    "t50ar2While the Choose Version button",
                    "t50ar2is used to select a game, the Quick",
                    "t50ar2View button provides a preview of",
                    "t50ar2the game version that lines up with",
                    "t50ar2the arrows before you select it. The",
                    "t50ar2quick view includes the game",
                    "t50ar2version name and its associated",
                    "t50ar2phases.",
                    "t50ar2 ",
                    "t50ab1Back",
                    "t50ar2If you press this button, no",
                    "t50ar2change will be made to the game",
                    "t50ar2version. It will simply return you",
                    "t50ar2to the last screen you were on",
                    "t50ar2before arriving at the Game",
                    "t50ar2Version Selection screen.",
                    "t50ar2 ",
                    "t50cb1$!$",
                    "t50ar2This button provides help for the",
                    "t50ar2current screen throughout the",
                    "t50ar2app. Press Contents for links to",
                    "t50ar2all available help, and press Done",
                    "t50ar2when you are finished.",
                    
                    "s55ab55Play A Game Screen",
                    "t55ar2 ",
                    "t55ab1Start A New Game",
                    "t55ar2Use this button to begin a brand-",
                    "t55ar2new game from scratch. This will",
                    "t55ar2take you to the Start A New",
                    "t55ar2Game screen. An option to start",
                    "t55ar2from scratch or to copy players",
                    "t55ar2from another game will be",
                    "t55ar2provided.",
                    "t55ar2 ",
                    "t55ab1Restart A Game",
                    "t55ar2Use this button to return to a",
                    "t55ar2game you were playing and start",
                    "t55ar2over. This will take you to the",
                    "t55ar2Available Games screen which",
                    "t55ar2lists all the games that may be",
                    "t55ar2restarted. When you restart a",
                    "t55ar2game, all players remain, but",
                    "t55ar2completed phases and points are",
                    "t55ar2removed. Players that previously",
                    "t55ar2chose phases will no longer do so.",
                    "t55ar2Use the Edit Player button to ",
                    "t55ar2reinstate the option to choose",
                    "t55ar2phases for each player.",
                    "t55ar2 ",
                    "t55ab1Resume A Game",
                    "t55ar2Use this button to continue a",
                    "t55ar2game where you left off. This will",
                    "t55ar2take you to the Available Games",
                    "t55ar2screen which lists all the games",
                    "t55ar2that may be resumed.",
                    "t55ar2 ",
                    "t55ab1Remove A Game",
                    "t55ar2Use this button to completely",
                    "t55ar2eliminate a game from the",
                    "t55ar2system. This will take you to the",
                    "t55ar2Available Games screen which",
                    "t55ar2lists all the games that may be",
                    "t55ar2removed.",
                    "t55ar2 ",
                    "t55ab1Cancel",
                    "t55ar2Use this button to return to the",
                    "t55ar2Welcome screen.",
                    "t55ar2 ",
                    "t55cb1$!$",
                    "t55ar2This button provides help for the",
                    "t55ar2current screen throughout the",
                    "t55ar2app. Press Contents for links to",
                    "t55ar2all available help, and press Done",
                    "t55ar2when you are finished.",
                    
                    "s60ab55Player Sort Selection Screen",
                    "t60ar2 ",
                    "t60ar2This screen appears when you",
                    "t60ar2press a sort button, either when",
                    "t60ar2changing the default sort order",
                    "t60ar2or when you want to change the",
                    "t60ar2order in which the players appear",
                    "t60ar2on the current game screen.",
                    "t60ar2 ",
                    "t60ab1Alphabetically by Name",
                    "t60ar2Press this button to sort the",
                    "t60ar2players in ascending alphabetical",
                    "t60ar2sequence based on their names.",
                    "t60ar2On the Game screen, this will be",
                    "t60ar2shown as Sort: Alphabetical.",
                    "t60ar2 ",
                    "t60ab1In the Order They Were Added",
                    "t60ar2Press this button so that the first",
                    "t60ar2player you added to the game",
                    "t60ar2will appear first, the second",
                    "t60ar2player added will be next, and so",
                    "t60ar2on.",
                    "t60ar2On the Game screen, this will be",
                    "t60ar2shown as Sort: Order Added.",
                    "t60ar2 ",
                    "t60ab1In Order by Dealer",
                    "t60ar2Press this button to sort the",
                    "t60ar2players in ascending sequence",
                    "t60ar2based on the dealer sequence",
                    "t60ar2number you assigned on the Add",
                    "t60ar2A Player screen, or changed on",
                    "t60ar2the Edit Player screen.",
                    "t60ar2On the Game screen, this will be",
                    "t60ar2shown as Sort: Dealer Order.",
                    "t60ar2 ",
                    "t60ab1Low-to-High by Phase and Points",
                    "t60ar2Use this button to arrange the",
                    "t60ar2players from the lowest phase",
                    "t60ar2and the highest number of points",
                    "t60ar2to the highest phase and the",
                    "t60ar2lowest number of points. This",
                    "t60ar2means that the player currently",
                    "t60ar2in last place will appear first, and",
                    "t60ar2the player in first place will",
                    "t60ar2appear last.",
                    "t60ar2On the Game screen, this will be",
                    "t60ar2shown as Sort: Low-to-High.",
                    "t60ar2 ",
                    "t60ab1High-to-Low by Phase and Points",
                    "t60ar2Use this button to arrange the",
                    "t60ar2players from the highest phase",
                    "t60ar2and the lowest number of points",
                    "t60ar2to the lowest phase and the",
                    "t60ar2highest number of points. This",
                    "t60ar2means that the player currently",
                    "t60ar2in first place will appear first, and",
                    "t60ar2the player in last place will",
                    "t60ar2appear last.",
                    "t60ar2On the Game screen, this will be",
                    "t60ar2shown as Sort: High-to-Low.",
                    "t60ar2 ",
                    "t60ab1Back",
                    "t60ar2This button saves your sort",
                    "t60ar2choice and returns you to the screen",
                    "t60ar2you were on before arriving at",
                    "t60ar2the Player Sort Selection screen.",
                    "t60ar2 ",
                    "t60cb1$!$",
                    "t60ar2This button provides help for the",
                    "t60ar2current screen throughout the",
                    "t60ar2app. Press Contents for links to",
                    "t60ar2all available help, and press Done",
                    "t60ar2when you are finished.",
                    
                    "s65ab55Start A New Game Screen",
                    "t65ar2 ",
                    "t65ab1Start From Scratch",
                    "t65ar2This button immediately starts a",
                    "t65ar2brand new game using your",
                    "t65ar2default settings. When the Game",
                    "t65ar2screen appears, you may begin",
                    "t65ar2adding players by pressing the",
                    "t65ar2Add Player button.",
                    "t65ar2 ",
                    "t65ab1Copy Players",
                    "t65ar2Use this button to start a new",
                    "t65ar2game and copy the players from",
                    "t65ar2another game. This will take you",
                    "t65ar2to the Available Games screen.",
                    "t65ar2Choose a game and a new game",
                    "t65ar2will start which includes all the",
                    "t65ar2players from the game you",
                    "t65ar2selected. Players that previously",
                    "t65ar2chose phases will no longer do so.",
                    "t65ar2Use the Edit Player button to",
                    "t65ar2reinstate the option to choose",
                    "t65ar2phases for each player.",
                    "t65ar2 ",
                    "t65ab1Cancel",
                    "t65ar2This button returns you to the",
                    "t65ar2Play A Game screen.",
                    "t65ar2 ",
                    "t65cb1$!$",
                    "t65ar2This button provides help for the",
                    "t65ar2current screen throughout the",
                    "t65ar2app. Press Contents for links to",
                    "t65ar2all available help, and press Done",
                    "t65ar2when you are finished.",
                    
                    "s70ab55U Pick 10 Phase Selection Screen",
                    "t70ar2 ",
                    "t70ar2This screen appears when you",
                    "t70ar2have selected a game of U Pick",
                    "t70ar210, either for a new game, or",
                    "t70ar2when setting the default values.",
                    "t70ar2You must choose the 10 phases",
                    "t70ar2that you would like your game to",
                    "t70ar2contain. The spinning wheel in",
                    "t70ar2the center displays more than 75",
                    "t70ar2different phases that are",
                    "t70ar2available in Phase 10 Easy Score.",
                    "t70ar2Line up your choice with",
                    "t70ar2the arrows one at a time. For",
                    "t70ar2each phase you want, press the",
                    "t70ar2Pick Phase button. All your phase",
                    "t70ar2selections will appear on the",
                    "t70ar2screen in the order you selected",
                    "t70ar2them.",
                    "t70ar2 ",
                    "t70ab1Play Phases",
                    "t70ar2Use this slider to choose to play",
                    "t70ar2all phases, or just the even-",
                    "t70ar2numbered or odd-numbered",
                    "t70ar2ones. If you choose even or odd,",
                    "t70ar2your choice and the associated",
                    "t70ar2phases will be highlighted in blue.",
                    "t70ar2 ",
                    "t70ab1Pick Phase",
                    "t70ar2As noted above, pressing this",
                    "t70ar2button when a phase lines up",
                    "t70ar2with the arrows will add that",
                    "t70ar2phase to the game and display it",
                    "t70ar2above the spinning wheel.",
                    "t70ar2 ",
                    "t70ab1Remove",
                    "t70ar2This button is used to remove the",
                    "t70ar2most recent phase you added to",
                    "t70ar2the list in case you changed your",
                    "t70ar2mind or made a mistake.",
                    "t70ar2Continuing to press this button",
                    "t70ar2will remove the phases one at a",
                    "t70ar2time.",
                    "t70ar2 ",
                    "t70ab1Back",
                    "t70ar2This completes the setup for your",
                    "t70ar2U Pick 10 game and returns you",
                    "t70ar2to either the Default Settings or",
                    "t70ar2Edit Game screen, depending on",
                    "t70ar2where you were before arriving",
                    "t70ar2at the U Pick 10 Phase Selection",
                    "t70ar2screen. If you did not choose 10",
                    "t70ar2phases, you will be given the",
                    "t70ar2option of pressing Back again",
                    "t70ar2to exit without saving any",
                    "t70ar2changes.",
                    "t70ar2 ",
                    "t70cb1$!$",
                    "t70ar2This button provides help for the",
                    "t70ar2current screen throughout the",
                    "t70ar2app. Press Contents for links to",
                    "t70ar2all available help, and press Done",
                    "t70ar2when you are finished.",
                    
                    "s75ab55View History Screen",
                    "t75ar2 ",
                    "t75ar2It is here that you can see all the",
                    "t75ar2changes made for each player",
                    "t75ar2during the course of a game. All",
                    "t75ar2phase and point changes are",
                    "t75ar2saved for each player, and all",
                    "t75ar2rounds are noted as they are",
                    "t75ar2completed. If a player wants to",
                    "t75ar2know how long they have been",
                    "t75ar2trying to clear a phase, that",
                    "t75ar2information is available here.",
                    "t75ar2 ",
                    "t75ar2The spinning wheel in the center",
                    "t75ar2will show all the actions that are",
                    "t75ar2associated with this player in this",
                    "t75ar2game thus far.",
                    "t75ar2 ",
                    "t75ab1Back",
                    "t75ar2This button returns you to the",
                    "t75ar2Game screen.",
                    "t75ar2 ",
                    "t75cb1$!$",
                    "t75ar2This button provides help for the",
                    "t75ar2current screen throughout the",
                    "t75ar2app. Press Contents for links to",
                    "t75ar2all available help, and press Done",
                    "t75ar2when you are finished.",
                    
                    "s80ab55Welcome Screen",
                    "t80ar2 ",
                    "t80ab1Play A Game",
                    "t80ar2Use this button to start a new",
                    "t80ar2game, restart a game, resume a",
                    "t80ar2game, or remove a game.",
                    "t80ab1 ",
                    "t80ab1Review App",
                    "t80ar2Use this button to leave a written",
                    "t80ar2review for this app in the App",
                    "t80ar2Store.",
                    "t80ar2 ",
                    "t80ab1Edit Default Settings",
                    "t80ar2Use this button to change the",
                    "t80ar2original preset defaults. This",
                    "t80ar2allows you to customize the",
                    "t80ar2scorekeeping features according",
                    "t80ar2to your preferences.",
                    "t80ar2 ",
                    "t80ab1Continuous Display",
                    "t80ar2Use this button to override your",
                    "t80ar2iPhone's idle timer. The default",
                    "t80ar2for this switch is set to no,",
                    "t80ar2which means that the iPhone will",
                    "t80ar2shut off automatically based on",
                    "t80ar2the Auto-Lock time value you",
                    "t80ar2specified in your Display &",
                    "t80ar2Brightness Settings. If you set",
                    "t80ar2this option to yes, then Phase",
                    "t80ar210 Easy Score will prevent the",
                    "t80ar2iPhone from shutting off,",
                    "t80ar2regardless of your Auto-Lock",
                    "t80ar2time value. Since it usually",
                    "t80ar2takes a few minutes to play a",
                    "t80ar2round, this will prevent the",
                    "t80ar2need to unlock your iPhone",
                    "t80ar2every time you need to make a",
                    "t80ar2scoring update. Please note that",
                    "t80ar2this option affects only Phase",
                    "t80ar210 Easy Score. It has no effect",
                    "t80ar2on any other app on your iPhone.",
                    "t80ar2Note also, that although setting",
                    "t80ar2the option to yes is very",
                    "t80ar2convenient, it also requires",
                    "t80ar2more energy from your battery.",
                    "t80ar2 ",
                    "t80cb1$!$",
                    "t80ar2This button provides help for the",
                    "t80ar2current screen throughout the",
                    "t80ar2app. Press Contents for links to",
                    "t80ar2all available help, and press Done",
                    "t80ar2when you are finished."]

var deviceWeAreRunningOn = ""           // This is the device on which we're running
var deviceCategoryWeAreRunningOn = ""   // This is the category of device we're running on as follows:
                                        // iPhone Large
                                        // iPhone Small
                                        // iPad
                                        // everything else
var deviceWidth = 0                     // The width of the device we're running on
var deviceHeight = 0                    // The height of the device we're running on

// File levels and defaults for the following files:
//    defaults
//    games
//    history
var inputDefaultsFileLevel = "ii"
var outputDefaultsFileLevel = "oo"
var checkDefaults = ""
var inputGamesFileLevel = "ii"
var outputGamesFileLevel = "oo"
var checkGames = ""
var inputHistoryFileLevel = "ii"
var outputHistoryFileLevel = "oo"
var checkHistory = ""

let allSpaces = "                                                       "   // Constant of blanks
// The only characters allowed for a sequence number
let cornerRadiusStdButton : CGFloat = 10.0   // Standard radius used when rounding the corners of buttons
let cornerRadiusHelpButton : CGFloat = 20.0  // Standard radius used when rounding the corners of the help button
                                             // on all screens except the Game screen
let cornerRadiusGameHelpButton : CGFloat = 12.0  // Standard radius used when rounding the corners of the help button
                                                 // on the Game screen
let currentFileLevel = "02"             // Current level of all files (controls conversions if necessary)
let defaultVersionPhasesWidth = 54      // Width of Defaults phase box used for centering
let fileLevelConstant = "$FILLVL$"      // File level record identification constant
let futureExpansion = "FutureExpansion" // Constant for file filler areas
let initHistoryConstant = "0     "      // Initial value for a history entry
let iPadConstant = "iPad"               // Constant to denote an iPad
let iPhoneSmallConstant = "small iPhone" // Constant to denote smaller iPhones
let iPhoneLargeConstant = "large iPhone" // Constant to denote larger iPhones
let twoThirdsSmallScreen = 294          // Y position of 2/3 of a small screen
                                        // based on 10 lines out of 16, each line = 29.4
let twoThirdsLargeScreen = 441          // Y position of 2/3 of a large screen
                                        // based on 15 lines out of 23, each line = 29.4
let twoThirdsSmallGameScreen = 263      // Same as twoThirdsSmallScreen but for Game screen
let twoThirdsLargeGameScreen = 410      // Same as twoThirdsLargeScreen but for Game screen
let maxGameClearing = 50                // Limit for clearing the screen from previous iterations
let maxHistoryCodeEntryIndex = "26"     // Entry code limit for setting the player code for the history file
                                        // (entry code 26 would be history code z)
let phaseDivider = "500"                // Dividing point between uncleared and cleared phases
let intPhaseDivider = 500               // Companion for string phase divider
let initZeroCurDealer = "00"            // Constant of zero for current dealer
let initZeroDealer = "00"               // Constant of zero for dealer number
let initZeroEntry = "00"                // Constant of zero for entry number
let initZeroPhase2 = "00"               // Constant of zero for phases (2 digits)
let initZeroPhase3 = "000"              // Constant of zero for phases (3 digits)
let constantPhase6 = "006"              // Constant of six for end-of game phase
let constantPhase11 = "011"             // Constant of eleven for end-of game phase
let uPick10 = "U Pick 10"               // Constant of U Pick 10
let zeroPoints = "0000"                 // Constant of zero for points

let movingForward = "Forward"           // Constant for setting forward controller movement direction
let DSTarget = "DefaultSettings"        // Constant for setting backward-scrolling target
let EGTarget = "EditGame"               // Constant for setting backward-scrolling target
let VCTarget = "ViewController"         // Constant for setting backward-scrolling target

let AppleReviewWebsite = "https://apps.apple.com/app/id1535701557?action=write-review" // URL for doing written app review

let allPhasesCode = "a"                 // Constant for phase modifier of All
let evenPhasesCode = "e"                // Constant for phase modifier of Even
let oddPhasesCode = "o"                 // Constant for phase modifier of Odd
let allPhasesName = "All"               // COnstant name for phase modifier of All
let evenPhasesName = "Even"               // COnstant name for phase modifier of Even
let oddPhasesName = "Odd"               // COnstant name for phase modifier of Odd
let historyAddPointsCode = "a"          // Constant for history file - add points
let historyClearAllPointsCode = "c"     // Constant for history - clear all points
let historyClearPhaseCode = "d"         // Constant for history - clear phase
let historyEndRoundCode = "e"           // Constant for history - end round
let historyClearAllPhases = "f"         // Constant for history - clear all phases
let historyPlayerWasEdited = "g"        // Constant for history - player was edited
let gamesAndPhasesGame = "G"            // Constant for game/phase array game indicator
let gamesAndPhasesPhase = "P"           // Constant for game/phase array phase indicator
let gamesAndPhasesEnd = "X"             // Constant for game/phase array end-of-array indicator
let weightBold = "b"                    // Constant for setting bold weight for a font
let weightRegular = "r"                 // Constant for setting regular weight for a font
let justifyLeft = "l"                   // Constant for left justification
let justifyRight = "r"                  // Constant for right justification
let justifyCenter = "c"                 // Constant for center justification
let gameCompleteStatusCode = "c"        // Constant for the complete game indicator
let buttonCodeDisabled = "d"            // Constant for disabling a button
let buttonCodeEnabled = "e"             // Constant for enabling a button
let inProgress = "i"                    // In-progress status indicator
let itIsStarting = "s"                  // Starting status indicator
let notStarted = "n"                    // Not started status indicator
let trackingDealerConstant = "y"        // Tracking dealer constant value
let playerDoesNotChoosePhaseConstant = "n" // Player does not choose phase constant value
let playerChoosesPhaseConstant = "y"    // Player chooses phase constant value
let playerIsNotSkipped = "n"            // Player is not skipped code
let playerIsSkipped = "s"               // Player skipped code
let notTrackingDealerConstant = "n"     // Not tracking dealer constant value
let overrideIdleTimer = "y"             // User has requested that their idle timer be disabled
let leaveIdleTimer = "n"                // User wants their idle timer to be upheld
let dataFormatLabel = "l"               // Constant for requesting label data format
let dataFormatRaw = "r"                 // Constant for requesting raw data format
let updateFileRemovalCode = "r"         // Constant to remove a file record
let updateFileUpdateCode = "u"          // Constant to update a file record
let helpSectionIndicator = "s"          // Constant for help array section indicator
let helpTextIndicator = "t"             // Constant for help array text indicator
let helpColorYellow = "1"               // Constant for help color - yellow
let helpColorBrightGreen = "2"          // Constant for help color - bright green
let helpColorRed = "3"                  // Constant for help color - red
let helpColorOrange = "4"               // Constant for help color - orange
let helpColorWhite = "5"                // Constant for help color - white
let pointsStatusRed = "0"               // Display red background on points buttons
let pointsStatusStandard = "s"          // Display standard colors on points buttons
let usedDealerCode = "u"                // Constant signifying a used dealer sequence entry
let newLineConstant = "\n"              // Constant new line character for printing

// Error message from file initialization / conversion functions
var initConvertErrorMessage = ""

// Construct file name and determine path for the Defaults, Games, & History files
let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
let defaultsFileURL = DocumentDirURL.appendingPathComponent(gdefault.defaultsFileName).appendingPathExtension(gdefault.defaultsFileExt)
let gamesFileURL = DocumentDirURL.appendingPathComponent(gdefault.gamesFileName).appendingPathExtension(gdefault.gamesFileExt)
let historyFileURL = DocumentDirURL.appendingPathComponent(gdefault.historyFileName).appendingPathExtension(gdefault.historyFileExt)

class GlobalDefaults { // Global default variable values for the system

    var playerSortDecisionDriverView = ""       // Originating view preceding PlayerSortSelection
    var gameVersionConfirmationDecisionDriverView = ""  // Originating view preceding GameVersionDisplay
    var availableGameChoiceInstructions = ""    // Instructions Text for Available Games
    var updateTarget = ""                       // Used to identify when an "update" button was pressed
                                                // so that all intermediate views can be hidden
    var startOverTarget = ""                    // Used to identify when a "start over" button was pressed
                                                // so that all intermediate views can be hidden
    var clearPhaseButtonIndex = 0               // Used to identify the "clear phase" button index
                                                // so that that button can be disabled after processing
    var addPointsButtonIndex = 0                // Used to identify the "add points" button index
                                                // so that that button can be disabled after processing
    var skipPlayerButtonIndex = 0               // Used to identify the "skip player" button index
                                                // so that that button can be altered after processing
    var editPlayerButtonIndex = 0               // Used to identify the "edit player" button index
                                                // so that that button can be disabled after processing
    var viewHistoryButtonIndex = 0              // Used to identify the "view history" button index
                                                // so that that button can be disabled after processing
    var UP10ReturnPressed = "1"                 // Used in U Pick 10 Phase Selection to enforce
                                                // selection of 10 phases or cancellation
    var preUP10Version = ""                     // Save the version so that it can be reinstated upon
                                                // cancellation in UPick10
    var preUP10PhaseModifier = ""               // Save the phase modifier so that it can be reinstated upon
                                                // cancellation in UPick10
    var RemovePressed = "1"                     // Used when removing a game in AvailableGames to force
                                                // the user to press remove a second time to do the
                                                // removal
    var helpCaller = ""                         // Identification number of the controller that just invoked help
    var awaitingHelpReturn = "n"                // Indicator that help was requested
    
    // Variables to save the original values of several fields as they
    // were before help was requested (so they can be reinstated upon return)
    var preHelpNewPlayerName = ""
    var preHelpDealerOrder = "00"
    var preHelpMarkAsDealer = 0.0
    var preHelpPlayerChoosesPhaseValue = 0.0
    var preHelpErrorMessage = ""
    
    // Variables to save the original values of several fields as they
    // were before edit player was invoked (so they can be reinstated upon return)
    var preEditPlayerPlayerName = ""
    var preEditPlayerPhase1 = "   "
    var preEditPlayerPhase2 = "   "
    var preEditPlayerPhase3 = "   "
    var preEditPlayerPhase4 = "   "
    var preEditPlayerPhase5 = "   "
    var preEditPlayerPhase6 = "   "
    var preEditPlayerPhase7 = "   "
    var preEditPlayerPhase8 = "   "
    var preEditPlayerPhase9 = "   "
    var preEditPlayerPhase10 = "   "
    var preEditPlayerCurrentPhase = "  "
    var preEditPlayerStartRoundPhase = "   "
    var preEditPlayerPoints = "0000"
    var preEditPlayerStartRoundPoints = "0000"
    var preEditPlayerDealerOrder = "00"
    var preEditPlayerCurrentDealer = "00"
    var preEditPlayerPlayerChoosesPhaseIndicator = ""
    
    // Player index numbers by button for the currently-sorted display
    // Loaded by the aRefreshView function in TheGame when the buttons are set up
    // Used when processing the buttons so that the correct player is updated
    // This is needed because the display order can change based on the
    // user-requested sort, so the index can't be calculated
    var playerIdxByButton = [99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
                             99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
                             99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
                             99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
                             99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
                             99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
                             99, 99, 99, 99, 99, 99, 99, 99, 99, 99,
                             99, 99, 99, 99, 99]
    
    // Clear phase button color situation
    // "all red" - all clear phase buttons should be red
    // "one red" - one specific clear phase button should be red
    // "all green" - all clear phase buttons should be green
    var clearPhaseButtonColorStatus = "all green"
    var clearPhaseButtonSpecificIndex = 99  // This will be the player's entry order number
    
    // Array to hold multiple winners and then see who actually won based
    // on points
    var gameWinnerPointsEntry = [String]()
    
    // Colors to use when setting clear phase buttons
    // Usually black text on bright green backgroound, but changes to white text
    // on red background when "end round" finds that no one cleared phase, or that
    // the player with zero points did not clear phase
    var clearPhaseTextColor = appColorBlack
    var clearPhaseBackgroundColor = appColorBrightGreen
    
    // Colors to use when setting add points buttons
    // Usually black text on bright green backgroound, but changes to white text
    // on red background when "end round" finds that more than one player
    // has zero points
    var addPointsTextColor = appColorBlack
    var addPointsBackgroundColor = appColorBrightGreen
    
    // Defaults file name & record length
    let defaultsFileName = "p10es.defaults" // Name of the Defaults file
    let defaultsFileExt = "txt"             // Extension of the Defaults file
    let defaultsRecordSize = 1024           // Size of the Defaults record
    // Defaults file field offsets
    let defaultsOffsetFileLevel = 8
    let defaultsOffsetTrackDealer = 10
    let defaultsOffsetGameVersion = 11
    let defaultsOffsetPhase1 = 14
    let defaultsOffsetPhase2 = 17
    let defaultsOffsetPhase3 = 20
    let defaultsOffsetPhase4 = 23
    let defaultsOffsetPhase5 = 26
    let defaultsOffsetPhase6 = 29
    let defaultsOffsetPhase7 = 32
    let defaultsOffsetPhase8 = 35
    let defaultsOffsetPhase9 = 38
    let defaultsOffsetPhase10 = 41
    let defaultsOffsetPhaseModifier = 44
    let defaultsOffsetPlayerSort = 45
    let defaultsOffsetContDisplay = 47
    // Defaults file field lengths
    let defaultsLengthFileLevel = 2
    let defaultsLengthTrackDealer = 1
    let defaultsLengthGameVersion = 3
    let defaultsLengthPhase = 3
    let defaultsLengthPhaseModifier = 1
    let defaultsLengthPlayerSort = 2
    let defaultsLengthContDisplay = 1

    // Original default values for Defaults file and then
    // global storage after file has been created
    var defaultsTrackDealer = "y"       // Track dealer yes/no
    var defaultsGameVersion = "000" // Game version
    var defaultsPhase1 = "001"   // Phase number 1
    var defaultsPhase2 = "002"   // Phase number 2
    var defaultsPhase3 = "003"   // Phase number 3
    var defaultsPhase4 = "004"   // Phase number 4
    var defaultsPhase5 = "005"   // Phase number 5
    var defaultsPhase6 = "006"   // Phase number 6
    var defaultsPhase7 = "007"   // Phase number 7
    var defaultsPhase8 = "008"   // Phase number 8
    var defaultsPhase9 = "009"   // Phase number 9
    var defaultsPhase10 = "010"  // Phase number 10
    
    var defaultsPhaseModifier = "a"     // All=a, Even=e, Odd=o
    var defaultsPlayerSort = "01"       // Player sort order on game screen
    var defaultsContDisplay = "n"       // Continuous display (override idle timer)
    
    // Games file name & record length
    let gamesFileName = "p10es.games"   // Name of the Games file
    let gamesFileExt = "txt"            // Extension of the Games file
    let gamesRecordSize = 2048          // Size of the Games record
    // Games file field offsets
    let gamesOffsetFileLevel = 8
    let gamesOffsetGameName = 10
    let gamesOffsetGameVersion = 25
    let gamesOffsetPhase1 = 28
    let gamesOffsetPhase2 = 31
    let gamesOffsetPhase3 = 34
    let gamesOffsetPhase4 = 37
    let gamesOffsetPhase5 = 40
    let gamesOffsetPhase6 = 43
    let gamesOffsetPhase7 = 46
    let gamesOffsetPhase8 = 49
    let gamesOffsetPhase9 = 52
    let gamesOffsetPhase10 = 55
    let gamesOffsetPhaseModifier = 58
    let gamesOffsetTrackDealer = 59
    let gamesOffsetPlayerSort = 60
    let gamesOffsetPlayerName = 62
    let gamesOffsetPlayerEntryOrder = 362
    let gamesOffsetPlayerDealerOrder = 392
    let gamesOffsetCurrentDealer = 422
    let gamesOffsetPlayerChoosesPhase = 424
    let gamesOffsetPlayerPhase1 = 439
    let gamesOffsetPlayerPhase2 = 484
    let gamesOffsetPlayerPhase3 = 529
    let gamesOffsetPlayerPhase4 = 574
    let gamesOffsetPlayerPhase5 = 619
    let gamesOffsetPlayerPhase6 = 664
    let gamesOffsetPlayerPhase7 = 709
    let gamesOffsetPlayerPhase8 = 754
    let gamesOffsetPlayerPhase9 = 799
    let gamesOffsetPlayerPhase10 = 844
    let gamesOffsetPlayerCurrentPhase = 889
    let gamesOffsetPlayerStartRoundPhases = 919
    let gamesOffsetPlayerPoints = 964
    let gamesOffsetPlayerStartRoundPoints = 1024
    let gamesOffsetPlayerWinner = 1084
    let gamesOffsetRoundNumber = 1099
    let gamesOffsetRoundStatus = 1101
    let gamesOffsetGameStatus = 1102
    let gamesOffsetPlayerButtonStatus = 1103
    let gamesOffsetPlayerPointsStatus = 1178
    let gamesOffsetPlayerPointsStatusEntry = 1193
    let gamesOffsetPlayerSkipped = 1223
    // Games file field lengths & array occurrences
    let gamesLengthFileLevel = 2
    let gamesLengthGameName = 15
    let gamesLengthGameVersion = 3
    let gamesLengthPhase = 3
    let gamesLengthPhaseModifier = 1
    let gamesLengthTrackDealer = 1
    let gamesLengthPlayerSort = 2
    let gamesLengthPlayerName = 20
    let gamesLengthPlayerNameOccurs = 15
    let gamesLengthPlayerEntryOrder = 2
    let gamesLengthPlayerEntryOrderOccurs = 15
    let gamesLengthPlayerDealerOrder = 2
    let gamesLengthPlayerDealerOrderOccurs = 15
    let gamesLengthCurrentDealer = 2
    let gamesLengthPlayerChoosesPhase = 1
    let gamesLengthPlayerChoosesPhaseOccurs = 15
    let gamesLengthPlayerPhase1 = 3
    let gamesLengthPlayerPhase1Occurs = 15
    let gamesLengthPlayerPhase2 = 3
    let gamesLengthPlayerPhase2Occurs = 15
    let gamesLengthPlayerPhase3 = 3
    let gamesLengthPlayerPhase3Occurs = 15
    let gamesLengthPlayerPhase4 = 3
    let gamesLengthPlayerPhase4Occurs = 15
    let gamesLengthPlayerPhase5 = 3
    let gamesLengthPlayerPhase5Occurs = 15
    let gamesLengthPlayerPhase6 = 3
    let gamesLengthPlayerPhase6Occurs = 15
    let gamesLengthPlayerPhase7 = 3
    let gamesLengthPlayerPhase7Occurs = 15
    let gamesLengthPlayerPhase8 = 3
    let gamesLengthPlayerPhase8Occurs = 15
    let gamesLengthPlayerPhase9 = 3
    let gamesLengthPlayerPhase9Occurs = 15
    let gamesLengthPlayerPhase10 = 3
    let gamesLengthPlayerPhase10Occurs = 15
    let gamesLengthPlayerCurrentPhase = 2
    let gamesLengthPlayerCurrentPhaseOccurs = 15
    let gamesLengthPlayerStartRoundPhases = 3
    let gamesLengthPlayerStartRoundPhasesOccurs = 15
    let gamesLengthPlayerPoints = 4
    let gamesLengthPlayerPointsOccurs = 15
    let gamesLengthPlayerStartRoundPoints = 4
    let gamesLengthPlayerStartRoundPointsOccurs = 15
    let gamesLengthPlayerWinner = 1
    let gamesLengthPlayerWinnerOccurs = 15
    let gamesLengthRoundNumber = 2
    let gamesLengthRoundStatus = 1
    let gamesLengthGameStatus = 1
    let gamesLengthPlayerButtonStatus = 1
    let gamesLengthPlayerButtonStatusOccurs = 75
    let gamesLengthPlayerPointsStatus = 1
    let gamesLengthPlayerPointsStatusOccurs = 15
    let gamesLengthPlayerPointsStatusEntry = 2
    let gamesLengthPlayerPointsStatusEntryOccurs = 15
    let gamesLengthPlayerSkipped = 1
    let gamesLengthPlayerSkippedOccurs = 15
    
    // Original default values for Games file and then
    // global storage after file has been created
    let dummyGamesName = "$$$*DG*$$$     "  // Dummy constant for Games file
    var gamesGameName = "$$$*DG*$$$     "   // Name of game
    var gamesGameVersion = "000"            // Game version
    var gamesPhase1 = "001"                 // Phase number 1
    var gamesPhase2 = "002"                 // Phase number 2
    var gamesPhase3 = "003"                 // Phase number 3
    var gamesPhase4 = "004"                 // Phase number 4
    var gamesPhase5 = "005"                 // Phase number 5
    var gamesPhase6 = "006"                 // Phase number 6
    var gamesPhase7 = "007"                 // Phase number 7
    var gamesPhase8 = "008"                 // Phase number 8
    var gamesPhase9 = "009"                 // Phase number 9
    var gamesPhase10 = "010"                // Phase number 10
    var gamesPhaseModifier = "a"            // All=a, Even=e, Odd=o
    var gamesTrackDealer = "y"              // Track dealer yes/no
    var gamesPlayerSort = "02"              // Player sort order on game screen
    // Player name array
    var gamesPlayerName = ["                    ", "                    ",
                           "                    ", "                    ",
                           "                    ", "                    ",
                           "                    ", "                    ",
                           "                    ", "                    ",
                           "                    ", "                    ",
                           "                    ", "                    ",
                           "                    "]
    // Player entry order array
    var gamesPlayerEntryOrder = ["00", "00", "00", "00", "00",
                                 "00", "00", "00", "00", "00",
                                 "00", "00", "00", "00", "00"]
    // Player dealer order array
    var gamesPlayerDealerOrder = ["00", "00", "00", "00", "00",
                                  "00", "00", "00", "00", "00",
                                  "00", "00", "00", "00", "00"]
    var gamesCurrentDealer = "00"   // Current dealer sequence number (not index)
    // Player chooses phase yes/no array
    var gamesPlayerChoosesPhase = ["n", "n", "n", "n", "n",
                                   "n", "n", "n", "n", "n",
                                   "n", "n", "n", "n", "n"]
    // Player phase arrays. The phase 1 array contains phase 1
    // for all 15 players. The phase 2 array contains phase 2
    // for all 15 players, etc. This is true when a player is
    // NOT choosing their phases. If a player is choosing their
    // phases, the corresponding phase slots for that player
    // across all 10 arrays will be "000" until that player
    // chooses their phase for a given round.
    // These arrays are used to keep track of which phases each
    // player has cleared, with uncleared phases ranging from
    // 001-230, and cleared phases ranging from 501-730.
    // Player phase 1 number array
    var gamesPlayerPhase1 = ["001", "001", "001", "001", "001",
                             "001", "001", "001", "001", "001",
                             "001", "001", "001", "001", "001"]
    // Player phase 2 number array
    var gamesPlayerPhase2 = ["002", "002", "002", "002", "002",
                             "002", "002", "002", "002", "002",
                             "002", "002", "002", "002", "002"]
    // Player phase 3 number array
    var gamesPlayerPhase3 = ["003", "003", "003", "003", "003",
                             "003", "003", "003", "003", "003",
                             "003", "003", "003", "003", "003"]
    // Player phase 4 number array
    var gamesPlayerPhase4 = ["004", "004", "004", "004", "004",
                             "004", "004", "004", "004", "004",
                             "004", "004", "004", "004", "004"]
    // Player phase 5 number array
    var gamesPlayerPhase5 = ["005", "005", "005", "005", "005",
                             "005", "005", "005", "005", "005",
                             "005", "005", "005", "005", "005"]
    // Player phase 6 number array
    var gamesPlayerPhase6 = ["006", "006", "006", "006", "006",
                             "006", "006", "006", "006", "006",
                             "006", "006", "006", "006", "006"]
    // Player phase 7 number array
    var gamesPlayerPhase7 = ["007", "007", "007", "007", "007",
                             "007", "007", "007", "007", "007",
                             "007", "007", "007", "007", "007"]
    // Player phase 8 number array
    var gamesPlayerPhase8 = ["008", "008", "008", "008", "008",
                             "008", "008", "008", "008", "008",
                             "008", "008", "008", "008", "008"]
    // Player phase 9 number array
    var gamesPlayerPhase9 = ["009", "009", "009", "009", "009",
                             "009", "009", "009", "009", "009",
                             "009", "009", "009", "009", "009"]
    // Player phase 10 number array
    var gamesPlayerPhase10 = ["010", "010", "010", "010", "010",
                              "010", "010", "010", "010", "010",
                              "010", "010", "010", "010", "010"]
    // Player current phase array
    var gamesPlayerCurrentPhase = ["01", "01", "01", "01", "01",
                                   "01", "01", "01", "01", "01",
                                   "01", "01", "01", "01", "01"]
    // Player start-of-round phase number array
    var gamesPlayerStartRoundPhases = ["001", "001", "001", "001", "001",
                                       "001", "001", "001", "001", "001",
                                       "001", "001", "001", "001", "001"]
    // Player points array
    var gamesPlayerPoints = ["0000", "0000", "0000", "0000", "0000",
                             "0000", "0000", "0000", "0000", "0000",
                             "0000", "0000", "0000", "0000", "0000"]
    // Player start-of-round points array
    var gamesPlayerStartRoundPoints = ["0000", "0000", "0000", "0000", "0000",
                                       "0000", "0000", "0000", "0000", "0000",
                                       "0000", "0000", "0000", "0000", "0000"]
    var gamesPlayerWinner = ["n", "n", "n", "n", "n",
                             "n", "n", "n", "n", "n",
                             "n", "n", "n", "n", "n"]
    var gamesRoundNumber = "01" // Current round number 01, 02, ...
    var gamesRoundStatus = "s"  // Round status In progress=i, Starting=s
    var gamesGameStatus = "n"   // Game status In progress=i, Not started=n, Completed = c
    // Status of all player buttons in the current game:
    // Each player has 5 buttons in order: "clear phase", "add points", "skip player", "edit player", "edit history"
    // e=enabled, d=disabled
    // Note that all entries in gamesPlayerButtonStatus are always in order by player entry.
    var gamesPlayerButtonStatus = ["e", "e", "e", "e", "e", "e",
                                   "e", "e", "e", "e", "e", "e",
                                   "e", "e", "e", "e", "e", "e",
                                   "e", "e", "e", "e", "e", "e",
                                   "e", "e", "e", "e", "e", "e",
                                   "e", "e", "e", "e", "e", "e",
                                   "e", "e", "e", "e", "e", "e",
                                   "e", "e", "e", "e", "e", "e",
                                   "e", "e", "e", "e", "e", "e",
                                   "e", "e", "e", "e", "e", "e",
                                   "e", "e", "e", "e", "e", "e",
                                   "e", "e", "e", "e", "e", "e",
                                   "e", "e", "e"]
    // Players with zero points detected at end of round:
    // 0=player has zero points in the round, use white text on red background when displaying add points button
    // s=either player has more than zero points in the round, or it's not end of round yet, so use standard colors when
    // displaying add points button
    var gamesPlayerPointsStatus = ["s", "s", "s", "s", "s",
                                   "s", "s", "s", "s", "s",
                                   "s", "s", "s", "s", "s"]
    // Entry order array associated with above points status array
    var gamesPlayerPointsStatusEntry = ["00", "00", "00", "00", "00",
                                        "00", "00", "00", "00", "00",
                                        "00", "00", "00", "00", "00"]
    // Player skip status:
    // n = not skipped
    // s = skipped
    var gamesPlayerSkipped = ["n", "n", "n", "n", "n",
                              "n", "n", "n", "n", "n",
                              "n", "n", "n", "n", "n"]

    // History file name & record length
    let historyFileName = "p10es.history"
    let historyFileExt = "txt"
    let historyRecordSize = 16384
    
    // History file field offsets
    let historyOffsetFileLevel = 8
    let historyOffsetGameName = 10
    let historyOffsetPlayerHistory = 25
    let historySubOffsetPlayerNumber = 0
    let historySubOffsetPointsAction = 1
    let historySubOffsetPointsChanged = 2
    let historySubOffsetPhaseAction = 1
    let historySubOffsetPhaseChanged = 2
    
    // History file field lengths & array elements
    let historyLengthFileLevel = 2
    let historyLengthGameName = 15
    let historyLengthPlayerHistory = 6
    let historyLengthPlayerNumber = 1
    let historyLengthPointsAction = 1
    let historyLengthPointsChanged = 4
    let historyLengthPhaseAction = 1
    let historyLengthPhaseChanged = 2
    let historyLengthPlayerHistoryOccurs = 2475
    
    // Original default values for History file and then
    // global storage after file has been created
    let dummyHistoryName = "$$$*DH*$$$     "
    var historyGameName = "$$$*DH*$$$     "
    // History layout:
    // - Offset 0       Player number code a-o
    // - Offset 1       History entry type
    //                  a = add points via AddPoints
    //                  b = start round via TheGame (not used now, perhaps in the future)
    //                  c = clear all points via EditPlayer
    //                  d = clear phase via ClearPhase or TheGame
    //                  e = end round via TheGame
    //                  f = clear all phases via EditPlayer
    //                  g = player was edited via EditPlayer - followed by f, c, d, a
    // - Offset 2-5     number of points added (type a)
    //                  or 0000 (type c)
    //                  or "    " (type g)
    // - Offset 2-3     cleared phase (type d)
    //                  or round number (types b, e)
    //                  or 00 (type f)
    // - Offset 4-5     blank filler (types b, d, e, f)
    var historyPlayerHistory: [String] = Array (repeating: "      ", count:2475)
    var historyPlayerNumber = "0"
    var historyPointsAction = " "
    var historyPointsChanged = "0000"
    var historyPhaseAction = " "
    var historyPhaseChanged = "00"
}

let gdefault = GlobalDefaults()

// General function to determine a player's phase completion status as well
// as their point total.
// Input:   data to be returned l = label text or r = raw data,
//          index to the player arrays
// Returns: if label text   - player completion status
//                          - points text
//          if raw data     - phase (3 digits 001-011) & points (4 digits) & completed phases (3 digits 000-010)
// It is the caller's responsibility to place this information on the
// appropriate player synopsis label.

func determinePhaseAndPointsStatus (requestedFormatIn: String, indexIn: Int) -> (rawDataOrPhaseText: String, pointsText: String) {
    
    // First see if the player is choosing their own phase, or is just
    // playing them in standard order.
    //
    // For standard order:
    // - Check the player phase arrays in order from 1 to 10.
    // - In each array, just examine the index passed to this function,
    //   since this represents the player being set up.
    // - Find the first phase that's less than 500. This is an uncleared
    //   phase. Return "Current Phase N", where N is the player phase
    //   array being examined.
    // - If the phase numbers are > 500 for all 10 player phase arrays for
    //   this player (or just 5 when even/odd is in use), return "All Phases Completed".
    //
    // For players choosing their own phase order:
    // - Check the player phase arrays in order from 1 to 10 (or just the evens or odds).
    // - In each array, just examine the index passed to this function,
    //   since this represents the player being set up.
    // - Find each phase that's greater than 500. This is a cleared
    //   phase. All others are as yet unannounced phases. Total the
    //   number of completed phases, and return " Completed a,b,c,...",
    //   where a,b,c,... are the actual completed phase numbers.
    // - If the phase numbers are > 500 for all 10 player phase arrays for
    //   this player (or just 5 when even/odd is in use), return "All Phases Completed".
    // - If no phase numbers are > 500, return "No Phases Completed"
    //
    // For both players choosing phases and those not choosing, simply
    // provide their current point total after the phase completion status.
    //
    // Regarding the actual format of the data being returned, label text consists of 2
    // strings: the first is one of the phase phrases above, and the second is Points xxxx
    // Raw data is pppxxxxccc, where ppp is the phase, xxxx is the points, and ccc is
    // the number of completed phases.
    // Note that the phase is just a relative number from 001-011.

    let playerPoints = "Points"
    var returnPhaseStatus = ""
    var returnRawPhase = ""
    var returnRawPoints = ""
    var returnRawCompleted = ""
    
    //print("TG dpaps determining phase and points status for player index \(indexIn)")
    //print("TG dpaps - Std Phases: 01=\(gdefault.gamesPlayerPhase1[indexIn]) 02=\(gdefault.gamesPlayerPhase2[indexIn]) 03=\(gdefault.gamesPlayerPhase3[indexIn]) 04=\(gdefault.gamesPlayerPhase4[indexIn])  05=\(gdefault.gamesPlayerPhase5[indexIn])  06=\(gdefault.gamesPlayerPhase6[indexIn])  07=\(gdefault.gamesPlayerPhase7[indexIn])  08=\(gdefault.gamesPlayerPhase8[indexIn]) 09=\(gdefault.gamesPlayerPhase9[indexIn])  10=\(gdefault.gamesPlayerPhase10[indexIn]) SOR Phase: \(gdefault.gamesPlayerStartRoundPhases[indexIn])")
    switch gdefault.gamesPlayerChoosesPhase[indexIn] {
    case playerDoesNotChoosePhaseConstant:
        let result = analyzeNoChoicePhaseCompletion(indexIn: indexIn)
        returnPhaseStatus = result.phaseText
        returnRawPhase = result.phaseRaw
        returnRawCompleted = result.completedRaw
    case playerChoosesPhaseConstant:
        let result = analyzeChoicePhaseCompletion(indexIn: indexIn)
        returnPhaseStatus = result.phaseText
        returnRawPhase = result.phaseRaw
        returnRawCompleted = result.completedRaw
    default:
        _ = ""
    }
    
    // Set up and return the point total
    //print("TG dpaps returning \(returnPhaseStatus)")
    returnRawPoints = gdefault.gamesPlayerPoints[indexIn]
    let intPoints = Int(returnRawPoints)
    
    // Return the results in the requested format
    if requestedFormatIn == dataFormatLabel {
        let rawDataOrPhaseText = returnPhaseStatus
        let pointsText = playerPoints + String(format: "% 4d", intPoints!)
        //print("TG dPAPS format=\(requestedFormatIn) raw=<\(rawDataOrPhaseText)> points=<\(pointsText)>")
        return (rawDataOrPhaseText, pointsText)
    }
    else {
        let rawDataOrPhaseText = returnRawPhase + returnRawPoints + returnRawCompleted
        let pointsText = ""
        //print("TG dPAPS format=\(requestedFormatIn) raw=<\(rawDataOrPhaseText)> points=<\(pointsText)>")
        return (rawDataOrPhaseText, pointsText)
    }
} // End determinePhaseAndPointsStatus

// This function examines the requested phase number and returns the
// original non-cleared phase number. Cleared phase numbers always
// exceed 500, while uncleared phase numbers are always < 500.

func preparePhaseNumber(phaseIn: String) -> String {
    var usePhaseNumber = ""
    if phaseIn > phaseDivider {
        let intPhaseNumber = Int(phaseIn)! - intPhaseDivider
        usePhaseNumber = String(format: "%03d", intPhaseNumber)
    }
    else {
        usePhaseNumber = phaseIn
    }
    return usePhaseNumber
}

// General function to move the dealer indicator to the next player in sequence
// The proecedure is as follows:
// - Only follow this procedure if keeping track of the dealer
// - Build an array of the dealer and entry sequence numbers
// - Sort the array by dealer sequence number
// - Search the sorted array for the entry sequence number that matches the current dealer sequence number
// - Proceed to the following array entry (revert to the first entry if already at the end of the array)
// - From the entry just moved to, extract the entry sequence number and put it in the current dealer sequence
func advanceToNextDealer () {
    //print("VC aTND")
    if gdefault.gamesTrackDealer == trackingDealerConstant {
        var pcount = 0
        var dealerSortData = [String]()
        dealerSortData.removeAll()
        while pcount < gdefault.gamesLengthPlayerNameOccurs {
            if gdefault.gamesPlayerDealerOrder[pcount] == initZeroDealer {
                break
            }
            dealerSortData.append(gdefault.gamesPlayerDealerOrder[pcount] + gdefault.gamesPlayerEntryOrder[pcount])
            pcount += 1
        }
        //print("VC aTND loaded dealer/entry sequences = \(dealerSortData)")
        dealerSortData.sort()
        //print("VC aTND sorted dealer/entry sequences = \(dealerSortData)")
        pcount = 0
        //print("VC aTND looking for entry sequence \(gdefault.gamesCurrentDealer)")
        let maxArray = dealerSortData.count
        while pcount < maxArray {
            let sortData = dealerSortData[pcount]
            //print("VC aTND entry \(pcount) is \(sortData)")
            let sidx = sortData.index(sortData.startIndex, offsetBy: 2)
            let eidx = sortData.endIndex
            let range = sidx ..< eidx
            let entrySequence = String(sortData[range])
            if gdefault.gamesCurrentDealer == entrySequence {
                //print("VC aTND match found at index \(pcount)")
                break
            }
            pcount += 1
        }
        if pcount == (maxArray - 1) {
            pcount = 0
        }
        else {
            pcount += 1
        }
        //print("VC aTND index reset to \(pcount)")
        let sortData = dealerSortData[pcount]
        let sidx = sortData.index(sortData.startIndex, offsetBy: 2)
        let eidx = sortData.endIndex
        let range = sidx ..< eidx
        let entrySequence = String(sortData[range])
        gdefault.gamesCurrentDealer = entrySequence
        //print("VC aTND current dealer reset to \(entrySequence)")
    }
}

// General function to get the current number of players in the game
// based on the number of players in the array who have a non-zero
// entry number
// Output:  the number of defined players
func countThePlayers () -> Int {
    var pcount = 0
    while pcount < gdefault.gamesLengthPlayerNameOccurs {
        if gdefault.gamesPlayerEntryOrder[pcount] == initZeroEntry {
            break
        }
        pcount += 1
    }
    return pcount
}

// General function to create and return a new game name based on the
// current date and time, preceded by a $ that users will not be allowed to
// enter when naming their own games, thus ensuring no duplicates.
func makeAGameName () -> String {
    
    let date = Date()

    let calendar = Calendar.current
    
    let year = calendar.component(.year, from: date as Date)
    let month = calendar.component(.month, from: date as Date)
    let day = calendar.component(.day, from: date as Date)
    let hour = calendar.component(.hour, from: date as Date)
    let minute = calendar.component(.minute, from: date as Date)
    let second = calendar.component(.second, from: date as Date)

    let gnYear = String(format: "%04d", year)
    let gnMonth = String(format: "%02d", month)
    let gnDay = String(format: "%02d", day)
    let gnHour = String(format: "%02d", hour)
    let gnMinute = String(format: "%02d", minute)
    let gnSecond = String(format: "%02d", second)
    
    let gameName = "$" + gnYear + gnMonth + gnDay + gnHour + gnMinute + gnSecond
    
    return gameName
}

// General function to update the Games file
// Functions available: 1) Update a game
//                      2) Remove a game
// Input parameters:
//                      1) actionIn     u = update, r = remove
//                      2) gameOffsetIn offset of game within full record
func updateGamesFile (actionIn: String, gameOffsetIn: Int) {
    
    var gamesRec1of3 = ""
    var gamesRec2of3 = ""
    var gamesRec3of3 = ""
    var gamesRec1of2 = ""
    var gamesRec2of2 = ""
    
    // Retrieve the full Games file
    let fileHandleVCGUpdate:FileHandle=FileHandle(forUpdatingAtPath: gamesFileURL.path)!
    let holdGamesFile = String(data: fileHandleVCGUpdate.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
    let gameFileSize = holdGamesFile.count
    let gameRecordSize = gdefault.gamesRecordSize
    
    //print("VC uGF received Games update request code=\(actionIn)")
    //print("VC uGF Games file size=\(gameFileSize), rec size=\(gameRecordSize)")
    //print("VC uGF Games game offset in=\(gameOffsetIn)")
    //print("VC uGF Games file before update=<\(holdGamesFile)>")
    // This is the update action ...
    if actionIn == updateFileUpdateCode {
        // Extract the Games record up to but not including the game in progress
        //print("VC uGF-u extracting games rec 1 of 3, offset=0, length=\(gameOffsetIn)")
        gamesRec1of3 = extractRecordField(recordIn: holdGamesFile, fieldOffset: 0, fieldLength: gameOffsetIn)
        // Unless the game is at the end of the Games record, extract the Games
        // record immediately following the game in progress
        if (gameOffsetIn + gameRecordSize) < gameFileSize {
            //print("VC uGF-u extracting games rec 3 of 3, offset=\(gameOffsetIn + gameRecordSize), length=\(gameFileSize - gameOffsetIn - gameRecordSize)")
            gamesRec3of3 = extractRecordField(recordIn: holdGamesFile, fieldOffset: gameOffsetIn + gameRecordSize, fieldLength: gameFileSize - gameOffsetIn - gameRecordSize)
        }
        // Construct the game record for the game in progress
        gamesRec2of3 = loadGamesRecordFromGlobal(fileLevelIn: currentFileLevel, gameNameIn: gdefault.gamesGameName)
        //print("VC uGF-u concatenating part 1 size=\(gamesRec1of3.count) part 2 size=\(gamesRec2of3.count) part 3 size=\(gamesRec3of3.count)")
        //print("VC uGF-u part 1=<\(gamesRec1of3)>")
        //print("VC uGF-u part 2=<\(gamesRec2of3)>")
        //print("VC uGF-u part 3=<\(gamesRec3of3)>")
        
        let newGameFileRecord = gamesRec1of3 + gamesRec2of3 + gamesRec3of3
        
        //print("VC uGF-u Games replacement rec=<\(newGameFileRecord)>")
        //print("VC uGF-u Games record written with size=\(newGameFileRecord.count)")
        
        // Clear the entire file
        try? fileHandleVCGUpdate.truncate(atOffset: 0)
        
        // Replace the entire file
        fileHandleVCGUpdate.write(newGameFileRecord.data(using: String.Encoding.utf8)!)
        fileHandleVCGUpdate.closeFile()
        //print("VC uGF update complete")
    }
    // This is the remove action ...
    if actionIn == updateFileRemovalCode {
        // Extract the Games record up to but not including the game being removed
        //print("VC uGF-r extracting games rec 1 of 2 for removal, offset=0, length=\(gameOffsetIn)")
        gamesRec1of2 = extractRecordField(recordIn: holdGamesFile, fieldOffset: 0, fieldLength: gameOffsetIn)
        // Unless the game is at the end of the Games record, extract the Games
        // record immediately following the game being removed
        if (gameOffsetIn + gameRecordSize) < gameFileSize {
            //print("VC uGF-r extracting games rec 2 of 2 for removal, offset=\(gameOffsetIn + gameRecordSize), length=\(gameFileSize - gameOffsetIn - gameRecordSize)")
            gamesRec2of2 = extractRecordField(recordIn: holdGamesFile, fieldOffset: gameOffsetIn + gameRecordSize, fieldLength: gameFileSize - gameOffsetIn - gameRecordSize)
        }
        //print("VC uGF-r part 1=<\(gamesRec1of2)>")
        //print("VC uGF-r part 2=<\(gamesRec2of2)>")
        
        let newGameFileRecord = gamesRec1of2 + gamesRec2of2
        
        //print("VC uGF-r Games replacement rec=<\(newGameFileRecord)>")
        //print("VC uGF-r Games record written with size=\(newGameFileRecord.count)")
        
        // Clear the entire file
        try? fileHandleVCGUpdate.truncate(atOffset: 0)
        
        // Replace the entire file
        fileHandleVCGUpdate.write(newGameFileRecord.data(using: String.Encoding.utf8)!)
        fileHandleVCGUpdate.closeFile()
        //print("VC uGF removal complete")
    }
}

// General function to update the History file
// Functions available: 1) Update history (add history entries)
//                      2) Remove history (remove entire game from the history file)
// Input parameters:
//                      1) actionIn         u = update
//                                          r = remove game
//                      2) historyOffsetIn  offset of history record within
//                                          full file
//                      3) newHistoryDataIn history entry to be added
//                                          Note that one history entry is 6 bytes long. If
//                                          multiple entries are being added, they are all
//                                          concatenated together, and this function will
//                                          parse all the individual entries automatically
//                                          and will do just one file update I/O after
//                                          processing all the entries.
//                                          Note also that this data is not used when
//                                          removing a game.
//                                          Note that if this field has a value of "newname",
//                                          then no history data is updated. Only the game
//                                          name is updated from global storage.
func updateHistoryFile (actionIn: String, historyOffsetIn: Int, newHistoryDataIn: String) {
    
    var historyRec1of3 = ""
    var historyRec2of3 = ""
    var historyRec3of3 = ""
    var historyGameRec1of2 = ""
    var historyGameRec2of2 = ""
    var playerHistoryEntry = ""
    //var historyOriginalGame = ""
    
    // Retrieve the full History file
    let fileHandleVCHUpdate:FileHandle=FileHandle(forUpdatingAtPath: historyFileURL.path)!
    let holdHistoryFile = String(data: fileHandleVCHUpdate.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
    let historyFileSize = holdHistoryFile.count
    let historyRecordSize = gdefault.historyRecordSize
    let newHistorySize = newHistoryDataIn.count
    let newHistoryOccurrences = newHistorySize / gdefault.historyLengthPlayerHistory
    var hcount = 0
    var playerHistoryOffset = 0
    
    //print("VC uHF received History update or game removal request ...")
    //print("VC uHF History file size=\(historyFileSize), rec size=\(historyRecordSize)")
    //print("VC uHF History game offset in=\(historyOffsetIn)")
    //print("VC uHF requested log entry to add=<\(newHistoryDataIn)>")
    //print("VC uHF History file before update=<\(holdHistoryFile)>")
    // This is the update action ...
    if actionIn == updateFileUpdateCode {
        // Extract the History file data up to but not including the
        // record containing the game in progress
        //print("VC uHF record 1 of 3: from 0 for a length of \(historyOffsetIn)")
        //print("VC uHF extracting history rec 1 of 3")
        historyRec1of3 = extractRecordField(recordIn: holdHistoryFile, fieldOffset: 0, fieldLength: historyOffsetIn)
        // Unless the game is at the end of the History record, extract the
        // History file data immediately following the record containing
        // the game in progress
        //print("VC uHF record 3 of 3: from \(historyOffsetIn + historyRecordSize) for a length of \(historyFileSize - historyOffsetIn - historyRecordSize)")
        if (historyOffsetIn + historyRecordSize) < historyFileSize {
            //print("VC uHF extracting history rec 3 of 3")
            historyRec3of3 = extractRecordField(recordIn: holdHistoryFile, fieldOffset: historyOffsetIn + historyRecordSize, fieldLength: historyFileSize - historyOffsetIn - historyRecordSize)
        }
        else {
            //print("VC uHF record 3 of 3 is null")
        }
        
        // Extract and then update the history file data for the record
        // containing the game in progress
        
        // -- First extract the full history record
        //print("VC uHF record 2 of 3 (initially): from \(historyOffsetIn) for a length of \(historyRecordSize)")
        //print("VC uHF extracting history rec 2 of 3")
        historyRec2of3 = extractRecordField(recordIn: holdHistoryFile, fieldOffset: historyOffsetIn, fieldLength: historyRecordSize)

        // If this is not a game name change, extract the player history array
        // Otherwise, leave the record as is except for the game name
        
        if !(newHistoryDataIn == "newname") {
            //print("VC uHF just player history: from \(gdefault.historyOffsetPlayerHistory) for a length of \(gdefault.historyLengthPlayerHistoryOccurs * gdefault.historyLengthPlayerHistory)")
            //print("VC uHF extracting player history rec 2 of 3")
            let playerHistory = extractRecordField(recordIn: historyRec2of3, fieldOffset: gdefault.historyOffsetPlayerHistory, fieldLength: gdefault.historyLengthPlayerHistoryOccurs * gdefault.historyLengthPlayerHistory)
            
            // -- Scan the player history array to find the entry where the player
            //    number is zero. This is where the new entry goes (or entries go).
            while hcount < gdefault.historyLengthPlayerHistoryOccurs {
                //print("VC uHF extracting player history entry")
                playerHistoryEntry = extractRecordField(recordIn: playerHistory, fieldOffset: playerHistoryOffset, fieldLength: gdefault.historyLengthPlayerHistory)
                //print("VC uHF hcount=\(hcount) offset=\(playerHistoryOffset) playerHistoryEntry=<\(playerHistoryEntry)>")
                let idx = playerHistoryEntry.index(playerHistoryEntry.startIndex, offsetBy: 0)
                let playerCode = playerHistoryEntry[idx]
                if playerCode == "0" {
                    //print("VC uHF found player code 0, will do update within history record at offset \(playerHistoryOffset)")
                    break
                }
                hcount += 1
                playerHistoryOffset += gdefault.historyLengthPlayerHistory
            }
            // As long as there's room in the history file, update the
            // next available entry (or entries if multiple history entries were passed to this function)
            //
            // instring                     - this game's history record
            // historyOffsetPlayerHistory   - offset within each game's history record where the history array starts
            // playerHistoryOffset          - index within the history array area (relative to 0) where the new history
            //                                data will go (this is the first spot where the action code is "0"
            // startReplacement-1           - position within this game's history record where the new history data starts
            // endReplacement-1             - position within this game's history record where the new history data ends
            //                                (this will be a multiple of a history entry's length, depending on
            //                                 how many entries were passed to this function)
            //
            if (hcount + newHistoryOccurrences - 1) < gdefault.historyLengthPlayerHistoryOccurs {
                let instring: NSString = historyRec2of3 as NSString
                let startReplacement = playerHistoryOffset + gdefault.historyOffsetPlayerHistory + 1
                let endReplacement = startReplacement + newHistorySize - 1
                //print("VC uHF playerHistoryOffset=\(playerHistoryOffset)")
                //print("VC uHF substitution: startReplacement=\(startReplacement), endReplacement=\(endReplacement)")
                //print("VC uHF 1st substitution is to \(startReplacement-1)")
                //print("VC uHF 2nd substitution is simply len=\(newHistoryDataIn.count) data=\(newHistoryDataIn)")
                //print("VC uHF 3rd substitution is from \(endReplacement)")
                
                historyRec2of3 = instring.substring(to: startReplacement-1) + newHistoryDataIn + instring.substring(from: endReplacement)
                //print("in=<\(playerHistoryEntry)>, out len=\(historyRec2of3.count) data=<\(newHistoryDataIn)>")

                //print("VC uHF part 1 len=\(historyRec1of3.count) data=<\(historyRec1of3)>")
                //print("VC uHF part 2 len=\(historyRec2of3.count) data=<\(historyRec2of3)>")
                //print("VC uHF part 3 len=\(historyRec3of3.count) data=<\(historyRec3of3)>")
                
                let newHistoryFileRecord = historyRec1of3 + historyRec2of3 + historyRec3of3
                
                //print("VC uHF History replacement rec=<\(newHistoryFileRecord)>")
                // Clear the entire file
                try? fileHandleVCHUpdate.truncate(atOffset: 0)
                
                // Replace the entire file
                fileHandleVCHUpdate.write(newHistoryFileRecord.data(using: String.Encoding.utf8)!)
            }
        }
        else {
            // Replace the game name
            // instring                     - this game's history record
            // historyOriginalGame          - this game's original name before this name change
            // historyOffsetGameName        - offset within each game's history record where the game name starts
            // startReplacement-1           - position within this game's history record where the new game name goes
            // endReplacement-1             - position within this game's history record where the new game name ends
            //historyOriginalGame = extractRecordField(recordIn: historyRec2of3, fieldOffset: gdefault.historyOffsetGameName, fieldLength: gdefault.historyLengthGameName)
            let instring: NSString = historyRec2of3 as NSString
            let startReplacement = gdefault.historyOffsetGameName + 1
            let endReplacement = startReplacement + gdefault.historyLengthGameName - 1
            //print("VC uHF substitution: startReplacement=\(startReplacement), endReplacement=\(endReplacement)")
            //print("VC uHF 1st substitution is to \(startReplacement-1)")
            //print("VC uHF 2nd substitution is simply len=\(gdefault.historyLengthGameName) data=\(gdefault.historyGameName)")
            //print("VC uHF 3rd substitution is from \(endReplacement)")
            
            historyRec2of3 = instring.substring(to: startReplacement-1) + gdefault.historyGameName + instring.substring(from: endReplacement)
            //print("in=<\(historyOriginalGame)>, out len=\(historyRec2of3.count) data=<\(gdefault.historyGameName)>")

            //print("VC uHF part 1 len=\(historyRec1of3.count) data=<\(historyRec1of3)>")
            //print("VC uHF part 2 len=\(historyRec2of3.count) data=<\(historyRec2of3)>")
            //print("VC uHF part 3 len=\(historyRec3of3.count) data=<\(historyRec3of3)>")
            
            let newHistoryFileRecord = historyRec1of3 + historyRec2of3 + historyRec3of3
            
            //print("VC uHF History replacement rec=<\(newHistoryFileRecord)>")
            // Clear the entire file
            try? fileHandleVCHUpdate.truncate(atOffset: 0)
            
            // Replace the entire file
            fileHandleVCHUpdate.write(newHistoryFileRecord.data(using: String.Encoding.utf8)!)
        }
        
        fileHandleVCHUpdate.closeFile()
        //print("VC uHF update complete")
    }
    
    // This is the game removal action ...
    if actionIn == updateFileRemovalCode {
        // Extract the History record up to but not including the game being removed
        //print("VC uHF extracting history rec 1 of 2 for removal at offset 0 for a length of \(historyOffsetIn)")
        historyGameRec1of2 = extractRecordField(recordIn: holdHistoryFile, fieldOffset: 0, fieldLength: historyOffsetIn)
        // Unless the game is at the end of the History record, extract the History
        // record immediately following the game being removed
        if (historyOffsetIn + historyRecordSize) < historyFileSize {
            //print("VC uHF extracting history rec 2 of 2 (rest of record after game being removed) at offset \(historyOffsetIn + historyRecordSize) with length \(historyFileSize - historyOffsetIn - historyRecordSize)")
            historyGameRec2of2 = extractRecordField(recordIn: holdHistoryFile, fieldOffset: historyOffsetIn + historyRecordSize, fieldLength: historyFileSize - historyOffsetIn - historyRecordSize)
        }
        //print("VC uHF part 1=<\(historyGameRec1of2)>")
        //print("VC uHF part 2=<\(historyGameRec2of2)>")
        
        let newHistoryFileRecord = historyGameRec1of2 + historyGameRec2of2
        
        //print("VC uHF History replacement rec=<\(newHistoryFileRecord)>")
        //print("VC uHF History record written with size=\(newHistoryFileRecord.count)")
        
        // Clear the entire file
        try? fileHandleVCHUpdate.truncate(atOffset: 0)
        
        // Replace the entire file
        fileHandleVCHUpdate.write(newHistoryFileRecord.data(using: String.Encoding.utf8)!)
        fileHandleVCHUpdate.closeFile()
        //print("VC uHF removal complete")
    }
}

// General function to add spaces to the left and right of the game version
// and phase modifier that's shown on the defaults screen
// Input: game version and phase text
// Output:  left side spaces
//          right side spaces

func expandGameVersionAndModifier (textIn: String) -> (leftSpaces: String,  rightSpaces : String) {
    let vAMLength = textIn.count
    let leftSpaceCount = (defaultVersionPhasesWidth - vAMLength) / 2
    let sidx = allSpaces.index(allSpaces.startIndex, offsetBy: 0)
    var eidx = allSpaces.index(allSpaces.startIndex, offsetBy: leftSpaceCount + 1)
    var range = sidx ..< eidx
    let leftSpaces = String(allSpaces[range])
    
    let rightSpaceCount = defaultVersionPhasesWidth - vAMLength - leftSpaceCount
    eidx = allSpaces.index(allSpaces.startIndex, offsetBy: rightSpaceCount + 1)
    range = sidx ..< eidx
    let rightSpaces = String(allSpaces[range])
    return (leftSpaces, rightSpaces)
}

// General function to acquire game version name from the
// predefined array of games and phases
// Input: game version number
// Output: game version name

func retrieveGameVersionName (numberIn: String) -> String {
    var vcount = 0
    let theNumber = Int(numberIn)
    var gameVersionName = ""
    repeat {
        let gamePhaseEntry = gamesAndPhases[vcount]
        var sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 0)
        var eidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
        var range = sidx ..< eidx
        if gamePhaseEntry[range] == gamesAndPhasesGame {
            if vcount == theNumber {
                sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
                eidx = gamePhaseEntry.endIndex
                range = sidx ..< eidx
                gameVersionName = String(gamePhaseEntry[range])
            }
            else {
                vcount += 1
            }
        }
        else {
            vcount += 1
        }
    } // End search loop
    while gameVersionName == ""
    return gameVersionName
}

// General function to acquire game version number from the
// predefined array of games and phases. Note that this
// number is the actual index within the predefined array.
// For example, if the array contains game version 1, 10
// phases, game version 2, 10 more phases, etc., and
// game version 2 is the one to be returned, then the number
// returned would be 11.
// Input: game version name
// Output: game version number

func retrieveActualGameVersionNumber (nameIn: String) -> String {
    var vcount = 0
    var gameVersionNumber = ""
    repeat {
        let gamePhaseEntry = gamesAndPhases[vcount]
        var sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 0)
        var eidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
        var range = sidx ..< eidx
        if gamePhaseEntry[range] == gamesAndPhasesGame {
            sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
            eidx = gamePhaseEntry.endIndex
            range = sidx ..< eidx
            if nameIn == gamePhaseEntry[range] {
                gameVersionNumber = String(format: "%03d", vcount)
            }
            else {
                vcount += 1
            }
        }
        else {
            vcount += 1
        }
    } // End search loop
    while gameVersionNumber == ""
    return gameVersionNumber
}

// General function to acquire game version number from the
// predefined array of games and phases. Note that this
// number is the relative index within the predefined array.
// That is, it is the first game version (0), second game
// version (1), etc.
// Input: game version name
// Output: game version number

func retrieveRelativeGameVersionNumber (nameIn: String) -> Int {
    var vcount = 0
    var gcount = 0
    var gameVersionNumber = 999
    repeat {
        let gamePhaseEntry = gamesAndPhases[vcount]
        var sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 0)
        var eidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
        var range = sidx ..< eidx
        if gamePhaseEntry[range] == gamesAndPhasesGame {
            gcount += 1
            sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
            eidx = gamePhaseEntry.endIndex
            range = sidx ..< eidx
            if nameIn == gamePhaseEntry[range] {
                gameVersionNumber = gcount - 1
            }
            else {
                vcount += 1
            }
        }
        else {
            vcount += 1
        }
    } // End search loop
    while gameVersionNumber == 999
    return gameVersionNumber
}

// General function to acquire phase name from the predefined
// array of games and phases
// Input: phase number
// Output: phase name

func retrieveGamePhaseName (numberIn: String) -> String {
    var vcount = 0
    let theNumber = Int(numberIn)
    var gamePhaseName = ""

    repeat {
        let gamePhaseEntry = gamesAndPhases[vcount]
        var sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 0)
        var eidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
        var range = sidx ..< eidx
        if gamePhaseEntry[range] == gamesAndPhasesPhase {
            if vcount == theNumber {
                sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
                eidx = gamePhaseEntry.endIndex
                range = sidx ..< eidx
                gamePhaseName = String(gamePhaseEntry[range])
            }
            else {
                vcount += 1
            }
        }
        else {
            vcount += 1
        }
    } // End search loop
    while gamePhaseName == ""
    return gamePhaseName
}

// General function to acquire phase number from the game/phase array
// Input: game version name, phase name
// Output: phase number

func retrieveGamePhaseNumber (gameNameIn: String, phaseNameIn: String) -> String {
    var pcount = 0
    var gcount = 0
    var gamePhaseNumber = ""
    var gamePhaseEntry = ""
    
    // First find the requested game and save its index as the start point
    // to begin searching for the phase name
    
    repeat {
        gamePhaseEntry = gamesAndPhases[gcount]
        var sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 0)
        var eidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
        var range = sidx ..< eidx
        if gamePhaseEntry[range] == gamesAndPhasesGame {
            sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
            eidx = gamePhaseEntry.endIndex
            range = sidx ..< eidx
            if gameNameIn == String(gamePhaseEntry[range]) {
                pcount = gcount
            }
        }
        gcount += 1
    } // End game search loop
    while pcount == 0
    
    // Now start at the above-determined index and search for the requested
    // phase name
    
    repeat {
        gamePhaseEntry = gamesAndPhases[pcount]
        var sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 0)
        var eidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
        var range = sidx ..< eidx
        if gamePhaseEntry[range] == gamesAndPhasesPhase {
            sidx = gamePhaseEntry.index(gamePhaseEntry.startIndex, offsetBy: 1)
            eidx = gamePhaseEntry.endIndex
            range = sidx ..< eidx
            if phaseNameIn == String(gamePhaseEntry[range]) {
                gamePhaseNumber = String(format: "%03d", pcount)
            }
        }
        pcount += 1
    } // End phase search loop
    while gamePhaseNumber == ""
    return gamePhaseNumber
}

// General function to extract one field from a data record
// Input:   data record
//          beginning offset for extraction
//          length of field to be extracted
// Return:  the data field

func extractRecordField (recordIn: String, fieldOffset: Int, fieldLength: Int) -> String {
    //print("VC eRF data=<\(recordIn)>")
    //print("VC eRF offset + length = \(fieldOffset) + \(fieldLength)")
    let sidx = recordIn.index(recordIn.startIndex, offsetBy: fieldOffset)
    let eidx = recordIn.index(recordIn.startIndex, offsetBy: fieldOffset + fieldLength)
    let range = sidx ..< eidx
    return String(recordIn[range])
}

// Load the Defaults file record from global storage, except for the file level
// which is passed to this function

func loadDefaultsRecordFromGlobal (fileLevelIn: String) -> String {
    var dDR1 = ""
    var dDR2 = ""
    var dDR3 = ""
    var dDR4 = ""
    var dDR5 = ""
    var dDR6 = ""
    var dDR7 = ""
    var dDR8 = ""
    var dDR9 = ""
    var dDR10 = ""
    var dDR11 = ""
    var dDR12 = ""
    var dDR13 = ""
    var dDR14 = ""
    var dDR15 = ""
    var dDR16 = ""
    var dDR17 = ""
    let dDRFX1 = futureExpansion
    let dDRFX3 = dDRFX1 + dDRFX1 + dDRFX1
    let dDRFX2 = dDRFX1 + dDRFX1
    let dDRFX9 = dDRFX3 + dDRFX3 + dDRFX3
    let dDRFX65 = dDRFX9 + dDRFX9 + dDRFX9 + dDRFX9 + dDRFX9 + dDRFX9 + dDRFX9 + dDRFX2

    dDR1 = fileLevelConstant
    dDR2 = fileLevelIn
    dDR3 = gdefault.defaultsTrackDealer
    dDR4 = gdefault.defaultsGameVersion
    dDR5 = gdefault.defaultsPhase1
    dDR6 = gdefault.defaultsPhase2
    dDR7 = gdefault.defaultsPhase3
    dDR8 = gdefault.defaultsPhase4
    dDR9 = gdefault.defaultsPhase5
    dDR10 = gdefault.defaultsPhase6
    dDR11 = gdefault.defaultsPhase7
    dDR12 = gdefault.defaultsPhase8
    dDR13 = gdefault.defaultsPhase9
    dDR14 = gdefault.defaultsPhase10
    dDR15 = gdefault.defaultsPhaseModifier
    dDR16 = gdefault.defaultsPlayerSort
    dDR17 = gdefault.defaultsContDisplay

    let defaultsText:String = dDR1 + dDR2 + dDR3 + dDR4 + dDR5 + dDR6 + dDR7 + dDR8 + dDR9 + dDR10 + dDR11 + dDR12 + dDR13 + dDR14 + dDR15 + dDR16 + dDR17 + dDRFX65 + "F"
    
    return defaultsText
}

// Convert or create the defaults file as appropriate as follows:
// Input File Level     Output File Level       Action
//       00                    02               Create current
//       01                    02               Update file format from level 01 to level 02
//       02                    02               Leave file as is
// Note that no I/O is performed within this function
// The I/O is the responsibility of the caller
//
// Function returns the Defaults record and an error message if applicable

func handleDefaultsConversion() -> String {
    outputDefaultsFileLevel = currentFileLevel
    var returnDefaults = ""
    initConvertErrorMessage = ""
    var dDR1 = ""
    var dDR2 = ""
    var dDR3 = ""
    var dDR17 = ""
    let dDRFX1 = futureExpansion
    let dDRFX3 = dDRFX1 + dDRFX1 + dDRFX1
    let dDRFX9 = dDRFX3 + dDRFX3 + dDRFX3
    let dDRFX65 = dDRFX9 + dDRFX9 + dDRFX9 + dDRFX9 + dDRFX9 + dDRFX9 + dDRFX9 + dDRFX1 + dDRFX1
    
    if !(inputDefaultsFileLevel == outputDefaultsFileLevel) {
        if inputDefaultsFileLevel == "00" {
            // Initialize current level Defaults record
            returnDefaults = loadDefaultsRecordFromGlobal(fileLevelIn: outputDefaultsFileLevel)
        }
        else {
            // Convert level 01 to level 02
            // Header
            dDR1 = fileLevelConstant
            dDR2 = outputDefaultsFileLevel
            // Track dealer through player sort
            let sidx = checkDefaults.index(checkDefaults.startIndex, offsetBy: 10)
            let eidx = checkDefaults.index(checkDefaults.startIndex, offsetBy: 47)
            let range = sidx ..< eidx
            dDR3 = String(checkDefaults[range])
            // Continuous display
            dDR17 = "n"
            returnDefaults = dDR1 + dDR2 + dDR3 + dDR17 + dDRFX65 + "F"
        }
        return returnDefaults
    }
    return returnDefaults
}
    
// Load the Games file record from global storage, except for the file level
// and game name which are passed to this function

func loadGamesRecordFromGlobal (fileLevelIn: String, gameNameIn: String) -> String {
    var dDG1 = ""
    var dDG2 = ""
    var dDG3 = ""
    var dDG4 = ""
    var dDG5 = ""
    var dDG6 = ""
    var dDG7 = ""
    var dDG8 = ""
    var dDG9 = ""
    var dDG10 = ""
    var dDG11 = ""
    var dDG12 = ""
    var dDG13 = ""
    var dDG14 = ""
    var dDG15 = ""
    var dDG16 = ""
    var dDG17 = ""
    var dDG18 = ""
    var dDG19 = ""
    var dDG20 = ""
    var dDG21 = ""
    var dDG22 = ""
    var dDG23 = ""
    var dDG24 = ""
    var dDG25 = ""
    var dDG26 = ""
    var dDG27 = ""
    var dDG28 = ""
    var dDG29 = ""
    var dDG30 = ""
    var dDG31 = ""
    var dDG32 = ""
    var dDG33 = ""
    var dDG34 = ""
    var dDG35 = ""
    var dDG36 = ""
    var dDG37 = ""
    var dDG38 = ""
    var dDG39 = ""
    var dDG40 = ""
    var dDG41 = ""
    var dDG42 = ""
    var dDG43 = ""
    var dDG44 = ""
    let dDGFX1 = futureExpansion
    let dDGFX3 = dDGFX1 + dDGFX1 + dDGFX1
    let dDGFX9 = dDGFX3 + dDGFX3 + dDGFX3
    let dDGFX54 = dDGFX9 + dDGFX9 + dDGFX9 + dDGFX9 + dDGFX9 + dDGFX9
    
    //print("VC lGRFG lvl=\(dDG1), game name=\(dDG3)")
    dDG1 = fileLevelConstant
    //print("VC lGRFG loading file level constant \(fileLevelConstant) size=\(fileLevelConstant.count)")
    dDG2 = fileLevelIn
    dDG3 = gameNameIn
    dDG4 = gdefault.gamesGameVersion
    dDG5 = gdefault.gamesPhase1
    dDG6 = gdefault.gamesPhase2
    dDG7 = gdefault.gamesPhase3
    dDG8 = gdefault.gamesPhase4
    dDG9 = gdefault.gamesPhase5
    dDG10 = gdefault.gamesPhase6
    dDG11 = gdefault.gamesPhase7
    dDG12 = gdefault.gamesPhase8
    dDG13 = gdefault.gamesPhase9
    dDG14 = gdefault.gamesPhase10
    dDG15 = gdefault.gamesPhaseModifier
    dDG16 = gdefault.gamesTrackDealer
    dDG17 = gdefault.gamesPlayerSort
    var pcount = 0
    //print("VC lGRFG loading \(gdefault.gamesLengthPlayerNameOccurs) players")
    while pcount < gdefault.gamesLengthPlayerNameOccurs {
        dDG18 = dDG18 + gdefault.gamesPlayerName[pcount]
        pcount += 1
    }
    //print("VC lGRFG players are \(gdefault.gamesPlayerName) size=\(dDG18.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerEntryOrderOccurs {
        dDG19 = dDG19 + gdefault.gamesPlayerEntryOrder[pcount]
        pcount += 1
    }
    //print("VC lGRFG loading \(gdefault.gamesLengthPlayerEntryOrderOccurs) entry #s size=\(dDG19.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerDealerOrderOccurs {
        dDG20 = dDG20 + gdefault.gamesPlayerDealerOrder[pcount]
        //print("VC lGRFG dealer \(pcount) is \(gdefault.gamesPlayerDealerOrder[pcount])")
        pcount += 1
    }
    //print("VC lGRFG loading \(gdefault.gamesLengthPlayerDealerOrderOccurs) dealer #s size=\(dDG20.count)")
    dDG21 = gdefault.gamesCurrentDealer
    //print("VC lGRFG current dealer is \(dDG21) size=\(dDG21.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerChoosesPhaseOccurs {
        dDG22 = dDG22 + gdefault.gamesPlayerChoosesPhase[pcount]
        pcount += 1
    }
    //print("VC lGRFG player chooses is \(dDG22) size=\(dDG22.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase1Occurs {
        dDG23 = dDG23 + gdefault.gamesPlayerPhase1[pcount]
        pcount += 1
    }
    //print("VC lGRFG player phase 1 is \(dDG23) size=\(dDG23.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase2Occurs {
        dDG24 = dDG24 + gdefault.gamesPlayerPhase2[pcount]
        pcount += 1
    }
    //print("VC lGRFG player phase 2 is \(dDG24) size=\(dDG24.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase3Occurs {
        dDG25 = dDG25 + gdefault.gamesPlayerPhase3[pcount]
        pcount += 1
    }
    //print("VC lGRFG player phase 3 is \(dDG25) size=\(dDG25.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase4Occurs {
        dDG26 = dDG26 + gdefault.gamesPlayerPhase4[pcount]
        pcount += 1
    }
    //print("VC lGRFG player phase 4 is \(dDG26) size=\(dDG26.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase5Occurs {
        dDG27 = dDG27 + gdefault.gamesPlayerPhase5[pcount]
        pcount += 1
    }
    //print("VC lGRFG player phase 5 is \(dDG27) size=\(dDG27.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase6Occurs {
        dDG28 = dDG28 + gdefault.gamesPlayerPhase6[pcount]
        pcount += 1
    }
    //print("VC lGRFG player phase 6 is \(dDG28) size=\(dDG28.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase7Occurs {
        dDG29 = dDG29 + gdefault.gamesPlayerPhase7[pcount]
        pcount += 1
    }
    //print("VC lGRFG player phase 7 is \(dDG29) size=\(dDG29.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase8Occurs {
        dDG30 = dDG30 + gdefault.gamesPlayerPhase8[pcount]
        pcount += 1
    }
    //print("VC lGRFG player phase 8 is \(dDG30) size=\(dDG30.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase9Occurs {
        dDG31 = dDG31 + gdefault.gamesPlayerPhase9[pcount]
        pcount += 1
    }
    //print("VC lGRFG player phase 9 is \(dDG31) size=\(dDG31.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase10Occurs {
        dDG32 = dDG32 + gdefault.gamesPlayerPhase10[pcount]
        pcount += 1
    }
    //print("VC lGRFG player phase 10 is \(dDG32) size=\(dDG32.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerCurrentPhaseOccurs {
        dDG33 = dDG33 + gdefault.gamesPlayerCurrentPhase[pcount]
        pcount += 1
    }
    //print("VC lGRFG player current phase is \(dDG33) size=\(dDG33.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerStartRoundPhasesOccurs {
        dDG34 = dDG34 + gdefault.gamesPlayerStartRoundPhases[pcount]
        pcount += 1
    }
    //print("VC lGRFG player SOR phase is \(dDG34) size=\(dDG34.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPointsOccurs {
        dDG35 = dDG35 + gdefault.gamesPlayerPoints[pcount]
        pcount += 1
    }
    //print("VC lGRFG player points is \(dDG35) size=\(dDG35.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerStartRoundPointsOccurs {
        dDG36 = dDG36 + gdefault.gamesPlayerStartRoundPoints[pcount]
        pcount += 1
    }
    //print("VC lGRFG player SOR points is \(dDG36) size=\(dDG36.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerWinnerOccurs {
        dDG37 = dDG37 + gdefault.gamesPlayerWinner[pcount]
        pcount += 1
    }
    //print("VC lGRFG player winner is \(dDG37) size=\(dDG37.count)")
    dDG38 = gdefault.gamesRoundNumber
    //print("VC lGRFG round number is \(dDG38) size=\(dDG38.count)")
    dDG39 = gdefault.gamesRoundStatus
    //print("VC lGRFG round status is \(dDG39) size=\(dDG39.count)")
    dDG40 = gdefault.gamesGameStatus
    //print("VC lGRFG game status is \(dDG40) size=\(dDG40.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerButtonStatusOccurs {
        dDG41 = dDG41 + gdefault.gamesPlayerButtonStatus[pcount]
        pcount += 1
    }
    //print("VC lGRFG player button status is \(dDG41) size=\(dDG41.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPointsStatusOccurs {
        dDG42 = dDG42 + gdefault.gamesPlayerPointsStatus[pcount]
        pcount += 1
    }
    //print("VC lGRFG player points status is \(dDG42) size=\(dDG42.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPointsStatusEntryOccurs {
        dDG43 = dDG43 + gdefault.gamesPlayerPointsStatusEntry[pcount]
        pcount += 1
    }
    //print("VC lGRFG player points status entry is \(dDG43) size=\(dDG43.count)")
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerSkippedOccurs {
        dDG44 = dDG44 + gdefault.gamesPlayerSkipped[pcount]
        pcount += 1
    }
    //print("VC lGRFG player skipped status is \(dDG44) size=\(dDG44.count)")
    let gamesText:String = dDG1 + dDG2 + dDG3 + dDG4 + dDG5 + dDG6 + dDG7 + dDG8 + dDG9 + dDG10 + dDG11 + dDG12 + dDG13 + dDG14 + dDG15 + dDG16 + dDG17 + dDG18 + dDG19 + dDG20 + dDG21 + dDG22 + dDG23 + dDG24 + dDG25 + dDG26 + dDG27 + dDG28 + dDG29 + dDG30 + dDG31 + dDG32 + dDG33 + dDG34 + dDG35 + dDG36 + dDG37 + dDG38 + dDG39 + dDG40 + dDG41 + dDG42 + dDG43 + dDG44 + dDGFX54
    
    //print("VC lGRFG returning games record with size \(gamesText.count)")
    
    return gamesText
}

// Convert or create the Games file as appropriate as follows:
// Input File Level     Output File Level       Action
//       00                    02               Create current
//       01                    02               Update file from 01 to 02
//       02                    02               Leave file as is
// Note that no I/O is performed within this function
// The I/O is the responsibility of the caller
//
// Function returns the Games record and an error message if applicable

func handleGamesConversion() -> String {
    outputGamesFileLevel = currentFileLevel
    var returnGames = ""
    initConvertErrorMessage = ""
    var dDG1 = ""
    var dDG2 = ""
    var dDG3 = ""
    var dDG4 = ""
    var dDG5 = ""
    let dDG44 = "nnnnnnnnnnnnnnn"
    let dDGFX1 = futureExpansion
    let dDGFX3 = dDGFX1 + dDGFX1 + dDGFX1
    let dDGFX9 = dDGFX3 + dDGFX3 + dDGFX3
    let dDGFX54 = dDGFX9 + dDGFX9 + dDGFX9 + dDGFX9 + dDGFX9 + dDGFX9
    
    if !(inputGamesFileLevel == outputGamesFileLevel) {
        if inputGamesFileLevel == "00" {
            // Initialize current level Games record
            returnGames = loadGamesRecordFromGlobal(fileLevelIn: outputDefaultsFileLevel, gameNameIn: gdefault.dummyGamesName)
        }
        else {
            // Convert Games level 01 to level 02
            let gamesCountLimit = checkGames.count / 2048
            var gamesCount = 0
            var gamesOffset = 0
            while gamesCount < gamesCountLimit {
                gamesOffset = gamesCount * 2048
                dDG1 = fileLevelConstant
                dDG2 = outputGamesFileLevel
                // Game name through game status
                var sidx = checkGames.index(checkGames.startIndex, offsetBy: gamesOffset + 10)
                var eidx = checkGames.index(checkGames.startIndex, offsetBy: gamesOffset + 1103)
                var range = sidx ..< eidx
                dDG3 = String(checkGames[range])
                // Player status buttons
                sidx = checkGames.index(checkGames.startIndex, offsetBy: gamesOffset + 1103)
                eidx = checkGames.index(checkGames.startIndex, offsetBy: gamesOffset + 1163)
                range = sidx ..< eidx
                let originalButtons = String(checkGames[range])
                dDG4 = convertPlayerButtons(startButtons: originalButtons)
                // Player points buttons through player entry order
                sidx = checkGames.index(checkGames.startIndex, offsetBy: gamesOffset + 1163)
                eidx = checkGames.index(checkGames.startIndex, offsetBy: gamesOffset + 1208)
                range = sidx ..< eidx
                dDG5 = String(checkGames[range])
                returnGames = returnGames + dDG1 + dDG2 + dDG3 + dDG4 + dDG5 + dDG44 + dDGFX54
                gamesCount += 1
            }
        }
        return returnGames
    }
    return returnGames
}

// Conversion function for player buttons
// Input: original 60-entry buttons string
// Output: converted 75-entry buttons string
// Each set abcd becomes abxcd, where a,b,c, and d are the original values, and x is the new skipped player value
// There are 15 sets of abcd that will become 15 sets of abxcd, where x is a constant "n" (not skipped)
func convertPlayerButtons(startButtons: String) -> String {
    let originalButtonArray = Array(startButtons)
    var convertedButtons = [" ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
                            " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
                            " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
                            " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
                            " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
                            " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
                            " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
                            " ", " ", " ", " ", " "]
    convertedButtons[0]  = String(originalButtonArray[0])
    convertedButtons[1]  = String(originalButtonArray[1])
    convertedButtons[2]  = "n"
    convertedButtons[3]  = String(originalButtonArray[2])
    convertedButtons[4]  = String(originalButtonArray[3])
    convertedButtons[5]  = String(originalButtonArray[4])
    convertedButtons[6]  = String(originalButtonArray[5])
    convertedButtons[7]  = "n"
    convertedButtons[8]  = String(originalButtonArray[6])
    convertedButtons[9]  = String(originalButtonArray[7])
    convertedButtons[10] = String(originalButtonArray[8])
    convertedButtons[11] = String(originalButtonArray[9])
    convertedButtons[12] = "n"
    convertedButtons[13] = String(originalButtonArray[10])
    convertedButtons[14] = String(originalButtonArray[11])
    convertedButtons[15] = String(originalButtonArray[12])
    convertedButtons[16] = String(originalButtonArray[13])
    convertedButtons[17] = "n"
    convertedButtons[18] = String(originalButtonArray[14])
    convertedButtons[19] = String(originalButtonArray[15])
    convertedButtons[20] = String(originalButtonArray[16])
    convertedButtons[21] = String(originalButtonArray[17])
    convertedButtons[22] = "n"
    convertedButtons[23] = String(originalButtonArray[18])
    convertedButtons[24] = String(originalButtonArray[19])
    convertedButtons[25] = String(originalButtonArray[20])
    convertedButtons[26] = String(originalButtonArray[21])
    convertedButtons[27] = "n"
    convertedButtons[28] = String(originalButtonArray[22])
    convertedButtons[29] = String(originalButtonArray[23])
    convertedButtons[30] = String(originalButtonArray[24])
    convertedButtons[31] = String(originalButtonArray[25])
    convertedButtons[32] = "n"
    convertedButtons[33] = String(originalButtonArray[26])
    convertedButtons[34] = String(originalButtonArray[27])
    convertedButtons[35] = String(originalButtonArray[28])
    convertedButtons[36] = String(originalButtonArray[29])
    convertedButtons[37] = "n"
    convertedButtons[38] = String(originalButtonArray[30])
    convertedButtons[39] = String(originalButtonArray[31])
    convertedButtons[40] = String(originalButtonArray[32])
    convertedButtons[41] = String(originalButtonArray[33])
    convertedButtons[42] = "n"
    convertedButtons[43] = String(originalButtonArray[34])
    convertedButtons[44] = String(originalButtonArray[35])
    convertedButtons[45] = String(originalButtonArray[36])
    convertedButtons[46] = String(originalButtonArray[37])
    convertedButtons[47] = "n"
    convertedButtons[48] = String(originalButtonArray[38])
    convertedButtons[49] = String(originalButtonArray[39])
    convertedButtons[50] = String(originalButtonArray[40])
    convertedButtons[51] = String(originalButtonArray[41])
    convertedButtons[52] = "n"
    convertedButtons[53] = String(originalButtonArray[42])
    convertedButtons[54] = String(originalButtonArray[43])
    convertedButtons[55] = String(originalButtonArray[44])
    convertedButtons[56] = String(originalButtonArray[45])
    convertedButtons[57] = "n"
    convertedButtons[58] = String(originalButtonArray[46])
    convertedButtons[59] = String(originalButtonArray[47])
    convertedButtons[60] = String(originalButtonArray[48])
    convertedButtons[61] = String(originalButtonArray[49])
    convertedButtons[62] = "n"
    convertedButtons[63] = String(originalButtonArray[50])
    convertedButtons[64] = String(originalButtonArray[51])
    convertedButtons[65] = String(originalButtonArray[52])
    convertedButtons[66] = String(originalButtonArray[53])
    convertedButtons[67] = "n"
    convertedButtons[68] = String(originalButtonArray[54])
    convertedButtons[69] = String(originalButtonArray[55])
    convertedButtons[70] = String(originalButtonArray[56])
    convertedButtons[71] = String(originalButtonArray[57])
    convertedButtons[72] = "n"
    convertedButtons[73] = String(originalButtonArray[58])
    convertedButtons[74] = String(originalButtonArray[59])
    
    let returnString : String = convertedButtons.joined(separator: "")
    return returnString
}

// Convert or create the History file as appropriate as follows:
// Input File Level     Output File Level       Action
//       00                    02               Create current
//       01                    02               Updfate file from 01 to 02
//       02                    02               Leave file as is
// Note that no I/O is performed within this function
// The I/O is the responsibility of the caller
//
// Function returns the Games record and an error message if applicable

func handleHistoryConversion() -> String {
    outputHistoryFileLevel = currentFileLevel
    var returnHistory = ""
    initConvertErrorMessage = ""
    var dDH1 = ""
    var dDH2 = ""
    var dDH3 = ""
    
    if !(inputHistoryFileLevel == outputHistoryFileLevel) {
        if inputHistoryFileLevel == "00" {
            // Initialize current level History record
            returnHistory = initHistoryRecord(fileLevelIn: outputHistoryFileLevel, gameNameIn: gdefault.dummyHistoryName)
        }
        else {
            // Convert History level 01 to level 02
            let historyCountLimit = checkHistory.count / 16384
            var historyCount = 0
            var historyOffset = 0
            while historyCount < historyCountLimit {
                historyOffset = historyCount * 16384
                dDH1 = fileLevelConstant
                dDH2 = outputHistoryFileLevel
                // Game name through future expansion
                let sidx = checkHistory.index(checkHistory.startIndex, offsetBy: historyOffset + 10)
                let eidx = checkHistory.index(checkHistory.startIndex, offsetBy: historyOffset + 16384)
                let range = sidx ..< eidx
                dDH3 = String(checkHistory[range])
                returnHistory = returnHistory + dDH1 + dDH2 + dDH3
                historyCount += 1
            }
        }
        return returnHistory
    }
    return returnHistory
}

// Initialize a new History file record
// The file level and game name are passed to this function

func initHistoryRecord (fileLevelIn: String, gameNameIn: String) -> String {
    var dDH1 = ""
    var dDH2 = ""
    var dDH3 = ""
    let dDH4 = initHistoryConstant
    let dDHFX1 = futureExpansion
    let dDHFX5 = dDHFX1 + dDHFX1 + dDHFX1 + dDHFX1 + dDHFX1
    let dDHFX20 = dDHFX5 + dDHFX5 + dDHFX5 + dDHFX5
    let dDHFX100 = dDHFX20 + dDHFX20 + dDHFX20 + dDHFX20 + dDHFX20
    
    dDH1 = fileLevelConstant
    dDH2 = fileLevelIn
    dDH3 = gameNameIn

    //print("VC iHR lvl=\(dDH2), game name=\(dDH3), history(1)=\(dDH4)")
    
    var historyText:String = dDH1 + dDH2 + dDH3
    var hcount = 0
    while hcount < gdefault.historyLengthPlayerHistoryOccurs {
        historyText = historyText + dDH4
        hcount += 1
    }
    historyText = historyText + dDHFX100 + "Expansion"
    
    return historyText
}

// Given the full Defaults record in string checkDefaults, extract all the
// component fields and place them in the corresponding global storage fields
// set aside for the Defaults record

func extractDefaultsRecord () {

    gdefault.defaultsTrackDealer = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetTrackDealer, fieldLength: gdefault.defaultsLengthTrackDealer)

    gdefault.defaultsGameVersion = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetGameVersion, fieldLength: gdefault.defaultsLengthGameVersion)

    gdefault.defaultsPhase1 = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetPhase1, fieldLength: gdefault.defaultsLengthPhase)
    
    gdefault.defaultsPhase2 = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetPhase2, fieldLength: gdefault.defaultsLengthPhase)
    
    gdefault.defaultsPhase3 = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetPhase3, fieldLength: gdefault.defaultsLengthPhase)
    
    gdefault.defaultsPhase4 = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetPhase4, fieldLength: gdefault.defaultsLengthPhase)
   
    gdefault.defaultsPhase5 = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetPhase5, fieldLength: gdefault.defaultsLengthPhase)
    
    gdefault.defaultsPhase6 = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetPhase6, fieldLength: gdefault.defaultsLengthPhase)
    
    gdefault.defaultsPhase7 = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetPhase7, fieldLength: gdefault.defaultsLengthPhase)

    gdefault.defaultsPhase8 = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetPhase8, fieldLength: gdefault.defaultsLengthPhase)
    
    gdefault.defaultsPhase9 = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetPhase9, fieldLength: gdefault.defaultsLengthPhase)
    
    gdefault.defaultsPhase10 = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetPhase10, fieldLength: gdefault.defaultsLengthPhase)
    
    gdefault.defaultsPhaseModifier = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetPhaseModifier, fieldLength: gdefault.defaultsLengthPhaseModifier)
    
    gdefault.defaultsPlayerSort = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetPlayerSort, fieldLength: gdefault.defaultsLengthPlayerSort)
    
    gdefault.defaultsContDisplay = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetContDisplay, fieldLength: gdefault.defaultsLengthContDisplay)
} // End extractDefaultsRecord

// This function drives the initialization or conversion of all the application
// files, each one in turn. If no conversion is needed, the file is left as is.
// At the end, global storage will contain all the defaults.
//
// Input: name of file to be prepared
// Output: data record of the entire file
//
func initOrConvertFiles (fileToPrepare: String) -> String {
    
    initConvertErrorMessage = ""
    
    if fileToPrepare == "Defaults" {
    
        //=============================================================
        //=====                   DEFAULTS FILE                   =====
        //=============================================================

        // Set up levels for potential defaults file conversion as follows:
        // 1. If there is no defaults file, set the input level to "00"
        // 2. If the file exists (and by definition starts with $FILLVL$),
        //    set the input level to the two characters after $FILLVL$.
        // 3. Run the conversion function.

        // Initialize input defaults file level in case this function runs more than once

        inputDefaultsFileLevel = "ii"
        outputDefaultsFileLevel = "oo"
        checkDefaults = ""

        // Create Defaults file if it does not exist.
        
        if !FileManager.default.fileExists(atPath: defaultsFileURL.path) {
            inputDefaultsFileLevel = "00"
            //print("VC there is no Defaults file")
            if !FileManager.default.createFile(atPath: defaultsFileURL.path, contents: nil, attributes: nil) {
                initConvertErrorMessage = "Unable to create defaults file"
            }
        }

        // Read Defaults file if it exists already and extract its level.
        
        if inputDefaultsFileLevel == "ii" {
            let fileHandleVCDefaultsCk:FileHandle=FileHandle(forReadingAtPath:defaultsFileURL.path)!
            let fileContent:String=String(data: fileHandleVCDefaultsCk.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleVCDefaultsCk.closeFile()
            checkDefaults = fileContent
            
            //print("VC Defaults file length in is \(checkDefaults.count) data=<\(checkDefaults)>")

            inputDefaultsFileLevel = extractRecordField(recordIn: checkDefaults, fieldOffset: gdefault.defaultsOffsetFileLevel, fieldLength: gdefault.defaultsLengthFileLevel)
        }
        
        // Convert Defaults file (conversion function will only do so if it's
        // necessary) or initialize Defaults file based on input/output file
        // levels (see handleDefaultsConversion function).
        // The conversion function does no I/O - all I/O is performed here
           
        if initConvertErrorMessage == "" {
            let defaultsText:String = handleDefaultsConversion ()
            switch inputDefaultsFileLevel {
               
            case "00": // There was no defaults file, so write one from scratch
                //print("VC create new Defaults file")
                let fileHandleVCDefaultsUpdate:FileHandle=FileHandle(forUpdatingAtPath:defaultsFileURL.path)!
                fileHandleVCDefaultsUpdate.write(defaultsText.data(using: String.Encoding.utf8)!)
                fileHandleVCDefaultsUpdate.closeFile()
                //print("VC new Defaults file length out=\(defaultsText.count) data=<\(defaultsText)>")
                
            case "01": // The old defaults file was converted, so replace the old one - then
                       // update global memory from the converted file content (defaultsText)
                //print("VC convert Defaults file 01 to 02")
                let fileHandleVCDefaultsReplace:FileHandle=FileHandle(forUpdatingAtPath:defaultsFileURL.path)!
                fileHandleVCDefaultsReplace.truncateFile(atOffset: 0)
                fileHandleVCDefaultsReplace.write(defaultsText.data(using: String.Encoding.utf8)!)
                fileHandleVCDefaultsReplace.closeFile()
                //print("VC converted Defaults file length out=\(defaultsText.count) data=<\(defaultsText)>")
                extractDefaultsRecord ()
               
            case "02": // The defaults file was current already, so no file action is required - but must
                       // update global memory from the file content (checkDefaults)
                //print("VC leave Defaults file as is")
                //print("VC original Defaults file length out=\(checkDefaults.count) data=<\(checkDefaults)>")
                extractDefaultsRecord ()
               
            default:
                _ = ""
            }
        }
    } // End Defaults file processing
    
    if fileToPrepare == "Games" {
        //==========================================================
        //=====                   GAMES FILE                   =====
        //==========================================================
        
        // Set up levels for potential games file conversion as follows:
        // 1. If there is no games file, set the input level to "00"
        // 2. If the file exists (and by definition starts with $FILLVL$),
        //    set the input level to the two characters after $FILLVL$.
        // 3. Run the conversion function.
        
        // Initialize input games file level in case this function runs more than once
        
        inputGamesFileLevel = "ii"
        outputGamesFileLevel = "oo"
        checkGames = ""
        
        // Create Games file if it does not exist.

        if !FileManager.default.fileExists(atPath: gamesFileURL.path) {
            inputGamesFileLevel = "00"
            //print("VC there is no Games file")
            if !FileManager.default.createFile(atPath: gamesFileURL.path, contents: nil, attributes: nil) {
                initConvertErrorMessage = "Unable to create Games file"
            }
        }
        
        // Read Games file if it exists already and extract its level.
        
        if inputGamesFileLevel == "ii" {
            let fileHandleVCGamesCk:FileHandle=FileHandle(forReadingAtPath:gamesFileURL.path)!
            let fileContent:String=String(data: fileHandleVCGamesCk.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleVCGamesCk.closeFile()
            checkGames = fileContent
            //print("VC Games file length in is \(checkGames.count) data=<\(checkGames)>")
            inputGamesFileLevel = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetFileLevel, fieldLength: gdefault.gamesLengthFileLevel)
        }

        // Convert Games file (conversion function will only do so if it's
        // necessary) or initialize Games file based on input/output file
        // levels (see handleGamesConversion function).
        // The conversion function does no I/O - all I/O is performed here

        if initConvertErrorMessage == "" {
            let gamesText:String = handleGamesConversion ()
            switch inputGamesFileLevel {
               
            case "00": // There was no Games file, so write one from scratch
                //print("VC create new Games file")
                let fileHandleVCGamesUpdate:FileHandle=FileHandle(forUpdatingAtPath:gamesFileURL.path)!
                fileHandleVCGamesUpdate.write(gamesText.data(using: String.Encoding.utf8)!)
                fileHandleVCGamesUpdate.closeFile()
                //print("VC new Games file length out=\(gamesText.count) data=<\(gamesText)>")
            
            case "01": // The old Games file was converted, so replace the old one - then
                       // update global memory from the converted file content (gamesText)
                //print("VC convert Games file 01 to 02")
                let fileHandleVCGamesReplace:FileHandle=FileHandle(forUpdatingAtPath:gamesFileURL.path)!
                fileHandleVCGamesReplace.truncateFile(atOffset: 0)
                fileHandleVCGamesReplace.write(gamesText.data(using: String.Encoding.utf8)!)
                fileHandleVCGamesReplace.closeFile()
                //print("VC converted Games file length out=\(gamesText.count) data=<\(gamesText)>")
               
            case "02":
                //print("VC leave Games file as is")
                //print("VC original Games file length out=\(checkGames.count) data=<\(checkGames)>")
                break // The Games file was current already, so no file action is required
                
            default:
                   _ = ""
               }
           }
     } //End Games file processing
    
       if fileToPrepare == "History" {
     
         //=============================================================
         //=====                    HISTORY FILE                   =====
         //=============================================================

         // Set up levels for potential history file conversion as follows:
         // 1. If there is no history file, set the input level to "00"
         // 2. If the file exists (and by definition starts with $FILLVL$),
         //    set the input level to the two characters after $FILLVL$.
         // 3. Run the conversion function.

         // Initialize input history file level in case this function runs more than once

         inputHistoryFileLevel = "ii"
         outputHistoryFileLevel = "oo"
         checkHistory = ""

         // Create History file if it does not exist.

         if !FileManager.default.fileExists(atPath: historyFileURL.path) {
             inputHistoryFileLevel = "00"
             //print("VC there is no History file")
             if !FileManager.default.createFile(atPath: historyFileURL.path, contents: nil, attributes: nil) {
                 initConvertErrorMessage = "Unable to create history file"
             }
         }

        // Read History file if it exists already and extract its level.

         if inputHistoryFileLevel == "ii" {
             let fileHandleVCHistoryCk:FileHandle=FileHandle(forReadingAtPath:historyFileURL.path)!
             let fileContent:String=String(data: fileHandleVCHistoryCk.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
             fileHandleVCHistoryCk.closeFile()
             checkHistory = fileContent
             //print("VC History file length in is \(checkHistory.count) data=<\(checkHistory)>")

             inputHistoryFileLevel = extractRecordField(recordIn: checkHistory, fieldOffset: gdefault.historyOffsetFileLevel, fieldLength: gdefault.historyLengthFileLevel)
         }

         // Convert History file (conversion function will only do so if it's
         // necessary) or initialize History file based on input/output file
         // levels (see handleHistoryConversion function).
         // The conversion function does no I/O - all I/O is performed here
        
         if initConvertErrorMessage == "" {
            let historyText:String = handleHistoryConversion ()
            switch inputHistoryFileLevel {
                
            case "00": // There was no history file, so write one from scratch
                //print("VC create new History file")
                let fileHandleVCHistoryUpdate:FileHandle=FileHandle(forUpdatingAtPath:historyFileURL.path)!
                fileHandleVCHistoryUpdate.write(historyText.data(using: String.Encoding.utf8)!)
                fileHandleVCHistoryUpdate.closeFile()
                //print("VC new History file length out=\(historyText.count) data=<\(historyText)>")
                
            case "01": // The old History file was converted, so replace the old one - then
                       // update global memory from the converted file content (historyText)
                //print("VC convert History file 01 to 02")
                let fileHandleVCHistoryReplace:FileHandle=FileHandle(forUpdatingAtPath:historyFileURL.path)!
                fileHandleVCHistoryReplace.truncateFile(atOffset: 0)
                fileHandleVCHistoryReplace.write(historyText.data(using: String.Encoding.utf8)!)
                fileHandleVCHistoryReplace.closeFile()
                //print("VC converted History file length out=\(historyText.count) data=<\(historyText)>")
                
            case "02":
                //print("VC leave History file as is")
                //print("VC original History file length out=\(checkHistory.count) data=<\(checkHistory)>")
                break // The history file was current already, so no file action is required
                
            default:
                _ = ""
            }
        }
     } // End history file processing
    
     return initConvertErrorMessage
} // End initOrConvertFiles

// Given the full Games record in string checkGames, extract all the
// component fields and place them in the corresponding global storage fields
// set aside for the Games record

func extractGamesRecord () {

    gdefault.gamesGameName = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetGameName, fieldLength: gdefault.gamesLengthGameName)
    //print("VC extracted gameName=\(gdefault.gamesGameName)")

    gdefault.gamesGameVersion = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetGameVersion, fieldLength: gdefault.gamesLengthGameVersion)
    //print("VC extracted gameVersion=\(gdefault.gamesGameVersion)")

    gdefault.gamesPhase1 = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPhase1, fieldLength: gdefault.gamesLengthPhase)
    //print("VC extracted P1=\(gdefault.gamesPhase1)")

    gdefault.gamesPhase2 = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPhase2, fieldLength: gdefault.gamesLengthPhase)
    //print("VC extracted P2=\(gdefault.gamesPhase2)")

    gdefault.gamesPhase3 = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPhase3, fieldLength: gdefault.gamesLengthPhase)
    //print("VC extracted P3=\(gdefault.gamesPhase3)")

    gdefault.gamesPhase4 = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPhase4, fieldLength: gdefault.gamesLengthPhase)
    //print("VC extracted P4=\(gdefault.gamesPhase4)")

    gdefault.gamesPhase5 = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPhase5, fieldLength: gdefault.gamesLengthPhase)
    //print("VC extracted P5=\(gdefault.gamesPhase5)")

    gdefault.gamesPhase6 = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPhase6, fieldLength: gdefault.gamesLengthPhase)
    //print("VC extracted P6=\(gdefault.gamesPhase6)")

    gdefault.gamesPhase7 = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPhase7, fieldLength: gdefault.gamesLengthPhase)
    //print("VC extracted P7=\(gdefault.gamesPhase7)")

    gdefault.gamesPhase8 = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPhase8, fieldLength: gdefault.gamesLengthPhase)
    //print("VC extracted P8=\(gdefault.gamesPhase8)")

    gdefault.gamesPhase9 = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPhase9, fieldLength: gdefault.gamesLengthPhase)
    //print("VC extracted P9=\(gdefault.gamesPhase9)")

    gdefault.gamesPhase10 = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPhase10, fieldLength: gdefault.gamesLengthPhase)
    //print("VC extracted P10=\(gdefault.gamesPhase10)")

    gdefault.gamesPhaseModifier = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPhaseModifier, fieldLength: gdefault.gamesLengthPhaseModifier)
    //print("VC extracted modifier=\(gdefault.gamesPhaseModifier)")

    gdefault.gamesTrackDealer = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetTrackDealer, fieldLength: gdefault.gamesLengthTrackDealer)
    //print("VC extracted trackDealer=\(gdefault.gamesTrackDealer)")

    gdefault.gamesPlayerSort = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerSort, fieldLength: gdefault.gamesLengthPlayerSort)
    //print("VC extracted player sort=\(gdefault.gamesPlayerSort)")

    var pcount = 0
    while pcount < gdefault.gamesLengthPlayerNameOccurs {
        gdefault.gamesPlayerName[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerName + (pcount * gdefault.gamesLengthPlayerName), fieldLength: gdefault.gamesLengthPlayerName)
        //print("VC extracted player name \(pcount)=\(gdefault.gamesPlayerName[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerEntryOrderOccurs {
        gdefault.gamesPlayerEntryOrder[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerEntryOrder + (pcount * gdefault.gamesLengthPlayerEntryOrder), fieldLength: gdefault.gamesLengthPlayerEntryOrder)
        //print("VC extracted player entry order \(pcount)=\(gdefault.gamesPlayerEntryOrder[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerDealerOrderOccurs {
        gdefault.gamesPlayerDealerOrder[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerDealerOrder + (pcount * gdefault.gamesLengthPlayerDealerOrder), fieldLength: gdefault.gamesLengthPlayerDealerOrder)
        //print("VC extracted player Dealer order \(pcount)=\(gdefault.gamesPlayerDealerOrder[pcount])")
        pcount+=1
    }

    gdefault.gamesCurrentDealer = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetCurrentDealer, fieldLength: gdefault.gamesLengthCurrentDealer)
    //print("VC extracted dealer=\(gdefault.gamesCurrentDealer)")

    pcount = 0
    while pcount < gdefault.gamesLengthPlayerChoosesPhaseOccurs {
        gdefault.gamesPlayerChoosesPhase[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerChoosesPhase + (pcount * gdefault.gamesLengthPlayerChoosesPhase), fieldLength: gdefault.gamesLengthPlayerChoosesPhase)
        //print("VC extracted player chooses phase \(pcount)=\(gdefault.gamesPlayerChoosesPhase[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase1Occurs {
        gdefault.gamesPlayerPhase1[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerPhase1 + (pcount * gdefault.gamesLengthPlayerPhase1), fieldLength: gdefault.gamesLengthPlayerPhase1)
        //print("VC extracted player phase 1 \(pcount)=\(gdefault.gamesPlayerPhase1[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase2Occurs {
        gdefault.gamesPlayerPhase2[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerPhase2 + (pcount * gdefault.gamesLengthPlayerPhase2), fieldLength: gdefault.gamesLengthPlayerPhase2)
        //print("VC extracted player phase 2 \(pcount)=\(gdefault.gamesPlayerPhase2[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase3Occurs {
        gdefault.gamesPlayerPhase3[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerPhase3 + (pcount * gdefault.gamesLengthPlayerPhase3), fieldLength: gdefault.gamesLengthPlayerPhase3)
        //print("VC extracted player phase 3 \(pcount)=\(gdefault.gamesPlayerPhase3[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase4Occurs {
        gdefault.gamesPlayerPhase4[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerPhase4 + (pcount * gdefault.gamesLengthPlayerPhase4), fieldLength: gdefault.gamesLengthPlayerPhase4)
        //print("VC extracted player phase 4 \(pcount)=\(gdefault.gamesPlayerPhase4[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase5Occurs {
        gdefault.gamesPlayerPhase5[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerPhase5 + (pcount * gdefault.gamesLengthPlayerPhase5), fieldLength: gdefault.gamesLengthPlayerPhase5)
        //print("VC extracted player phase 5 \(pcount)=\(gdefault.gamesPlayerPhase5[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase6Occurs {
        gdefault.gamesPlayerPhase6[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerPhase6 + (pcount * gdefault.gamesLengthPlayerPhase6), fieldLength: gdefault.gamesLengthPlayerPhase6)
        //print("VC extracted player phase 6 \(pcount)=\(gdefault.gamesPlayerPhase6[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase7Occurs {
        gdefault.gamesPlayerPhase7[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerPhase7 + (pcount * gdefault.gamesLengthPlayerPhase7), fieldLength: gdefault.gamesLengthPlayerPhase7)
        //print("VC extracted player phase 7 \(pcount)=\(gdefault.gamesPlayerPhase7[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase8Occurs {
        gdefault.gamesPlayerPhase8[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerPhase8 + (pcount * gdefault.gamesLengthPlayerPhase8), fieldLength: gdefault.gamesLengthPlayerPhase8)
        //print("VC extracted player phase 8 \(pcount)=\(gdefault.gamesPlayerPhase8[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase9Occurs {
        gdefault.gamesPlayerPhase9[pcount] = extractRecordField(recordIn: checkGames,  fieldOffset: gdefault.gamesOffsetPlayerPhase9 + (pcount * gdefault.gamesLengthPlayerPhase9), fieldLength: gdefault.gamesLengthPlayerPhase9)
        //print("VC extracted player phase 9 \(pcount)=\(gdefault.gamesPlayerPhase9[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPhase10Occurs {
        gdefault.gamesPlayerPhase10[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerPhase10 + (pcount * gdefault.gamesLengthPlayerPhase10), fieldLength: gdefault.gamesLengthPlayerPhase10)
        //print("VC extracted player phase 10 \(pcount)=\(gdefault.gamesPlayerPhase10[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerCurrentPhaseOccurs {
        gdefault.gamesPlayerCurrentPhase[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerCurrentPhase + (pcount * gdefault.gamesLengthPlayerCurrentPhase), fieldLength: gdefault.gamesLengthPlayerCurrentPhase)
        //print("VC extracted player current phase \(pcount)=\(gdefault.gamesPlayerCurrentPhase[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerStartRoundPhasesOccurs {
        gdefault.gamesPlayerStartRoundPhases[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerStartRoundPhases + (pcount * gdefault.gamesLengthPlayerStartRoundPhases), fieldLength: gdefault.gamesLengthPlayerStartRoundPhases)
        //print("VC extracted player start round phases \(pcount)=\(gdefault.gamesPlayerStartRoundPhases[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPointsOccurs {
        gdefault.gamesPlayerPoints[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerPoints + (pcount * gdefault.gamesLengthPlayerPoints), fieldLength: gdefault.gamesLengthPlayerPoints)
        //print("VC extracted player points \(pcount)=\(gdefault.gamesPlayerPoints[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerStartRoundPointsOccurs {
        gdefault.gamesPlayerStartRoundPoints[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerStartRoundPoints + (pcount * gdefault.gamesLengthPlayerStartRoundPoints), fieldLength: gdefault.gamesLengthPlayerStartRoundPoints)
        //print("VC extracted player start round points \(pcount)=\(gdefault.gamesPlayerStartRoundPoints[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerWinnerOccurs {
        gdefault.gamesPlayerWinner[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerWinner + (pcount * gdefault.gamesLengthPlayerWinner), fieldLength: gdefault.gamesLengthPlayerWinner)
        //print("VC extracted player winner \(pcount)=\(gdefault.gamesPlayerWinner[pcount])")
        pcount+=1
    }
    
    gdefault.gamesRoundNumber = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetRoundNumber, fieldLength: gdefault.gamesLengthRoundNumber)
    //print("VC extracted round number=\(gdefault.gamesRoundNumber)")
    
    gdefault.gamesRoundStatus = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetRoundStatus, fieldLength: gdefault.gamesLengthRoundStatus)
    //print("VC extracted round status=\(gdefault.gamesRoundStatus)")
    
    gdefault.gamesGameStatus = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetGameStatus, fieldLength: gdefault.gamesLengthGameStatus)
    //print("VC extracted game status=\(gdefault.gamesGameStatus)")
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerButtonStatusOccurs {
        gdefault.gamesPlayerButtonStatus[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerButtonStatus + (pcount * gdefault.gamesLengthPlayerButtonStatus), fieldLength: gdefault.gamesLengthPlayerButtonStatus)
        //print("VC extracted player button status \(pcount)=\(gdefault.gamesPlayerButtonStatus[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPointsStatusOccurs {
        gdefault.gamesPlayerPointsStatus[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerPointsStatus + (pcount * gdefault.gamesLengthPlayerPointsStatus), fieldLength: gdefault.gamesLengthPlayerPointsStatus)
        //print("VC extracted player points status \(pcount)=\(gdefault.gamesPlayerPointsStatus[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerPointsStatusEntryOccurs {
        gdefault.gamesPlayerPointsStatusEntry[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerPointsStatusEntry + (pcount * gdefault.gamesLengthPlayerPointsStatusEntry), fieldLength: gdefault.gamesLengthPlayerPointsStatusEntry)
        //print("VC extracted player points status entry \(pcount)=\(gdefault.gamesPlayerPointsStatusEntry[pcount])")
        pcount+=1
    }
    
    pcount = 0
    while pcount < gdefault.gamesLengthPlayerSkippedOccurs {
        gdefault.gamesPlayerSkipped[pcount] = extractRecordField(recordIn: checkGames, fieldOffset: gdefault.gamesOffsetPlayerSkipped + (pcount * gdefault.gamesLengthPlayerSkipped), fieldLength: gdefault.gamesLengthPlayerSkipped)
        //print("VC extracted player skipped \(pcount)=\(gdefault.gamesPlayerSkipped[pcount])")
        pcount+=1
    }
    
} // End extractGamesRecord

// Function to acquire the phase status for players who do choose phases
// Input:   index to the player arrays
// Returns: phase information in text format
//          phase level information in raw data format
//          all phases in raw data format
//          number of phases completed in raw data format

func analyzeChoicePhaseCompletion (indexIn: Int) -> (phaseText: String, phaseRaw: String, phasesAllRaw: String, completedRaw: String) {
    
    let allPhasesCompleted = " All Phases Completed"
    let noPhasesCompleted = " No Phases Completed"
    var phasesCompleted = 0
    var phaseText = " Completed "
    var phaseRaw = ""
    var phasesAllRaw = ""
    var completedRaw = ""
    let comma = ","
    var useComma = ""
    
    useComma = ""
    switch gdefault.gamesPhaseModifier {
    case allPhasesCode:
        if gdefault.gamesPlayerPhase1[indexIn] > phaseDivider {
            phasesCompleted += 1
            phaseText = phaseText + "1"
            phasesAllRaw = "001"
            //print("TG phase1 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase2[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "2"
            phasesAllRaw = phasesAllRaw + "002"
            //print("TG phase2 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase3[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "3"
            phasesAllRaw = phasesAllRaw + "003"
            //print("TG phase3 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase4[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "4"
            phasesAllRaw = phasesAllRaw + "004"
            //print("TG phase4 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase5[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "5"
            phasesAllRaw = phasesAllRaw + "005"
            //print("TG phase5 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase6[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "6"
            phasesAllRaw = phasesAllRaw + "006"
            //print("TG phase6 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase7[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "7"
            phasesAllRaw = phasesAllRaw + "007"
            //print("TG phase7 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase8[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "8"
            phasesAllRaw = phasesAllRaw + "008"
            //print("TG phase8 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase9[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "9"
            phasesAllRaw = phasesAllRaw + "009"
            //print("TG phase9 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase10[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "10"
            phasesAllRaw = phasesAllRaw + "010"
            //print("TG phase10 > 500, phasesCompleted now=\(phasesCompleted)")
        }
                
        if phasesCompleted == 0 {
            //print("TG dpaps # completed = 0")
            phaseText = noPhasesCompleted
        }
        else if phasesCompleted == 10 {
            //print("TG dpaps # completed = 10")
            phaseText = allPhasesCompleted
        }
        phaseRaw = String(format: "%03d", phasesCompleted + 1)
        completedRaw = String(format: "%03d", phasesCompleted)
    case evenPhasesCode:
        if gdefault.gamesPlayerPhase2[indexIn] > phaseDivider {
            phasesCompleted += 1
            phaseText = phaseText + "2"
            phasesAllRaw = "002"
            //print("TG phase2 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase4[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "4"
            phasesAllRaw = phasesAllRaw + "004"
            //print("TG phase4 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase6[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "6"
            phasesAllRaw = phasesAllRaw + "006"
            //print("TG phase6 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase8[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "8"
            phasesAllRaw = phasesAllRaw + "008"
            //print("TG phase8 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase10[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "10"
            phasesAllRaw = phasesAllRaw + "010"
            //print("TG phase10 > 500, phasesCompleted now=\(phasesCompleted)")
        }
                
        if phasesCompleted == 0 {
            //print("TG dpaps # completed = 0")
            phaseText = noPhasesCompleted
        }
        else if phasesCompleted == 5 {
            //print("TG dpaps # completed = 5")
            phaseText = allPhasesCompleted
        }
        phaseRaw = String(format: "%03d", phasesCompleted + 1)
        completedRaw = String(format: "%03d", phasesCompleted)
    case oddPhasesCode:
        if gdefault.gamesPlayerPhase1[indexIn] > phaseDivider {
            phasesCompleted += 1
            phaseText = phaseText + "1"
            phasesAllRaw = "001"
            //print("TG phase1 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase3[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "3"
            phasesAllRaw = phasesAllRaw + "003"
            //print("TG phase3 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase5[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "5"
            phasesAllRaw = phasesAllRaw + "005"
            //print("TG phase5 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase7[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "7"
            phasesAllRaw = phasesAllRaw + "007"
            //print("TG phase7 > 500, phasesCompleted now=\(phasesCompleted)")
        }
        if gdefault.gamesPlayerPhase9[indexIn] > phaseDivider {
            phasesCompleted += 1
            if phasesCompleted > 1 {
                useComma = comma
            }
            phaseText = phaseText + useComma + "9"
            phasesAllRaw = phasesAllRaw + "009"
            //print("TG phase9 > 500, phasesCompleted now=\(phasesCompleted)")
        }
                
        if phasesCompleted == 0 {
            //print("TG dpaps # completed = 0")
            phaseText = noPhasesCompleted
        }
        else if phasesCompleted == 5 {
            //print("TG dpaps # completed = 5")
            phaseText = allPhasesCompleted
        }
        phaseRaw = String(format: "%03d", phasesCompleted + 1)
        completedRaw = String(format: "%03d", phasesCompleted)
    default:
        _ = ""
    }
    
    return (phaseText, phaseRaw, phasesAllRaw, completedRaw)
}

// Function to acquire the phase status for players who do not choose phases
// Input:   index to the player arrays
// Returns: phase information in text format
//          phase information in raw data format
//          number of phases completed in raw format

func analyzeNoChoicePhaseCompletion (indexIn: Int) -> (phaseText: String, phaseRaw: String, completedRaw: String) {
    
    let currentPhase = " Current Phase  "
    let allPhasesCompleted = " All Phases Completed"
    var phaseText = ""
    var phaseRaw = ""
    var completedRaw = ""
    
    //print("analyze no choice mod=\(gdefault.gamesPhaseModifier)")
    
    switch gdefault.gamesPhaseModifier {
    case allPhasesCode:
        if gdefault.gamesPlayerPhase1[indexIn] < phaseDivider {
            phaseText = currentPhase + "1"
            phaseRaw = "001"
            completedRaw = "000"
        }
        else if gdefault.gamesPlayerPhase2[indexIn] < phaseDivider {
            phaseText = currentPhase + "2"
            phaseRaw = "002"
            completedRaw = "001"
        }
        else if gdefault.gamesPlayerPhase3[indexIn] < phaseDivider {
            phaseText = currentPhase + "3"
            phaseRaw = "003"
            completedRaw = "002"
        }
        else if gdefault.gamesPlayerPhase4[indexIn] < phaseDivider {
            phaseText = currentPhase + "4"
            phaseRaw = "004"
            completedRaw = "003"
        }
        else if gdefault.gamesPlayerPhase5[indexIn] < phaseDivider {
            phaseText = currentPhase + "5"
            phaseRaw = "005"
            completedRaw = "004"
        }
        else if gdefault.gamesPlayerPhase6[indexIn] < phaseDivider {
            phaseText = currentPhase + "6"
            phaseRaw = "006"
            completedRaw = "005"
        }
        else if gdefault.gamesPlayerPhase7[indexIn] < phaseDivider {
            phaseText = currentPhase + "7"
            phaseRaw = "007"
            completedRaw = "006"
        }
        else if gdefault.gamesPlayerPhase8[indexIn] < phaseDivider {
            phaseText = currentPhase + "8"
            phaseRaw = "008"
            completedRaw = "007"
        }
        else if gdefault.gamesPlayerPhase9[indexIn] < phaseDivider {
            phaseText = currentPhase + "9"
            phaseRaw = "009"
            completedRaw = "008"
        }
        else if gdefault.gamesPlayerPhase10[indexIn] < phaseDivider {
            phaseText = currentPhase + "10"
            phaseRaw = "010"
            completedRaw = "009"
        }
        else {
            phaseText = allPhasesCompleted
            //phaseRaw = "011"
            phaseRaw = constantPhase11
            completedRaw = "010"
        }
    case evenPhasesCode:
        if gdefault.gamesPlayerPhase2[indexIn] < phaseDivider {
            //print("anc phase2=\(gdefault.gamesPlayerPhase2[indexIn])")
            phaseText = currentPhase + "2"
            phaseRaw = "002"
            completedRaw = "000"
        }
        else if gdefault.gamesPlayerPhase4[indexIn] < phaseDivider {
            //print("anc phase4=\(gdefault.gamesPlayerPhase4[indexIn])")
            phaseText = currentPhase + "4"
            phaseRaw = "004"
            completedRaw = "001"
        }
        else if gdefault.gamesPlayerPhase6[indexIn] < phaseDivider {
            //print("anc phase6=\(gdefault.gamesPlayerPhase6[indexIn])")
            phaseText = currentPhase + "6"
            phaseRaw = "006"
            completedRaw = "002"
        }
        else if gdefault.gamesPlayerPhase8[indexIn] < phaseDivider {
            //print("anc phase8=\(gdefault.gamesPlayerPhase8[indexIn])")
            phaseText = currentPhase + "8"
            phaseRaw = "008"
            completedRaw = "003"
        }
        else if gdefault.gamesPlayerPhase10[indexIn] < phaseDivider {
            //print("anc phase10=\(gdefault.gamesPlayerPhase10[indexIn])")
            phaseText = currentPhase + "10"
            phaseRaw = "010"
            completedRaw = "004"
        }
        else {
            //print("anc all phases completed")
            phaseText = allPhasesCompleted
            //phaseRaw = "011"
            phaseRaw = constantPhase11
            completedRaw = "005"
        }
    case oddPhasesCode:
        if gdefault.gamesPlayerPhase1[indexIn] < phaseDivider {
            phaseText = currentPhase + "1"
            phaseRaw = "001"
            completedRaw = "000"
        }
        else if gdefault.gamesPlayerPhase3[indexIn] < phaseDivider {
            phaseText = currentPhase + "3"
            phaseRaw = "003"
            completedRaw = "001"
        }
        else if gdefault.gamesPlayerPhase5[indexIn] < phaseDivider {
            phaseText = currentPhase + "5"
            phaseRaw = "005"
            completedRaw = "002"
        }
        else if gdefault.gamesPlayerPhase7[indexIn] < phaseDivider {
            phaseText = currentPhase + "7"
            phaseRaw = "007"
            completedRaw = "003"
        }
        else if gdefault.gamesPlayerPhase9[indexIn] < phaseDivider {
            phaseText = currentPhase + "9"
            phaseRaw = "009"
            completedRaw = "004"
        }
        else {
            phaseText = allPhasesCompleted
            //phaseRaw = "011"
            phaseRaw = constantPhase11
            completedRaw = "005"
        }
    default:
        _ = ""
    }
    return (phaseText, phaseRaw, completedRaw)
}

// General function to analyze a string and verify that it contains only letters, numbers, or spaces
// Input: string to be analyzed
// Output: boolean true if string contains only A-Z, a-z, 0-9, and space
//         boolean false if any other character is found
func isAlphaNumSpace(dataIn: String) -> Bool {

    var goodCharacters = true
    for char in dataIn {
        if !goodCharacters {
            break
        }
        switch char {
        case "a"..."z", "A"..."Z", "0"..."9", " ":
            _=""
        default:
            goodCharacters = false
        }
    }
    return goodCharacters
}

// General function to analyze a string and verify that it contains only numbers
// Input: string to be analyzed
// Output: boolean true if string contains only 0-9
//         boolean false if any other character is found
func isNum(dataIn: String) -> Bool {

    var goodCharacters = true
    for char in dataIn {
        if !goodCharacters {
            break
        }
        switch char {
        case "0"..."9":
            _=""
        default:
            goodCharacters = false
        }
    }
    return goodCharacters
}

// General function to convert a player's entry number to the code used for the history file
// Input:   player entry number
// Output:  history code
func createHistoryPlayerCode(playerIn: String) -> String {
    let codeValues = "abcdefghijklmnopqrstuvwxyz"
    let intPlayerIn = Int(playerIn)
    let idx = codeValues.index(codeValues.startIndex, offsetBy: intPlayerIn! - 1)
    return String(codeValues[idx])
}

let scrollView :UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.isScrollEnabled = true
    scrollView.isPagingEnabled = true
    scrollView.backgroundColor = appColorMediumGreen
    return scrollView
}()

class ViewController: UIViewController {
    @IBOutlet weak var playGameButton: UIButton!
    @IBOutlet weak var aReviewAppButton: UIButton!
    @IBOutlet weak var editDefaultsButton: UIButton!
    @IBOutlet weak var contDisplayNo: UILabel!
    @IBOutlet weak var contDisplaySlider: UISlider!
    @IBOutlet weak var contDisplayYes: UILabel!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    @IBOutlet weak var informationArea1: UILabel!
    @IBOutlet weak var informationArea2: UILabel!
    @IBOutlet weak var informationArea3: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    
    var largerYesNoFont: CGFloat = 30
    /*
    let vc = TheGame()
    vc.returnToStart = { [weak self] in
        guard let self = self else { return }
    }
     */
    
    
    
    /*
    let vc = TheGame
    ()
    vc.returnToAvailableGames = { [weak self] in
        // unwrap optional
        guard let self = self else { return }
    }
    */
    
    // The continuous display slider has been moved
    @IBAction func contDisplaySlider(_ sender: UISlider) {
        
        // Set value to the nearest 1 and turn the idle timer override on or off
               
        sender.setValue((Float)((Int)((sender.value + 0.5) / 1) * 1), animated: false)
        let sval = Int(contDisplaySlider.value)
        if sval == 0 {
            gdefault.defaultsContDisplay = leaveIdleTimer
            contDisplayNo.textColor = appColorBrightGreen
            contDisplayNo.font = UIFont.systemFont(ofSize: largerYesNoFont, weight: UIFont.Weight.heavy)
            contDisplayYes.textColor = appColorDarkGray
            contDisplayYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            UIApplication.shared.isIdleTimerDisabled = false
        }
        else {
            gdefault.defaultsContDisplay = overrideIdleTimer
            contDisplayNo.textColor = appColorDarkGray
            contDisplayNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            contDisplayYes.textColor = appColorBrightGreen
            contDisplayYes.font = UIFont.systemFont(ofSize: largerYesNoFont, weight: UIFont.Weight.heavy)
            UIApplication.shared.isIdleTimerDisabled = true
        }
        
        // Then update the Defaults file accordingly
        
        let defaultsText: String = loadDefaultsRecordFromGlobal(fileLevelIn: currentFileLevel)
         
        // First clear the file, then write the reconstructed record in its place
         
        let fileHandleCDDefaultsUpdate:FileHandle=FileHandle(forUpdatingAtPath:defaultsFileURL.path)!
        
        fileHandleCDDefaultsUpdate.truncateFile(atOffset: 0)
        fileHandleCDDefaultsUpdate.write(defaultsText.data(using: String.Encoding.utf8)!)
        fileHandleCDDefaultsUpdate.closeFile()
    }
    
    @IBAction func aReviewAppButton(_ sender: Any) {
        
        // Establish review service
        let reviewService = ReviewService.shared
        
        // Send user to Apple to leave a written review (not just stars)
        // Note that this review may be done as often as the user desires
        let deadline = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            [weak self] in reviewService.requestReview(isWrittenReview: true)
        }
    }
    
    // The help button has been pressed
    @IBAction func aViewTutorialButton(_ sender: Any) {
        gdefault.helpCaller = helpSectionCodeWelcome
    }
    
    // Anchor to return to this view from anywhere
    @IBAction func unwindToViewController(sender: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        
        //print("VC start vDL")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Save the iPhone or iPad model we're running on because
        // a few fields need to be adjusted based on the screen size
        let theDeviceWeAreRunningOn = UIDevice.modelName
        // Remove "Simulator " from the device model name
        deviceWeAreRunningOn = theDeviceWeAreRunningOn.replacingOccurrences(of: "Simulator ", with: "")
        deviceCategoryWeAreRunningOn = ""
        //print("VC vDL we are running on \(deviceWeAreRunningOn)")
        
        if largerScreeniPhones.contains(deviceWeAreRunningOn) {
            deviceCategoryWeAreRunningOn = iPhoneLargeConstant
        }
        
        if deviceCategoryWeAreRunningOn == "" {
            if deviceWeAreRunningOn.contains(iPadConstant) {
                deviceCategoryWeAreRunningOn = iPadConstant
            }
        }
            
        if deviceCategoryWeAreRunningOn == "" {
            deviceCategoryWeAreRunningOn = iPhoneSmallConstant
        }
        //print("VC vDL and this is category \(deviceCategoryWeAreRunningOn)")
        
        let screenSize : CGRect = UIScreen.main.bounds
        deviceWidth = Int(screenSize.width)
        deviceHeight = Int(screenSize.height)
        //print("VC vDL screen W=\(deviceWidth) H=\(deviceHeight)")
        
        // Initialize error message
        errorMessage.text = ""
        
        // Make the error message have bold text
        errorMessage.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
        
        // Round the button corners
        playGameButton.layer.cornerRadius = cornerRadiusStdButton
        aReviewAppButton.layer.cornerRadius = cornerRadiusStdButton
        editDefaultsButton.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton

        informationArea1.text = ""
        informationArea2.text = ""
        informationArea3.text = ""
        
        // Create, convert, or leave all the system files alone as needed
        errorMessage.textColor = appColorRed
        errorMessage.text = initOrConvertFiles(fileToPrepare: "Defaults")
        
        if errorMessage.text == "" {
            errorMessage.text = initOrConvertFiles(fileToPrepare: "Games")
        }
        
        if errorMessage.text == "" {
            errorMessage.text = initOrConvertFiles(fileToPrepare: "History")
        }
        
        if !(errorMessage.text == "") {
            errorMessage.backgroundColor = appColorYellow
        }
        
        // If requested by the user, override the iPhone timeout so that the app
        // continues running without going to sleep
        switch gdefault.defaultsContDisplay {
        case overrideIdleTimer:
            UIApplication.shared.isIdleTimerDisabled = true
        case leaveIdleTimer:
            UIApplication.shared.isIdleTimerDisabled = false
        default:
            UIApplication.shared.isIdleTimerDisabled = false
        }
        
        //print("VC end vDL")
    } // End of ViewDidLoad
    
    func aRefreshView() {

        // Load the view data values from global storage
             
        // Continuous display
        
        if gdefault.defaultsContDisplay == overrideIdleTimer {
            contDisplaySlider.value = 1
            contDisplayNo.textColor = appColorDarkGray
            contDisplayNo.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
            contDisplayYes.textColor = appColorBrightGreen
            contDisplayYes.font = UIFont.systemFont(ofSize: largerYesNoFont, weight: UIFont.Weight.heavy)
        }
        else {
            contDisplaySlider.value = 0
            contDisplayNo.textColor = appColorBrightGreen
            contDisplayNo.font = UIFont.systemFont(ofSize: largerYesNoFont, weight: UIFont.Weight.heavy)
            contDisplayYes.textColor = appColorDarkGray
            contDisplayYes.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        }
        
        informationArea1.text = ""
        informationArea2.text = ""
        informationArea3.text = ""
        
        // Give the user a warning if there are more than 50 games are on file - this many
        // games can slow down the application
        if errorMessage.text == "" {
            let fileHandleVC50GamesGet:FileHandle=FileHandle(forReadingAtPath:gamesFileURL.path)!
            let fileContent:String=String(data: fileHandleVC50GamesGet.availableData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
            fileHandleVC50GamesGet.closeFile()
            let gameFileSize = fileContent.count
            // Compute number of games in the file (minus one to allow for the dummy game)
            let gamesInFile = gameFileSize / gdefault.gamesRecordSize - 1
            if gamesInFile > 49 {
                informationArea1.text = "You have " + String(gamesInFile) + " games on file."
                informationArea2.text = "To help the app run faster, it would"
                informationArea3.text = "be a good idea to remove some of them."
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //print("VC start vWA")
        
        // We're at the first view in the system - set indication that scrolling is always forward from here
        //print("VC vWA startOverTarget was \(gdefault.startOverTarget)")
        gdefault.startOverTarget = movingForward
        //print("VC vWA now setting forward movement direction")
        aRefreshView()
        //print("VC end vWA")
    }
}
