//
//  InformationLabel.swift
//  Graduation_Project
//
//  Created by Mac on 2023/8/29.
//

import SwiftUI

struct InformationLabel: View
{
    let image: String
    let label: String

    var body: some View
    {
        HStack(spacing: 20)
        {
            Image(systemName: self.image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)

            Text(self.label)
                .bold()
                .font(.body)

            Spacer()
        }
    }
}

struct InformationLabel_Previews: PreviewProvider
{
    static var previews: some View
    {
        InformationLabel(image: "person.fill", label: "Name")
    }
}
