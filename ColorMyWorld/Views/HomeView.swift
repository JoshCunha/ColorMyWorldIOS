//
//  HomeView.swift
//  ColorMyWorld
//
//  Created by Joshua Cunha on 2023-11-07.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Welcome!").font(.system(size: 50)).bold()
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.gray.opacity(0.7))
                    VStack {
                        Image(systemName: "photo")
                            .foregroundColor(Color.black)
                            .font(.system(size: 50))
                        Text("Upload a Picture")
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                            .bold()
                    }
                }.frame(width: UIScreen.main.bounds.width - 80, height: 100)
            }
            
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.gray.opacity(0.7))
                    VStack {
                        Image(systemName: "camera")
                            .foregroundColor(Color.black)
                            .font(.system(size: 50))
                        Text("Take a Photo")
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                            .bold()
                    }
                }.frame(width: UIScreen.main.bounds.width - 80, height: 100)
            }
            
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.gray.opacity(0.7))
                    VStack {
                        Image(systemName: "safari")
                            .foregroundColor(Color.black)
                            .font(.system(size: 50))
                        Text("Get Random Image")
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                            .bold()
                    }
                }.frame(width: UIScreen.main.bounds.width - 80, height: 100)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
