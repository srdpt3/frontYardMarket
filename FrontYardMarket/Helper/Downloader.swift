//
//  Downloader.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/16/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import Foundation
import FirebaseStorage

let storage = Storage.storage()

func uploadImages(images: [UIImage?], itemId: String, completion: @escaping (_ imageLinks: [String]) -> Void) {
    
    if Reachabilty.HasConnection() {
        
        var uploadedImagesCount = 0
        var imageLinkArray: [String] = []
        var nameSuffix = 0
        
        for image in images {
            
            let fileName = "ItemImages/" + itemId + "/" + "\(nameSuffix)" + ".jpg"
            let imageData = image!.jpegData(compressionQuality: 0.5)
            
            saveImageInFirebase(imageData: imageData!, fileName: fileName) { (imageLink) in
                
                if imageLink != nil {
                    
                    imageLinkArray.append(imageLink!)
                    
                    uploadedImagesCount += 1
                    
                    if uploadedImagesCount == images.count {
                        completion(imageLinkArray)
                    }
                }
            }
            
            nameSuffix += 1
        }
        
    } else {
        print("No Internet Connection")
    }
}

func saveImageInFirebase(imageData: Data, fileName: String, completion: @escaping (_ imageLink: String?) -> Void) {
    
    var task: StorageUploadTask!
    
    let storageRef = storage.reference(forURL: kFILEREFERENCE).child(fileName)
    
    task = storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
        
        task.removeAllObservers()
        
        if error != nil {
            print("Error uploading image", error!.localizedDescription)
            completion(nil)
            return
        }
        
        storageRef.downloadURL { (url, error) in
            
            guard let downloadUrl = url else {
                completion(nil)
                return
            }
            
            completion(downloadUrl.absoluteString)
        }
    })
}

func uploadChatImages(messageId: String, senderId: String, senderUsername: String, senderAvatarUrl : String, recipientId: String,
                      recipientUsername: String, recipientAvatarUrl : String, imageData: Data, metadata: StorageMetadata, storageChatRef: StorageReference
    , onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
    
    storageChatRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
        if error != nil {
            onError(error!.localizedDescription)
            return
        }
        storageChatRef.downloadURL { (url, error) in
            if let metaImageUrl = url?.absoluteString {
                let chat = Chat(_messageId: messageId, _textMessage: "", _avatarUrl: "", _photoUrl: metaImageUrl, _senderId: senderId, _username: senderUsername, _date: Date().timeIntervalSince1970)
                
                //        guard let dict = try? chatDictionaryFrom(chat) else { return }
                
                FirebaseReference(.chat).document(senderId).collection("chatRoom").document(recipientId).collection("chatItems").document(messageId).setData(ChatApi.chatDictionaryFrom(chat)as! [String : Any]) { (error) in
                    if error == nil {
                        ChatApi.FIRESTORE_COLLECTION_CHATROOM(senderId: recipientId, recipientId: senderId).document(messageId).setData(ChatApi.chatDictionaryFrom(chat) as! [String : Any])
                        
                        let inboxMessage1 = InboxMessage(id: UUID().uuidString, lastMessage:  "PHOTO", username: recipientUsername, type: "PHOTO", date: Date().timeIntervalSince1970, userId: recipientId, avatarUrl: "recipientAvatarUrl")
                        let inboxMessage2 = InboxMessage(id: UUID().uuidString, lastMessage:  "PHOTO", username: senderUsername, type: "PHOTO", date: Date().timeIntervalSince1970, userId: senderId, avatarUrl: "senderAvatarUrl")
                        
                        
                        ChatApi.FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: senderId, recipientId: recipientId).setData(ChatApi.inboxDict(inboxMessage1) as! [String : Any])
                        ChatApi.FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: recipientId, recipientId: senderId).setData(ChatApi.inboxDict(inboxMessage2) as! [String : Any])
                        onSuccess()
                    } else {
                        onError(error!.localizedDescription)
                    }
                }
                
                
                
            }
        }
    }
}

