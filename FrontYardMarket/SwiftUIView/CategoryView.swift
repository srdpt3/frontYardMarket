//
//  CategoryView.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/25/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//


import SwiftUI

struct CategoryView: View {
    @ObservedObject var data = getData()
    //    @State var Grid : [Int] = []
    
    let width: CGFloat = (UIScreen.main.bounds.width - 24) / 3
    
    var body: some View {
        Home2(data:  self.$data.datas, Grid:  self.$data.Grid).edgesIgnoringSafeArea(.all)
        
    }
    
    
    
    
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}


struct Home2 : View {
    
    @Binding var data : [Category]
    @Binding var Grid : [Int]
    
    
    
    var body : some View{
        
        VStack{
            
            ZStack{
                
                HStack{
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("search").resizable().frame(width: 25, height: 25).foregroundColor(Color.black.opacity(0.2))
                    }
                    .offset(y: -15)
                }
                
                
            }.padding([.top,.horizontal])
                .background(Color("Color"))
            
            VStack{
                if !self.Grid.isEmpty{
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        //                if self.selected == "row"{
                        
                        
                        VStack(spacing: 25){
                            ForEach(self.Grid,id: \.self){i in
                                
                                
                                HStack(spacing: 15){
                                    ForEach(i...i+2,id:  \.self){j in
                                        
                                        VStack{
                                            
                                            if j != self.data.count{
                                                
                                                Card(data: self.data[j])
                                            }
                                        }
                                        
                                    }
                                    if i == self.Grid.last! && self.data.count % 3 != 0{
                                        
                                        Spacer(minLength: 0)
                                    }
                                    
                                }
                                
                            }
                            
                            
                        } .padding()
                        
                        //                    }.padding()
                        
                        
                    }
                }
                
            }

            
        }.background(Color("Color"))
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.bottom,10)
    }
    
    
    
}
struct Card : View {
    
    var data : Category
    
    var body: some View{
        
        VStack(spacing: 15){
            
            Image(data.imageName!)
                .resizable()
                .frame(width: (UIScreen.main.bounds.width - 45) / 3, height: 150)
                .cornerRadius(12)
            
            
        }
        .cornerRadius(10)
        .shadow(radius: 6)
    }
}

//// sample data...
//var gridData = [
//
//    DataType(id: 0, rows:
//
//        [row(id: 0, name: "Matcha Raspberry", pic: "r11", likes: "190"),row(id: 1, name: "Red Velvet", pic: "r12", likes: "98")]
//    ),
//
//    DataType(id: 1, rows:
//        [row(id: 0, name: "Cupcakes with Cream and Berries", pic: "r21", likes: "92"),row(id: 1, name: "Pistachio Macarons", pic: "r22", likes: "88")]
//    ),
//
//    DataType(id: 2, rows: [row(id: 0, name: "Creamy Strawberry Tart", pic: "r31", likes: "32"),row(id: 1, name: "Delisious Cheesecake", pic: "r32", likes: "160")]
//    )
//
//]
//
//var rowData = [
//
//    row(id: 0, name: "Matcha Raspberry ", pic: "r11", likes: "190"),
//    row(id: 1, name: "Red Velvet", pic: "r12", likes: "98"),
//
//    row(id: 2, name: "Cupcakes with Cream and Berries", pic: "r21", likes: "92"),
//    row(id: 3, name: "Pistachio Macarons", pic: "r22", likes: "88"),
//
//    row(id: 4, name: "Creamy Strawberry Tart", pic: "r31", likes: "32"),
//    row(id: 5, name: "Delisious Cheesecake", pic: "r32", likes: "160")
//]

