//
//  HealthyView.swift
//  Graduation_Project
//
//  Created by Mac on 2023/8/24.
//

import SwiftUI

struct HealthyView: View
{

    var body: some View
    {
        VStack(spacing:40)
        {
            //用戶頭像
            HStack
            {
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: 150,height: 150)
            }
            
            //用戶名稱
            Text("秋雨")
            
            NavigationStack
            {
                VStack(spacing:50)
                {
                    //MARK: 導航頁面
                    NavigationLink(destination: BMIView())
                    {
                        HealthyButton(title: "BMI")
                    }
                    
                    NavigationLink(destination: KcalView())
                    {
                        HealthyButton(title: "卡路里")
                    }
                    NavigationLink(destination: BodyView())
                    {
                        HealthyButton(title: "身體素質")
                    }
                    NavigationLink(destination: SwiftUIView())
                    {
                        HealthyButton(title: "未來展望")
                    }
                    
                }
                
                Spacer()
            }
        }
    }
}

struct HealthyView_Previews: PreviewProvider
{
    static var previews: some View
    {
        HealthyView()
    }
}
