//
//  MessageView.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/29/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessageView: View {
    
    var body: some View {
        HomeView()
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
struct HomeView : View {
    
    var body : some View{
        
        ZStack{
            
            Color("bg").edgesIgnoringSafeArea(.top)
            
            VStack{
                
                topView()
            }
        }
    }
}

struct MessageSubView: View {
    @ObservedObject var messageViewModel = MessageViewModel()
    
    var body: some View{
        
        
        
        List{
            
            if !messageViewModel.inboxMessages.isEmpty {
                
            }
            
            ForEach(messageViewModel.inboxMessages, id: \.id) { inboxMessage in
                
                
                NavigationLink(destination: ChatView()){
                    HStack {

                        
                        AnimatedImage(url: URL(string: inboxMessage.avatarUrl)).resizable().frame(width: 50, height: 50).clipShape(Circle())

                        VStack(alignment: .leading, spacing: 5) {
                            Text(inboxMessage.username).font(.headline).bold()
                            Text(inboxMessage.lastMessage).font(.subheadline).lineLimit(2)
                        }
                        Spacer()
                        VStack(spacing: 5) {
                            Text(timeAgoSinceDate(Date(timeIntervalSince1970: inboxMessage.date), currentDate: Date(), numericDates: true)).bold().padding(.leading, 15)
                            
                            //                                 Text("2").padding(8).background(Color.blue).foregroundColor(Color.white).clipShape(Circle())
                        }
                        
                    }.padding(10)
                }
                
                
            }
        }.navigationBarTitle(Text("Messages"), displayMode: .inline).navigationBarHidden(true)
            .onAppear {
                self.messageViewModel.loadInboxMessages()
        }
        .onDisappear {
            if self.messageViewModel.listener != nil {
                self.messageViewModel.listener.remove()
            }
        }
    }
}

struct topView : View {
    
    var body : some View{
        
        VStack{
            
            HStack(spacing: 15){
                
                Text("Chats").fontWeight(.heavy).font(.system(size: 23))
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    
                    Image(systemName: "magnifyingglass").resizable().frame(width: 20, height: 20)
                }
                
                Button(action: {
                    
                }) {
                    
                    Image("menu").resizable().frame(width: 20, height: 20)
                }
                
            }
            .foregroundColor(Color.white)
            .padding()
            
            GeometryReader{_ in
                
                MessageSubView().clipShape(Rounded())
            }
        }
        
        
    }
}

struct Rounded : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .topLeft, cornerRadii: CGSize(width: 55, height: 55))
        return Path(path.cgPath)
    }
}
