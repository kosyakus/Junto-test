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
    
    dynamic var temperature: Double = 0.0
    dynamic var date: String = ""
    dynamic var descr: String = ""
    dynamic var icon: String = ""
    
    convenience init?(_ json: JSON) {
        
        guard
            let temperature = json["main"]["temp"].double,
            let date = json["dt_txt"].string,
            let descr = json["weather"][0]["description"].string,
            let icon = json["weather"][0]["icon"].string
            else { return nil }
        
        self.init()
        self.temperature = temperature
        self.date = date
        self.descr = descr
        self.icon = "http://openweathermap.org/img/w/" + icon + ".png"
        
    }
    
}
