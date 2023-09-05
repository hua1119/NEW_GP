//
//  SigninView.swift
//  Graduation_Project
//
//  MARK: 註冊 Created by Mac on 2023/8/20.
//

import SwiftUI
import FirebaseAuth
struct signupView: View
{
    @AppStorage("uid") var userID: String = ""
    
    //關閉當前畫面
    @Environment(\.dismiss)private var dismiss
    
    //警示提示視窗
    @State private var showAlert: Bool=false
    @State private var success: Bool=false
    //提示訊息
    @State private var alertMessage: String=""
    //帳號
    @State private var account: String=""
    //密碼
    @State private var password: String=""
    //密碼驗證
    @State private var againpassword: String=""
    @State private var users: [(account:String,password:String,againpassword:String)]=[]
    
    //MARK: 想確認帳號是否被註冊過(以後處理）
    
    //MARK: 驗證密碼
    private func passcheck() -> Bool
    {
        return !self.password.isEmpty && self.password==self.againpassword
    }
    
    var body: some View
    {
        NavigationStack
        {
            VStack(spacing: 60)
            {
                //Logo
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: 150,height: 150)
                    .padding(.top,-90)
                
                //Image("our logo")
                VStack(spacing: 20)
                {
                    TextField("輸入您的帳號", text: self.$account)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .frame(width: 300, height: 50)
                        .cornerRadius(100)
                    
                    SecureField("輸入您的密碼", text: self.$password)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .frame(width: 300, height: 50)
                        .cornerRadius(100)
                        .lineLimit(10)
                    
                    SecureField("再次輸入密碼", text: self.$againpassword)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .frame(width: 300, height: 50)
                        .cornerRadius(100)
                    
                }
                
                Button("註冊")
                {
                    Auth.auth().createUser(withEmail: account, password: password)
                    {
                        authResult, error in
                        if let error = error
                        {
                            print(error)
                            return
                        }
                        if let authResult = authResult
                        {
                            print(authResult.user.uid)
                            userID = authResult.user.uid
                        }
                    }
                    if(self.account.isEmpty || self.password.isEmpty || self.againpassword.isEmpty)
                    {
                        self.showAlert=true
                        self.alertMessage="請填寫所有欄位"
                    }
                    else if(self.password.count<4)
                    {
                        self.showAlert=true
                        self.alertMessage="密碼需大於4字元"
                    }
                    else if(!self.passcheck())
                    {
                        self.showAlert=true
                        self.alertMessage="密碼不相符"
                    }
                    else
                    {
                        users.append((account: self.account, password: self.password, againpassword: self.againpassword))
                        self.showAlert=true
                        self.alertMessage="註冊成功!"
                        self.success=true
                        
                        //關閉畫面
                        if(self.passcheck())
                        {
                            self.dismiss()
                        }
                    }
                }
                .foregroundColor(Color.white)
                .padding(10)
                .frame(width: 300, height: 50)
                .background(Color(red: 0.828, green: 0.249, blue: 0.115))
                .cornerRadius(100)
                .font(.title3)
                .alert(isPresented: self.$showAlert)
                {
                    Alert(
                        title: Text(alertMessage),
                        dismissButton: .default(Text("確認")))
                }
            }
        }
        .padding()
        .navigationTitle(Text("註冊"))
        .navigationBarTitleDisplayMode(.inline)
    }
}
struct signupView_Previews: PreviewProvider
{
    static var previews: some View
    {
        signupView()
    }
}
