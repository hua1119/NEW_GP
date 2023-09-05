////  _Color.swift
////  Graduation_Project
////
////  Created by Mac on 2023/8/23.
////
//
//import Foundation
//import SwiftUI
//
//struct CustomToogleStyle: ToggleStyle
//{
//    func makeBody(configuration: Configuration) -> some View
//    {
//            ZStack
//            {
//                RoundedRectangle(cornerRadius: 20,style: .continuous).frame(width: 150, height: 40)
//                    .foregroundColor(configuration.isOn ? .black:.white)
//
//
//                RoundedRectangle(cornerRadius: 20,style: .continuous)
//                    .foregroundColor(configuration.isOn ? .black:.white)
//                    .animation(.easeInOut, value: configuration.isOn)
//                    .frame(width: 92, height: 44)
//                    .offset(x:configuration.isOn ? 30:-50)
//                    .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
//
//
//                HStack
//                {
//                    Text(" 淺色模式")
//                        .bold()
//                        .font(.system(size: 15))
//                        .foregroundColor(configuration.isOn ? .gray:.white)
//
//                    Spacer()
//
//                    Text("深色模式")
//                        .bold()
//                        .font(.system(size: 15))
//                        .foregroundColor(configuration.isOn ? .black:.gray)
//
//                }
//                .frame(width: 135)
//            }
//
//            .onTapGesture
//            {
//                withAnimation(.easeInOut(duration: 0.2))
//                {
//                    configuration.isOn.toggle()
//                }
//            }
//        }
//    }
