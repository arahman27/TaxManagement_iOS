//
//  UpdateController.swift
//  A4_Aditya_Rahman
//

import UIKit

class UpdateController: UIViewController {
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var secondTF: UITextField!
    @IBOutlet weak var thirdTF: UITextField!
    @IBOutlet weak var fourthTF: UITextField!
    @IBOutlet weak var titleTF: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var thirdLbl: UILabel!
    @IBOutlet weak var fourthLbl: UILabel!
    @IBOutlet weak var firstLbl: UILabel!
    
    var mode: Int!
    var customer: Customer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        if mode == 1 {
            titleTF.text = "Update Customer Information"
            firstLbl.text = "Username"
            firstTF.text = customer.username
            secondLbl.text = "Name"
            secondTF.text = customer.name
            thirdLbl.text = "Password"
            thirdTF.text = customer.password
            fourthLbl.text = "Phone"
            fourthTF.text = customer.phone
            
        }
        else if mode == 2 {
            titleTF.text = "Update Customer Address"
            firstLbl.text = "Street"
            firstTF.text = customer.street
            secondLbl.text = "Suite"
            secondTF.text = customer.suite
            thirdLbl.text = "City"
            thirdTF.text = customer.city
            fourthLbl.text = "Zipcode"
            fourthTF.text = customer.zipcode
            
        }
        else if mode == 3 {
            titleTF.text = "Update Company Information"
            firstLbl.text = "Company name"
            firstTF.text = customer.companyName
            secondLbl.text = "Catchphrase"
            secondTF.text = customer.catchPhrase
            thirdLbl.text = "BS"
            thirdTF.text = customer.bs
            fourthLbl.text = "Website"
            fourthTF.text = customer.website
            
        }
    }
    
    @IBAction func updateClick(_ sender: UIButton) {
        if mode == 1 {
            CoreDataHandler.shared.updateCustomerBasic(cust: customer, username: firstTF.text ?? "", name: secondTF.text ?? "", password: thirdTF.text ?? "", phone: fourthTF.text ?? "") {}
            
            guard let userHomeScreen = storyboard?.instantiateViewController(withIdentifier: "userHome") as? UserHomeController else {
                print("Could not find screen")
                return
                
            }
            
            userHomeScreen.currCustomer = customer
            self.navigationController?.popViewController(animated: true)
            
        }
        else if mode == 2 {
            CoreDataHandler.shared.updateCustomerAddress(cust: customer, street: firstTF.text ?? "", suite: secondTF.text ?? "", city: thirdTF.text ?? "", zipcode: fourthTF.text ?? "") {}
            
            guard let userHomeScreen = storyboard?.instantiateViewController(withIdentifier: "userHome") as? UserHomeController else {
                print("Could not find screen")
                return
                
            }
            
            userHomeScreen.currCustomer = customer
            self.navigationController?.popViewController(animated: true)
            
        }
        else if mode == 3 {
            CoreDataHandler.shared.updateCustomerCompany(cust: customer, companyname: firstTF.text ?? "", catchphrase: secondTF.text ?? "", bs: thirdTF.text ?? "", website: fourthTF.text ?? "") {}
            
            guard let userHomeScreen = storyboard?.instantiateViewController(withIdentifier: "userHome") as? UserHomeController else {
                print("Could not find screen")
                return
                
            }
            
            userHomeScreen.currCustomer = customer
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    @IBAction func cancelClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
}
