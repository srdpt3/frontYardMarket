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
    //    @State var item : [Item] = []
    @ObservedObject var itemArray : getCategoryItem
    //    init(category : Category){
    //        loadItems(category: category)
    //        print(self.itemArray.count)
    //    }
    //
    
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
    
    var body: some View{
        
        ZStack(alignment: .top, content: {
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack{
                    
                    // now going to do strechy header....
                    // follow me...
                    
                    //                    GeometryReader{g in
                    //
                    //                        Image("poster")
                    //                        .resizable()
                    //                        // fixing the view to the top will give strechy effect...
                    //                        // increasing height by drag amount....
                    //                        .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                    //                            .frame(height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 4.4 + g.frame(in: .global).minY  : UIScreen.main.bounds.height / 4.4)
                    //                        .onReceive(self.time) { (_) in
                    //
                    //                            // its not a timer...
                    //                            // for tracking the image is scrolled out or not...
                    //
                    //                            let y = g.frame(in: .global).minY
                    //
                    //                            if -y > (UIScreen.main.bounds.height / 4.4) - 100{
                    //
                    //                                withAnimation{
                    //
                    //                                    self.show = true
                    //                                }
                    //                            }
                    //                            else{
                    //
                    //                                withAnimation{
                    //
                    //                                    self.show = false
                    //                                }
                    //                            }
                    //
                    //                        }
                    //
                    //                    }
                    //                    // fixing default height...
                    //                        .frame(height: UIScreen.main.bounds.height / 4.4)
                    
                    VStack{
                        
                        HStack{
                            Image("gucci")
                                .resizable()
                                .frame(width: 30, height: 30)
                            // for dark mode adaption...
                            //                                .foregroundColor(.primary)
                            Text("Chanel")
                                .font(.title)
                                .fontWeight(.bold).cornerRadius(15)
                            
                            Spacer()
                            
                            Button(action: {
                                print(self.item.count)
                            }) {
                                
                                Text("Add")
                                    .foregroundColor(.white)
                                    .padding(.vertical,5)
                                    .padding(.horizontal, 10)
                                    .background(Color.blue)
                                    .clipShape(Capsule())
                            }
                        }
                        
                        VStack(spacing: 20){
                            
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
            
            //            if self.show{
            
            //                TopView()
            //            }
        })
            .edgesIgnoringSafeArea(.bottom)
    }
}

// CardView...

struct CardView : View {
    
    var data : Item
    
    var body: some View{
        
        HStack(alignment: .top, spacing: 20){
            
            AnimatedImage(url: URL(string: self.data.imageLinks.first!)).resizable().frame(width: 90, height: 90).cornerRadius(20)
            VStack(alignment: .leading, spacing: 6) {
                
                Text(self.data.name)
                    .fontWeight(.bold)
                
                Text(self.data.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack(spacing: 12){
                    
                    Button(action: {
                        
                    }) {
                        
                        Text("View")
                            .fontWeight(.bold)
                            .padding(.vertical,5)
                            .padding(.horizontal,30)
                            // for adapting to dark mode...
                            .background(Color.primary.opacity(0.06))
                            .clipShape(Capsule())
                    }
                    
                    Text(convertToCurrency(self.data.price))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            }
            
            Spacer(minLength: 0)
        }
    }
    func convertToCurrency(_ number: Double) -> String {
           
           let currencyFormatter = NumberFormatter()
           currencyFormatter.usesGroupingSeparator = true
           currencyFormatter.numberStyle = .currency
           currencyFormatter.locale = Locale.current
           
           return currencyFormatter.string(from: NSNumber(value: number))!
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

var data = [
    
    CardTemp(id: 0, image: "g1", title: "Zombie Gunship Survival", subTitile: "Tour the apocalypse"),
    CardTemp(id: 1, image: "g1", title: "Portal", subTitile: "Travel through dimensions"),
    CardTemp(id: 2, image: "g1", title: "Wave Form", subTitile: "Fun enagaging wave game"),
    CardTemp(id: 3, image: "g1", title: "Temple Run", subTitile: "Run for your life"),
    CardTemp(id: 4, image: "g1", title: "World of Warcrat", subTitile: "Be whoever you want"),
    CardTemp(id: 5, image: "g1", title: "Alto’s Adventure", subTitile: "A snowboarding odyssey"),
    CardTemp(id: 6, image: "g1", title: "Space Frog", subTitile: "Jump and have fun"),
    CardTemp(id: 7, image: "g1", title: "Dinosaur Mario", subTitile: "Keep running")
]


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



