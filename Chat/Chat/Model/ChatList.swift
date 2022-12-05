//
//  ChatList.swift
//  Chat
//
//  Created by Bimal@AppStation on 14/11/22.
//

import Foundation

class ChatList: NSObject {
    var personName:String = ""
    
    init(_ dict:[String:Any]) {
        personName = dict["personName"] as? String ?? ""
    }
    
}
