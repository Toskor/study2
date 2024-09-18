
import SwiftUI
import WebKit



struct SimpleWebView {
    let url: URL
    
    func makeWebView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    class Coordinator: NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                print(url)
            }
            decisionHandler(.allow)
        }
    }
}

#if os(macOS)
extension SimpleWebView: NSViewRepresentable {
    func makeNSView(context: Context) -> WKWebView {
        makeWebView(context: context)
    }
   
    func updateNSView(_ uiView: WKWebView, context: Context) {
    }
}
#elseif os(iOS)
extension SimpleWebView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        makeWebView(context: context)
    }
   
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
#endif

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleWebView(url: URL(string: "https://google.com")!)
    }
}


 
