import SwiftUI
import AppKit

@main
struct SwiftPickerApp: App {
    @StateObject private var browserManager = BrowserManager()
    @State private var pendingUrl: URL?
    
    init() {
        // Register for URL events
        NSAppleEventManager.shared().setEventHandler(
            URLHandler.shared,
            andSelector: #selector(URLHandler.handleGetURLEvent(_:withReplyEvent:)),
            forEventClass: AEEventClass(kInternetEventClass),
            andEventID: AEEventID(kAEGetURL)
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(browserManager: browserManager, url: $pendingUrl)
                .onAppear {
                    browserManager.fetchInstalledBrowsers()
                    // Check if there was already a URL received
                    if let url = URLHandler.shared.pendingUrl {
                        self.pendingUrl = url
                        URLHandler.shared.pendingUrl = nil
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: .didReceiveURL)) { notification in
                    if let url = notification.object as? URL {
                        self.pendingUrl = url
                    }
                }
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}

class URLHandler: NSObject {
    static let shared = URLHandler()
    var pendingUrl: URL?
    
    @objc func handleGetURLEvent(_ event: NSAppleEventDescriptor, withReplyEvent replyEvent: NSAppleEventDescriptor) {
        if let urlString = event.paramDescriptor(forKeyword: keyDirectObject)?.stringValue,
           let url = URL(string: urlString) {
            
            // If the app is already running, send a notification
            if NSApp.isRunning {
                NotificationCenter.default.post(name: .didReceiveURL, object: url)
            } else {
                // Otherwise store it for onAppear
                pendingUrl = url
            }
        }
    }
}

extension Notification.Name {
    static let didReceiveURL = Notification.Name("didReceiveURL")
}
