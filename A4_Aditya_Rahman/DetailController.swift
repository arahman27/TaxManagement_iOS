//
//  DetailController.swift
//  A4_Aditya_Rahman
//

import UIKit
import MapKit

class DetailController: UIViewController {
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var suiteLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var zipcodeLbl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var catchphraseLbl: UILabel!
    @IBOutlet weak var bsLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var newStatusTF: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var customer: Customer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLbl.text = "Username: " + (customer.username ?? "")
        nameLbl.text = "Name: " + (customer.name ?? "")
        emailLbl.text = "Email: " + (customer.email ?? "")
        phoneLbl.text = "Phone: " + (customer.phone ?? "")
        passwordLbl.text = "Password: " + (customer.password ?? "")
        streetLbl.text = "Street: " + (customer.street ?? "")
        suiteLbl.text = "Suite: " + (customer.suite ?? "")
        cityLbl.text = "City: " + (customer.city ?? "")
        zipcodeLbl.text = "Zipcode: " + (customer.zipcode ?? "")
        companyLbl.text = "Company: " + (customer.companyName ?? "")
        catchphraseLbl.text = "Catchphrase: " + (customer.catchPhrase ?? "")
        bsLbl.text = "BS: " + (customer.bs ?? "")
        websiteLbl.text = "Website: " + (customer.website ?? "")
        statusLbl.text = "Current status: " + (customer.status ?? "")
        
        let zoomLevel = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let centerOfMap = CLLocationCoordinate2D(latitude: customer.lat, longitude: customer.lng)
        
        let visibleRegion = MKCoordinateRegion(center: centerOfMap, span: zoomLevel)
        
        mapView.setRegion(visibleRegion, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = centerOfMap
        pin.title = "Customer location"
        mapView.addAnnotation(pin)
        
    }
    
    @IBAction func updateClick(_ sender: UIButton) {
        if newStatusTF.text?.isEmpty == false {
            if newStatusTF.text?.uppercased() == "AWAITED" || newStatusTF.text?.uppercased() == "FAILEDTOREACH" || newStatusTF.text?.uppercased() == "ONBOARDED" || newStatusTF.text?.uppercased() == "INPROCESS" || newStatusTF.text?.uppercased() == "COMPLETED" || newStatusTF.text?.uppercased() == "DENIED"{
                CoreDataHandler.shared.updateStatus(cust: customer, status: newStatusTF.text?.uppercased() ?? "") {}
                statusLbl.text = "Current status: " + (customer.status ?? "")
                
                let alertController = UIAlertController(title: "Success", message: "The status has been updated.", preferredStyle: .alert)
                let dismissAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(dismissAlert)
                self.present(alertController, animated: true, completion: nil)
                
            }
            else {
                let alertController = UIAlertController(title: "Error", message: "Please enter a valid status [AWAITED, FAILEDTOREACH, ONBOARED, INPROCESS, COMPLETED, DENIED]", preferredStyle: .alert)
                let dismissAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(dismissAlert)
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Enter status to update.", preferredStyle: .alert)
            let dismissAlert = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(dismissAlert)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
}
