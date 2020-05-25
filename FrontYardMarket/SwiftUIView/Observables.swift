//
//  Observables.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/25/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import SwiftUI
import Firebase

class getData : ObservableObject{
    
    @Published var datas = [Category]()
    //    @Published var top = [Topdatatype]()
    
    init() {
        
        FirebaseReference(.Category).getDocuments { (snapshot, error) in
            
//            guard let snapshot = snapshot else {
//                completion(categoryArray)
//                return
//            }
            
            if error != nil{
                return
            }
            
            if !snapshot!.isEmpty {
                
                for categoryDict in snapshot!.documents {
                    self.datas.append(Category(_dictionary: categoryDict.data() as NSDictionary))
                }
            }
            
        }
    }
}

