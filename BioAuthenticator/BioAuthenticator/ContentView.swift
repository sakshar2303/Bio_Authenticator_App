import SwiftUI
import ARKit

struct ContentView: View {
    @StateObject var faceController = FaceController()
    @State private var isEnrolled = UserDefaults.standard.savedBioKey != nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                if !isEnrolled {
                    VStack(spacing: 40) {
                        Text("Enroll Your Bio-Key").font(.largeTitle.bold()).foregroundStyle(.white)
                        ARViewContainer(faceController: faceController)
                            .frame(height: 400).clipShape(Circle())
                        
                        Button("Record Expression") {
                            // Data is already String-indexed in the controller
                            UserDefaults.standard.savedBioKey = faceController.currentExpressionData
                            isEnrolled = true
                        }
                        .buttonStyle(.borderedProminent).tint(.cyan).controlSize(.large)
                    }
                } else {
                    VaultView(faceController: faceController)
                }
            }
        }
    }
}
