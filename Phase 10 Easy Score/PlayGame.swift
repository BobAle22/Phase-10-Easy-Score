//
//  PlayGame.swift
//  Phase 10 Easy Score
//
//  Created by Robert J Alessi on 1/28/20.
//  Copyright © 2020 Robert J Alessi. All rights reserved.
//

import UIKit

class PlayGame: UIViewController {

    @IBOutlet weak var aResumeGameButton: UIButton!
    @IBOutlet weak var aStartGameButton: UIButton!
    @IBOutlet weak var aRestartGameButton: UIButton!
    @IBOutlet weak var aRemoveGameButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var aViewTutorialButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    // Anchor to return to this view from anywhere
    @IBAction func unwindToPlayGame(sender: UIStoryboardSegue) {
    }
    
    @IBAction func aViewTutorialButton(_ sender: Any) {
        gdefault.helpCaller = helpSectionCodePlayAGame
    }
    
    // Set 2nd half of the instructions to appear on the next screen
    @IBAction func aResumeGameButton(_ sender: Any) {
        gdefault.availableGameChoiceInstructions = "Resume"
    }
    
    // Set 2nd half of the instructions to appear on the next screen
    @IBAction func aRestartGameButton(_ sender: Any) {
        gdefault.availableGameChoiceInstructions = "Restart"
    }
    
    // Set 2nd half of the instructions to appear on the next screen
    @IBAction func aRemoveGameButton(_ sender: Any) {
        gdefault.availableGameChoiceInstructions = "Remove"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Initialize error message
        errorMessage.text = ""
        
        // Make the error message have bold text
        errorMessage.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
        
        // Round the button corners
        aResumeGameButton.layer.cornerRadius = cornerRadiusStdButton
        aStartGameButton.layer.cornerRadius = cornerRadiusStdButton
        aRestartGameButton.layer.cornerRadius = cornerRadiusStdButton
        aRemoveGameButton.layer.cornerRadius = cornerRadiusStdButton
        cancelButton.layer.cornerRadius = cornerRadiusStdButton
        aViewTutorialButton.layer.cornerRadius = cornerRadiusHelpButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //print("PG start vWA")
        
        // Hide this view if we're scrolling backward to the beginning        
        //print("PG vWA startOver was \(gdefault.startOverTarget)")
        if gdefault.startOverTarget == VCTarget {
            //print("PG vWA hiding view (scrolling backward to the beginning)")
            self.view.isHidden = true
        }
        //else {
            //print("PG vWA not hiding view (scrolling forward)")
        //}
    
        super.viewWillAppear(animated)
        
        //print("PG end vWA")
    } // End viewWillAppear
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
