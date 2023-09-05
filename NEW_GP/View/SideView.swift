//
//  SideView.swift
//  Graduation_Project
//
//  Created by 0825.
//

import SwiftUI

struct SideView: View
{
    @AppStorage("colorScheme") private var colorScheme: Bool=true
    @AppStorage("logIn") private var logIn: Bool = false
    
    @Binding var showSide: Bool
    
    @State var isDarkMode: Bool = false
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View
    {
        ZStack
        {
            //MARK: 背景
            Color.black
                .opacity(self.showSide ? 0.5:0)
                .onTapGesture
            {
                withAnimation(.spring())
                {
                    self.showSide.toggle()
                }
            }
            
            //MARK: 側邊欄
            Rectangle()
                .fill(.orange)
                .frame(maxWidth: UIScreen.main.bounds.width/1.5)
                .overlay
            {
                //MARK: 項目連結
                VStack
                {
                    //MARK: 深淺模式
                    HStack{
                        Image(systemName: self.isDarkMode ? "moon.fill":"sun.max.fill")
                            .font(.largeTitle)
                            .foregroundColor(self.isDarkMode ? Color.white : Color.black)
                            .padding(.leading, 60)
                        Toggle("", isOn: self.$colorScheme)
                            .padding(.trailing, 60)
                            .tint(Color.black)
                        
                    }
                    
                    //MARK: 連結
                    NavigationStack
                    {
                        VStack{
                            HStack{
                                NavigationLink(destination: SwiftUIView())
                                {
                                    Text("過往食譜")
                                        .font(.system(size:20))
                                }
                            }
                            NavigationLink(destination: SwiftUIView())
                            {
                                Text("食材紀錄")
                                    .font(.system(size:20))
                            }
                        }
                    }
                    
                    Button(action:
                            {
                        withAnimation(.easeInOut)
                        {
                            self.logIn = false
                        }
                    }) {
                        Text("登出")
                            .font(.system(size:20))
                    }
                }
                .font(.title)
                .foregroundColor(.black)
            }
            .offset(x: self.showSide ? -70:-330)
            .animation(.spring(), value: self.showSide)
        }
        .ignoresSafeArea(.all)
        .preferredColorScheme(self.colorScheme ? .light:.dark)
        
        .onChange(of: self.colorScheme)
        {
            newValue in
            self.isDarkMode = !self.colorScheme
        }
    }
}

struct SideView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
