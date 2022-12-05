//
//  Chat.swift
//  Chat
//
//  Created by Bimal@AppStation on 14/11/22.
//

import Foundation
import UIKit

class Chat: NSObject {
    var enterText:String = ""
    var image: UIImage!
    var currentTime: String = ""
    
    init(_ dict:[String:Any]) {
        enterText = dict["enterText"] as? String ?? ""
        image = dict["enterText"] as? UIImage? as? UIImage
        currentTime = dict["currentTime"] as? String ?? ""
    }
   
}
