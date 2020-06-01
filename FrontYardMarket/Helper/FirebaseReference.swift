//
//  FirebaseReference.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/13/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference : String{
    case User
    case Category
    case Items
    case Basket
    case chat
    case messages
}


func FirebaseReference(_ collectionReference : FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}
