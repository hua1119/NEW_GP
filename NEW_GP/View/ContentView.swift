//
//  ContentView.swift
//
//  Created by 0822
//

import SwiftUI

struct ContentView: View
{
    @AppStorage("signIn") private var signIn: Bool=false
    
    //切換深淺模式
    @State var isDarkMode: Bool=false
    
    //TabView選擇的頁面
    @State private var showSide: Bool=false
    @State private var select: Int=1
    @State private var information: Information=Information(name: "品瑞", gender: "男性", age: 21, height: 170, weight: 55, phone: "0800012000")
    
    var body: some View
    {
        ZStack
        {
            //MARK: TabView
            TabView(selection: self.$select)
            {
                ProgressView()
                    .tag(0)
                    .tabItem
                {
                    Label("我的最愛", systemImage: "heart.fill")
                }
                
                HomeView(select: self.$select)
                    .tag(1)
                    .tabItem
                {
                    Label("主頁", systemImage: "house.fill")
                }
                
                MemberView(select: self.$select, information: self.$information)
                    .tag(2)
                    .tabItem
                {
                    Label("會員", systemImage: "person.fill")
                }
            }
            .tint(.black)
            
            SideView(showSide: self.$showSide)
        }
        .ignoresSafeArea(.all)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar
        {
            //MARK: 選單按鈕
            ToolbarItem(placement: .navigationBarLeading)
            {
                Button
                {
                    withAnimation(.spring())
                    {
                        self.showSide.toggle()
                    }
                }
            label:
                {
                    VStack
                    {
                        ForEach(0..<3)
                        {_ in
                            Capsule()
                                .fill(Color("cameracolor"))
                                .frame(width: 30, height: 3)
                        }
                    }
                }
                .opacity(self.showSide ? 0:1)
            }
            
            //MARK: 搜尋按鈕
            ToolbarItem(placement: .principal)
            {
                HStack
                {
                    Spacer().opacity(self.showSide ? 1:0)
                    
                    Button
                    {
                    }
                label:
                    {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(.systemGray3))
                            .frame(width: self.showSide ? 60:250,height: 38)
                            .overlay
                        {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color("cameracolor"))
                                .frame(maxWidth: .infinity, alignment: self.showSide ? .trailing:.leading)
                                .frame(height: 20)
                                .padding(.horizontal, 10)
                        }
                    }
                }
                .opacity(self.select==1 ? 1:0)
                .animation(.easeInOut.speed(2), value: self.select)
            }
            
            //MARK: 相機按鈕或編輯按鈕
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button
                {
                }
            label:
                {
                    if(self.select==1)
                    {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("cameracolor"))
                            .frame(height: 30)
                            .transition(.opacity.animation(.easeInOut.speed(2)))
                    }
                    else if(self.select==2)
                    {
                        NavigationLink(destination: MydataView(information: self.$information))
                        {
                            Text("編輯")
                        }
                        .transition(.opacity.animation(.easeInOut.speed(2)))
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationStack
        {
            ContentView()
        }
    }
}
