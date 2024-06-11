//
//  Admin+CoreDataProperties.swift
//  A4_Aditya_Rahman
//
//  Created by user257614 on 4/7/24.
//
//

import Foundation
import CoreData


extension Admin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Admin> {
        return NSFetchRequest<Admin>(entityName: "Admin")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?
    @NSManaged public var username: String?

}

extension Admin : Identifiable {

}
