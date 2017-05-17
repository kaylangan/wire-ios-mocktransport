//
// Wire
// Copyright (C) 2017 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation
import CoreData

@objc public final class MockTeam: NSManagedObject, EntityNamedProtocol {
    @NSManaged public var conversations: Set<MockConversation>?
    @NSManaged public var members: Set<MockMember>?
    @NSManaged public var creator: MockUser?
    @NSManaged public var name: String?
    @NSManaged public var assetKey: String?
    @NSManaged public var identifier: String
    
    public static var entityName = "Team"
}

extension MockTeam {
    public static func predicateWithIdentifier(identifier: String) -> NSPredicate {
        return NSPredicate(format: "%K == %@", #keyPath(MockTeam.identifier), identifier)
    }
    
    @objc
    public static func insert(in context: NSManagedObjectContext, name: String?, assetKey: String?) -> MockTeam {
        let team: MockTeam = insert(in: context)
        team.identifier = NSUUID.create().transportString()
        team.name = name
        team.assetKey = assetKey
        return team
    }
    
    var payload: ZMTransportData {
        let data: [String : String?] = [
            "id": identifier,
            "name" : name,
            "icon_key" : assetKey,
            "creator" : creator?.identifier
            ]
        return data as NSDictionary
    }
}
