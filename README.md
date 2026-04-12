# BabyBite

A Flutter app for tracking children's nutrition.

---

## System Requirements

| Component | Minimum Requirement |
|---|---|
| macOS | 13 (Ventura) or later |
| RAM | 8 GB (16 GB recommended) |
| Free storage | **At least 80 GB** |
| Chip | Apple Silicon (M1/M2/M3) or Intel |

> **Note:** Check available storage at  > About This Mac > Storage before getting started.

---

## Setup Overview

```
1. Homebrew
2. Git
3. Visual Studio Code
4. Xcode (iOS)
5. Android Studio (Android)
6. Flutter SDK
7. Clone project & run the app
```

---

## Step 1 — Install Homebrew

Homebrew is a package manager for macOS, required to install development tools.

Open **Terminal** (Command + Space → type "Terminal") and run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After installation, if you are using an **Apple Silicon (M1/M2/M3)** chip, add Homebrew to your PATH:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Verify:

```bash
brew --version
```

---

## Step 2 — Install Git

```bash
brew install git
git --version
```

Configure your personal information:

```bash
git config --global user.name "Your Name"
git config --global user.email "email@example.com"
```

---

## Step 3 — Install Visual Studio Code

### 3.1 Download and install

1. Go to [https://code.visualstudio.com](https://code.visualstudio.com)
2. Click **Download Mac Universal**
3. Unzip the `.zip` file and drag **Visual Studio Code.app** into the **Applications** folder

### 3.2 Install the `code` command in Terminal

Open VSCode → press `Cmd + Shift + P` → type `Shell Command: Install 'code' command in PATH` → press Enter.

### 3.3 Install Flutter extensions

In VSCode, press `Cmd + Shift + X` and search for and install the following extensions:

- **Flutter** (by Dart Code) — required
- **Dart** (by Dart Code) — required
- **GitLens** — optional, Git support

---

## Step 4 — Install Xcode (for iOS)

> Xcode takes approximately **15–20 GB** of storage.

### 4.1 Install Xcode from the App Store

1. Open the **App Store**
2. Search for **Xcode** and click **Get** / **Install**
3. The download and installation may take 30–60 minutes

### 4.2 Install Command Line Tools and accept the License

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
sudo xcodebuild -license accept
```

### 4.3 Install CocoaPods

```bash
sudo gem install cocoapods
pod --version
```

If you encounter errors with Ruby, use Homebrew instead:

```bash
brew install cocoapods
```

---

## Step 5 — Install Android Studio (for Android)

> Android Studio + SDK takes approximately **10–15 GB** of storage.

### 5.1 Download and install

1. Go to [https://developer.android.com/studio](https://developer.android.com/studio)
2. Click **Download Android Studio**
3. Open the `.dmg` file, drag **Android Studio.app** into the **Applications** folder
4. Open Android Studio and follow the Setup Wizard (select **Standard** when prompted)

### 5.2 Install Android SDK and Command-line Tools

In Android Studio:

1. Go to **Android Studio > Settings** (or Preferences on older macOS)
2. Select **Languages & Frameworks > Android SDK**
3. **SDK Platforms** tab: check **Android 14.0 (API 34)** or later
4. **SDK Tools** tab: check the following items:
   - Android SDK Build-Tools
   - Android SDK Command-line Tools
   - Android Emulator
   - Android SDK Platform-Tools
5. Click **Apply** and wait for the download to complete

### 5.3 Set Android environment variables

Add to `~/.zshrc` (or `~/.bash_profile` if using bash):

```bash
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

Apply the changes:

```bash
source ~/.zshrc
```

### 5.4 Accept Android Licenses

```bash
flutter doctor --android-licenses
```

Press `y` to accept all.

### 5.5 Create an Android Emulator (optional)

In Android Studio → **Device Manager** → **Create Device** → select a device (e.g. Pixel 8) → select a system image (API 34) → Finish.

---

## Step 6 — Install Flutter SDK

> Flutter SDK takes approximately **2–3 GB** of storage.

### 6.1 Install Flutter via Homebrew

```bash
brew install --cask flutter
```

### 6.2 Verify environment variables

After installation, run the following command to verify:

```bash
flutter --version
```

If the command is not recognized, manually add it to `~/.zshrc`:

```bash
export PATH="$PATH:$HOME/flutter/bin"
source ~/.zshrc
```

### 6.3 Run Flutter Doctor

```bash
flutter doctor
```

Expected output — all items must show `[✓]`:

```
[✓] Flutter
[✓] Android toolchain
[✓] Xcode
[✓] VS Code
[✓] Connected device
```

If any item shows `[✗]` or `[!]`, follow the instructions in the output to resolve it.

---

## Step 7 — Clone the project

```bash
git clone https://github.com/kiu-chan/babybite.git
cd babybite
```

---

## Step 8 — Install dependencies

```bash
flutter pub get
```

---

## Step 9 — Run the app

### Option 1: Use the VSCode Flutter Extension (recommended)

This is the most convenient option — no Terminal commands needed.

1. Open the project folder in VSCode:
   ```bash
   code babybite
   ```
2. In the bottom-right corner of the Status Bar, click the device name (e.g. **No Device**) to select a target device (Simulator, Emulator, or a real device)
3. Press `fn + F5` or go to **Run > Start Debugging** to build and run the app
4. Or click the **Run** (▶) button on the `lib/main.dart` file when it is open

**Useful shortcuts while running:**

| Key | Action |
|---|---|
| `r` | Hot Reload — updates the UI instantly, preserves state |
| `R` | Hot Restart — restarts the app, resets state |
| `F5` | Start / Resume |
| `Shift + F5` | Stop the app |
| `Cmd + Shift + P` → `Flutter: Select Device` | Switch the active device |

---

### Option 2: Use Terminal

#### Check connected devices

```bash
flutter devices
```

#### Run on iOS Simulator

```bash
open -a Simulator
flutter run
```

#### Run on Android Emulator

Open Android Studio → **Device Manager** → click ▶ to start the emulator, then:

```bash
flutter run
```

#### Run on a real device (iPhone/Android)

- **iPhone:** Connect via USB cable, open Xcode → **Window > Devices** → trust the computer on your phone
- **Android:** Enable **Developer Options** → enable **USB Debugging** → connect via cable

```bash
flutter run
```

#### Run on a specific device

```bash
# List devices and get the device ID
flutter devices

# Run on the specified device
flutter run -d <device-id>
```

---

## Troubleshooting

### `flutter: command not found`

```bash
export PATH="$PATH:$(brew --prefix)/bin"
source ~/.zshrc
```

### CocoaPods error when building iOS

```bash
cd ios
pod install --repo-update
cd ..
```

### Android license not accepted

```bash
flutter doctor --android-licenses
```

### iOS build fails with signing error

Open **Xcode** → open `ios/Runner.xcworkspace` → select the **Runner** target → go to the **Signing & Capabilities** tab → set **Team** to your Apple ID.

---

## Contact

If you need support or have any questions, feel free to reach out:

- **Email:** [khanhk66uet@gmail.com](mailto:khanhk66uet@gmail.com)
- **WhatsApp:** [+84 974 022 602](https://wa.me/84974022602)

---

## Project Structure

```
babybite/
├── lib/             # Main source code
├── assets/
│   ├── icon/        # App icon
│   └── img/         # Images
├── android/         # Android configuration
├── ios/             # iOS configuration
└── pubspec.yaml     # Dependencies
```
