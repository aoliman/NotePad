//
//  NoteCoreData+CoreDataProperties.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//
//

import Foundation
import CoreData


extension NoteCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteCoreData> {
        return NSFetchRequest<NoteCoreData>(entityName: "NoteCoreData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var note: String?

}

extension NoteCoreData : Identifiable {

}
