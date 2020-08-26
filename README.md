# CodeViewer

A code viewer

<img width="712" alt="image" src="./misc/img.png">

## Features

- [x] Darkmode, lightmode adopt automatically
- [x] Syntax highlighting for over 110 languages (TextMate/Sublime Text.tmlanguage files can be imported)
- [x] Over 20 themes (TextMate/Sublime Text .tmtheme files can be imported)
- [x] Support SwiftUI

## Usage

```Swift
import SwiftUI
import CodeViewer

struct ContentView: View {
    private var json = """
    {
        "hello": "world"
    }
    """
    
    var body: some View {
        CodeViewer(content: json)
    }
}
```
