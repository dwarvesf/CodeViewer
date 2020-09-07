//
//  ContentView.swift
//  CodeViewer
//
//  Created by phucld on 8/20/20.
//  Copyright © 2020 Dwarves Foundattion. All rights reserved.
//

import SwiftUI
import CodeViewer

struct ContentView: View {
    @State private var json = ""
    
    var body: some View {
        CodeViewer(
            content: $json,
            mode: .json,
            darkTheme: .solarized_dark,
            lightTheme: .solarized_light,
            isReadOnly: true,
            fontSize: 13
        )
        .onAppear {
            json = """
            {
                "hello": "world"
            }
            """
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
