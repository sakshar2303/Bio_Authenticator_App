import SwiftUI

struct VaultView: View {
    @ObservedObject var faceController: FaceController
    @State private var isUnlocked = false
    
    let mockData = [
        ("Apple ID", "academy@apple.com"),
        ("Instagram", "@dev_sakshar"),
        ("Github", "sakshar23")
    ]

    var body: some View {
        ZStack {
            List(mockData, id: \.0) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.0).font(.headline)
                        Text(item.1).font(.subheadline).foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text(isUnlocked ? "Secret123" : "••••••••")
                        .monospaced()
                }
            }
            .blur(radius: isUnlocked ? 0 : 20)
            
            if !isUnlocked {
                VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                    .ignoresSafeArea()
                    .overlay {
                        VStack(spacing: 20) {
                            Image(systemName: "faceid")
                                .font(.system(size: 60))
                                .foregroundStyle(.cyan)
                                .symbolEffect(.pulse)
                            Text("Make your 'Secret Look' to Unlock")
                                .foregroundStyle(.white)
                        }
                    }
            }
        }
        .onReceive(faceController.$currentExpressionData) { _ in
            // SAFELY UNWRAP the saved key to avoid errors
            if let savedKey = UserDefaults.standard.savedBioKey {
                if faceController.verifyExpression(against: savedKey) {
                    if !isUnlocked {
                        faceController.triggerSuccessHaptic() // Trigger the vibration
                        withAnimation(.spring()) { isUnlocked = true }
                    }
                }
            }
        }
    }
}
