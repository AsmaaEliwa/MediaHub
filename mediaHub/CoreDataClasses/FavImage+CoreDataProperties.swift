//
//  FavImage+CoreDataProperties.swift
//  mediaHub
//
//  Created by asmaa gamal  on 30/11/2023.
//
//

import Foundation
import CoreData


extension FavImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavImage> {
        return NSFetchRequest<FavImage>(entityName: "FavImage")
    }

    @NSManaged public var url: String?

}

extension FavImage : Identifiable {

}
