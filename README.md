# SwiftPicker

A modern, native macOS browser picker built with SwiftUI.

SwiftPicker intercepts URLs and allows you to dynamically choose which browser to use for each link. It automatically detects all installed browsers on your system, providing a seamless and professional UI/UX.

## Features

- **Native SwiftUI Interface:** Clean, fast, and follows macOS design guidelines.
- **Dynamic Browser Detection:** Automatically finds all installed browsers (Safari, Chrome, Firefox, Brave, Arc, etc.).
- **Visual Feedback:** Shows high-quality icons and names for each browser.
- **Lightweight:** Built with pure Swift and SwiftUI for minimal resource usage and instant startup.
- **Privacy Focused:** Runs entirely locally with no tracking or data collection.

## Installation

### Via Homebrew (Coming Soon)

Once released, you can install it using:

```bash
brew install --cask your-username/tap/swiftpicker
```

### Manual Installation

1. Download the latest `SwiftPicker.app` from the Releases page.
2. Move it to your `/Applications` folder.
3. Open `SwiftPicker.app`.
4. When prompted by macOS, set **SwiftPicker** as your default web browser.

## Development

### Requirements

- macOS 13.0+
- Xcode 14.0+ (for building)

### Building from Source

```bash
# Clone the repository
git clone https://github.com/your-username/SwiftPicker.git
cd SwiftPicker

# Build with xcodebuild (or open in Xcode)
xcodebuild -project SwiftPicker.xcodeproj -scheme SwiftPicker -configuration Release
```

## License

MIT License. See [LICENSE](LICENSE) for details.
