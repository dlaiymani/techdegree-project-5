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

    var rideAccessRight = false
    var skipTheLinesRight = false

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
            nameLabel.text = "\(entrant.personalInformation!.firstName) \(entrant.personalInformation!.lastName)"
        }
    }

    func displayCategoryAndType(for entrant: Entrant) {
        if entrant.entrantCategory == .manager || entrant.entrantCategory == .vendor {
            typeAndCategoryLabel.text = "\(entrant.entrantCategory.rawValue) Pass"
        } else {
            typeAndCategoryLabel.text = "\(entrant.entrantCategory.rawValue) \(entrant.entrantType.rawValue) Pass"
        }
    }
    
    func displayAccess(for entrant: Entrant) {
        if entrant.rideAccess.isEmpty { // Vendor or Contract Employee
            rideAccessLabel.text = "Access to Rides Denied ⛔️"
            rideAccessRight = false
            skipTheLinesLabel.text = "Not allowed to skip the lines ⛔️"
            skipTheLinesRight = false
        }
        if entrant.rideAccess.contains(.all) {
            rideAccessLabel.text = "Unlimited Access to Rides ✅"
            rideAccessRight = true
            skipTheLinesLabel.text = "Not allowed to skip the lines ⛔️"
            skipTheLinesRight = false

        }
        if entrant.rideAccess.contains(.skipTheLines) {
            skipTheLinesLabel.text = "Allowed to skip the lines ✅"
            skipTheLinesRight = false
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
        let areas: [Area] = [.amusement, .kitchen, .rideControl, .maintenance, .office]
        
        emptyLabelInTestView()
        
        var delay = DispatchTime.now() + .seconds(0)
        if let entrant = entrant {
            for area in areas { // testing for the different areas
                
                // Perform a 1 second pause between each display
                DispatchQueue.main.asyncAfter(deadline: delay, execute: {
                    self.displayAreaAccess(forArea: area, andEntrant: entrant)
                })
                delay = delay + .seconds(1)
            }
            centerRightLabel.text = ""
        }

    }
    
    // Displays Access rights for a given Entrant and a given Area
    func displayAreaAccess(forArea area: Area, andEntrant entrant: Entrant) {
        
        
        var stringAccess = ""

        if entrant.areaAccess.contains(area) {
            stringAccess = "\(area.rawValue) ✅"
            soundEffectsPlayer.playSound(for: .accessGranted)
            
        } else {
            stringAccess = "\(area.rawValue) ⛔️"
            soundEffectsPlayer.playSound(for: .accessDenied)
        }
        
        switch area {
        case .amusement:
            self.amusementLabel.text = stringAccess
        case .kitchen:
            self.centerLeftLabel.text = stringAccess
        case .maintenance:
            self.maintenanceLabel.text = stringAccess
        case .rideControl:
            self.rideControl.text = stringAccess
        case .office:
            self.officeLabel.text = stringAccess
        }
        
    }
    
    @IBAction func rideAccessButtonTapped(_ sender: UIButton) {
        
        // Ride access
        emptyLabelInTestView()
        if let rideAccess = rideAccessLabel.text {
            centerLeftLabel.text = rideAccess
        }
        
        if rideAccessRight {
            soundEffectsPlayer.playSound(for: .accessGranted)
        } else {
            soundEffectsPlayer.playSound(for: .accessDenied)
        }
        
        let delay = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
            // Skip the lines access
            if let skipTheLine = self.skipTheLinesLabel.text {
                self.centerRightLabel.text = skipTheLine
            }
            if self.skipTheLinesRight {
                self.soundEffectsPlayer.playSound(for: .accessGranted)
            } else {
                self.soundEffectsPlayer.playSound(for: .accessDenied)
            }
        })
        
        
    }
    
    
    @IBAction func discountAccessButtonTapped(_ sender: UIButton) {
        
        emptyLabelInTestView()
        
        if let foodLabel = foodDiscountLabel.text {
            centerLeftLabel.text = foodLabel
        }
        
        if let merchlabel = merchDiscountLabel.text {
            centerRightLabel.text = merchlabel
        }
    }
    
    func emptyLabelInTestView() {
        amusementLabel.text = ""
        rideControl.text = ""
        maintenanceLabel.text = ""
        officeLabel.text = ""
        centerRightLabel.text = ""
        centerLeftLabel.text = ""
        
    }
    
    // Create new pass (i.e. displayong an alert view) and back to the main screen
    @IBAction func createNewPass(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Pass Created", message: "Back to main screen", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
