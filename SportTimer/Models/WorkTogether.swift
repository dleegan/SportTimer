//
//  WorkTogether.swift
//  SportTimer
//
//  Created by dleegan on 30/09/2023.
//

import Foundation
import GroupActivities

struct WorkTogether: GroupActivity {
    var metadata: GroupActivityMetadata {
        var metadata = GroupActivityMetadata()
        metadata.title = NSLocalizedString("Work Together", comment: "Title of group activity")
        metadata.type = .generic
        return metadata
    }
}
