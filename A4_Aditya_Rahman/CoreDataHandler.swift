//
//  CoreDataHandler.swift
//  A4_Aditya_Rahman
//

import Foundation
import UIKit
import CoreData
import CoreLocation

class CoreDataHandler {
    static let shared = CoreDataHandler()
  
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext?
    let geocoder = CLGeocoder()
    
    var storedLat: Double = 0
    var storedLng: Double = 0
    
    private init() {
      context = appDelegate.persistentContainer.viewContext

    }
  
    func saveContext() {
      appDelegate.saveContext()
    }
  
    func insertCustomer(id:Int, name:String, username:String, email:String, password:String, phone:String, website:String, street:String, suite:String, city:String, zipcode:String, lat:Double, lng:Double, companyname:String, catchphrase:String, bs:String, status:String, completion: @escaping () -> Void) {
        let cust = Customer(context: context!)
        cust.id = Int64(id)
        cust.name = name
        cust.username = username
        cust.email = email
        cust.password = password
        cust.phone = phone
        cust.website = website
        cust.street = street
        cust.suite = suite
        cust.city = city
        cust.zipcode = zipcode
        cust.lat = lat
        cust.lng = lng
        cust.companyName = companyname
        cust.catchPhrase = catchphrase
        cust.bs = bs
        cust.status = status
        
        saveContext()
        completion()
    }
    
    func insertAdmin(id:Int, name:String, username:String, email:String, password:String, phone:String, completion: @escaping () -> Void) {
        let admin = Admin(context: context!)
        admin.id = Int64(id)
        admin.name = name
        admin.username = username
        admin.email = email
        admin.phone = phone
        admin.password = password
        
        saveContext()
        completion()
        
    }
    
    func updateCustomerBasic(cust:Customer, username:String, name:String, password:String, phone:String, completion: @escaping () -> Void) {
        cust.username = username
        cust.name = name
        cust.password = password
        cust.phone = phone
        
        saveContext()
        completion()
        
    }
    
    func updateCustomerAddress(cust:Customer, street:String, suite:String, city:String, zipcode:String, completion: @escaping () -> Void) {
        cust.street = street
        cust.suite = suite
        cust.city = city
        cust.zipcode = zipcode
        
        getLocation(address: "\(street), \(city)")
        
        cust.lat = storedLat
        cust.lng = storedLng
        
        saveContext()
        completion()
        
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
    
    func updateCustomerCompany(cust:Customer, companyname:String, catchphrase:String, bs:String, website:String, completion: @escaping () -> Void) {
        cust.companyName = companyname
        cust.catchPhrase = catchphrase
        cust.bs = bs
        cust.website = website
        
        saveContext()
        completion()
        
    }
  
    func updateStatus(cust:Customer, status:String, completion: @escaping () -> Void) {
      cust.status = status
    
      saveContext()
      completion()
    }
  
    func getAllCustomers() -> Array<Customer> {
      let fetchRequest: NSFetchRequest<Customer> = Customer.fetchRequest()
      do {
        let cust = try context?.fetch(fetchRequest)
        return cust!
        } catch {
        print(error.localizedDescription)
        // Returning an empty Array - Error Handling
        let cust = Array<Customer>()
        return cust
        }
    }
    
    func getAllAdmins() -> Array<Admin> {
      let fetchRequest: NSFetchRequest<Admin> = Admin.fetchRequest()
      do {
        let admin = try context?.fetch(fetchRequest)
        return admin!
        } catch {
        print(error.localizedDescription)
        // Returning an empty Array - Error Handling
        let admin = Array<Admin>()
        return admin
        }
    }
  
    func deleteCustomer(for cust:Customer, completion: @escaping () -> Void) {
        
      context!.delete(cust)
      saveContext()
      completion()
    }
}
