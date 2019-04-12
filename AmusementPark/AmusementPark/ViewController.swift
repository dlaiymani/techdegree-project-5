//
//  ViewController.swift
//  AmusementPark
//
//  Created by davidlaiymani on 11/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Buttons Outlets
    @IBOutlet var entrantCategoryButtons: [UIButton]!
    @IBOutlet var entrantTypeButtons: [UIButton]!
    
    // MARK: - TextField Outlets
    
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var ssnTextField: UITextField!
    @IBOutlet weak var projectNumberTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    var textFieldsArray = [UITextField]()
    
    var entrantType: EntrantType = .freeChild
    var entrantCategory: EntrantCategory = .guest
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldsArray = [dateOfBirthTextField, ssnTextField, projectNumberTextField, firstNameTextField, lastNameTextField, companyTextField,
                           streetAddressTextField, cityTextField, stateTextField, zipCodeTextField]
        entrantButtonTapped(sender: entrantCategoryButtons[0])
        categoryButtonTapped(sender: entrantTypeButtons[0])
        affectActionToEntrantButtons()
        affectActionToCategoryButtons()
      
        
    }
    
    // Entrant Category buttons display managment
    func affectActionToEntrantButtons() {
        for button in entrantCategoryButtons {
            button.addTarget(self, action: #selector(entrantButtonTapped(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func entrantButtonTapped(sender: UIButton) {
        for button in entrantCategoryButtons {
            if button != sender {
                button.setTitleColor(.gray, for: .normal)
            } else {
                button.setTitleColor(.white, for: .normal)
            }
        }
        
        switch sender {
        case entrantCategoryButtons[0]:
            displayGuestBar()
            entrantCategory = .guest
        case entrantCategoryButtons[1]:
            displayEmployeeBar()
            entrantCategory = .employee
        case entrantCategoryButtons[2]:
            displayManagerBar()
            entrantCategory = .manager
        case entrantCategoryButtons[3]:
            displayVendorBar()
            entrantCategory = .manager
        default:
            fatalError()
            
        }
        categoryButtonTapped(sender: entrantTypeButtons[0])

        print("\(entrantCategory) - \(entrantType)")
        manageTextField()

    }
    
    // Entrant Type bar managment
    
    func affectActionToCategoryButtons() {
        for button in entrantTypeButtons {
            button.addTarget(self, action: #selector(categoryButtonTapped(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func categoryButtonTapped(sender: UIButton) {
        for button in entrantTypeButtons {
            if button != sender {
                button.setTitleColor(.gray, for: .normal)
            } else {
                button.setTitleColor(.white, for: .normal)
            }
        }
        
        if entrantCategory == .guest {
            switch sender {
            case entrantTypeButtons[0]:
                entrantType = .freeChild
            case entrantTypeButtons[1]:
                entrantType = .classic
            case entrantTypeButtons[2]:
                entrantType = .vip
            case entrantTypeButtons[3]:
                entrantType = .vip
            default:
                fatalError()
            }
        } else if entrantCategory == .employee {
            switch sender {
            case entrantTypeButtons[0]:
                entrantType = .food
            case entrantTypeButtons[1]:
                entrantType = .ride
            case entrantTypeButtons[2]:
                entrantType = .maintenance
            case entrantTypeButtons[3]:
                entrantType = .maintenance
            default:
                fatalError()
            }
        } else if entrantCategory == .manager {
            entrantType = .manager
        }
        manageTextField()
        
        print("\(entrantCategory) - \(entrantType)")
        
        
    }
    
    func enableCategoryButtons() {
        for button in entrantTypeButtons {
            button.isEnabled = true
            button.isHidden = false

        }
    }
    
    func disableCategoryButtons() {
        for button in entrantTypeButtons {
            button.isEnabled = false
            button.isHidden = true
        }
    }
    func displayGuestBar() {
        enableCategoryButtons()
        entrantTypeButtons[0].setTitle("Child", for: .normal)
        entrantTypeButtons[1].setTitle("Adult", for: .normal)
        entrantTypeButtons[2].setTitle("Senior", for: .normal)
        entrantTypeButtons[3].setTitle("VIP", for: .normal)
    }
    
    func displayEmployeeBar() {
        enableCategoryButtons()
        entrantTypeButtons[0].setTitle("Food Services", for: .normal)
        entrantTypeButtons[1].setTitle("Ride Services", for: .normal)
        entrantTypeButtons[2].setTitle("Maintenance", for: .normal)
        entrantTypeButtons[3].setTitle("Contract", for: .normal)
    }

    func displayManagerBar() {
        disableCategoryButtons()
    }
    
    
    func displayVendorBar() {
        disableCategoryButtons()
    }
    
    // textFields management
    
    func disableAllTextFields() {
        for textField in textFieldsArray {
            textField.isEnabled = false
            textField.backgroundColor = .lightGray
        }
    }
    
    func enableAllTextFields() {
        for textField in textFieldsArray {
            textField.isEnabled = true
            textField.backgroundColor = .white
        }
    }
    
    func manageTextField() {
        switch (entrantCategory, entrantType) {
        case (.guest, .freeChild):
            disableAllTextFields()
            textFieldsArray[0].isEnabled = true
            textFieldsArray[0].backgroundColor = .white
        case (.guest, .classic):
            enableAllTextFields()
            textFieldsArray[5].isEnabled = false
            textFieldsArray[5].backgroundColor = .lightGray
        default:
            fatalError()
        }
        
    }

}

