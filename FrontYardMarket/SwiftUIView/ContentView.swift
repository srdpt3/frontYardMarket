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
        
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home : View {
    
    @State var index = 0
    
    var body : some View{
        
        VStack(spacing: 0){
            
            MainView(index: self.$index)
            
            TabBar(index: self.$index)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct MainView : View {
    
    @Binding var index : Int
    
    var body : some View{
        
        GeometryReader{_ in
            
            VStack{
                
                //Your Views Change Views By Index....
                if self.index == 0 {
                    CategoryView()
                }
                
                Text("")
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        }
        .background(Color("Color").edgesIgnoringSafeArea(.top))
        .clipShape(Corners())
    }
}

struct TabBar : View {
    
    @Binding var index : Int
    
    var body : some View{
        
        HStack{
            
            HStack(spacing: (UIScreen.main.bounds.width - 80) / 5){
                
                Button(action: {
                    
                    self.index = 0
                    
                }) {
                    
                    Image("Home")
                        .foregroundColor(self.index == 0 ? .black : Color.black.opacity(0.35))
                }
                
                Button(action: {
                    
                    self.index = 1
                    
                }) {
                    
                    Image("Search")
                        .foregroundColor(self.index == 1 ? .black : Color.black.opacity(0.35))
                }
                
                Button(action: {
                    
                    self.index = 2
                    
                }) {
                    
                    Image("Bag")
                        .foregroundColor(self.index == 2 ? .black : Color.black.opacity(0.35))
                }
                
                Button(action: {
                    
                    self.index = 3
                    
                }) {
                    
                    Image("Profile")
                        .foregroundColor(self.index == 3 ? .black : Color.black.opacity(0.35))
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 12)
            .padding(.top, 28)
            .background(Color.white)
            .clipShape(Curve(index: self.$index))
            
        }.background(Color("Color"))
    }
}

struct Corners : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 40, height: 40))
        
        return Path(path.cgPath)
    }
}

struct Curve : Shape {
    
    @Binding var index : Int
    
    func path(in rect: CGRect) -> Path {
        
        let path1 = Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            path.addArc(center: CGPoint(x: getPosition(value: rect.width), y: 0), radius: 20, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: false)
        }
        
        let path2 = Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addArc(center: CGPoint(x: getPosition(value: rect.width), y: 5), radius: 5, startAngle: .zero, endAngle: .init(degrees: 360), clockwise: false)
            
        }
        
        return Path{path in
            
            path.addPath(path1)
            path.addPath(path2)
        }
    }
    
    func getPosition(value: CGFloat)->CGFloat{
        
        var width : CGFloat
        let spacing = (UIScreen.main.bounds.width - 80) / 5
        
        if index == 0{
            
            width = 40
        }
        else if index == 1{
            
            width = spacing + 60
        }
        else if index == 2{
            
            width = (spacing * 2) + 80
        }
        else{
            
            width = value - 40
        }
        
        return width
    }
}


