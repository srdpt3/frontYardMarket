//
//  ChatViewModel.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/29/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI


class ChatViewModel: ObservableObject {
    
    @Published var composedMessage: String = ""
    var imageData: Data = Data()
    var errorString = ""
    
    var image: Image = Image(systemName: IMAGE_PHOTO)
    
    
    @Published var showAlert: Bool = false
    @Published var showImagePicker: Bool = false
   
    func sendTextMessage(recipientId: String, recipientAvatarUrl: String, recipientUsername: String, completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        if !composedMessage.isEmpty {
            ChatApi().sendMessages(message: composedMessage, recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, onSuccess: completed, onError: onError)
          } else {
              showAlert = true
              errorString = "Please fill in all fields"
          }
    }
    
    func sendPhotoMessage(recipientId: String, recipientAvatarUrl: String, recipientUsername: String, completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
    if !imageData.isEmpty {
      
        ChatApi().sendPhoto(recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, imageData: imageData, onSuccess: completed, onError: onError)
        
        
      } else {
          showAlert = true
          errorString = "Please fill in all fields"
      }
    }
    

}
