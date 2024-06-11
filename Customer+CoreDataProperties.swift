//
//  Customer+CoreDataProperties.swift
//  A4_Aditya_Rahman
//
//  Created by user257614 on 4/7/24.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?
    @NSManaged public var status: String?
    @NSManaged public var username: String?
    @NSManaged public var website: String?
    @NSManaged public var bs: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var companyName: String?
    @NSManaged public var city: String?
    @NSManaged public var street: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var suite: String?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double

}

extension Customer : Identifiable {

}
