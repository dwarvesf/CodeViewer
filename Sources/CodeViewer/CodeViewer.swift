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
    
    @Binding var content: String
    @State private var firstInit = true
    
    private let mode: CodeWebView.Mode
    private let darkTheme: CodeWebView.Theme
    private let lightTheme: CodeWebView.Theme
    private let isReadOnly: Bool
    private let fontSize: Int
    private let codeView = CodeWebView()
    
    var textDidChanged: ((String) -> Void)?

    @Environment(\.colorScheme) var colorScheme

    public init(
        content: Binding<String>,
        mode: CodeWebView.Mode = .json,
        darkTheme: CodeWebView.Theme = .solarized_dark,
        lightTheme: CodeWebView.Theme = .solarized_light,
        isReadOnly: Bool = false,
        fontSize: Int = 12,
        textDidChanged: ((String) -> Void)? = nil
    ) {
        self._content = content
        self.mode = mode
        self.darkTheme = darkTheme
        self.lightTheme = lightTheme
        self.isReadOnly = isReadOnly
        self.fontSize = fontSize
        self.textDidChanged = textDidChanged
    }
    
    private func getWebView() -> CodeWebView {
        codeView.setReadOnly(isReadOnly)
        codeView.setMode(mode)
        codeView.setFontSize(fontSize)

        colorScheme == .dark ? codeView.setTheme(darkTheme) : codeView.setTheme(lightTheme)
        
        return codeView
    }
    
    private func updateView() {
        if firstInit {
            DispatchQueue.main.async {
                codeView.setContent(content)
                codeView.clearSelection()
                firstInit = false
            }
        }
        
        colorScheme == .dark ? codeView.setTheme(darkTheme) : codeView.setTheme(lightTheme)
        
        codeView.textDidChanged = { text in
            content = text
            self.textDidChanged?(text)
        }
    }
    
    
    // MARK: macOS
    public func makeNSView(context: Context) -> CodeWebView {
        getWebView()
    }
    
    public func updateNSView(_ webview: CodeWebView, context: Context) {
        updateView()
    }
    
    // MARK: iOS
    public func makeUIView(context: Context) -> CodeWebView {
        getWebView()
    }
    
    public func updateUIView(_ webview: CodeWebView, context: Context) {
        updateView()
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
        CodeViewer(content: .constant(jsonString))
    }
}
#endif
