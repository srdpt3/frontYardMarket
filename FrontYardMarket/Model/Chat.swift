//
//  ChatViewModel.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/29/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import Foundation


//struct Chat: Encodable, Decodable {
//    var messageId: String
//    var textMessage: String
//    var avatarUrl: String
//    var photoUrl: String
//    var senderId: String
//    var username: String
//    var date: Double
//}



class Chat {
    
    var messageId: String
    var textMessage: String
    var avatarUrl: String
    var photoUrl: String
    var senderId: String
    var username: String
    var date: Double
    
    init(_messageId : String, _textMessage: String,_avatarUrl: String, _photoUrl: String,_senderId: String, _username:String, _date : Double) {
        
        messageId = _messageId
        textMessage = _textMessage
        avatarUrl = _avatarUrl
        photoUrl = _photoUrl
        senderId = _senderId
        username = _username
        date = _date
        
    }
    
    init(_dictionary: NSDictionary) {
        messageId = _dictionary["messageId"] as! String
        textMessage = _dictionary["textMessage"] as! String
        avatarUrl = _dictionary["avatarUrl"] as! String
        photoUrl = _dictionary["photoUrl"] as! String
        senderId = _dictionary["senderId"] as! String
        username = _dictionary["username"] as! String
        date = _dictionary["date"] as! Double
        
        
        
    }
    
}
