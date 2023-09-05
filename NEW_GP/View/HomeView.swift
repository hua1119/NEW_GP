//
//
//  Home.swift
//
//  Created by 0820
//

import SwiftUI

struct HomeView: View
{
    @Binding var select: Int
    
    private let cook: [String]=["煎", "煮", "炒", "炸", "烘"]
    
    var body: some View
    {
        
        NavigationStack
        {
            VStack
            {
                //MARK: 今日推薦
                ScrollView(.horizontal, showsIndicators: false)
                {
                    HStack
                    {
                        ForEach(0..<5)
                        {
                            _ in
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.gray)
                                .frame(width: 300, height: 200)
                                .overlay(Text("今日推薦").font(.title))
                        }
                    }
                }
                
                Capsule().frame(height: 1).padding(.vertical)
                
                //MARK: 烹飪方法
                HStack
                {
                    ForEach(0..<5)
                    {index in
                        Circle()
                            .fill(.gray)
                            .scaledToFit()
                            .frame(width: 60)
                            .overlay(Text(self.cook[index]).font(.title))
                        
                        
                        if(index<4){
                            Spacer()
                        }
                    }
                }
                Capsule().frame(height: 1).padding(.vertical)
                HStack
                {
                    NavigationLink(destination: HealthyView())
                    {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .overlay(Text("健康管理").font(.title).foregroundColor(Color("textcolor")))
                        
                    }
                    VStack
                    {
                        NavigationLink(destination: MyrecipeView())
                        {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray)
                                .overlay(Text("我的食譜").font(.title).foregroundColor(Color("textcolor")))
                        }
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .overlay(Text("購物清單").font(.title))
                    }
                }
            }
            .padding()
        }
    }
}
