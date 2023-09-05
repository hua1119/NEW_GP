//
//  SwiftUIView.swift
//  Graduation_Project
//
//  Created by Mac on 2023/8/24.
//

import SwiftUI

struct SwiftUIView: View
{
    @State private var showSheet: Bool=false
    @State private var up: Bool=false
    private let title: [String]=["A", "B", "C", "D", "E"]
    var body: some View
    {
        NavigationStack
        {
            VStack(spacing: 50)
            {
                ForEach(self.title, id: \.self)
                {
                    index in
                    Button
                    {
                        self.showSheet.toggle()
                    }
                label:
                    {
                        Text(index)
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(10)
                            .frame(width: 300)
                            .background(.black)
                            .cornerRadius(10)
                    }
                }
            }
            .sheet(isPresented: self.$showSheet)
            {
                ZStack
                {
                    VStack
                    {
                        Rectangle()
                            .fill(Color.indigo.gradient)
                            .frame(height: self.up ? 200:250)
                            .overlay(alignment: .topTrailing)
                        {
                            Button
                            {
                                withAnimation(.spring())
                                {
                                    self.up.toggle()
                                }
                            }
                        label:
                            {
                                Image(systemName: self.up ? "chevron.down":"chevron.up")
                                    .resizable()
                                    .frame(width: 40, height: 20)
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                        
                        Rectangle()
                            .fill(.white)
                            .overlay
                        {
                            List
                            {
                                ForEach(1..<21)
                                {
                                    index in
                                    Text("\(index)")
                                        .font(.largeTitle)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .listStyle(.inset)
                            .padding(.top, self.up ? 0:100)
                        }
                    }
                    
                    VStack
                    {
                        VStack
                        {
                            Text("TITLE")
                                .bold()
                                .font(.largeTitle)
                            
                            Text("SUBTITLE")
                                .font(.title3)
                            
                            Capsule().frame(height: 1)
                        }
                        .foregroundColor(self.up ? .white:.black)
                        .background(.clear)
                        .offset(y: self.up ? -250:-75)
                    }
                }
                .presentationContentInteraction(.scrolls)
                .presentationCornerRadius(20)
                .presentationDragIndicator(.visible)
            }
        }
    }
}
struct SwiftUIView_Previews: PreviewProvider
{
    static var previews: some View
    {
        SwiftUIView()
    }
}
