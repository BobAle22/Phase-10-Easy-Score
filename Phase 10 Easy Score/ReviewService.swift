//
//  ReviewService.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 3/14/22.
//  Copyright © 2022 Robert J Alessi. All rights reserved.
//

import Foundation
import StoreKit

class ReviewService {
    
    private init() {}
    static let shared = ReviewService()
    
    private let defaults = UserDefaults.standard
    private let app = UIApplication.shared
    
    private var lastRequest: Date? {
        get {
            // Get the last request date
            return defaults.value(forKey: "ReviewService.lastRequest") as? Date
        }
        set {
            // Set the last request date
            defaults.set(newValue, forKey: "ReviewService.lastRequest")
        }
    }
    
    private var fourMonthsAgo: Date {
        //let todaysDate = Date()
        //let fourMonthsAgo = Calendar.current.date(byAdding: .day, value: -124, to: Date())!
        //print("RS-1A todaysDate=\(todaysDate)")
        //print("RS-1B fourMonthsAgo=\(fourMonthsAgo)")
        return Calendar.current.date(byAdding: .day, value: -124, to: Date())!
    }
    
    private var shouldRequestReview: Bool {
        //print("RS sRR running should RequestReview - only for stars reviews - should not be executed for written reviews")
        if lastRequest == nil {
            // This is the first time ever requesting a review - ok to do so
            //print("RS-2  lastRequest is nil - ok to review")
            return true
        }
        else {
            // It has been at least 4 months since the last review - ok to do so
            //print("RS-3A lastRequest is not nil, but=\(String(describing: lastRequest))")
            //print("RS-3B fourMonthsAgo=\(fourMonthsAgo)")
            let lastRequest = self.lastRequest
            if !(lastRequest! > fourMonthsAgo) {
                //print("RS-4  lastRequest=\(String(describing: lastRequest)) is less than or equal to 4 months ago - ok to review")
                return true
            }
        }
        // It has been less than 4 months since the last review - not ok to do so
        //print("RS-5A lastRequest is not nil, but=\(String(describing: lastRequest))")
        //print("RS-5B fourMonthsAgo=\(fourMonthsAgo)")
        //print("RS-5C lastRequest is greater than 4 months ago - not ok to review")
        return false
    }
     
    func requestReview(isWrittenReview: Bool = false) {
        if isWrittenReview {
            // Prompt the user for a written review
            let appStoreURL = URL(string: AppleReviewWebsite)!
            app.open(appStoreURL)
        }
        else {
            guard shouldRequestReview else {return}
            // Prompt the user for a "stars" review only
            SKStoreReviewController.requestReview()
            lastRequest = Date()
        }
    }

}
