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
    
    @IBOutlet weak var amusementLabel: UILabel!
    @IBOutlet weak var centerLeftLabel: UILabel! // For kitchen, ride access, food disc.
    @IBOutlet weak var centerRightLabel: UILabel! // For skip the lines and merch. disc.
    @IBOutlet weak var rideControl: UILabel!
    @IBOutlet weak var maintenanceLabel: UILabel!
    @IBOutlet weak var officeLabel: UILabel!
    // MARK: - Stored Properties
    var entrant: Entrant? // Entrant to test
    let soundEffectsPlayer = SoundEffectPlayer()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        rideAccessLabel.text = ""
        skipTheLinesLabel.text = ""
        testLabel.text = "Access To:"
        
        if let entrant = entrant {
            displayName(for: entrant)
            displayCategoryAndType(for: entrant)
            displayAccess(for: entrant)
            displayDiscounts(for: entrant)
        }
    }
    

    // Set of functions displaying the main info of the entrant
    func displayName(for entrant: Entrant) {
        switch (entrant.entrantCategory, entrant.entrantType) {
        case (.guest, .freeChild), (.guest, .vip), (.guest, .classic):
            nameLabel.text = ""
            if entrant.entrantType == .freeChild {
                if let child = entrant as? ChildGuest, child.birthDate.isBirthday() {
                    nameLabel.text = "Happy Birthday 🎂 🎈"
                }
            }
        default: // personalInformation cannot be nil
            nameLabel.text = "\(entrant.personalInformation!.firstName) \(entrant.personalInformation!.firstName)"
        }
    }

    func displayCategoryAndType(for entrant: Entrant) {
        typeAndCategoryLabel.text = "\(entrant.entrantCategory.rawValue) \(entrant.entrantType.rawValue) Pass"
    }
    
    func displayAccess(for entrant: Entrant) {
        if entrant.rideAccess.contains(.all) {
            rideAccessLabel.text = "Unlimited Access to Rides ✅"
            skipTheLinesLabel.text = "Not allowed to skip the lines ⛔️ "
        }
        if entrant.rideAccess.contains(.skipTheLines) {
            skipTheLinesLabel.text = "Allowed to skip the lines ✅"
        }
    }
    
    func displayDiscounts(for entrant: Entrant) {
        
        if entrant.discountAccess[0].discount == 0.0 {
            foodDiscountLabel.text = "No Food Discount 😞"
        } else {
            foodDiscountLabel.text = "\(entrant.discountAccess[0].discount)% Food Discount 👍"
        }
        
        if entrant.discountAccess[1].discount == 0.0 {
            merchDiscountLabel.text = "No Merch Discount 😞"
            
        } else {
            merchDiscountLabel.text = "\(entrant.discountAccess[1].discount)% Merch Discount 👍"
        }

    }
    
    
    // MARK: - Test part

    @IBAction func areaAccessButtonTapped(_ sender: UIButton) {
        let areas: [Area] = [.amusement, .kitchen, .maintenance, .office, .rideControl]
        
        var stringAccess = ""
        
        if let entrant = entrant {
            for area in areas { // testing for the different areas
                
                
                if entrant.areaAccess.contains(area) {
                    stringAccess = "\(area.rawValue) ✅"
                    soundEffectsPlayer.playSound(for: .accessGranted)

                } else {
                    stringAccess = "\(area.rawValue) ⛔️"
                    soundEffectsPlayer.playSound(for: .accessDenied)
                }
                
                switch area {
                case .amusement:
                    amusementLabel.text = stringAccess
                case .kitchen:
                    centerLeftLabel.text = stringAccess
                case .maintenance:
                    maintenanceLabel.text = stringAccess
                case .rideControl:
                    rideControl.text = stringAccess
                case .office:
                    officeLabel.text = stringAccess
                }
            }
            centerRightLabel.text = ""
        }

    }
    
    @IBAction func rideAccessButtonTapped(_ sender: UIButton) {
        
        // Ride access
        amusementLabel.text = ""
        rideControl.text = ""
        maintenanceLabel.text = ""
        officeLabel.text = ""
        
        if let rideAccess = rideAccessLabel.text {
            centerLeftLabel.text = rideAccess
        } else {
            centerLeftLabel.text = "Unlimited Access to Rides ⛔️"
        }
        
        // Skip the lines access
        if let skipTheLine = skipTheLinesLabel.text {
            centerRightLabel.text = skipTheLine
        }
        
    }
    
    
    @IBAction func discountAccessButtonTapped(_ sender: UIButton) {
        
        if let foodLabel = foodDiscountLabel.text {
            centerLeftLabel.text = foodLabel
        }
        
        if let merchlabel = merchDiscountLabel.text {
            centerRightLabel.text = merchlabel
        }
    }
    
    // Creat new pass (i.e. displayong an alert view) and back to the main screen
    @IBAction func createNewPass(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Pass Created", message: "Back to main screen", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
