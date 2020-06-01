//
//  MessageView.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/29/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    @Binding var detail : Bool

    var body: some View {
        HomeView(detail: self.$detail)
    }
}

//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView()
//    }
//}
struct HomeView : View {
    
    @Binding var detail : Bool

    var body : some View{
        
        ZStack{
            
            Color("bg").edgesIgnoringSafeArea(.top)
            
//            NavigationLink(destination: ChatView()) {
//            
//                Text("")
//            }
            VStack{
                
                topView(detail: self.$detail)
            }
        }
    }
}

struct MessageSubView: View {
    @Binding var detail : Bool

    var body: some View{
  

   
            List{
                ForEach(0..<10){ _ in
      
                    NavigationLink(destination: ChatView(detail: self.$detail)){
                        HStack{
                            Image("Profile").resizable().clipShape(Circle()).frame(width: 50, height: 50)
                            VStack(alignment: .leading, spacing: 5){
                                Text("David").font(.headline).bold()
                                Text("asdfasdfasdf").font(.subheadline).lineLimit(2)
                            }
                            Spacer()
                            VStack(spacing: 5){
                                Text("15:00").bold()
                                Text("2").padding(8).foregroundColor(.white).background(Color.blue).clipShape(Circle())
                            }
                        }.padding(10)
                    }

                    
                }
                }.navigationBarTitle(Text("Messages"), displayMode: .inline).navigationBarHidden(true)
            //            .accentColor(Color("bg"))
        
    }
}

struct topView : View {
    @Binding var detail : Bool

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

                MessageSubView(detail: self.$detail).clipShape(Rounded())
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
