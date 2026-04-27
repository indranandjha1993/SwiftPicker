import SwiftUI

struct ContentView: View {
    @ObservedObject var browserManager: BrowserManager
    @Binding var url: URL?
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            if let url = url {
                Text("Open link in...")
                    .font(.headline)
                    .padding(.top)
                
                Text(url.absoluteString)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .padding(.horizontal)
            }
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(browserManager.installedBrowsers) { browser in
                        Button(action: {
                            if let url = url {
                                browserManager.open(url: url, with: browser)
                            }
                        }) {
                            VStack {
                                Image(nsImage: browser.icon)
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                
                                Text(browser.name)
                                    .font(.caption)
                                    .lineLimit(1)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(width: 80, height: 80)
                            .padding(10)
                            .background(Color.primary.opacity(0.05))
                            .cornerRadius(12)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .onHover { isHovering in
                            if isHovering {
                                NSCursor.pointingHand.push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(maxHeight: 400)
            
            HStack {
                Button("Cancel") {
                    NSApp.terminate(nil)
                }
                .keyboardShortcut(.escape, modifiers: [])
            }
            .padding(.bottom)
        }
        .frame(minWidth: 400, minHeight: 300)
        .background(VisualEffectView(material: .hudWindow, blendingMode: .withinWindow))
    }
}

struct VisualEffectView: NSViewRepresentable {
    let material: NSVisualEffectView.Material
    let blendingMode: NSVisualEffectView.BlendingMode
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = material
        view.blendingMode = blendingMode
        view.state = .active
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
    }
}
