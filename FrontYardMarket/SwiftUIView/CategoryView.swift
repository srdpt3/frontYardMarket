//
//  CategoryView.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/25/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//


import SwiftUI
import SDWebImageSwiftUI

struct CategoryView: View {
    
    
    @ObservedObject var categories : LoadCategory
    @ObservedObject var items : LoadItem
    
    
    init(){
        categories = LoadCategory()
        items = LoadItem()
    }
    
    var body: some View {
        CategoryMainView(data:  self.$categories.datas, Grid:  self.$categories.Grid, itemData: self.$items.datas).navigationBarTitle(Text("Category")).navigationBarHidden(true)
        //               Home2(data:  self.$categories.datas, Grid:  self.$categories.Grid).edgesIgnoringSafeArea(.all)
    }
    
}

struct CategoryMainView : View {
    
    @Binding var data : [Category]
    @Binding var Grid : [Int]
    @Binding var itemData : [Item]
    
    @State var txt = ""
    @State  var currentUser = MUser.currentUser()?.firstName
    
    var body : some View{
        
        VStack(spacing: 15){
            HStack(spacing: 12){
                
                Image("pic").renderingMode(.original).resizable().frame(width: 30, height: 30).cornerRadius(15)
                
                Text(String("Welcome \(self.currentUser!)")).font(.body)
                
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
                    if !self.data.isEmpty{
                        
                        HomeBottomView(data:self.$data, items: self.$itemData)
                    }
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
                                    ForEach(i...i+1,id:  \.self){j in
                                        VStack{
                                            if j != self.data.count{
                                                Card(data: self.data[j])
                                            }
                                        }
                                    }
                                    if i == self.Grid.last! && self.data.count % 2 != 0{
                                        
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


struct HomeBottomView : View {
    @Binding var data : [Category]
    @Binding var items : [Item]
    
    var body : some View{
        
        VStack(spacing: 10){
            
            HStack{
                
                Text("Featured Brands").font(.title)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    
                    Text("View More").foregroundColor(Color("bg"))
                    
                }.foregroundColor(Color("Color"))
                
            }.padding(.vertical, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 15){
                    
                    ForEach(self.data, id: \.id){i in
                        //                        FreshCellView(data: i)
                        Card(data: i)
                        //                        Image(i.imageName!).resizable().frame(width: 150, height: 150)
                        
                        
                    }
                }.padding(.vertical, 10)
            }
            
            HStack{
                
                Text("Hot Items").font(.title)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    
                    Text("View More").foregroundColor(Color("bg"))
                    
                }.foregroundColor(Color("Color"))
                
            }.padding(.vertical, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 15){
                    
                    ForEach(self.items, id: \.id){i in
                        
                        HotItemView(data: i)
                    }
                }
            }
        }
    }
}
struct Card : View {
    @State var show  = false
    var data : Category
    
    var body: some View{
        ZStack{
            VStack(spacing: 6){
                
                Button(action: {
                    
                }){
                    NavigationLink(destination: ItemView(category: self.data)){
                        Image(self.data.imageName!)
                            .resizable()
                            .frame(width: (UIScreen.main.bounds.width - 45) / 2.7, height: 120)
                            .cornerRadius(12)
                    }.buttonStyle(PlainButtonStyle()).padding([.leading], 5)
                    
                    
                }.buttonStyle(PlainButtonStyle())
                
                HStack(spacing: 10){
                    Text(data.name).fontWeight(.semibold).padding([.leading], 5)
                    
                }
                
            }
            .cornerRadius(10)
            .shadow(radius: 6)
            
        }}
    
    
}


struct HotItemView : View {
    
    var data : Item
    
    var body : some View{
        
        VStack(spacing: 10){
            
            //            Image(data.imageName)
            
            NavigationLink(destination: ItemDetailView(item: self.data)){
                AnimatedImage(url: URL(string: data.imageLinks.first!)).resizable().frame(width: (UIScreen.main.bounds.width - 45) / 2.7, height: 120).cornerRadius(12)
            }.buttonStyle(PlainButtonStyle()).padding([.leading], 5)            .cornerRadius(10)
                .shadow(radius: 6)
            
            HStack(spacing: 10){
                
                Image("rp1")
                
                VStack(alignment: .leading, spacing: 6){
                    
                    Text(data.name).fontWeight(.semibold)
                    Text("somebody").foregroundColor(Color("bg")).fontWeight(.semibold)
                    
                }.padding(.bottom,10)
                
            }
            
        }
    }
}



// sample datas...


var categories = ["FootWear","Accessories","HandBags","Clothings","Small Leather"]


class LoadCategory : ObservableObject{
    
    @Published var datas = [Category]()
    //    @Published var top = [Topdatatype]()
    @Published var Grid : [Int] = []
    init() {
        
        FirebaseReference(.Category).getDocuments { (snapshot, error) in
            
            //            guard let snapshot = snapshot else {
            //                completion(categoryArray)
            //                return
            //            }
            DispatchQueue.main.async {
                if error != nil{
                    return
                }
                if !snapshot!.isEmpty {
                    
                    for categoryDict in snapshot!.documents {
                        self.datas.append(Category(_dictionary: categoryDict.data() as NSDictionary))
                    }
                    for i in stride(from: 0, to: self.datas.count, by: 2){
                        
                        if i != self.datas.count{
                            print("Grid \(i)")
                            self.Grid.append(i)
                            print("data \(self.datas.count)")
                            
                        }
                        
                    }
                }
            }
            
            
            
            
        }
        
        
        
    }
}


class LoadItem : ObservableObject{
    
    @Published var datas = [Item]()
    //    @Published var top = [Topdatatype]()
    init() {
        
        FirebaseReference(.Items).getDocuments { (snapshot, error) in
            
            DispatchQueue.main.async {
                if error != nil{
                    return
                }
                if !snapshot!.isEmpty {
                    
                    for itemDict in snapshot!.documents {
                        
                        self.datas.append(Item(_dictionary: itemDict.data() as NSDictionary))
                    }
                    
                }
            }
        }
        
    }
    
}

