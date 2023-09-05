//
//  MemberView.swift
//
//  Created by on 2023/8/28.
//

import SwiftUI
import PhotosUI

struct MemberView: View
{
    @AppStorage("userImage") private var userImage: Data?
    
    @Binding var select: Int
    @Binding var information: Information
    
    @State private var pickImage: PhotosPickerItem?
    
    private let label: [InformationLabel]=[
        InformationLabel(image: "person.fill", label: "名稱"),
        InformationLabel(image: "figure.arms.open", label: "性別"),
        InformationLabel(image: "birthday.cake.fill", label: "年齡"),
        InformationLabel(image: "ruler", label: "身高"),
        InformationLabel(image: "dumbbell", label: "體重"),
        InformationLabel(image: "phone", label: "手機號碼")
    ]
    private let tag: [String]=["高血壓", "尿酸", "高血脂", "美食尋寶家", "7日打卡"]
    
    //MARK: 設定顯示資訊
    private func setInformation(index: Int) -> String
    {
        switch(index)
        {
            case 0:
                return self.information.name
            case 1:
                return self.information.gender
            case 2:
                return "\(self.information.age)"
            case 3:
                return "\(self.information.height)"
            case 4:
                return "\(self.information.weight)"
            case 5:
                return self.information.phone
            default:
                return ""
        }
    }
    
    var body: some View
    {
        VStack(spacing: 20)
        {
            //MARK: 頭像
            if let userImage=self.userImage,
               let image=UIImage(data: userImage)
            {
                PhotosPicker(selection: self.$pickImage, matching: .any(of: [.images, .livePhotos]))
                {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .background(.gray)
                        .clipShape(Circle())
                }
                .onChange(of: self.pickImage)
                {image in
                    Task
                    {
                        if let data=try? await image?.loadTransferable(type: Data.self)
                        {
                            self.userImage=data
                        }
                    }
                }
            }
            else
            {
                PhotosPicker(selection: self.$pickImage, matching: .any(of: [.images, .livePhotos]))
                {
                    Circle()
                        .fill(.gray)
                        .scaledToFit()
                        .frame(width: 200)
                }
                .onChange(of: self.pickImage)
                {image in
                    Task
                    {
                        if let data=try? await image?.loadTransferable(type: Data.self)
                        {
                            self.userImage=data
                        }
                    }
                }
            }
            
            //MARK: 標籤
            VStack(spacing: 20)
            {
                HStack(spacing: 20)
                {
                    ForEach(0..<3)
                    {index in
                        Capsule()
                            .fill(.white)
                            .frame(width: 100, height: 30)
                            .shadow(color: .gray, radius: 3, y: 3)
                            .overlay(Text(self.tag[index]))
                    }
                }
                
                HStack(spacing: 20)
                {
                    ForEach(3..<5)
                    {index in
                        Capsule()
                            .fill(.white)
                            .frame(width: 100, height: 30)
                            .shadow(color: .gray, radius: 3, y: 3)
                            .overlay(Text(self.tag[index]))
                    }
                }
            }
            
            //MARK: 使用者資訊
            List
            {
                ForEach(self.label.indices, id: \.self)
                {index in
                    HStack
                    {
                        self.label[index]
                        
                       Text(self.setInformation(index: index)).foregroundColor(.gray)
                    }
                    .frame(height: 40)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
}

struct MemberView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationStack
        {
            MemberView(
                select: .constant(2),
                information: .constant(
                    Information(
                        name: "Justin",
                        gender: "男性",
                        age: 21,
                        height: 170,
                        weight: 53,
                        phone: "0800012000"
                    )
                )
            )
        }
    }
}
