//
//  StretchModel.swift
//  StretchAndScripture
//
//  Created by diegitsen on 9/08/25.
//

import Foundation

// MARK: - Stretch
struct Stretch: Codable, Equatable {
    let id: Int?
    let name: String?
    let description: String?
    let benefits: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "english_name"
        case description = "pose_description"
        case benefits = "pose_benefits"
        case url = "url_png"
    }
    
    static func == (lhs: Stretch, rhs: Stretch) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Stretch {
    
    static let mock = Self(
        id: 3,
        name: "Bow",
        description: "From a prone position with the abdomen on the earth, the hands grip the ankles (but not the tops of the feet) with knees no wider than the width of your hips.  The heels are lifted away from the buttocks and at the same time the thighs are lifted away from the earth working opposing forces as the heart center, hips and back open.  The gaze is forward.",
        benefits: "Stretches the entire front of the body, ankles, thighs and groins, abdomen and chest, and throat, and deep hip flexors (psoas).  Strengthens the back muscles.  Improves posture.  Stimulates the organs of the abdomen and neck.",
        url: "https://res.cloudinary.com/dko1be2jy/image/upload/fl_sanitize/v1676483072/yoga-api/3_aa0fgk.png")
    
}
