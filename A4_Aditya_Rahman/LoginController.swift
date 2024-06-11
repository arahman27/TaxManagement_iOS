//
//  LoginController.swift
//  A4_Aditya_Rahman
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errLbl: UILabel!
    
    private var customerArr = Array<Customer>()
    private var adminArr = Array<Admin>()
    var currCustomer: Customer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.isSecureTextEntry = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customerArr = CoreDataHandler.shared.getAllCustomers()
        adminArr = CoreDataHandler.shared.getAllAdmins()
        
    }
    
    @IBAction func hideToggle(_ sender: UISwitch) {
        if sender.isOn {
            passwordTF.isSecureTextEntry = true
            
        }
        else {
            passwordTF.isSecureTextEntry = false
            
        }
    }
    
    @IBAction func loginClick(_ sender: UIButton) {
        errLbl.text = ""
        var found = 0
        
        if usernameTF.text?.isEmpty == true || passwordTF.text?.isEmpty == true{
            errLbl.text = "Error! Please enter both username and password."
        }
        else {
            for cust in customerArr {
                if cust.username == usernameTF.text && cust.password == passwordTF.text {
                    found = 1
                    currCustomer = cust
                    
                }
            }
            
            if found == 0 {
                for admin in adminArr {
                    if admin.username == usernameTF.text && admin.password == passwordTF.text {
                        found = 2
                        
                    }
                }
            }
            
            if found == 1 {
                guard let userHomeScreen = storyboard?.instantiateViewController(withIdentifier: "userHome") as? UserHomeController else {
                    print("Could not find screen")
                    return
                    
                }
                
                userHomeScreen.currCustomer = currCustomer
                self.navigationController?.pushViewController(userHomeScreen, animated: true)
                
            }
            else if found == 2 {
                guard let adminHomeScreen = storyboard?.instantiateViewController(withIdentifier: "adminHome") as? AdminHomeController else {
                    print("Could not find screen")
                    return
                    
                }
                
                self.navigationController?.pushViewController(adminHomeScreen, animated: true)
                
            }
            else{
                errLbl.text = "Error! Incorrect username or password."
                
            }
        }
    }
}
