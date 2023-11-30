//
//  FavVideo+CoreDataProperties.swift
//  mediaHub
//
//  Created by asmaa gamal  on 30/11/2023.
//
//

import Foundation
import CoreData


extension FavVideo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavVideo> {
        return NSFetchRequest<FavVideo>(entityName: "FavVideo")
    }

    @NSManaged public var url: String?

}

extension FavVideo : Identifiable {

}
