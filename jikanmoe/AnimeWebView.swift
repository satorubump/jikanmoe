//
//  AnimeWebView.swift
//  jikanmoe
//
//  Created by Satoru Ishii on 5/7/21.
//

import SwiftUI
import WebKit

struct AnimeWebView: UIViewRepresentable {

    let url: String
    private let observable = WebViewURLObservable()

    ///
    var observer: NSKeyValueObservation? {
        observable.instance
    }

    // MARK: - UIViewRepresentable
    /// Create Instance
    /// Retrun UIKit View
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    // MARK: - UIViewRepresentable
    /// Updating View
    ///
    func updateUIView(_ uiView: WKWebView, context: Context) {

        /// Observe the change URL
        observable.instance = uiView.observe(\WKWebView.url, options: .new) { view, change in
            if let url = view.url {
                print("Page URL: \(url)")
            }
        }

        /// Load URL Page
        uiView.load(URLRequest(url: URL(string: url)!))
    }
}

// MARK:  Observable Object
private class WebViewURLObservable: ObservableObject {
    @Published var instance: NSKeyValueObservation?
}
