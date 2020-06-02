//
//  ContentView.swift
//  Custom_InlineCurve_Shapes
//
//  Created by Dustin yang on 5/22/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        
        subMainView()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct subMainView : View {
    @State var index = 0
    
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                
                
                
                if self.index == 0{
                    
                    
                   CategoryView()
//                    TempView()
                    
                }
                else if self.index == 1{
                    
                    
                    
                    MessageView()
                    
                }
                else if self.index == 2{
                    
                    Color.blue
                }
                else{
                    
                    Color.orange
                }
                
                
                CircleTab(index: self.$index)
                //                    .opacity(self.detail ? 0 : 1)
                
            }
        }
    }
    
}


struct CircleTab : View {
    
    @Binding var index : Int
    //    @Binding var detail : Bool
    var body : some View{
        
        
        HStack{
            
            Button(action: {
                
                self.index = 0
                
            }) {
                
                VStack{
                    
                    if self.index != 0{
                        
                        Image("Home").foregroundColor(Color.black.opacity(0.2))
                        
                    }
                    else{
                        
                        Image("Home")
                            .resizable()
                            .frame(width: 25, height: 23)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("bg"))
                            .clipShape(Circle())
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        
                        Text("Category").foregroundColor(Color.black.opacity(0.7))
                    }
                }
                
                
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                
                self.index = 1
                
            }) {
                
                VStack{
                    
                    if self.index != 1{
                        
                        Image("Chat").resizable().frame(width: 19, height: 19).foregroundColor(Color.black.opacity(0.2))
                    }
                    else{
                        
                        Image("Chat")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("bg"))
                            .clipShape(Circle())
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        
                        Text("Chat").foregroundColor(Color.black.opacity(0.7))
                    }
                }
            }
            
            Spacer(minLength: 15)
            
            
            Button(action: {
                
                self.index = 2
                
            }) {
                
                VStack{
                    
                    if self.index != 2{
                        
                        Image("heart").resizable().frame(width: 19, height: 19).foregroundColor(Color.black.opacity(0.2))
                    }
                    else{
                        
                        Image("heart")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("bg"))
                            .clipShape(Circle())
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        
                        Text("Favorite").foregroundColor(Color.black.opacity(0.7))
                    }
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                
                self.index = 3
                
            }) {
                
                VStack{
                    
                    if self.index != 3{
                        
                        Image("settings").foregroundColor(Color.black.opacity(0.2))
                    }
                    else{
                        
                        Image("settings")
                            .resizable()
                            .frame(width: 24, height: 22)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("bg"))
                            .clipShape(Circle())
                            .offset(y: -20)
                            .padding(.bottom, -20)
                        
                        Text("Setting").foregroundColor(Color.black.opacity(0.7))
                    }
                }
            }
            
            
            
        }.padding(.vertical,-10)
            .padding(.horizontal, 25)
            .background(Color.white)
            .animation(.spring())
    }
}
