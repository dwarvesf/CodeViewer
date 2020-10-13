//
//  ContentView.swift
//  CodeViewerExample-iOS
//
//  Created by Phuc on 07/09/2020.
//  Copyright © 2020 Dwarves Foundattion. All rights reserved.
//

import SwiftUI
import CodeViewer

struct ContentView: View {
    
    @State private var json =  """
        {
            "hello": "world"
        }
        """
    
    var body: some View {
        CodeViewer(
            content: $json,
            mode: .json,
            darkTheme: .solarized_dark,
            lightTheme: .solarized_light,
            isReadOnly: true,
            fontSize: 54
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
