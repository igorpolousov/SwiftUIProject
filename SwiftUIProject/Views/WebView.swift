//
//  WebView.swift
//  SwiftUIProject
//
//  Created by Igor Polousov on 06.05.2022.
//

import Foundation
import Combine
import SwiftUI
import UIKit
import WebKit


struct VkWebView: UIViewRepresentable {
    var successCompletion: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    private var urlComponents: URLComponents = {
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "oauth.vk.com"
        urlComp.path = "/authorize"
        urlComp.queryItems = [
            URLQueryItem(name: "client_id", value: "7965537"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "336918"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.130"),
        ]
        return urlComp
    }()

    init(completion: @escaping () -> Void) {
        successCompletion = completion
    }

    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()

        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(makeCoordinator(), name: "iOSNative")
        configuration.preferences = preferences

        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)

        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        webView.navigationDelegate = context.coordinator

        return webView
    }

    func updateUIView(_ webView: WKWebView, context _: Context) {
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: VkWebView
        var webViewNavigationSubscriber: AnyCancellable?

        init(_ uiWebView: VkWebView) {
            parent = uiWebView
        }

        deinit {
            webViewNavigationSubscriber?.cancel()
        }

        func webView(
            _: WKWebView,
            decidePolicyFor navigationResponse: WKNavigationResponse,
            decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
        ) {
            guard
                let url = navigationResponse.response.url,
                url.path == "/blank.html",
                let fragment = url.fragment
            else { return decisionHandler(.allow) }

            let parameters = fragment
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .reduce([String: String]()) { result, params in
                    var dict = result
                    let key = params[0]
                    let value = params[1]
                    dict[key] = value
                    return dict
                }
            guard
                let token = parameters["access_token"],
                let userIDString = parameters["user_id"],
                let userID = Int(userIDString)

            else { return decisionHandler(.allow) }

            if token.count > 0 && userID > 0 {
                AuthData.share.userId = userID
                AuthData.share.token = token
                parent.successCompletion()
            }

            decisionHandler(.cancel)
        }
    }
}

extension VkWebView.Coordinator: WKScriptMessageHandler {
    func userContentController(_: WKUserContentController, didReceive message: WKScriptMessage) {
        // Make sure that your passed delegate is called
        if message.name == "iOSNative" {
            if let body = message.body as? [String: Any?] {
                print("JSON value received from web is: \(body)")
            } else if let body = message.body as? String {
                print("String value received from web is: \(body)")
            }
        }
    }
}
