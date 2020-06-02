//
//  ItemView.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/26/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemView: View {
    var category : Category!
    @ObservedObject var itemArray : getCategoryItem
    
    
    init(category : Category){
        itemArray = getCategoryItem(category: category)
    }
    
    var body: some View {
        ItemViewHome(item: self.itemArray.item)
    }
    
    
    
    //    func loadItems(category : Category){
    //        downloadItemsFromFirebase(category.id) { (item) in
    //            //            print(item)
    //            self.itemArray = item
    //            print(self.itemArray.count)
    //
    //        }
    //
    //    }
}

//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemView()
//    }
//}

struct ItemViewHome : View {
    
    // for sticky header view...
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    var item : [Item]
    @State var show = false
    @Environment(\.presentationMode) var presentation
    
    var body: some View{
        
        ZStack(alignment: .top, content: {
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack{
                    
                    
                    VStack{
                        
                        HStack{
                            
                            Button(action: {
                                self.presentation.wrappedValue.dismiss()
                            }) {
                                
                                Image(systemName: "arrow.left.circle")
                                    .renderingMode(.original).foregroundColor(Color.white).padding(10)
                                
                            }
                            
                            
                            Image("prada")
                                .resizable()
                                .frame(width: 40, height: 40).cornerRadius(20)
                            // for dark mode adaption...
                            .foregroundColor(.primary)
                            Text("Prada")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {
                                print(self.item.count)
                                self.show.toggle()
                            }) {
                                
                                Text("Add")
                                    .foregroundColor(.white)
                                    .padding(.vertical,5)
                                    .padding(.horizontal, 10)
                                    .background(Color("bg"))
                                    .clipShape(Capsule())
                            }
                        }
                        
                        VStack(spacing: 30){
                            
                            ForEach(item, id: \.id){i in
                                
                                CardView(data: i)
                                
                            }
                        }
                        .padding(.top)
                    }
                    .padding()
                    
                    Spacer()
                }
            })
            

        })
            .edgesIgnoringSafeArea(.bottom).navigationBarTitle("").navigationBarHidden(true)
            .sheet(isPresented: $show){
                AddItemView()
        }
    }
}

// CardView...

struct CardView : View {
    @State var show  = false
    
    var data : Item
    var body: some View{
        
        HStack(alignment: .top, spacing: 20){
            
            AnimatedImage(url: URL(string: self.data.imageLinks.first!)).resizable().frame(width: 100, height: 100).cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 6) {
                HStack{
                    
                    Text(self.data.name)
                        .fontWeight(.bold)
                    Spacer()
                    
                }
                
                HStack{
                    
                    Text(self.data.description)
                                     .font(.caption)
                                     .foregroundColor(.gray).lineLimit(2)
                                 
                    Spacer()
                    Button(action: {
                                
                            }) {
                                NavigationLink(destination:  ItemDetailView(item: self.data, show: self.$show)){
                                    Text(">")
                                        .fontWeight(.bold)
                                        .padding(.vertical,5)
                                        .padding(.horizontal, 10)
                                        // for adapting to dark mode...
                                        .background(Color.primary.opacity(0.06))
                                        .clipShape(Capsule()).foregroundColor(Color("bg"))
                                }
                                
                            }
                            .clipShape(CustomShape(corner: .topLeft, radii: 55))
                }
             
                HStack(spacing: 10){
                    Text("$" + String(format:"%.1f", self.data.price))
                        .font(.caption)
                        .foregroundColor(.gray)   .fontWeight(.bold)
                    
                    
                    
                    
                    //                    Button(action: {
                    //                        self.show.toggle()
                    //                    }) {
                    //
                    //                        Text("View")
                    //                            .fontWeight(.bold)
                    //                            .padding(.vertical,5)
                    //                            .padding(.horizontal,30)
                    //                            // for adapting to dark mode...
                    //                            .background(Color.primary.opacity(0.06))
                    //                            .clipShape(Capsule())
                    //                    }
                    Image("heart").renderingMode(.original).foregroundColor(Color.white)
                    
                    Text("2")
                        .font(.caption)
                        .foregroundColor(.gray).padding(.trailing)
                    
                }
                
            }
            
            //            Spacer(minLength: 10)
        
            
        }
        //        .sheet(isPresented: $show) {
        //            ItemDetailView(item: self.data, show: self.$show)
        //        }
    }
    
    
}

// TopView...

//struct TopView : View {
//
//    var body: some View{
//
//        HStack{
//
//            VStack(alignment: .leading, spacing: 12) {
//
//                HStack(alignment: .top){
//
//                    Image("apple")
//                        .renderingMode(.template)
//                        .resizable()
//                        .frame(width: 25, height: 30)
//                        // for dark mode adaption...
//                        .foregroundColor(.primary)
//
//                    Text("Add your item")
//                        .font(.title)
//                        .fontWeight(.bold)
//                }
//
//                Text("")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//            }
//
//            Spacer(minLength: 0)
//
//
//        }
//            // for non safe area phones padding will be 15...
//            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 10 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 2)
//            .padding(.horizontal)
//            .padding(.bottom)
//            .background(BlurBG())
//    }
//}


// Blur background...

struct BlurBG : UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIVisualEffectView{
        
        // for dark mode adoption...
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
        
    }
}

// sample data for cards....

struct CardTemp : Identifiable {
    
    var id : Int
    var image : String
    var title : String
    var subTitile : String
}



class getCategoryItem : ObservableObject{
    @Published var item: [Item] = []
    init(category : Category) {
        
        downloadItemsFromFirebase(category.id) { (item) in
            //            print(item)
            
            self.item = item
            print(self.item.count)
        }
        
        
    }
    
    
    
    
}



