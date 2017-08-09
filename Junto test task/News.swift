//
//  News.swift
//  Junto test task
//
//  Created by Admin on 09.08.17.
//  Copyright © 2017 NS. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class News: Object {
    
    dynamic var name: String = ""
    dynamic var descr: String = ""
    dynamic var upvotes: Int = 0
    dynamic var thumbnail: String = ""
    dynamic var url: String = ""
    dynamic var screenShot: String = ""
    
    convenience init?(_ json: JSON) {
        
        guard
            let name = json["name"].string,
            let descr = json["tagline"].string,
            let upvotes = json["votes_count"].int,
            let thumbnail = json["thumbnail"]["image_url"].string,
            let url = json["discussion_url"].string,
            let screenShot = json["screenshot_url"]["850px"].string
            else { return nil }
        
        self.init()
        self.name = name
        self.descr = descr
        self.upvotes = upvotes
        self.thumbnail = thumbnail
        self.url = url
        self.screenShot = screenShot
        
        
    }
    
}
