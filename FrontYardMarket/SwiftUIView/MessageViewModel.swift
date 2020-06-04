//
//  MessageViewModel.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 6/3/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import SwiftUI



import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI


class MessageViewModel: ObservableObject {
    
   
    @Published var inboxMessages: [InboxMessage] = [InboxMessage]()

    var listener: ListenerRegistration!
    
//    init() {
//        loadInboxMessages()
//    }
    func loadInboxMessages() {
        self.inboxMessages = []

        
           ChatApi().getInboxMessages(onSuccess: { (inboxMessages) in
            if self.inboxMessages.isEmpty {
                self.inboxMessages = inboxMessages
            }
        }, onError: { (errorMessage) in

        }, newInboxMessage: { (inboxMessage) in
            if !self.inboxMessages.isEmpty {
                self.inboxMessages.append(inboxMessage)
            }
        }) { (listener) in
            self.listener = listener
        }
    }
}
