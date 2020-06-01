//
//  TabBarView.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/30/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    @State var selected = 0
    @State var detail = false

    var body: some View {
        
        ZStack(alignment: .bottom){
            
            VStack{
                
                if self.selected == 0{
                    
                    NavigationView{
                        
                        MessageView(detail: self.$detail)
                    }
                }
                else if self.selected == 1{
                    
                    GeometryReader{_ in
                        
                        Text("Wishlist")
                    }
                    
                }
                else{
                    
                    GeometryReader{_ in
                        
                        Text("Search")
                    }
                }
                
            }.background(Color("Color").edgesIgnoringSafeArea(.all))
            
            FloatingTabbar(detail: self.$detail, selected: self.$selected).opacity(self.detail ? 0 : 1)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}


struct FloatingTabbar : View {
    @Binding var detail : Bool
    @Binding var selected : Int
    @State var expand = false
    
    var body : some View{
        
        HStack{
            
            Spacer(minLength: 0)
            
            HStack{
                
                if !self.expand{
                    
                    Button(action: {
                        
                        self.expand.toggle()
                        
                    }) {
                        
                        Image(systemName: "arrow.left").foregroundColor(.black).padding()
                    }
                }
                else{
                    
                    Button(action: {
                        
                        self.selected = 0
                        
                    }) {
                        
                        Image("Home").foregroundColor(self.selected == 0 ? .black : .gray).padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button(action: {
                        
                        self.selected = 1
                        
                    }) {
                        
                        Image("Search").foregroundColor(self.selected == 1 ? .black : .gray).padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button(action: {
                        
                        self.selected = 2
                        
                    }) {
                        
                        Image("settings").foregroundColor(self.selected == 2 ? .black : .gray).padding(.horizontal)
                    }
                }
                
                
            }.padding(.vertical,self.expand ? 20 : 8)
                .padding(.horizontal,self.expand ? 35 : 8)
                .background(Color.white)
                .clipShape(Capsule())
                .padding(22)
                .onLongPressGesture {
                    
                    self.expand.toggle()
            }
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6))
        }
        
        
    }
}
