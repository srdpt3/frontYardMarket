//
//  ChatApi.swift
//  Instagram
//
import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase

class ChatApi {
    func sendMessages(message: String, recipientId: String, recipientAvatarUrl: String, recipientUsername: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        let senderId = MUser.currentId()
        guard let senderUsername = MUser.currentUser()?.email else { return }
        let senderAvatarUrl = "https://t1.daumcdn.net/liveboard/notepet/b145a337a91e4b20a7d6c74f7d4ffbf2.jpg"
        let recipientAvatarUrl = "https://t1.daumcdn.net/liveboard/notepet/b145a337a91e4b20a7d6c74f7d4ffbf2.jpg"

        
        
        let messageId = ChatApi.FIRESTORE_COLLECTION_CHATROOM(senderId: senderId, recipientId: recipientId).document().documentID
        
        let chat = Chat(_messageId: messageId, _textMessage: message, _avatarUrl: "", _photoUrl: "", _senderId: senderId, _username: senderUsername, _date: Date().timeIntervalSince1970, _type: "TEXT")
        
        //        guard let dict = try? chatDictionaryFrom(chat) else { return }
        
        FirebaseReference(.chat).document(senderId).collection("chatRoom").document(recipientId).collection("chatItems").document(messageId).setData(ChatApi.chatDictionaryFrom(chat) as! [String : Any]) { (error) in
            if error == nil {
                ChatApi.FIRESTORE_COLLECTION_CHATROOM(senderId: recipientId, recipientId: senderId).document(messageId).setData(ChatApi.chatDictionaryFrom(chat) as! [String : Any])
                
                let inboxMessage1 = InboxMessage(id: UUID().uuidString, lastMessage: message, username: recipientUsername, type: "TEXT", date: Date().timeIntervalSince1970, userId: recipientId, avatarUrl: recipientAvatarUrl)
                let inboxMessage2 = InboxMessage(id: UUID().uuidString, lastMessage: message, username: senderUsername, type: "TEXT", date: Date().timeIntervalSince1970, userId: senderId, avatarUrl: senderAvatarUrl)
                
                
                ChatApi.FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: senderId, recipientId: recipientId).setData(ChatApi.inboxDict(inboxMessage1) as! [String : Any])
                ChatApi.FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: recipientId, recipientId: senderId).setData(ChatApi.inboxDict(inboxMessage2) as! [String : Any])
                onSuccess()
            } else {
                onError(error!.localizedDescription)
            }
        }
        
        
        
    }
    
    func sendPhoto(recipientId: String, recipientAvatarUrl: String, recipientUsername: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        let senderId = MUser.currentId()
        guard let senderUsername = MUser.currentUser()?.email else { return }
        let senderAvatarUrl = "https://t1.daumcdn.net/liveboard/notepet/b145a337a91e4b20a7d6c74f7d4ffbf2.jpg"

        let messageId = ChatApi.FIRESTORE_COLLECTION_CHATROOM(senderId: senderId, recipientId: recipientId).document().documentID
        let storageChatRef = ChatApi.STORAGE_CHAT_ID(chatId: messageId)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        uploadChatImages(messageId: messageId, senderId: senderId, senderUsername: senderUsername, senderAvatarUrl: senderAvatarUrl, recipientId: recipientId, recipientUsername: recipientUsername, recipientAvatarUrl: recipientAvatarUrl, imageData: imageData, metadata: metaData, storageChatRef: storageChatRef, onSuccess: onSuccess, onError: onError)
        
        
        
        
        
        
    }
    
    func getChatMessages(withUser userId: String, onSuccess: @escaping([Chat]) -> Void, onError: @escaping(_ errorMessage: String) -> Void, newChatMessage: @escaping(Chat) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        let listenerFirestore = FirebaseReference(.chat).document(MUser.currentId()).collection("chatRoom").document(userId).collection("chatItems").order(by: "date", descending: false).addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                return
            }
            
            var chatArray = [Chat]()
            //            for document in snapshot.documents {
            //                let dict = document.data()
            //                guard let decoderComment = try? Comment.init(fromDictionary: dict) else {return}
            //                comments.append(decoderComment)
            //                print("comment data")
            //                print(decoderComment.comment)
            //            }
            
            snapshot.documentChanges.forEach { (documentChange) in
                switch documentChange.type {
                case .added:
                    print("type: added")
                    let dict = documentChange.document.data()
                    guard let decoderChat = try? Chat.init(_dictionary: dict as NSDictionary) else {return}
                    newChatMessage(decoderChat)
                    chatArray.append(decoderChat)
                    
                case .modified:
                    print("type: modified")
                case .removed:
                    print("type: removed")
                }
            }
            
            onSuccess(chatArray)
            
        }
        
        listener(listenerFirestore)
    }
    
    func getInboxMessages(onSuccess: @escaping([InboxMessage]) -> Void, onError: @escaping(_ errorMessage: String) -> Void, newInboxMessage: @escaping(InboxMessage) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        let listenerFirestore = FirebaseReference(.messages).document(MUser.currentId()).collection("inboxMessages").order(by: "date", descending: true).addSnapshotListener { (querySnapshot, error) in
          
            guard let snapshot = querySnapshot else {
                return
            }
            
            var inboxMessages = [InboxMessage]()
            //            for document in snapshot.documents {
            //                let dict = document.data()
            //                guard let decoderComment = try? Comment.init(fromDictionary: dict) else {return}
            //                comments.append(decoderComment)
            //                print("comment data")
            //                print(decoderComment.comment)
            //            }
            
            snapshot.documentChanges.forEach { (documentChange) in
                switch documentChange.type {
                case .added:
                    print("type: added")
                    let dict = documentChange.document.data()
                    guard let decoderInboxMessage = try? InboxMessage.init(_dictionary: dict  as NSDictionary) else {return}
                    newInboxMessage(decoderInboxMessage)
                    inboxMessages.append(decoderInboxMessage)
                    
                case .modified:
                    print("type: modified")
                case .removed:
                    print("type: removed")
                }
            }
            
            onSuccess(inboxMessages)
            
        }
        
        listener(listenerFirestore)
    }
    
    
    
    
    // Storage - Posts
    static var STORAGE_CHAT = storage.reference(forURL: kFILEREFERENCE).child("chat")
    
    static func STORAGE_CHAT_ID(chatId: String) -> StorageReference {
        return STORAGE_CHAT.child(chatId)
    }
    
    
    
    static func FIRESTORE_COLLECTION_CHATROOM(senderId: String, recipientId: String) -> CollectionReference {
        return  FirebaseReference(.chat).document(senderId).collection("chatRoom").document(recipientId).collection("chatItems")
    }
    
    
    static func FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: String, recipientId: String) -> DocumentReference {
        return FirebaseReference(.messages).document(senderId).collection("inboxMessages").document(recipientId)
        
        
    }
    
    static func chatDictionaryFrom(_ chat: Chat) -> NSDictionary {
        
        return NSDictionary(objects: [chat.messageId, chat.textMessage, chat.avatarUrl,chat.photoUrl,chat.senderId,chat.username,  chat.date, chat.type],
                            forKeys: ["messageId" as NSCopying, "textMessage" as NSCopying, "avatarUrl" as NSCopying,"photoUrl" as NSCopying,"senderId" as NSCopying, "username" as NSCopying , "date" as NSCopying,"type" as NSCopying])
    }
    
    
    static func inboxDict(_ inboxMessage: InboxMessage) -> NSDictionary {
        
        return NSDictionary(objects: [inboxMessage.id, inboxMessage.lastMessage, inboxMessage.username, inboxMessage.type, inboxMessage.date, inboxMessage.userId, inboxMessage.avatarUrl],
                            forKeys: ["id" as NSCopying, "lastMessage" as NSCopying,
                                      "username" as NSCopying,"type" as NSCopying,"date" as NSCopying,"userId" as NSCopying, "avatarUrl" as NSCopying])
    }
    
    
    func uploadImages(images: [UIImage?], itemId: String, completion: @escaping (_ imageLinks: [String]) -> Void) {
        
        if Reachabilty.HasConnection() {
            
            var uploadedImagesCount = 0
            var imageLinkArray: [String] = []
            var nameSuffix = 0
            
            for image in images {
                
                let fileName = "chat/" + itemId + "/" + "\(nameSuffix)" + ".jpg"
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
    
}
