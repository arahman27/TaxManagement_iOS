//
//  RegisterController.swift
//  A4_Aditya_Rahman
//

import UIKit
import CoreLocation

class RegisterController: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var suiteTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var zipcodeTF: UITextField!
    @IBOutlet weak var companyTF: UITextField!
    @IBOutlet weak var catchphraseTF: UITextField!
    @IBOutlet weak var bsTF: UITextField!
    @IBOutlet weak var websiteTF: UITextField!
    
    private var customerArr = Array<Customer>()
    
    let geocoder = CLGeocoder()
    
    var storedLat: Double = 0
    var storedLng: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        customerArr = CoreDataHandler.shared.getAllCustomers()
        
    }

    @IBAction func registerClick(_ sender: UIButton) {
        if nameTF.text?.isEmpty == true || usernameTF.text?.isEmpty == true || emailTF.text?.isEmpty == true || phoneTF.text?.isEmpty == true || passwordTF.text?.isEmpty == true || confirmPasswordTF.text?.isEmpty == true || streetTF.text?.isEmpty == true || suiteTF.text?.isEmpty == true || cityTF.text?.isEmpty == true || zipcodeTF.text?.isEmpty == true || companyTF.text?.isEmpty == true || catchphraseTF.text?.isEmpty == true || bsTF.text?.isEmpty == true || websiteTF.text?.isEmpty == true {
            let alertController = UIAlertController(title: "Error", message: "Please enter enter all information.", preferredStyle: .alert)
            let dismissAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(dismissAlert)
            self.present(alertController, animated: true, completion: nil)
            
        }
        else{
            if passwordTF.text != confirmPasswordTF.text {
                let alertController = UIAlertController(title: "Error", message: "The passwords do not match.", preferredStyle: .alert)
                let dismissAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(dismissAlert)
                self.present(alertController, animated: true, completion: nil)
                
            }
            else if let checkUserName =  customerArr.first(where: {$0.username == usernameTF.text}) {
                let alertController = UIAlertController(title: "Error", message: "The username: \(checkUserName.username ?? "") already exists.", preferredStyle: .alert)
                let dismissAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(dismissAlert)
                self.present(alertController, animated: true, completion: nil)
                
            }
            else{
                let id = customerArr.count + 1
                
                getLocation(address: "\(streetTF.text ?? ""), \(cityTF.text ?? "")")
                
                CoreDataHandler.shared.insertCustomer(id: id, name: nameTF.text ?? "", username: usernameTF.text ?? "", email: emailTF.text ?? "", password: passwordTF.text ?? "", phone: phoneTF.text ?? "", website: websiteTF.text ?? "", street: streetTF.text ?? "", suite: suiteTF.text ?? "", city: cityTF.text ?? "", zipcode: zipcodeTF.text ?? "", lat: storedLat, lng: storedLng, companyname: companyTF.text ?? "", catchphrase: catchphraseTF.text ?? "", bs: bsTF.text ?? "", status: "AWAITED") {}
                
                guard let userHomeScreen = storyboard?.instantiateViewController(withIdentifier: "userHome") as? UserHomeController else {
                    print("Could not find screen")
                    return
                    
                }
                
                customerArr = CoreDataHandler.shared.getAllCustomers()
                userHomeScreen.currCustomer = customerArr.last
                
                self.navigationController?.pushViewController(userHomeScreen, animated: true)
                
            }
        }
    }
    
    func getLocation(address: String) {
        geocoder.geocodeAddressString(address) { results, error in
        
            if error != nil {
                print("Error occured")
                print(error ?? "error")
                return
            }
            
            if results != nil {
                if results?.count == 0 {
                    print("No coordinates found")
                    
                }
                else {
                    let placemark: CLPlacemark = (results?.first)!
                    
                    if let lat = placemark.location?.coordinate.latitude, let lng = placemark.location?.coordinate.longitude {
                        self.storedLat = lat
                        self.storedLng = lng
                    }
                }
            }
        }
    }
}
