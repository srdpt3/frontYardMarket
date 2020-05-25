//
//  CategoryView.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/25/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var observedData = getData()
    
    var body: some View {
        Home2(data: self.$observedData.datas).edgesIgnoringSafeArea(.all)
        
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}

struct Home2 : View {
    
    @Binding var data : [Category]
    @State var selected = "row"
    
    var body : some View{
        
        VStack{
            
            ZStack{
                
                HStack{
                    
                    //                    Button(action: {
                    //
                    //
                    //
                    //                    }) {
                    //
                    //                        Image("settings").resizable().frame(width: 25, height: 25).foregroundColor(Color.black.opacity(0.2))
                    //                    }
                    //                    .offset(y: -15)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("search").resizable().frame(width: 25, height: 25).foregroundColor(Color.black.opacity(0.2))
                    }
                    .offset(y: -15)
                }
                
                HStack(spacing: 15){
                    
                    Button(action: {
                        
                        self.selected = "row"
                        
                        
                    }) {
                        
                        VStack{
                            
                            Image("row")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(self.selected == "row" ? Color.pink : Color.black.opacity(0.2))
                            
                            Circle().fill(self.selected == "row" ? Color.pink : Color.clear).frame(width: 5, height: 5).padding(.vertical,4)
                        }
                        
                    }
                    
                    Button(action: {
                        
                        self.selected = "grid"
                        
                    }) {
                        
                        VStack{
                            
                            Image("grid")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(self.selected == "grid" ? Color.pink : Color.black.opacity(0.2))
                            
                            Circle().fill(self.selected == "grid" ? Color.pink : Color.clear).frame(width: 5, height: 5).padding(.vertical,4)
                        }
                        
                    }
                }
                
            }.padding([.top,.horizontal])
                .background(Color("Color"))
            
            ScrollView(.vertical, showsIndicators: false) {
                
                if self.selected == "row"{
                    RowView(data: self.$data)
                    
                }
                else{
                    GridView(data: self.$data)

//                    GridView()
                }
            }
            
        }.background(Color("Color"))
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.bottom,10)
    }
}

struct RowView : View {
    @Binding var data : [Category];
    var body : some View{
        
        VStack(spacing: 18){
            if(self.data.count == 15){
                ForEach(self.data, id: \.id){i in
                    
                    VStack{
                        
                        Image(i.imageName!).resizable().frame(width : 200, height: 200)
                        HStack{
                            
                            Text(i.name).font(.title)
                            
                            Spacer(minLength: 0)
                            
                            //                        Text(i.likes)
                            
                            Button(action: {
                                
                            }) {
                                
                                Image("heart").renderingMode(.original)
                            }
                            
                        }.padding()
                        
                    }.background(Color.white)
                        .cornerRadius(10)
                }
            }
            
            
        }.padding()
    }
}

struct GridView : View {
    @Binding var data : [Category];

    var body : some View{
        
        VStack(spacing: 18){
            
            ForEach(self.data, id: \.id){i in

                
                HStack(spacing: 15){
                    
                    ForEach(i.rows){j in
                        
                        VStack(spacing: 20){
                            
                            Image(j.pic).resizable().frame(height: 200)
                            
                            HStack{
                                
                                //                                Text(j.name)
                                
                                Spacer(minLength: 0)
                                
                            }.padding(.horizontal)
                            
                            HStack{
                                
                                Spacer()
                                
                                Text(j.likes)
                                
                                Button(action: {
                                    
                                }) {
                                    
                                    Image("heart").renderingMode(.original)
                                }
                            }.padding([.horizontal,.bottom])
                            
                        }.background(Color.white)
                            .cornerRadius(10)
                    }
                }
            }
            
        }.padding()
    }
}

struct DataType : Identifiable {
    
    var id : Int
    var rows : [row]
}

struct row : Identifiable {
    
    var id : Int
    var name : String
    var pic : String
    var likes : String
}

// sample data...

var gridData = [
    
    DataType(id: 0, rows:
        
        [row(id: 0, name: "Matcha Raspberry", pic: "r11", likes: "190"),row(id: 1, name: "Red Velvet", pic: "r12", likes: "98")]
    ),
    
    DataType(id: 1, rows:
        [row(id: 0, name: "Cupcakes with Cream and Berries", pic: "r21", likes: "92"),row(id: 1, name: "Pistachio Macarons", pic: "r22", likes: "88")]
    ),
    
    DataType(id: 2, rows: [row(id: 0, name: "Creamy Strawberry Tart", pic: "r31", likes: "32"),row(id: 1, name: "Delisious Cheesecake", pic: "r32", likes: "160")]
    )
    
]

var rowData = [
    
    row(id: 0, name: "Matcha Raspberry ", pic: "r11", likes: "190"),
    row(id: 1, name: "Red Velvet", pic: "r12", likes: "98"),
    
    row(id: 2, name: "Cupcakes with Cream and Berries", pic: "r21", likes: "92"),
    row(id: 3, name: "Pistachio Macarons", pic: "r22", likes: "88"),
    
    row(id: 4, name: "Creamy Strawberry Tart", pic: "r31", likes: "32"),
    row(id: 5, name: "Delisious Cheesecake", pic: "r32", likes: "160")
    
]
