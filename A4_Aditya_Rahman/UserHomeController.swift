//
//  UserHomeController.swift
//  A4_Aditya_Rahman
//

import UIKit

class UserHomeController: UIViewController {
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var suiteLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var zipcodeLbl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var catchphraseLbl: UILabel!
    @IBOutlet weak var bsLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    
    var currCustomer: Customer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        usernameLbl.text = currCustomer.username
        nameLbl.text = "Name: " + (currCustomer.name ?? "")
        statusLbl.text = "Status: " + (currCustomer.status ?? "")
        
        if currCustomer.status == "AWAITED" {
            statusLbl.textColor = UIColor.yellow
            
        }
        else if currCustomer.status == "FAILEDTOREACH" {
            statusLbl.textColor = UIColor(red: 0.7, green: 0.2, blue: 0.3, alpha: 1.0)
            
        }
        else if currCustomer.status == "ONBOARDED" {
            statusLbl.textColor = UIColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 1.0)
            
        }
        else if currCustomer.status == "INPROCESS" {
            statusLbl.textColor = UIColor(red: 0.1, green: 0.8, blue: 0.50, alpha: 1.0)
            
        }
        else if currCustomer.status == "COMPLETED" {
            statusLbl.textColor = UIColor(red: 0.1, green: 0.7, blue: 0.60, alpha: 1.0)
            
        }
        else {
            statusLbl.textColor = UIColor(red: 0.9, green: 0.1, blue: 0.1, alpha: 1.0)
            
        }
        
        emailLbl.text = "Email: " + (currCustomer.email ?? "")
        phoneLbl.text = "Phone: " + (currCustomer.phone ?? "")
        passwordLbl.text = "Password: " + (currCustomer.password ?? "")
        streetLbl.text = (currCustomer.street ?? "")
        suiteLbl.text = (currCustomer.suite ?? "")
        cityLbl.text = (currCustomer.city ?? "")
        zipcodeLbl.text = (currCustomer.zipcode ?? "")
        companyLbl.text = "Company name: " + (currCustomer.companyName ?? "")
        catchphraseLbl.text = "Catchphrase: " + (currCustomer.catchPhrase ?? "")
        bsLbl.text = "BS: " + (currCustomer.bs ?? "")
        websiteLbl.text = "Website: " + (currCustomer.website ?? "")
        
    }
    
    @IBAction func logoutClick(_ sender: UIButton) {
        self.navigationItem.setHidesBackButton(false, animated: true)
        self.navigationController?.popToRootViewController(animated: false)
        
    }
    
    @IBAction func updateBasic(_ sender: UIButton) {
        guard let updateScreen = storyboard?.instantiateViewController(withIdentifier: "updateCust") as? UpdateController else {
            print("Could not find screen")
            return
            
        }
        
        updateScreen.mode = 1
        updateScreen.customer = currCustomer
        self.navigationController?.pushViewController(updateScreen, animated: true)
        
    }
    
    @IBAction func updateAddress(_ sender: UIButton) {
        guard let updateScreen = storyboard?.instantiateViewController(withIdentifier: "updateCust") as? UpdateController else {
            print("Could not find screen")
            return
            
        }
        
        updateScreen.mode = 2
        updateScreen.customer = currCustomer
        self.navigationController?.pushViewController(updateScreen, animated: true)
        
    }
    
    @IBAction func updateCompany(_ sender: UIButton) {
        guard let updateScreen = storyboard?.instantiateViewController(withIdentifier: "updateCust") as? UpdateController else {
            print("Could not find screen")
            return
            
        }
        
        updateScreen.mode = 3
        updateScreen.customer = currCustomer
        self.navigationController?.pushViewController(updateScreen, animated: true)
        
    }
}

