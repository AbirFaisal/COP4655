//
//  Task.swift
//  lab-task-squirrel
//
//  Created by Charlie Hieger on 11/15/22.
//

import UIKit
import CoreLocation

class Scavenge {
    let title: String
    let description: String
    var image: UIImage?
    var imageLocation: CLLocation?
    var isComplete: Bool {
        image != nil
    }

    init(title: String, description: String) {
        self.title = title
        self.description = description
    }

    func set(_ image: UIImage, with location: CLLocation) {
        self.image = image
        self.imageLocation = location
    }
}

extension Scavenge {
    static var mockedScavenges: [Scavenge] {
        return [
            Scavenge(title: "Your favorite local restraunt",
                 description: "Where do you go to eat?"),
            
            Scavenge(title: "Your favorite local cafe",
                 description: "Where do you go to get coffee?"),
            
            Scavenge(title: "Your go-to brunch place",
                 description: "Where to you go to have brunch?"),
            
            Scavenge(title: "Your favorite hiking spot",
                 description: "Where do you go to be one with nature?")
        ]
    }
}
