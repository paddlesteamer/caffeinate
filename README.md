# Caffeinate Toggle

A simple macOS menu bar app that toggles the `caffeinate -d` command to prevent your display from sleeping.

## Features

- **Left-click**: Toggle caffeinate on/off
- **Right-click**: Quit the app
- Visual feedback with different icons for active/inactive states
- Automatically disables when the lid is closed
- Runs as a menu bar app (no dock icon)

## What is `caffeinate -d`?

The `caffeinate` command is a built-in macOS utility that prevents the system from sleeping. The `-d` flag specifically prevents the display from sleeping.

## Building

Make sure you have Xcode Command Line Tools installed:

```bash
xcode-select --install
```

Then build the app:

```bash
chmod +x build.sh
./build.sh
```

## Running

After building, run the app:

```bash
open build/CaffeinateToggle.app
```

## Installing

To install to your Applications folder:

```bash
cp -r build/CaffeinateToggle.app /Applications/
```

## Auto-start at Login

To have the app start automatically when you log in:

1. Open **System Preferences** → **General** → **Login Items**
2. Click the **+** button
3. Navigate to `/Applications/CaffeinateToggle.app` and add it

## Icons

- ☕ (empty cup): Caffeinate is OFF
- ☕ (filled cup): Caffeinate is ON
