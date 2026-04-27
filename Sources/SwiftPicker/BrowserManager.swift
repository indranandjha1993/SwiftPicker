import Foundation
import AppKit

struct Browser: Identifiable {
    let id = UUID()
    let name: String
    let bundleIdentifier: String
    let path: URL
    let icon: NSImage
}

class BrowserManager: ObservableObject {
    @Published var installedBrowsers: [Browser] = []
    
    func fetchInstalledBrowsers() {
        let httpUrls = ["http://google.com", "https://google.com"]
        var uniqueBrowsers: [String: Browser] = [:]
        
        for urlString in httpUrls {
            if let url = URL(string: urlString) {
                // Get all apps that can open HTTP/HTTPS URLs
                let apps = LSCopyApplicationURLsForURL(url as CFURL, .all)?.takeRetainedValue() as? [URL] ?? []
                
                for appUrl in apps {
                    if let bundle = Bundle(url: appUrl),
                       let bundleIdentifier = bundle.bundleIdentifier,
                       bundleIdentifier != Bundle.main.bundleIdentifier { // Exclude self
                        
                        let name = bundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
                            ?? bundle.object(forInfoDictionaryKey: "CFBundleName") as? String
                            ?? appUrl.deletingPathExtension().lastPathComponent
                        
                        let icon = NSWorkspace.shared.icon(forFile: appUrl.path)
                        
                        uniqueBrowsers[bundleIdentifier] = Browser(
                            name: name,
                            bundleIdentifier: bundleIdentifier,
                            path: appUrl,
                            icon: icon
                        )
                    }
                }
            }
        }
        
        self.installedBrowsers = Array(uniqueBrowsers.values).sorted { $0.name < $1.name }
    }
    
    func open(url: URL, with browser: Browser) {
        let configuration = NSWorkspace.OpenConfiguration()
        NSWorkspace.shared.open([url], withApplicationAt: browser.path, configuration: configuration) { _, error in
            if let error = error {
                print("Error opening URL: \(error.localizedDescription)")
            }
            NSApp.terminate(nil)
        }
    }
}
