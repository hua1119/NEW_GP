//
//  BodyView.swift
//  Graduation_Project
//
//  Created by Mac on 2023/8/29.
//

import SwiftUI

struct BodyView: View
{
    @State private var uricAcidChecked = false
    @State private var Hypertension = false
    @State private var Hyperglycemia = false
    @State private var Hyperlipidemia = false
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: 20)
        {
            HStack
            {
                Toggle("", isOn: $uricAcidChecked)
                    .toggleStyle(CheckBoxToggleStyle(shape: .square))
                Text("  尿酸")
                
            }
            
            HStack
            {
                Toggle("", isOn: $Hypertension)
                    .toggleStyle(CheckBoxToggleStyle(shape: .square))
                Text("  高血壓")
                
            }
            
            HStack
            {
                Toggle("", isOn: $Hyperglycemia)
                    .toggleStyle(CheckBoxToggleStyle(shape: .square))
                Text("  高血糖")
            }
            
            HStack
            {
                Toggle("", isOn: $Hyperlipidemia)
                    .toggleStyle(CheckBoxToggleStyle(shape: .square))
                Text("  高血脂")
            }
        }
        .padding()
    }
    
    struct CheckBoxToggleStyle: ToggleStyle
    {
        enum CheckBoxShape: String
        {
            case circle
            case square
        }
        let shape : CheckBoxShape
        init(shape: CheckBoxShape = .circle)
        {
            self.shape = shape
        }
        //configuration中包含isOn和label
        func makeBody(configuration: Configuration) -> some View
        {
            let systemName:String = configuration.isOn ? "checkmark.\(shape.rawValue).fill" : shape.rawValue
            Button(action:
            {
                configuration.isOn.toggle()
            }) {
                configuration.label
                Image(systemName: systemName)
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
}



struct BodyView_Previews: PreviewProvider
{
    static var previews: some View
    {
        BodyView()
    }
}
