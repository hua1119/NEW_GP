//.foregroundColor(Color(red: 0.995, green: 0.477, blue: 0.33))深橘色
//.foregroundColor(Color(red: 0.994, green: 0.689, blue: 0.418))淺橘色
//.foregroundColor(Color(red: 0.983, green: 0.821, blue: 0.411))黃色
//.foregroundColor(Color(red: 0.574, green: 0.609, blue: 0.386))綠色
//


import SwiftUI
import FirebaseAuth

//登入畫面
struct SiginView: View
{
    @AppStorage("uid") var userID: String = ""
    
    //AppStorage signIn -> Bool
    @AppStorage("signIn") private var signIn: Bool = false
    //同步用戶頭貼
    @AppStorage("userImage") private var userImage: Data?
    
    //開啟「忘記密碼」的狀態
    @State private var forget: Bool=false
    //帳號密碼審核狀態
    @State private var valid: Bool=false
    //帳號及密碼
    
    @State private var information: (String, String)=("", "")
    //警示提示視窗
    @State private var showAlert = false
    //提示訊息
    @State private var alertMessage:String?
    
    //手機儲存「記住我」狀態
    @State private var remember: Bool=false //之後要改
    @State private var account: String = ""
    @State private var password: String = ""
    
    //MARK: 檢查帳密
    private func signIn() async
    {
//        Auth.auth().signIn(withEmail: self.information.0, password: self.information.1) {(success, error) in
//            if let error {
//                self.alertMessage=error.localizedDescription
//            } else {
//                DispatchQueue.main.async {
//                    self.alertMessage="Sign in success!"
//                    self.showAlert.toggle()
//                }
//            }
//        }
//    }
        Auth.auth().signIn(withEmail: account, password: password)
        {authResult, error in
            if let error = error
            {
                print(error)
                return
            }
            else if let authResult = authResult
            {
                print(authResult.user.uid)
                userID = authResult.user.uid

                withAnimation(.easeInOut)
                {
                    self.signIn=true
                }
            }
        }
    }
    
    var body: some View
    {
        NavigationStack
        {
            if(self.signIn)
            {
                ContentView().transition(.opacity)
            }
            else
            {
                VStack(spacing: 20)
                {
                    //MARK: logo
                    //                    Image()
                    //                        .resizable()
                    //                        .scaledToFit()
                    //                        .frame(width: 150)
                    //                        .background(.gray)
                    //                        .clipShape(Circle())
                    //                        .padding(.bottom, 50)
                    
                    Circle()
                        .fill(.gray)
                        .scaledToFit()
                        .frame(width: 150)
                        .padding(.bottom, 50)
                    
                    VStack(spacing: 30)
                    {
                        //MARK: 帳號
                        TextField("帳號...", text: self.$account)
                            .scrollContentBackground(.hidden)
                            .padding()
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                        
                        //MARK: 密碼
                        SecureField("密碼...", text: self.$password)
                            .scrollContentBackground(.hidden)
                            .padding()
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                    }
                    .font(.title3)
                    
                    NavigationLink(destination:signupView())
                    {
                        Text("尚未註冊嗎？請點擊我")
                            .font(.body)
                            .foregroundColor(Color(red: 0.574, green: 0.609, blue: 0.386))
                            .colorMultiply(.gray)
                    }
                    HStack
                    {
                        //MARK: 記住我
                        HStack
                        {
                            Circle()
                                .fill(Color(.systemGray6))
                                .frame(width: 20)
                                .overlay
                            {
                                Circle()
                                    .fill(.blue)
                                    .padding(5)
                                    .opacity(self.remember ? 1:0)
                            }
                            .onTapGesture
                            {
                                withAnimation(.easeInOut)
                                {
                                    self.remember.toggle()
                                }
                            }
                            
                            Text("記住我").font(.callout)
                        }
                        
                        Spacer()
                        
                        //MARK: 忘記密碼
                        Button("忘記密碼？")
                        {
                            self.forget.toggle()
                        }
                        .font(.callout)
                    }
                    .sheet(isPresented: self.$forget)
                    {
                        ForgetPasswordView()
                            .presentationDetents([.medium])
                            .presentationCornerRadius(30)
                    }
                    //MARK: 登入
                    Button
                    {
                        Task {
                            await self.signIn()
                        }
                    }
                label:
                    {
                        Text("登入")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.828, green: 0.249, blue: 0.115))
                            .clipShape(Capsule())
                    }
                    
                    //MARK: Circle
                    HStack
                    {
                        ForEach(0..<3)
                        {index in
                            Circle()
                                .fill(Color(.systemGray3))
                                .scaledToFit()
                                .frame(height: 50)
                            
                            if(index<2)
                            {
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, 30)
                .alert("Sign In Message!", isPresented: self.$showAlert) {
                    Button("DISMISS") {
                        withAnimation(.easeInOut) {
                            self.signIn=true
                        }
                    }
                } message: {
                    if let text=self.alertMessage {
                        Text(text)
                    }
                }
                .navigationTitle(self.signIn ? "Home":"Sign In")
                .navigationBarTitleDisplayMode(.large)
                .transition(.opacity)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider
{
    static var previews: some View
    {
        SiginView()
    }
}
