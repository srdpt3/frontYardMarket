//
//  ChatView.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/29/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @Binding var detail : Bool
    
    var body: some View {
        
        ChatViewSub().onAppear(){
            self.detail.toggle()
        }.onDisappear(){
            self.detail.toggle()
        }
        
        
    }
}

//struct ChatView_Previews: PreviewProvider {
//    @State var detail : Bool
//
//    static var previews: some View {
//        ChatView(detail: )
//    }
//}

struct ChatViewSub: View{
    @ObservedObject var chatViewModel = ChatViewModel()
    var recipientId = "1234"
    var recipientAvatarUrl = ""
    var recipientUsername = ""
    
    func sendTextMessage(){
        chatViewModel.sendTextMessage(recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, completed: {
            self.clean()
        }) { (errorMessage) in
            self.chatViewModel.showAlert = true
            self.chatViewModel.errorString = errorMessage
            self.clean()
        }
    }
    
    func showPicker(){
        self.chatViewModel.showImagePicker = true
    }
    func sendPhoto(){
        chatViewModel.sendPhotoMessage(recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, completed: {
            
            
            
        }) { (errorMessage) in
            self.chatViewModel.showAlert = true
            self.chatViewModel.errorString = errorMessage
            self.clean()
        }
    }
    
    func clean() {
        self.chatViewModel.composedMessage = ""
    }
    
    var body: some View {
        
        
        VStack{
            ScrollView{
                ForEach(0..<10){_ in
                    VStack(alignment: .leading){
                        ChatRow(isCurrentUser: true)
                        ChatRow(isCurrentUser: false)
                        ChatRow(isCurrentUser:false, isPhoto: true)
                        
                        ChatRow(isCurrentUser:true, isPhoto: true)
                        
                    }.padding(.top, 20)
                    
                }
            }
            Spacer()
            HStack{
                
                HStack(spacing : 8){
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("emoji").resizable().frame(width: 20, height: 20)
                        
                    }.foregroundColor(.gray)
                    
                    TextField("Type Something", text: $chatViewModel.composedMessage)
                    
                    Button(action: {
                        
                    }) {
                        
                        Image(systemName: "camera.fill").font(.body)
                        
                    }.foregroundColor(.gray)
                    
                    Button(action: showPicker) {
                        
                        Image(systemName: "paperclip").font(.body)
                        
                    }.foregroundColor(.gray)
                    
                }.padding()
                    .background(Color("Color-2"))
                    .clipShape(Capsule())
                
                Button(action: sendTextMessage) {
                    
                    Image(systemName: "paperplane")
                        .resizable()
                        .frame(width: 15, height: 23)
                        .padding(13)
                        .foregroundColor(.white)
                        .background(Color("bg"))
                        .clipShape(Circle())
                    
                }.foregroundColor(.gray)
                
            }.padding(.horizontal, 15)
                .background(Color.white)
            
        }
        .sheet(isPresented: $chatViewModel.showImagePicker, onDismiss: {
            self.sendPhoto()
        }) {
            // ImagePickerController()
            ImagePicker(showImagePicker: self.$chatViewModel.showImagePicker, pickedImage: self.$chatViewModel.image, imageData: self.$chatViewModel.imageData)
        }
            
        .navigationBarTitle(Text("David"), displayMode: .inline)
        .alert(isPresented: $chatViewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(self.chatViewModel.errorString), dismissButton: .default(Text("OK")))
        }
    }
}


struct ChatRow : View {
    var isCurrentUser = false
    var isPhoto = false
    var body: some View {
        
        Group{
            if !isCurrentUser && !isPhoto{
                HStack(alignment: .top) {
                    Image("Profile").resizable().scaledToFill().frame(width: 30, height: 30).clipShape(Circle())
                    Text("hi gasdfasdfasdfasdfasfdasfdasdfasdfasdfuysasdfasdfasdfasfdasfdasfdasfdasdfasfasfd").padding(10).foregroundColor(.black).background(Color("Color-2")).cornerRadius(10).font(.callout).clipShape(msgTail(mymsg: false))
                }.padding(.leading, 15).padding(.trailing , 50 )
                
            }else if !isPhoto{
                HStack(alignment: .top) {
                    Spacer(minLength: 50)
                    Text("asfasfdxxcvzssfsavasfdasdliwjflsjlfkjaskljf kljs aljflak;sjfklawejlkf jaksl  sakljf;lsajdk ").padding(10).foregroundColor(.white).background(Color("bg")).cornerRadius(10).font(.callout).clipShape(msgTail(mymsg: true))
                }.padding(.trailing , 15 )
            }
            
            if !isCurrentUser && isPhoto{
                HStack(alignment: .top) {
                    Image("Profile").resizable().scaledToFill().frame(width: 30, height: 30).clipShape(Circle())
                    
                    Image("poster").resizable().scaledToFill().frame(width: 200, height: 200).cornerRadius(10)
                    Spacer()
                    
                }.padding(.leading, 15).padding(.trailing , 50 )
                
            }else if isCurrentUser && isPhoto{
                
                HStack(alignment: .top) {
                    Spacer()
                    Image("tr").resizable().scaledToFill().frame(width: 200, height: 200).cornerRadius(10)
                }.padding(.trailing , 15 )
            }
            
        }
        
        
        
        
    }
}


struct chatTopview : View {
    
    
    var body : some View{
        
        
        HStack(spacing : 15){
            
            Button(action: {
                
                
            }) {
                
                Image(systemName: "control").font(.title).rotationEffect(.init(degrees: -90))
            }
            
            Spacer()
            
            VStack(spacing: 5){
                
                Image("Profile").resizable().frame(width: 45, height: 45).clipShape(Circle())
                
                Text("Dustin").fontWeight(.heavy)
                
            }.offset(x: 25)
            
            
            Spacer()
            
            Button(action: {
                
            }) {
                
                Image(systemName: "phone.fill").resizable().frame(width: 20, height: 20)
                
            }.padding(.trailing, 25)
            
            Button(action: {
                
            }) {
                
                Image(systemName: "video.fill").resizable().frame(width: 23, height: 16)
            }
            
        }.foregroundColor(.white)
            .padding()
    }
}


struct msgTail : Shape {
    
    var mymsg : Bool
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,mymsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 25, height: 25))
        return Path(path.cgPath)
    }
}

