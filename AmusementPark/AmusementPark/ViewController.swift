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
    
    @IBOutlet weak var populateDataButton: UIButton!
    
    var entrantType: EntrantType = .freeChild
    var entrantCategory: EntrantCategory = .guest
    
    var employees = [Employee]()
    var guest = [Guest]()
    var manager = [Manager]()
    var vendor = [Vendor]()
    
    
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
            entrantCategory = .vendor
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
                populateDataButton.isEnabled = true
                populateDataButton.setTitleColor(.black, for: .normal)

            case entrantTypeButtons[1]:
                entrantType = .classic
                populateDataButton.isEnabled = false
                populateDataButton.setTitleColor(.lightGray, for: .normal)
            case entrantTypeButtons[2]:
                entrantType = .senior
                populateDataButton.isEnabled = true
                populateDataButton.setTitleColor(.black, for: .normal)

            case entrantTypeButtons[3]:
                entrantType = .seasonPass
                populateDataButton.isEnabled = true
                populateDataButton.setTitleColor(.black, for: .normal)

            case entrantTypeButtons[4]:
                entrantType = .vip
                populateDataButton.isEnabled = false
                populateDataButton.setTitleColor(.lightGray, for: .normal)

            default:
                fatalError()
            }
        } else if entrantCategory == .employee {
            populateDataButton.isEnabled = true
            populateDataButton.setTitleColor(.black, for: .normal)
            switch sender {
            case entrantTypeButtons[0]:
                entrantType = .food
            case entrantTypeButtons[1]:
                entrantType = .ride
            case entrantTypeButtons[2]:
                entrantType = .maintenance
            case entrantTypeButtons[3]:
                entrantType = .contract
            default:
                fatalError()
            }
        } else if entrantCategory == .manager {
            entrantType = .manager
        } else {
            entrantType = .vendor

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
        entrantTypeButtons[3].setTitle("Season Pass", for: .normal)
        entrantTypeButtons[3].isEnabled = true
        entrantTypeButtons[4].setTitle("VIP", for: .normal)
    }
    
    func displayEmployeeBar() {
        enableCategoryButtons()
        entrantTypeButtons[0].setTitle("Food Services", for: .normal)
        entrantTypeButtons[1].setTitle("Ride Services", for: .normal)
        entrantTypeButtons[2].setTitle("Maintenance", for: .normal)
        entrantTypeButtons[3].setTitle("Contract", for: .normal)
        entrantTypeButtons[4].isEnabled = false
        entrantTypeButtons[4].setTitle("", for: .normal)
        entrantTypeButtons[4].isHidden = true

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
            textField.text = ""
        }
    }
    
    func disableTextField(atIndex index: Int) {
        textFieldsArray[index].isEnabled = false
        textFieldsArray[index].backgroundColor = .lightGray
        textFieldsArray[index].text = ""

    }
    
    func enableAllTextFields() {
        for textField in textFieldsArray {
            textField.isEnabled = true
            textField.backgroundColor = .white
            textField.text = ""

        }
    }
    
    
    func enableTextField(atIndex index: Int) {
        textFieldsArray[index].isEnabled = true
        textFieldsArray[index].backgroundColor = .white
        textFieldsArray[index].text = ""

    }
    
    func manageTextField() {
        switch (entrantCategory, entrantType) {
        case (.guest, .freeChild):
            disableAllTextFields()
            enableTextField(atIndex: 0)
        case (.guest, .classic), (.guest, .vip):
            disableAllTextFields()
        case (.guest, .senior):
            disableAllTextFields()
            enableTextField(atIndex: 0)
            enableTextField(atIndex: 3)
            enableTextField(atIndex: 4)
        case (.guest, .seasonPass), (.employee, .food), (.employee, .ride),
             (.employee, .maintenance), (.employee, .contract), (.manager, .manager):
            enableAllTextFields()
            disableTextField(atIndex: 5)
            disableTextField(atIndex: 0)
            disableTextField(atIndex: 1)
            disableTextField(atIndex: 2)
        case (.vendor, .vendor):
            disableAllTextFields()
            enableTextField(atIndex: 0)
            enableTextField(atIndex: 3)
            enableTextField(atIndex: 4)
            enableTextField(atIndex: 5)
        default:
            fatalError()
        }
        
    }
    
    // MARK: - Populate Data
    
    @IBAction func populateDataTapped(_ sender: UIButton) {
        switch (entrantCategory, entrantType) {
        case (.guest, .freeChild):
            dateOfBirthTextField.text = "2016-04-03"
        case (.guest, .seasonPass):
            let personalInformation = PersonalInformation(firstName: "Season", lastName: "Pass", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
            populateForm(personalInformation: personalInformation, birthDate: nil)
        case (.guest, .senior):
            let personalInformation = PersonalInformation(firstName: "Senior", lastName: "Senior", streetAddress: "", city: "", state: "", zipCode: "")
            populateForm(personalInformation: personalInformation, birthDate: "1960-01-01")

        case (.employee, .food):
            let personalInformation = PersonalInformation(firstName: "Sheldon", lastName: "Cooper", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
            populateForm(personalInformation: personalInformation, birthDate: nil)
        case (.employee, .maintenance):
            let personalInformation = PersonalInformation(firstName: "Amy", lastName: "Fowler", streetAddress: "2 Infinite Loop", city: "Pasadena", state: "New York", zipCode: "91001")
            populateForm(personalInformation: personalInformation, birthDate: nil)
        case (.employee, .ride):
            let personalInformation = PersonalInformation(firstName: "Penny", lastName: "Hofstader", streetAddress: "3 Infinite Loop", city: "Ohmaha", state: "Nebraska", zipCode: "68197")
            populateForm(personalInformation: personalInformation, birthDate: nil)
        case (.employee, .contract):
            let personalInformation = PersonalInformation(firstName: "Leonard", lastName: "Hofstader", streetAddress: "4 Infinite Loop", city: "Pasadena", state: "California", zipCode: "90000")
            populateForm(personalInformation: personalInformation, birthDate: nil)
        case (.manager, .manager):
            let personalInformation = PersonalInformation(firstName: "Rajesh", lastName: "Kootrapali", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
            populateForm(personalInformation: personalInformation, birthDate: nil)
        case (.vendor, .vendor):
            let personalInformation = PersonalInformation(firstName: "Howard", lastName: "Wolowitz", streetAddress: "", city: "", state: "", zipCode: "")
            populateForm(personalInformation: personalInformation, birthDate: "1970-09-25")

        default:
            
            fatalError()
        }
    }
    
    func populateForm(personalInformation: PersonalInformation, birthDate: String?) {
        if let birthDate = birthDate {
            dateOfBirthTextField.text = birthDate
        }
        firstNameTextField.text = personalInformation.firstName
        lastNameTextField.text = personalInformation.lastName
        streetAddressTextField.text = personalInformation.streetAddress
        cityTextField.text = personalInformation.city
        stateTextField.text = personalInformation.state
        zipCodeTextField.text = personalInformation.zipCode
        
    }
    
    
    
    // Temp function
//    func createObjects() {
//        switch (entrantCategory, entrantType) {
//        case (.guest, .freeChild):
//            do {
//                let childEntrant = try ChildGuest(birthDate: "2016-04-03")
//                dateOfBirthTextField.text = childEntrant.stringForPersonalInformation()
//            } catch EntrantError.missingDateOfBirth {
//                print("Date of birth is missing")
//            } catch EntrantError.tooOld {
//                print("Child is too old")
//            } catch let error {
//                print("Unexpected error \(error)")
//            }
//        case (.guest, .seasonPass):
//            let personalInformation = PersonalInformation(firstName: "Season", lastName: "Pass", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
//            let guest = SeasonPassGuest(personalInformation: personalInformation)
//            firstNameTextField.text = guest.personalInformation.firstName
//            lastNameTextField.text = guest.personalInformation.lastName
//            streetAddressTextField.text = guest.personalInformation.streetAddress
//            cityTextField.text = guest.personalInformation.city
//            stateTextField.text = guest.personalInformation.state
//            zipCodeTextField.text = guest.personalInformation.zipCode
//
//
//        case (.guest, .senior):
//            let personalInformation = PersonalInformation(firstName: "Senior", lastName: "Senior", streetAddress: "2 Infinite Loop", city: "Pasadena", state: "New York", zipCode: "91001")
//            do {
//                let guest = try SeniorGuest(birthDate: "1960-01-01", personalInformation: personalInformation)
//                firstNameTextField.text = guest.personalInformation.firstName
//                lastNameTextField.text = guest.personalInformation.lastName
//                dateOfBirthTextField.text = "\(guest.birthDate)"
//            } catch EntrantError.missingDateOfBirth {
//                print("Date of birth is missing")
//            } catch let error {
//                print("Unexpected error \(error)")
//            }
//        case (.employee, .food):
//            populateEmployeeData(employees[0])
//        case (.employee, .maintenance):
//            populateEmployeeData(employees[1])
//        case (.employee, .ride):
//            populateEmployeeData(employees[2])
//        case (.employee, .contract):
//            populateEmployeeData(employees[3])
//        case (.manager, .manager):
//            let personalInformationManager = PersonalInformation(firstName: "Rajesh", lastName: "Kootrapali", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
//            do {
//                let manager = try Manager(personalInformation: personalInformationManager)
//                populateManagerData(manager)
//            } catch EntrantError.addressImcomplete {
//                print("Address incomplete")
//            } catch let error {
//                print("Unexpected error\(error) ")
//            }
//
//        case (.vendor, .vendor):
//            let personalInformationVendor = PersonalInformation(firstName: "Howard", lastName: "Wolowitz", streetAddress: "1 Inifinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
//            do {
//                let vendor = try Vendor(birthDate: "1970-09-25", personalInformation: personalInformationVendor, company: "Apple")
//                populateVendorData(vendor)
//            } catch EntrantError.addressImcomplete {
//                print("Address incomplete")
//            } catch let error {
//                print("Unexpected error\(error) ")
//            }
//        default:
//
//            fatalError()
//        }
//    }
    
}

