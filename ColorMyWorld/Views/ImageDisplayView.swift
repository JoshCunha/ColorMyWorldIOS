//
//  ImageDisplayView.swift
//  ColorMyWorld
//
//  Created by Joshua Cunha on 2023-11-14.
//

import SwiftUI

struct ImageDisplayView: View {
    @State private var saturationVal: Double = 1.0
    @State private var brightnessVal: Double = .zero
    
    var picture: Image?
    var body: some View {
        VStack {
            if let picture {
                picture
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: UIScreen.main.bounds.width - 10,
                        height: UIScreen.main.bounds.height/2
                    )
                    .saturation(saturationVal)
                    .brightness(brightnessVal)
            }
            HStack {
                Text("Saturation: ")
                Slider (
                    value: $saturationVal,
                    in: 1...10
                )
            }.padding(.leading, 10).padding(.trailing, 10)
            HStack {
                Text("Brightness: ")
                Slider (
                    value: $brightnessVal,
                    in: 0...1
                )
            }.padding(.leading, 10).padding(.trailing, 10)
        }
    }
}

struct ImageDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDisplayView(picture: Image(systemName: "photo"))
    }
}
