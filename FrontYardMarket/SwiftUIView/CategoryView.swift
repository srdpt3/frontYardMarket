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
    
    let width: CGFloat = (UIScreen.main.bounds.width - 24) / 3
    var body: some View {
        Home2(data:  self.$data.datas, Grid:  self.$data.Grid).edgesIgnoringSafeArea(.all)
    }
    
}

//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}

struct Home2 : View {
    @State var delay : Double = 0.6
    @Binding var data : [Category]
    @Binding var Grid : [Int]
    
    var body : some View{
        
        VStack(spacing: 0){
            
            VStack{
                if !self.Grid.isEmpty{
                    
                    ZStack{
                        HStack{
                            Spacer()
                            
                            Button(action:{
                                
                                
                            }) {
                                
                                Image(systemName: "paperplane.fill").resizable().frame(width: 20, height: 20).foregroundColor(Color.black)
                            }
                            .offset(y: -5).padding(.trailing, 20)
                        }
                        
                        
                        
                        Text("Category")
                            .font(.title)
                            .fontWeight(.bold)
                        
                    }.padding(.top, 45)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        
                        VStack(spacing: 20){
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
                    }
                }
                
                
                
                
                
            }
        }  .background(Color("Color-2"))
            .edgesIgnoringSafeArea(.top)
        
    }
    
    
    
}
struct Card : View {
    @State var show  = false
    var data : Category
    
    var body: some View{
        ZStack{
            VStack(spacing: 10){
                
                Button(action: {
                    
                }){
                    NavigationLink(destination: ItemView(category: self.data)){
                        Image(self.data.imageName!)
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width - 45) / 3, height: 100)
                            .cornerRadius(12)
                    }
                    
                    
                }
                //                        .buttonStyle(PlainButtonStyle())
            }
            .cornerRadius(10)
            .shadow(radius: 6)
            
        }
        
    }
}
