//
//  MainView.swift
//  ColorMyWorld
//
//  Created by Joshua Cunha on 2023-11-07.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            HomeView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
