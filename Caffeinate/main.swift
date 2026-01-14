import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var caffeinateProcess: Process?
    var isActive = false
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.action = #selector(toggleCaffeinate)
            button.target = self
            updateIcon()
        }
        
        // Create right-click menu
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q"))
        statusItem.menu = nil // We'll handle left-click ourselves
        
        // Add right-click support
        if let button = statusItem.button {
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
    }
    
    @objc func toggleCaffeinate(_ sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        
        if event.type == .rightMouseUp {
            // Show quit menu on right-click
            let menu = NSMenu()
            menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q"))
            statusItem.menu = menu
            statusItem.button?.performClick(nil)
            statusItem.menu = nil
            return
        }
        
        // Left-click toggles caffeinate
        if isActive {
            stopCaffeinate()
        } else {
            startCaffeinate()
        }
    }
    
    func startCaffeinate() {
        caffeinateProcess = Process()
        caffeinateProcess?.executableURL = URL(fileURLWithPath: "/usr/bin/caffeinate")
        caffeinateProcess?.arguments = ["-d"]
        
        do {
            try caffeinateProcess?.run()
            isActive = true
            updateIcon()
        } catch {
            print("Failed to start caffeinate: \(error)")
        }
    }
    
    func stopCaffeinate() {
        caffeinateProcess?.terminate()
        caffeinateProcess = nil
        isActive = false
        updateIcon()
    }
    
    func updateIcon() {
        if let button = statusItem.button {
            // Use SF Symbols for the icon
            if isActive {
                button.image = NSImage(systemSymbolName: "cup.and.saucer.fill", accessibilityDescription: "Caffeinate Active")
                button.toolTip = "Caffeinate is ON - Click to disable"
            } else {
                button.image = NSImage(systemSymbolName: "cup.and.saucer", accessibilityDescription: "Caffeinate Inactive")
                button.toolTip = "Caffeinate is OFF - Click to enable"
            }
        }
    }
    
    @objc func quit() {
        stopCaffeinate()
        NSApp.terminate(nil)
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        stopCaffeinate()
    }
}

// Create and run the application
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.accessory) // Hide from dock
app.run()
