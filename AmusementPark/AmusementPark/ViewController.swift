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
    
    // MARK: - Constraints
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    
    var entrantType: EntrantType = .freeChild
    var entrantCategory: EntrantCategory = .guest
    
    var employees = [Employee]()
    var guest = [Guest]()
    var manager = [Manager]()
    var vendor = [Vendor]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        textFieldsArray = [dateOfBirthTextField, ssnTextField, projectNumberTextField, firstNameTextField, lastNameTextField, companyTextField,
                           streetAddressTextField, cityTextField, stateTextField, zipCodeTextField]
        entrantTypeButtonTapped(sender: entrantCategoryButtons[0])
        categoryButtonTapped(sender: entrantTypeButtons[0])
        affectActionToEntrantButtons()
        affectActionToCategoryButtons()
      
    }
    
    // Entrant Category buttons display managment
    func affectActionToEntrantButtons() {
        for button in entrantCategoryButtons {
            button.addTarget(self, action: #selector(entrantTypeButtonTapped(sender:)), for: .touchUpInside)
        }
    }
    
    func grayButtons(_ buttonsArray: [UIButton], except buttonTapped: UIButton) {
        for button in buttonsArray {
            if buttonTapped != button {
                button.setTitleColor(.gray, for: .normal)
            } else {
                button.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    @objc func entrantTypeButtonTapped(sender: UIButton) {
        grayButtons(entrantCategoryButtons, except: sender)
        
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
        grayButtons(entrantTypeButtons, except: sender)
        managePopulateButton(isEnabled: true)
        
        switch entrantCategory {
        case .guest:
            switch sender {
            case entrantTypeButtons[0]:
                entrantType = .freeChild
            case entrantTypeButtons[1]:
                entrantType = .classic
                managePopulateButton(isEnabled: false)
            case entrantTypeButtons[2]:
                entrantType = .senior
            case entrantTypeButtons[3]:
                entrantType = .seasonPass
            case entrantTypeButtons[4]:
                entrantType = .vip
                managePopulateButton(isEnabled: false)
            default:
                fatalError()
            }
        case .employee:
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
        case .manager:
            entrantType = .manager
        case .vendor:
            entrantType = .vendor
        default:
            fatalError()
        }
        manageTextField()
        
        print("\(entrantCategory) - \(entrantType)")
    }
    
    func managePopulateButton(isEnabled: Bool) {
        if isEnabled == true {
            populateDataButton.isEnabled = true
            populateDataButton.setTitleColor(.black, for: .normal)
        } else {
            populateDataButton.isEnabled = false
            populateDataButton.setTitleColor(.lightGray, for: .normal)
        }
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
            populateForm(personalInformation: personalInformation, birthDate: nil, company: nil)
        case (.guest, .senior):
            let personalInformation = PersonalInformation(firstName: "Senior", lastName: "Senior", streetAddress: "", city: "", state: "", zipCode: "")
            populateForm(personalInformation: personalInformation, birthDate: "1960-01-01", company: nil)

        case (.employee, .food):
            let personalInformation = PersonalInformation(firstName: "Sheldon", lastName: "Cooper", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
            populateForm(personalInformation: personalInformation, birthDate: nil, company: nil)
        case (.employee, .maintenance):
            let personalInformation = PersonalInformation(firstName: "Amy", lastName: "Fowler", streetAddress: "2 Infinite Loop", city: "Pasadena", state: "New York", zipCode: "91001")
            populateForm(personalInformation: personalInformation, birthDate: nil, company: nil)
        case (.employee, .ride):
            let personalInformation = PersonalInformation(firstName: "Penny", lastName: "Hofstader", streetAddress: "3 Infinite Loop", city: "Ohmaha", state: "Nebraska", zipCode: "68197")
            populateForm(personalInformation: personalInformation, birthDate: nil, company: nil)
        case (.employee, .contract):
            let personalInformation = PersonalInformation(firstName: "Leonard", lastName: "Hofstader", streetAddress: "4 Infinite Loop", city: "Pasadena", state: "California", zipCode: "90000")
            populateForm(personalInformation: personalInformation, birthDate: nil, company: nil)
        case (.manager, .manager):
            let personalInformation = PersonalInformation(firstName: "Rajesh", lastName: "Kootrapali", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
            populateForm(personalInformation: personalInformation, birthDate: nil, company: nil)
        case (.vendor, .vendor):
            let personalInformation = PersonalInformation(firstName: "Howard", lastName: "Wolowitz", streetAddress: "", city: "", state: "", zipCode: "")
            populateForm(personalInformation: personalInformation, birthDate: "1970-09-25", company: "Apple")

        default:

            fatalError()
        }
    }
    
    func populateForm(personalInformation: PersonalInformation, birthDate: String?, company: String?) {
        if let birthDate = birthDate {
            dateOfBirthTextField.text = birthDate
        }
        if let company = company {
            companyTextField.text = company
        }
        firstNameTextField.text = personalInformation.firstName
        lastNameTextField.text = personalInformation.lastName
        streetAddressTextField.text = personalInformation.streetAddress
        cityTextField.text = personalInformation.city
        stateTextField.text = personalInformation.state
        zipCodeTextField.text = personalInformation.zipCode
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GeneratePassSegue" {
            switch (entrantCategory, entrantType) {
            case (.guest, .freeChild):
                do {
                    let child = try ChildGuest(birthDate: dateOfBirthTextField.text!)
                } catch EntrantError.missingDateOfBirth {
                    print("Date of birth is missing")
                } catch EntrantError.tooOld {
                    print("Child is too old")
                } catch let error {
                    print("Unexpected error \(error)")
                }
           case (.guest, .seasonPass):
            if let personalInformation = createPersonalInformation() {
                do {
                    let guest = try SeasonPassGuest(personalInformation: personalInformation)
                } catch EntrantError.addressImcomplete {
                    print("Address incomplete")
                } catch let error {
                    print("Unexpected error \(error)")
                }
            }

            case (.guest, .senior):
                if let personalInformation = createPersonalInformation(), let dateOfBirth = dateOfBirthTextField.text {
                    do {
                        let guest = try SeniorGuest(birthDate: dateOfBirth, personalInformation: personalInformation)
                    } catch EntrantError.addressImcomplete {
                        print("Address incomplete")
                    } catch EntrantError.missingDateOfBirth {
                        print("Date of birth is missing")
                    } catch let error {
                        print("Unexpected error \(error)")
                    }
                }
           case (.employee, .food), (.employee, .maintenance), (.employee, .ride), (.employee, .contract):
            if let personalInformation = createPersonalInformation() {
                do {
                    let guest = try Employee(entrantType: entrantType, personalInformation: personalInformation)
                } catch EntrantError.addressImcomplete {
                    print("Address incomplete")
                } catch let error {
                    print("Unexpected error \(error)")
                }
            }

           case (.manager, .manager):
            if let personalInformation = createPersonalInformation() {
                do {
                    let guest = try Manager(personalInformation: personalInformation)
                } catch EntrantError.addressImcomplete {
                    print("Address incomplete")
                } catch let error {
                    print("Unexpected error \(error)")
                }
            }

           case (.vendor, .vendor):
            if let personalInformation = createPersonalInformation(), let birthDate = dateOfBirthTextField.text, let company = companyTextField.text {
                do {
                    let guest = try Vendor(birthDate: birthDate, personalInformation: personalInformation, company: company)
                } catch EntrantError.addressImcomplete {
                    print("Address incomplete")
                } catch EntrantError.missingCompany {
                    print("Company is missing")
                } catch let error {
                    print("Unexpected error \(error)")
                }
            }

            default:
                
                fatalError()
            }
        }
    }
    
    
    func createPersonalInformation() -> PersonalInformation? {
        if let dateOfBirth = dateOfBirthTextField.text, let ssn = ssnTextField.text, let projectNumber = projectNumberTextField.text,
            let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let company = companyTextField.text, let street = streetAddressTextField.text,
            let city = cityTextField.text, let state = stateTextField.text, let zip = zipCodeTextField.text {
                return PersonalInformation(firstName: firstName, lastName: lastName, streetAddress: street, city: city, state: state, zipCode: zip)
        }
        return nil
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let info = notification.userInfo, let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let frame = keyboardFrame.cgRectValue
            bottomConstraint.constant = frame.size.height + 10
            topConstraint.constant = -frame.size.height - 10
            
            UIView.animate(withDuration: 0.8) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    @objc func keyboardWillHide(_ notification: Notification) {
        bottomConstraint.constant = 40
        topConstraint.constant = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
