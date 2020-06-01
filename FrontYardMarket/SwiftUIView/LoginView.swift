//
//  LoginView.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/24/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import SwiftUI
import JGProgressHUD

struct LoginView: View {
    var body: some View {
        
        
        
        ZStack{
            
            //            LinearGradient(gradient: .init(colors: [Color.whi,Color("Color"),Color("Color")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            if UIScreen.main.bounds.height > 800{
                
                LoginHome()
            }
            else{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LoginHome()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct  LoginHome : View {
    @State var index = 0;
    var body: some View {
        VStack {
            
//            Image(systemName: "signature").resizable().frame(width: 140, height: 120)
            
            HStack{
                Button(action: {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        
                        self.index = 0
                    }
                }){
                    Text("Existing")
                        .foregroundColor(self.index == 0 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                }.background(self.index == 0 ? Color.white : Color.clear)
                    .clipShape(Capsule())
                
                
                Button(action: {
                    
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        
                        self.index = 1
                    }
                    
                }) {
                    
                    Text("New")
                        .foregroundColor(self.index == 1 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                    
                }.background(self.index == 1 ? Color.white : Color.clear)
                    .clipShape(Capsule())
            }.background(Color.black.opacity(0.1))
                .clipShape(Capsule())
                .padding(.top, 25)
            
            if self.index == 0{
                
                Login()
            }
            else{
                
                SignUp()
            }
            
            if self.index == 0{
                
                Button(action: {
                    
                }) {
                    
                    Text("Forget Password?")
                        .foregroundColor(.white)
                    
                }
                .padding(.top, 20)
            }
            HStack(spacing: 15){
                
                Color.white.opacity(0.7)
                    .frame(width: 35, height: 1)
                
                Text("Or")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Color.white.opacity(0.7)
                    .frame(width: 35, height: 1)
                
            }.padding(.top , 10)
            HStack{
                
                Button(action: {
                    
                }) {
                    
                    Image("fb")
                        .renderingMode(.original)
                        .padding()
                    
                }.background(Color.white)
                    .clipShape(Circle())
                
                Button(action: {
                    
                }) {
                    
                    Image("google")
                        .renderingMode(.original)
                        .padding()
                    
                }.background(Color.white)
                    .clipShape(Circle())
                    .padding(.leading, 25)
            }
            .padding(.top, 10)
            
        }.padding()
    }
}


struct Login : View {
    let hud = JGProgressHUD(style: .dark)
    
    @State var mail = ""
    @State var pass = ""
    
    var body : some View{
        
        VStack{
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    
                    TextField("Enter Email Address", text: self.$mail)
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$pass)
                    
                    Button(action: {
                        
                    }) {
                        
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    }
                    
                }.padding(.vertical, 20)
                
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            
            
            Button(action: {
                MUser.loginUserWith(email:  self.mail, password: self.pass) { (error, isEmailVerified) in
                    
                    if error == nil {
                        
                        if  isEmailVerified {
                            //                            self.dismissView()
                            print("Email is verified")
                        } else {
                            //                            self.resendButtonOutlet.isHidden = false
                            
                            //                            self.hud.textLabel.text = "Please Verify your email!"
                            //                            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                            ////                            self.hud.show()
                            //                            self.hud.dismiss(afterDelay: 2.0)
                        }
                        
                    } else {
                        print("error loging in the iser", error!.localizedDescription)
                        //                        self.hud.textLabel.text = error!.localizedDescription
                        //                        self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                        //                        self.hud.show(in: <#T##UIView#>)
                        //                        self.hud.dismiss(afterDelay: 2.0)
                    }
                    
                    
                    //                    self.hideLoadingIdicator()
                }
            }) {
                
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                
            }.background(
                
                LinearGradient(gradient: .init(colors: [Color("Color2"),Color("Color")]), startPoint: .leading, endPoint: .trailing)
            )
                .cornerRadius(8)
                .offset(y: -40)
                .padding(.bottom, -40)
                .shadow(radius: 15)
        }
    }
}

struct SignUp : View {
    
    @State var mail = ""
    @State var pass = ""
    @State var repass = ""
    
    var body : some View{
        
        VStack{
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    
                    TextField("Enter Email Address", text: self.$mail)
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$pass)
                    
                    Button(action: {
                        
                    }) {
                        
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    }
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Re-Enter", text: self.$repass)
                    
                    Button(action: {
                        
                    }) {
                        
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    }
                    
                }.padding(.vertical, 20)
                
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            
            
            Button(action: {
                
            }) {
                
                Text("SIGNUP")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                
            }.background(
                
                LinearGradient(gradient: .init(colors: [Color("Color2"),Color("Color")]), startPoint: .leading, endPoint: .trailing)
            )
                .cornerRadius(8)
                .offset(y: -40)
                .padding(.bottom, -40)
                .shadow(radius: 15)
        }
    }
}

