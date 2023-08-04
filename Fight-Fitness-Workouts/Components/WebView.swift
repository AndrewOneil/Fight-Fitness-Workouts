import SwiftUI
import WebKit

//Webview is used to create embedded youtube videos
struct WebView: UIViewRepresentable {
    let url: URL
    
    //video player configured to play inline on the same view as timer
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
            configuration.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        return webView
    }
    
    //loads the url into the video player by passing url in as a request
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "https://www.youtube.com/embed/kbgkeTTSau8")!)
    }
}
