//
//  ItemDetailView.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/27/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit

struct ItemDetailView: View {
    @State var item : Item!
    
    var body: some View {
        itemDetailHome(item: self.$item)
    }
}

//struct ItemDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemDetailView(item: item)
//    }
//}
//


struct itemDetailHome : View {
    
    @State var color = 0
    @State var height = UIScreen.main.bounds.height
    @State var width = UIScreen.main.bounds.width
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @Binding var item : Item!
//    @Binding var show : Bool
    @Environment(\.presentationMode) var presentation
    
    var body: some View{
        
        VStack{
            
            ZStack(alignment: .top){
                
                VStack{
                    
                    AnimatedImage(url: URL(string: self.item.imageLinks.first!)).resizable().frame( height: 300)
                }
                
                
                HStack{
                    
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        
                        Image(systemName: "arrow.left.circle")
                            .renderingMode(.original).foregroundColor(Color.white).padding()
                        
                    }
                    .padding(.leading, 10)
                    .padding(.top, 10).colorMultiply(Color.white)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        
                        Image(systemName: "flag")
                            .renderingMode(.original)
                            .padding()
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, self.height > 800 ? 15 : 10)
                    .background(Color.white)
                    .clipShape(CustomShape(corner: .bottomLeft, radii: self.height > 800 ? 30 : 25))
                }
                
            }.navigationBarTitle("").navigationBarHidden(true)
                .background(Color.clear)
                .clipShape(CustomShape(corner: .bottomLeft, radii: 55))
            
            ScrollView(self.height > 400 ? .init() : .vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack{
                        
                        Text(self.item.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            print("push to favorite")
                        }) {
                            
                            Image("heart")
                                .renderingMode(.original)
                                .padding()
                        }
                        .background(self.color == 0 ? Color.yellow : Color.orange)
                        .clipShape(Circle())
                        
                    }
                    .padding(.horizontal, 35)
                    .padding(.top,25)
                    
                    
                    Text(self.item.description)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 30)
                        .padding(.top,20)
                    
                    Spacer(minLength: 0)
                    
                    
                }
            }
            ZStack {
                MapView(ceterCoordinate: $centerCoordinate, mapAnnotations: locations).edgesIgnoringSafeArea(.all)
                Circle().fill(Color.blue).opacity(0.3).frame(width: 20, height: 20)
            }
            
            Spacer(minLength: 10)
            
            HStack{
                
                Text("$" + String(format:"%.1f", self.item.price))
                    
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 35)
                    .padding(.bottom,25)
                
                Spacer()
                Button(action: {
                    
                }) {
                    NavigationLink(destination: ChatView()){
                        Text("Contact Seller")
                            .foregroundColor(.white)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 35)
                    }
                    
                }
                .background(Color("bg"))
                .clipShape(CustomShape(corner: .topLeft, radii: 55))
                
                
                
            }
            
        }
            //        .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)

        
    }
}


struct CustomShape : Shape {
    
    var corner : UIRectCorner
    var radii : CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radii, height: radii))
        
        return Path(path.cgPath)
    }
}

//class Host : UIHostingController<ContentView> {
//
//    override var prefersHomeIndicatorAutoHidden: Bool{
//
//        return true
//    }
//}
