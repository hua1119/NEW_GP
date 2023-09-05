//
//  Mydata.swift
//  Graduation_Project
//
//  Created by Mac on 2023/8/23.
//

import SwiftUI

struct MydataView: View
{
    @Binding var information: Information
    @Environment(\.dismiss) private var dismiss
    @State private var success: Bool = false
    @State private var temporary: [Any] = ["", "", "", "", "", ""]
    
    @State private var ageSelection: Int = 0 // 用于年龄选择的属性
    
    @State private var textFieldValue: [String] = ["", "", "", "", "", ""]
    
    private func setListView(index: Int) -> some View
    {
        if(index==0 || (index>=5 && index<=5))
        {
            return AnyView(TextField("", text: Binding<String>(
                get: { self.textFieldValue[index] },
                set: { self.textFieldValue[index] = $0 }
            )))
        }
        else if(index==1)
        {
            return AnyView(
                Picker("性別", selection: $textFieldValue[index]) // 更新为 Picker，使用 textFieldValue 绑定
                {
                    Text("男性").tag("男性")
                    Text("女性").tag("女性")
                    Text("隱私").tag("隱私")
                }
                    .pickerStyle(.wheel)
                    .frame(width: 330, height: 43)
            )
        }
        else if(index==2)
        {
            return AnyView(
                Picker("年齡", selection: $ageSelection) // 更新为 Picker，使用 ageSelection 绑定
                {
                    ForEach(0..<120) { age in
                        Text("\(age)歲").tag(age)
                    }
                }
                    .pickerStyle(.wheel)
                    .frame(width: 330, height: 43)
            )
        }
        else if(index==3 || index==4)
        {
            return AnyView(
                HStack
                {
                    TextField("", text: Binding<String>(
                        get: { self.textFieldValue[index] },
                        set: { self.textFieldValue[index] = $0 }
                    ))
                    Stepper("", value: Binding<Double>(
                        get:
                            {
                                let stringValue = self.textFieldValue[index]
                                return Double(stringValue) ?? 0.0
                            },
                        set:
                            {
                                newValue in self.textFieldValue[index] = "\(newValue)"
                            }
                    ), in: 0...230)
                }
            )
        }
        else if(index==5)
        {
            return AnyView(TextField("", text: Binding<String>(
                get: { self.textFieldValue[index] },
                set: { self.textFieldValue[index] = $0 }
            )))
        }
        else
        {
            return AnyView(Text("ERROR"))
        }
    }
    
    private func setSection(index: Int) -> String
    {
        switch(index)
        {
        case 0:
            return "名字"
        case 1:
            return "性別"
        case 2:
            return "年齡"
        case 3:
            return "身高"
        case 4:
            return "體重"
        case 5:
            return "手機號碼"
        default:
            return ""
        }
    }
    
    private func updateInformation() async
    {
        information.name = textFieldValue[0]
        information.gender = textFieldValue[1]
        information.age = ageSelection // 使用 ageSelection 属性
        if let height = Double(textFieldValue[3]) {
            information.height = CGFloat(height)
        }
        if let weight = Double(textFieldValue[4]) {
            information.weight = CGFloat(weight)
        }
        information.phone = textFieldValue[5]
    }
    
    var body: some View
    {
        ZStack
        {
            List
            {
                ForEach(0..<temporary.count, id: \.self) { index in
                    Section(setSection(index: index))
                    {
                        setListView(index: index)
                    }
                    .headerProminence(.increased)
                }
                
                Button("確認")
                {
                    Task
                    {
                        await self.updateInformation()
                    }
                    success.toggle()
                }
                .frame(maxWidth: .infinity)
            }
            .font(.title3)
            .alert("修改成功", isPresented: $success)
            {
                Button("確認")
                {
                    dismiss()
                }
            }
        }
        .navigationTitle("編輯個人資料")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear
        {
            textFieldValue[0] = information.name
            textFieldValue[1] = information.gender
            ageSelection = information.age // 设置初始选择的年龄
            textFieldValue[3] = "\(information.height)"
            textFieldValue[4] = "\(information.weight)"
            textFieldValue[5] = information.phone
        }
    }
}

struct MydataView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationStack
        {
            MydataView(
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
