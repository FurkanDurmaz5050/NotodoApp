//
//  LogInView.swift
//  MyToDoList
//
//  Created by Kodgem Technology on 4.02.2022.
//

import SwiftUI
import Introspect


struct LogInView: View {
    enum FocusField: Hashable {
        case field
    }
    @State var textLogInEmail:String = ""
    @State var textLogInPassword:String = ""
    @State var isSignUpView:Bool = false
    @State var isSecureField:Bool = true
    
    
    
    @FocusState private var focusedField: FocusField?
    
    @EnvironmentObject var taskManager: TaskManager
    @State var showSpotlight:Bool = false
       @State var currentSpot:Int = 0
    
    
    var body: some View {
        VStack{
            
            Text("LOG IN")
                .font(.title.bold())
                .addSpotlight(0, shape: .rounded, roundedRadius: 10, text: Text("Furkan"), placeholderAlignment: .bottom)


            
            TextField("Email",text: $textLogInEmail)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(.white)
                .cornerRadius(30)
                .disableAutocorrection(true)
                .overlay(
                    Capsule(style: .continuous)
                        .stroke(Color.black, style: StrokeStyle(lineWidth: 1))
                )
                .introspectTextField { textfield in
                    textfield.returnKeyType = .done
                }
                .onSubmit {
                    if textLogInEmail != "" && textLogInPassword != "" {
                        
                        taskManager.loginFB(textLogInEmail: textLogInEmail, textLogInPassword: textLogInPassword)
                        print("başarılı")
                        
                    }
                    
                    
                }
                .multilineTextAlignment(.center)
                .focused(self.$focusedField, equals: .field)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                        self.focusedField = .field
                    }
                }
                .padding()
                .addSpotlight(1, shape: .rounded, roundedRadius: 10, text:Text("Furkan"),placeholderAlignment: .bottom)


                .padding(.top, 60)
                

            
            
            if isSecureField{
                SecureField("Password",text: $textLogInPassword)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.white)
                    .cornerRadius(30)
                    .disableAutocorrection(true)
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(Color.black, style: StrokeStyle(lineWidth: 1))
                    )
                    .introspectTextField { textfield in
                        textfield.returnKeyType = .done
                    }
                    .onSubmit {
                        if textLogInEmail != "" && textLogInPassword != "" {
                            
                            taskManager.loginFB(textLogInEmail: textLogInEmail, textLogInPassword: textLogInPassword)
                            print("Başarılı")
                        }
                        
                    }
                    .multilineTextAlignment(.center)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                            self.focusedField = .field
                        }
                    }
                    .padding()
                    .overlay{
                        HStack{
                            Spacer()
                            
                            Image(systemName: "eye.slash")
                                .onTapGesture {
                                    isSecureField = false
                                }
                        }.padding(.horizontal, 30)
                            

                    }
                    .addSpotlight(2, shape: .rounded, roundedRadius: 10, text: Text("rnjrjkjnkrnjnj"),placeholderAlignment: .top)
            } else{
                TextField("Password",text: $textLogInPassword)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.white)
                    .cornerRadius(30)
                    .disableAutocorrection(true)
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(Color.black, style: StrokeStyle(lineWidth: 1))
                    )
                    .introspectTextField { textfield in
                        textfield.returnKeyType = .done
                    }
                    .onSubmit {
                        if textLogInEmail != "" && textLogInPassword != "" {
                            
                            taskManager.loginFB(textLogInEmail: textLogInEmail, textLogInPassword: textLogInPassword)
                            print("Başarılı")
                        }
                        
                    }
                    .multilineTextAlignment(.center)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                            self.focusedField = .field
                        }
                    }
                    .padding()
                    .overlay{
                        HStack{
                            Spacer()
                            
                            Image(systemName: "eye")
                                .onTapGesture {
                                    isSecureField = true
                                }
                                
                        }.padding(.horizontal, 30)
                    }
                    .addSpotlight(2, shape: .rounded, roundedRadius: 10, text:Text("Furkan"),placeholderAlignment: .top)
            }
            
            
            
            HStack{
                NavigationLink {
                    ResetPasswordView()
                } label: {
                    Text("Reset Password")
                        .foregroundColor(.black.opacity(0.4))
                        .padding()
                        .addSpotlight(3, shape: .rounded, roundedRadius: 10, text:Text("Furkan"),placeholderAlignment: .top)
                    
                }
                
                Spacer()
                
                Text("Create New Account")
                    .foregroundColor(.black.opacity(0.4))
                    .padding()
                    .onTapGesture {
                        isSignUpView = true
                    }
                    .sheet(isPresented: $isSignUpView) {
                        SignUpView()
                            .environmentObject(taskManager)
                    }
                
            }
            
            
            if taskManager.logInErrorText != "" {
                Text("Error : \(taskManager.logInErrorText)")
                    .foregroundColor(.red)
                    .animation(.easeInOut)
            }
            
            
            
            Spacer()
            
            VStack {
                Text("Log In")
                    .font(.title3)
                    .foregroundColor(.blue)
            }
            .frame(maxWidth:.infinity, maxHeight: 60)
            .background(.cyan.opacity(0.3))
            .cornerRadius(30)
            .padding()
            .onTapGesture {
                
                if textLogInEmail != "" && textLogInPassword != "" {
                    
                    taskManager.loginFB(textLogInEmail: textLogInEmail, textLogInPassword: textLogInPassword)
                    
                    
                    
                    
                    
                    
                }
                else{
                    print("Boş bıraktınız!!")
                }
            }
            
            
            
        }.frame(maxWidth:.infinity, maxHeight: .infinity)
            .background(Color(red: 0.968, green: 0.973, blue: 0.986))
            .addSpotlightOverlay(show: $showSpotlight, currentSpot: $currentSpot)
                    .onAppear(){
                        showSpotlight = true
                    }
        
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
