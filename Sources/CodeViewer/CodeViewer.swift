import SwiftUI
import WebKit

#if os(OSX)
    import AppKit
    public typealias ViewRepresentable = NSViewRepresentable
#elseif os(iOS)
    import UIKit
    public typealias ViewRepresentable = UIViewRepresentable
#endif


public struct CodeViewer: ViewRepresentable {
    
    private var content: String
    private let mode: CodeWebView.Mode
    private let darkTheme: CodeWebView.Theme
    private let lightTheme: CodeWebView.Theme
    private let isReadOnly: Bool
    private let fontSize: Int
    private let codeView = CodeWebView()

    @Environment(\.colorScheme) var colorScheme

    public init(
        content: String,
        mode: CodeWebView.Mode = .json,
        darkTheme: CodeWebView.Theme = .solarized_dark,
        lightTheme: CodeWebView.Theme = .solarized_light,
        isReadOnly: Bool = false,
        fontSize: Int = 12
    ) {
        self.content = content
        self.mode = mode
        self.darkTheme = darkTheme
        self.lightTheme = lightTheme
        self.isReadOnly = isReadOnly
        self.fontSize = fontSize
    }
    
    func getWebView() -> CodeWebView {
        codeView.setContent(content)
        codeView.setReadOnly(isReadOnly)
        codeView.setMode(mode)
        codeView.setFontSize(fontSize)
        
        colorScheme == .dark ? codeView.setTheme(darkTheme) : codeView.setTheme(lightTheme)

        return codeView
    }

    public func makeNSView(context: Context) -> CodeWebView {
        getWebView()
    }
    
    public func updateNSView(_ webview: CodeWebView, context: Context) {
        colorScheme == .dark ? codeView.setTheme(darkTheme) : codeView.setTheme(lightTheme)
    }
    
    public func makeUIView(context: Context) -> CodeWebView {
        getWebView()
    }
    
    public func updateUIView(_ webview: CodeWebView, context: Context) {
        colorScheme == .dark ? codeView.setTheme(darkTheme) : codeView.setTheme(lightTheme)
    }
}

#if DEBUG
struct CodeViewer_Previews : PreviewProvider {
    static private var jsonString = """
    {
        "hello": "world"
    }
    """
    static var previews: some View {
        CodeViewer(content: jsonString)
    }
}
#endif
