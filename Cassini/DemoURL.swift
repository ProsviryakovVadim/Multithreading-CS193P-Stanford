//
//  DemoURL.swift
//  Cassini
//
//  Created by Vadim on 09.07.16.
//  Copyright © 2016 Vadim Prosviryakov. All rights reserved.
//

import Foundation

struct DemoURL {
    
    static let Stanford = NSURL(string: "https://comm.stanford.edu/wp-content/uploads/2013/01/stanford-campus.png")

    static let NASA = [
        "Cassini" : "http://photojournal.jpl.nasa.gov/jpeg/PIA03883.jpg",
        "Earth"   : "https://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
        "Saturn"  : "http://www.gamma72.ru/artcatalog/foto/m/b/33.jpg"
    ]
    
    
    static func NASAImageNamed(imageName: String?) -> NSURL? {
        if let urlString = NASA[imageName ?? ""] {
            return NSURL(string: urlString)
        } else {
            return nil
        }
    }
}