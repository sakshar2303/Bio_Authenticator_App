# BioAuthenticator  

**BioAuthenticator** is a secure "Intent-Based" vault for iOS that reimagines biometric security. Unlike standard FaceID which is passive, this app requires a specific, user-defined facial expression (the "Secret Look") to decrypt sensitive data.

---

## 🚀 The Concept
Standard biometrics can be bypassed if a phone is held up to a sleeping or unwilling user's face. **BioAuthenticator** solves this by requiring **active intent**. The user must perform a specific gesture—like a wink, a smile, or a cheek puff—to "unlock" the encrypted vault.



## 🛠 Technical Features
- **ARKit Face Tracking:** Monitors 52 unique facial blend shapes (muscle movements) at 60fps.
- **Biometric Mapping:** Maps facial geometry to a `[String: Float]` dictionary for precise gesture matching.
- **Haptic Engine (Taptic):** Uses `UIImpactFeedbackGenerator` to provide tactile confirmation of a successful biometric handshake.
- **SwiftUI + Liquid Glass UI:** Features a high-fidelity "blurred vault" aesthetic that "melts" away only upon successful verification.
- **Privacy-First Architecture:** No biometric data is sent to a server; all facial snapshots are stored locally on-device.

## 📱 How it Works
1. **Enrollment:** The user performs their "Secret Look" while the TrueDepth camera maps the coordinates of their facial muscles.
2. **Persistence:** The gesture is saved to the local secure storage as a mathematical threshold.
3. **Verification:** When entering the vault, the app compares the real-time `ARFaceAnchor` data against the saved key.
4. **Decryption:** If the "Match Score" exceeds 80%, the vault is unblurred and haptic feedback is triggered.

## 🏗 Tech Stack
- **Frameworks:** SwiftUI, ARKit, SceneKit, Combine
- **Hardware:** iPhone TrueDepth Camera System (iPhone X or newer)
- **Language:** Swift 6.0
- **Deployment:** iOS 18.0+

---

## 👨‍💻 Developed by
**Sakshar Dhawan** 
