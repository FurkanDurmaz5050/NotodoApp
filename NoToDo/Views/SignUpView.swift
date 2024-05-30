//
//  SignInView.swift
//  MyToDoList
//
//  Created by Kodgem Technology on 4.02.2022.
//

import SwiftUI

struct SignUpView: View {
    enum FocusField: Hashable {
        case mail
        case field
    }
    @State var textSignUpName:String = ""

    @State var textSignUpEmail:String = ""
    @State var textSignUpPassword:String = ""

    @FocusState private var focusedField: FocusField?
    
    @EnvironmentObject var taskManager: TaskManager
    @Environment(\.dismiss) var dismiss
    @State var isSecureField:Bool = true


    

    var body: some View {
        VStack{
            
            Text("SIGN UP")
                .font(.title.bold())
                .padding()
            
            TextField("İsim Soyisim",text: $textSignUpName)
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
                .multilineTextAlignment(.center)
                .focused(self.$focusedField, equals: .mail)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                        self.focusedField = .mail
                    }
                }
                .padding()
                .padding(.top, 60)
            
            TextField("Email",text: $textSignUpEmail)
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
                    if textSignUpEmail != "" && textSignUpPassword != "" && textSignUpName != ""  {
                        
                        taskManager.signUp(textEmail: textSignUpEmail, textPassword: textSignUpPassword, textName: textSignUpName)
                        print("başarılı")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                            if taskManager.isSignedIn{
                                dismiss()
                                taskManager.isSignedIn = false

                            }
                        }
                        
                        
                    }
                    
                    
                }
                .multilineTextAlignment(.center)
                .focused(self.$focusedField, equals: .field)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                        self.focusedField = .mail
                    }
                }
                .padding()
                .padding(.top, 60)

            if isSecureField{
                SecureField("Password",text: $textSignUpPassword)
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
                        if textSignUpEmail != "" && textSignUpPassword != "" && textSignUpName != "" {
                            
                            taskManager.signUp(textEmail: textSignUpEmail, textPassword: textSignUpPassword, textName: textSignUpName)
                                print("Başarılı")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                                if taskManager.isSignedIn{
                                    dismiss()
                                    taskManager.isSignedIn = false

                                }
                            }
                            
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
            } else {
                TextField("Password",text: $textSignUpPassword)
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
                        if textSignUpEmail != "" && textSignUpPassword != ""  && textSignUpName != "" {
                            
                            taskManager.signUp(textEmail: textSignUpEmail, textPassword: textSignUpPassword, textName: textSignUpName)
                                print("Başarılı")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                                if taskManager.isSignedIn{
                                    dismiss()
                                    taskManager.isSignedIn = false

                                }
                            }
                            
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
            }
            
            
            
            if taskManager.signUpErrorText != "" {
                Text("Error : \(taskManager.signUpErrorText)")
                    .foregroundColor(.red)
                    .animation(.easeInOut)
            }
            
            Spacer()
            
            VStack {
                Text("Sign Up")
                    .font(.title3)
                    .foregroundColor(.blue)
            }
            .frame(maxWidth:.infinity, maxHeight: 60)
            .background(.cyan.opacity(0.3))
            .cornerRadius(30)
            .padding()
            .onTapGesture {
                if textSignUpEmail != "" && textSignUpPassword != ""  && textSignUpName != "" {
                    
                    taskManager.signUp(textEmail: textSignUpEmail, textPassword: textSignUpPassword, textName: textSignUpName)
                        print("Başarılı")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {  /// Anything over 0.5 seems to work
                        if taskManager.isSignedIn{
                            dismiss()
                            taskManager.isSignedIn = false
                        }
                    }
                    
                }
                else{
                    print("Boş bıraktınız!!")
                }
            }
            
        
            
        }.frame(maxWidth:.infinity, maxHeight: .infinity)
            .background(Color(red: 0.968, green: 0.973, blue: 0.986))
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
