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
    
    // Color in gray all the buttons except the one is tapped
    func grayButtons(_ buttonsArray: [UIButton], except buttonTapped: UIButton) {
        for button in buttonsArray {
            if buttonTapped != button {
                button.setTitleColor(.gray, for: .normal)
            } else {
                button.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    // Mangement of the type bar according to the choosen category
    @objc func entrantTypeButtonTapped(sender: UIButton) {
        grayButtons(entrantCategoryButtons, except: sender)
        
        switch sender {
        case entrantCategoryButtons[0]:
          //  displayGuestBar()
            entrantCategory = .guest
        case entrantCategoryButtons[1]:
          //  displayEmployeeBar()
            entrantCategory = .employee
        case entrantCategoryButtons[2]:
         //   displayManagerBar()
            entrantCategory = .manager
        case entrantCategoryButtons[3]:
         //   displayVendorBar()
            entrantCategory = .vendor
        default:
            fatalError("Unexpected error")
        }
        displayTypeBar(for: entrantCategory)
        categoryButtonTapped(sender: entrantTypeButtons[0])  // Child is the default choice
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
                managePopulateButton(isEnabled: false) // no info so no need to populate
            case entrantTypeButtons[2]:
                entrantType = .senior
            case entrantTypeButtons[3]:
                entrantType = .seasonPass
            case entrantTypeButtons[4]:
                entrantType = .vip
                managePopulateButton(isEnabled: false) // no info so no need to populate
            default:
                fatalError("Unexpected error")
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
                fatalError("Unexpected error")
            }
        case .manager:
            entrantType = .manager
        case .vendor:
            entrantType = .vendor
        default:
            fatalError("Unexpected error")
        }
        manageTextField()
    }
    
    // Enable or disable the Populate Button
    func managePopulateButton(isEnabled: Bool) {
        if isEnabled == true {
            populateDataButton.isEnabled = true
            populateDataButton.setTitleColor(.black, for: .normal)
        } else {
            populateDataButton.isEnabled = false
            populateDataButton.setTitleColor(.lightGray, for: .normal)
        }
    }
    
    // Enable Category Buttons
    func enableCategoryButtons() {
        for button in entrantTypeButtons {
            button.isEnabled = true
            button.isHidden = false
        }
    }
    
    // Disable Populate Button
    func disableCategoryButtons() {
        for button in entrantTypeButtons {
            button.isEnabled = false
            button.isHidden = true
        }
    }
    

    func displayTypeBar(for entrantCategory: EntrantCategory) {
        enableCategoryButtons()
        switch entrantCategory {
        case .guest:
            displayGuestBar()
        case .employee:
            displayEmployeeBar()
        case .manager:
            disableCategoryButtons() // No need to display a type bar
        case .vendor:
            disableCategoryButtons() // No need to display a type bar

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

    
    //  Basic textFields management
    func disableAllTextFields() {
        for textField in textFieldsArray {
            textField.isEnabled = false
            textField.backgroundColor = .lightGray
            textField.text = ""
        }
    }
    
    func enableAllTextFields() {
        for textField in textFieldsArray {
            textField.isEnabled = true
            textField.backgroundColor = .white
            textField.text = ""
        }
    }
    
    func disableTextField(atIndex index: Int) {
        textFieldsArray[index].isEnabled = false
        textFieldsArray[index].backgroundColor = .lightGray
        textFieldsArray[index].text = ""

    }
    
    
    func enableTextField(atIndex index: Int) {
        textFieldsArray[index].isEnabled = true
        textFieldsArray[index].backgroundColor = .white
        textFieldsArray[index].text = ""
    }
    
    // Enable or disable the correct textfields according to the (type, category) choosen entrant
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
            if entrantType != .contract {
                disableTextField(atIndex: 2)
            }
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
    
    // When Populate Button is tapped: initialize the data and display them into the form
    @IBAction func populateDataTapped(_ sender: UIButton) {
        switch (entrantCategory, entrantType) {
        case (.guest, .freeChild):
            dateOfBirthTextField.text = "04/03/2016"
        case (.guest, .seasonPass):
            let personalInformation = PersonalInformation(firstName: "Season", lastName: "Pass", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
            populateForm(personalInformation: personalInformation)
        case (.guest, .senior):
            let personalInformation = PersonalInformation(firstName: "Senior", lastName: "Senior", streetAddress: "", city: "", state: "", zipCode: "")
            populateForm(personalInformation: personalInformation, birthDate: "01/01/1960")
        case (.employee, .food):
            let personalInformation = PersonalInformation(firstName: "Sheldon", lastName: "Cooper", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
            populateForm(personalInformation: personalInformation)
        case (.employee, .maintenance):
            let personalInformation = PersonalInformation(firstName: "Amy", lastName: "Fowler", streetAddress: "2 Infinite Loop", city: "Pasadena", state: "New York", zipCode: "91001")
            populateForm(personalInformation: personalInformation)
        case (.employee, .ride):
            let personalInformation = PersonalInformation(firstName: "Penny", lastName: "Hofstader", streetAddress: "3 Infinite Loop", city: "Ohmaha", state: "Nebraska", zipCode: "68197")
            populateForm(personalInformation: personalInformation)
        case (.employee, .contract):
            let personalInformation = PersonalInformation(firstName: "Leonard", lastName: "Hofstader", streetAddress: "4 Infinite Loop", city: "Pasadena", state: "California", zipCode: "90000")
            populateForm(personalInformation: personalInformation, projectNumber: "1001")
        case (.manager, .manager):
            let personalInformation = PersonalInformation(firstName: "Rajesh", lastName: "Kootrapali", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
            populateForm(personalInformation: personalInformation)
        case (.vendor, .vendor):
            let personalInformation = PersonalInformation(firstName: "Howard", lastName: "Wolowitz", streetAddress: "", city: "", state: "", zipCode: "")
            populateForm(personalInformation: personalInformation, birthDate: "09/25/1970", company: "Acme")
        default:
            fatalError("Unexpected error")
        }
    }
    
    
    // Display the test data into the form
    func populateForm(personalInformation: PersonalInformation, birthDate: String? = nil, company: String? = nil, projectNumber: String? = nil) {
        if let birthDate = birthDate {
            dateOfBirthTextField.text = birthDate
        }
        if let company = company {
            companyTextField.text = company
        }
        
        if let projectNumber = projectNumber {
            projectNumberTextField.text = projectNumber
        }
        firstNameTextField.text = personalInformation.firstName
        lastNameTextField.text = personalInformation.lastName
        streetAddressTextField.text = personalInformation.streetAddress
        cityTextField.text = personalInformation.city
        stateTextField.text = personalInformation.state
        zipCodeTextField.text = personalInformation.zipCode
    }
    
    
    // Set of functions which create the different Entrant
    func createClassicAndVIPGest() -> Entrant? {
        return Guest(entrantType: entrantType)
    }
    
    func createFreeChildGuest() -> Entrant? {
        
        var childGuest: Entrant?
        
        do {
            childGuest = try ChildGuest(birthDate: dateOfBirthTextField.text!)
        } catch EntrantError.missingDateOfBirth {
            alert(withTitle: "Date of birth is missing", andMessage: "Please type a date of birth")
        } catch EntrantError.tooOld {
            alert(withTitle: "Child is too old", andMessage: "You can not benefit fro Free Child advantages")
        } catch EntrantError.incorrectDate {
            alert(withTitle: "Incorrect Format for Date of Birth", andMessage: "Please type a date of birth")
        } catch let error {
            print("Unexpected error \(error)")
        }
        
        return childGuest
    }
    
    func createSeansonPassGuest() -> Entrant?  {
        
        var seasonPassGuest: Entrant?
        
        if let personalInformation = createPersonalInformation() {
            do {
                seasonPassGuest = try SeasonPassGuest(personalInformation: personalInformation)
            } catch EntrantError.addressImcomplete {
                alert(withTitle: "Incomplete Personal Information", andMessage: "Please fill the correct data")
            } catch let error {
                print("Unexpected error \(error)")
            }
        }
        return seasonPassGuest
    }
    
    
    func createSeniorGuest() -> Entrant? {
        var seniorGuest: Entrant?
        
        if let personalInformation = createPersonalInformation(), let dateOfBirth = dateOfBirthTextField.text {
            do {
                seniorGuest = try SeniorGuest(birthDate: dateOfBirth, personalInformation: personalInformation)
            } catch EntrantError.addressImcomplete {
                alert(withTitle: "Incomplete Personal Information", andMessage: "Please fill the correct data")
            } catch EntrantError.missingDateOfBirth {
                alert(withTitle: "Date of birth is missing", andMessage: "Please type a date of birth")
            } catch let error {
                print("Unexpected error \(error)")
            }
        }
        return seniorGuest
    }
    
    func createEmployee() -> Entrant? {
        var employee: Entrant?
        
        if let personalInformation = createPersonalInformation() {
            do {
                employee = try Employee(entrantType: entrantType, personalInformation: personalInformation)
            } catch EntrantError.addressImcomplete {
                alert(withTitle: "Incomplete Personal Information", andMessage: "Please fill the correct data")
            } catch let error {
                print("Unexpected error \(error)")
            }
        }
        return employee
    }
    
    
    func createContractEmployee() -> Entrant? {
        var contractEmployee: Entrant?
        
        if let personalInformation = createPersonalInformation() {
            do {
                if let projectNumber = projectNumberTextField.text {
                    let project = try Project(projectNumber: projectNumber)
                    contractEmployee = try ContractEmployee(project: project, personalInformation: personalInformation)
                }
            } catch EntrantError.addressImcomplete {
                alert(withTitle: "Incomplete Personal Information", andMessage: "Please fill the correct data")
            } catch EntrantError.incorrectProjectNumber {
                alert(withTitle: "Incorrect format for #Project", andMessage: "#Project must contains 6 digits")
            } catch let error {
                print("Unexpected error \(error)")
            }
        }
        
        return contractEmployee
    }
    
    func createManager() -> Entrant? {
        var manager: Entrant?
        if let personalInformation = createPersonalInformation() {
            do {
                manager = try Manager(personalInformation: personalInformation)
            } catch EntrantError.addressImcomplete {
                alert(withTitle: "Incomplete Personal Information", andMessage: "Please fill the correct data")
            } catch let error {
                print("Unexpected error \(error)")
            }
        }
        
        return manager
    }
    
    func createVendor() -> Entrant? {
        var vendor: Entrant?
        if let personalInformation = createPersonalInformation(), let birthDate = dateOfBirthTextField.text {
            do {
                if let companyName = companyTextField.text {
                    let company = Company(companyName: companyName)
                    vendor = try Vendor(birthDate: birthDate, personalInformation: personalInformation, company: company)
                }
            } catch EntrantError.addressImcomplete {
                alert(withTitle: "Incomplete Personal Information", andMessage: "Please fill the correct data")
            } catch EntrantError.missingCompany {
                alert(withTitle: "Company is missing", andMessage: "Please enter your company name")
            } catch EntrantError.missingDateOfBirth {
                alert(withTitle: "Date of birth is missing", andMessage: "Please type a date of birth")
            } catch EntrantError.incorrectDate {
                alert(withTitle: "Incorrect Format for Date of Birth", andMessage: "Please type a date of birth")
            } catch let error {
                print("Unexpected error \(error)")
            }
        }
        
        return vendor
    }
    
    // Create the Entrant if everything is correct then passe it to the next controller 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var entrant: Entrant?
        
        if segue.identifier == "GeneratePassSegue" {
            switch (entrantCategory, entrantType) {
                
            case (.guest, .classic), (.guest, .vip):
                entrant = createClassicAndVIPGest()
            case (.guest, .freeChild):
                entrant = createFreeChildGuest()
            case (.guest, .seasonPass):
                entrant = createSeansonPassGuest()
            case (.guest, .senior):
                entrant = createSeniorGuest()
            case (.employee, .food), (.employee, .maintenance), (.employee, .ride):
                entrant = createEmployee()
            case (.employee, .contract):
                entrant = createContractEmployee()
            case (.manager, .manager):
                entrant = createManager()
            case (.vendor, .vendor):
                entrant = createVendor()
            default:
                fatalError("Unexpected error")
            }
            
            // If entrant created i.e. all information are correct
            if let entrant = entrant, let destinationViewController = segue.destination as? NewPassViewController {
                destinationViewController.entrant = entrant
            }
        }
    }
    
    
    // Create Personal Information from input text fields
    func createPersonalInformation() -> PersonalInformation? {
        if let dateOfBirth = dateOfBirthTextField.text, let ssn = ssnTextField.text, let projectNumber = projectNumberTextField.text,
            let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let company = companyTextField.text, let street = streetAddressTextField.text,
            let city = cityTextField.text, let state = stateTextField.text, let zip = zipCodeTextField.text {
                return PersonalInformation(firstName: firstName, lastName: lastName, streetAddress: street, city: city, state: state, zipCode: zip)
        }
        return nil
    }
    
    // Display an alertView with a given title and a givent message
    func alert(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Keyboard Management
    
    @objc func keyboardWillShow(_ notification: Notification) {
        

        if let info = notification.userInfo, let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let frame = keyboardFrame.cgRectValue

            if UIApplication.shared.statusBarOrientation.isLandscape {
                bottomConstraint.constant = frame.size.height - 20
                topConstraint.constant = -frame.size.height + 210
                
            } else {
                bottomConstraint.constant = frame.size.height + 10
                topConstraint.constant = -frame.size.height + 140
            }
            
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
