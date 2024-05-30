//
//  ResetPasswordView.swift
//  CoachingApp
//
//  Created by Kodgem Technology on 18.11.2022.
//

import SwiftUI

struct ResetPasswordView: View {
    @StateObject var authManager = AuthManager()

    @State var emailText = ""
    var body: some View {
        VStack(spacing: 20) {
            Text("Emailini Gir")
           
            
            TextField("Email", text: $emailText)
            
            Button("Mail Gönder") {
                authManager.resetPassword(email: emailText)
            }
            Text("Not: Mail, Gelen Kutunuzda 'Spam' Sekmesine Düşmüş Olabilir Orayı da Kontrol Ediniz.")
                .font(.system(size: 10))
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
