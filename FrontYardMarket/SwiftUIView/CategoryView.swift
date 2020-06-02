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
        CategoryMainView().navigationBarTitle(Text("Category")).navigationBarHidden(true)
        //       Home2(data:  self.$data.datas, Grid:  self.$data.Grid).edgesIgnoringSafeArea(.all)
    }
    
}

struct CategoryMainView : View {
    @State var txt = ""
    @State  var currentUser = MUser.currentUser()?.firstName
    var body : some View{
        
        VStack(spacing: 15){
            
            HStack(spacing: 12){
                
                Image(systemName: "person").renderingMode(.original).resizable().frame(width: 30, height: 30)
                
                Text(String(self.currentUser!)).font(.body)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    
                    Image("filter").renderingMode(.original)
                }
            }
            
            HStack(spacing: 15){
                HStack{
                    Image(systemName: "magnifyingglass").font(.body)
                    TextField("Search", text: $txt)
                }.padding(10).background(Color("Color1")).cornerRadius(20)
                
                
            }
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing:15){
                    Image("poster").resizable().frame(width: 347, height: 150).overlay(
                        
                        VStack{
                            Spacer()
                            
                            HStack{
                                Text("Markdown Items").font(.headline).foregroundColor(.white)
                                Spacer()
                                
                            }.padding()
                        }
                        
                    )
                    
                    
                    HStack{
                        Text("Category").font(.title)
                        Spacer()
                    }.padding(.vertical, 15)
                    ScrollView(.horizontal, showsIndicators:  false){
                        HStack(spacing: 15) {
                            
                            
                            ForEach(categories, id: \.self){i in
                                VStack{
                                    
                                    NavigationLink(destination: ChatView()){
                                        Image(i).resizable().frame(width:60, height:60)
                                        
                                    } .buttonStyle(PlainButtonStyle())
                                    Text(i)
                                    
                                    
                                    
                                }
                                
                            }
                        }
                    }
                    
                                        HomeBottomView()
                }
            }
            
            Spacer()
        }.padding(.horizontal)
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


struct HomeBottomView : View {
    
    var body : some View{
        
        VStack(spacing: 15){
            
            HStack{

                Text("신선한 아이템").font(.title)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    
                    Text("더보기")
                    
                }.foregroundColor(Color("Color"))
                
            }.padding(.vertical, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 15){
                    
                    ForEach(freshitems){i in
                        
                        FreshCellView(data: i)
                    }
                }
            }
            
            HStack{

                Text("레시피").font(.title)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    
                    Text("더보기")
                    
                }.foregroundColor(Color("Color"))
                
            }.padding(.vertical, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 15){
                    
                    ForEach(recipeitems){i in
                        
                        RecipeCellView(data: i)
                    }
                }
            }
        }
    }
}

struct FreshCellView : View {
    
    var data : fresh
    @State var show = false
    
    var body : some View{
        
        ZStack{
            
//            NavigationLink(destination: Detail(show: self.$show), isActive: self.$show) {
//                
//                Text("")
//            }
            
            VStack(spacing: 10){
                
                Image(data.image).resizable().frame(width: 150, height: 150)
                Text(data.name).fontWeight(.semibold)
                Text(data.price).foregroundColor(.green).fontWeight(.semibold)
                
            }.onTapGesture {
                
                self.show.toggle()
            }
            
        }
    }
}

struct RecipeCellView : View {
    
    var data : recipe
    
    var body : some View{
        
        VStack(spacing: 10){
            
            Image(data.image)
            
            HStack(spacing: 10){
                
                Image(data.authorpic)
                
                VStack(alignment: .leading, spacing: 6){
                    
                    Text(data.name).fontWeight(.semibold)
                    Text(data.author).foregroundColor(.green).fontWeight(.semibold)
                }
            }

        }
    }
}



// sample datas...

var tabs = ["홈","위시리스트","장바구니"]

var categories = ["FootWear","Accessories","HandBags","Clothings","Small Leather"]

struct fresh : Identifiable {
    
    var id : Int
    var name : String
    var price : String
    var image : String
}

struct recipe : Identifiable {
    
    var id : Int
    var name : String
    var author : String
    var image : String
    var authorpic : String
}

var freshitems = [
    fresh(id: 1, name: "비비고만두", price: "6500원/ 팩",image: "f2"),
    fresh(id: 0, name: "김말이", price: "5000원/ 팩",image: "f1"),
    fresh(id: 2, name: "커피브레드", price: "3500원 / 팩",image: "f3")
    
    
]

var recipeitems = [
    recipe(id: 0, name: "파스타", author: "데니조",image: "r1",authorpic: "rp1"),
    recipe(id: 1, name: "바나나 라이스", author: "흑자",image: "r2",authorpic: "rp2"),
    recipe(id: 2, name: "라면", author: "null",image: "r3",authorpic: "rp3")
]
