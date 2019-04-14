//
//  NewPassViewController.swift
//  AmusementPark
//
//  Created by davidlaiymani on 13/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import UIKit

class NewPassViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeAndCategoryLabel: UILabel!
    @IBOutlet weak var rideAccessLabel: UILabel!
    @IBOutlet weak var skipTheLinesLabel: UILabel!
    @IBOutlet weak var merchDiscountLabel: UILabel!
    @IBOutlet weak var foodDiscountLabel: UILabel!
    
    
    @IBOutlet weak var areaAccessButton: UIButton!
    @IBOutlet weak var rideAccessButton: UIButton!
    @IBOutlet weak var discountAccessButton: UIButton!
    
    @IBOutlet weak var testLabel: UILabel!
    
    // MARK: - Stored Properties
    var entrant: Entrant?
    let soundEffectsPlayer = SoundEffectPlayer()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        rideAccessLabel.text = ""
        skipTheLinesLabel.text = ""
        
        if let entrant = entrant {
            displayName(for: entrant)
            displayCategoryAndType(for: entrant)
            displayAccess(for: entrant)
            displayDiscounts(for: entrant)
        }
    }
    

    func displayName(for entrant: Entrant) {
        switch (entrant.entrantCategory, entrant.entrantType) {
        case (.guest, .freeChild), (.guest, .vip), (.guest, .classic):
            nameLabel.text = ""
            if entrant.entrantType == .freeChild {
                if let child = entrant as? ChildGuest, child.birthDate.isBirthday() {
                    nameLabel.text = "Happy Birthday 🎂 🎈"
                }
            }
        default: // personalInformation can be nil
            nameLabel.text = "\(entrant.personalInformation!.firstName) \(entrant.personalInformation!.firstName)"
        }
    }

    func displayCategoryAndType(for entrant: Entrant) {
        typeAndCategoryLabel.text = "\(entrant.entrantCategory.rawValue) \(entrant.entrantType.rawValue) Pass"
    }
    
    func displayAccess(for entrant: Entrant) {

        if entrant.rideAccess.contains(.all) {
            rideAccessLabel.text = "Unlimited Access to Rides"
            skipTheLinesLabel.text = "Not allowed to skip the lines ❌ "
        }
        if entrant.rideAccess.contains(.skipTheLines) {
            skipTheLinesLabel.text = "Allowed to skip the lines 👍"
        }
    }
    
    func displayDiscounts(for entrant: Entrant) {
        foodDiscountLabel.text = "\(entrant.discountAccess[0].discount)% Food Discount"
        merchDiscountLabel.text = "\(entrant.discountAccess[1].discount)% Merch Discount"

    }
    
    
    // MARK: - Test part

    @IBAction func areaAccessButtonTapped(_ sender: UIButton) {
        let areas: [Area] = [.amusement, .kitchen, .maintenance, .office, .rideControl]
        
        var testString = "Access to: "
        if let entrant = entrant {
            for area in areas {
                if entrant.areaAccess.contains(area) {
                    testString += "\(area)-"
                }
            }
        }
        testString = testString.dropLast() + ""
        if testString == "" {
            testLabel.text = "Acces Denied"
            soundEffectsPlayer.playSound(for: .accessDenied)
        } else {
            testLabel.text = testString
            soundEffectsPlayer.playSound(for: .accessGranted)
        }

    }
    
    @IBAction func rideAccessButtonTapped(_ sender: UIButton) {
        
        var rideAccessString = ""
        if let rideAccess = rideAccessLabel.text {
            rideAccessString += rideAccess
        }
        
        if let skipTheLine = skipTheLinesLabel.text {
            if rideAccessString == "" {
                rideAccessString += skipTheLine
            } else {
                rideAccessString += " - \(skipTheLine)"
            }
        }
        
        testLabel.text = rideAccessString
        
        if rideAccessString != "" {
            soundEffectsPlayer.playSound(for: .accessGranted)
        } else {
            testLabel.text = "Access Denied"
            soundEffectsPlayer.playSound(for: .accessDenied)
        }
    }
    
    @IBAction func discountAccessButtonTapped(_ sender: UIButton) {
        
        testLabel.text = "\(foodDiscountLabel.text!) - \(merchDiscountLabel.text!)"

    }
    
    @IBAction func createNewPass(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Pass Created", message: "Back to main screen", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    
    

}
