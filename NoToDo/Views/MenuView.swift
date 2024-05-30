//
//  MenuView.swift
//  TodoDark
//
//  Created by Kodgem Technology on 30.03.2022.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 30){
            
            HStack {
                Image("menuFaceProfile")
                    .resizable()
                    .frame(width: 130, height: 130, alignment: .center)
                .padding()
                
                VStack {
                    Image(systemName: "circle")
                        .resizable()
                        .frame(width: 56, height: 56, alignment: .center)
                    .foregroundColor(Color(red: 0.233, green: 0.304, blue: 0.517))
                    .font(Font.system(size: 60, weight: .thin))
                    .overlay(
                        Image("arrowBack").resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            
                    )
                    
                    Spacer()
                }
            }
            .frame(maxWidth: 250, maxHeight: 150)
            
            Text("Furkan Durmaz")
                .frame(maxWidth: 150)
                .foregroundColor(.white)
                .font(.system(size: 40, weight: .semibold))
                .padding(.leading)
            
            HStack {
                Image(systemName: "bookmark")
                    .resizable()
                    .frame(width: 22, height: 30)
                    .foregroundColor(Color(red: 0.304, green: 0.391, blue: 0.588))
                .padding(.leading)
                .font(Font.system(size: 60, weight: .thin))

                
                Text("Templates")
                    .font(.system(size: 19, weight: .regular))
                    .foregroundColor(.white)
                    .padding(.leading)
            }
            HStack {
                Image("categories")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundColor(Color(red: 0.304, green: 0.391, blue: 0.588))
                .padding(.leading)
                
                Text("Categories")
                    .font(.system(size: 19, weight: .regular))
                    .foregroundColor(.white)
                    .padding(.leading)
            }
            
            
            
            
        }.frame(maxWidth : .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color(red: 0.03, green: 0.124, blue: 0.347))
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
