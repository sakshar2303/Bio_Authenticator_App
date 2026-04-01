import ARKit
import Combine
import Foundation
import UIKit

class FaceController: NSObject, ObservableObject, ARSessionDelegate {
    @Published var isFaceVisible = false
    @Published var currentExpressionData: [String: Float] = [:]
    
    private let session = ARSession()
    private let hapticGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    override init() {
        super.init()
        session.delegate = self
        hapticGenerator.prepare()
        startSession()
    }
    
    func getSession() -> ARSession { session }
    
    private func startSession() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func triggerSuccessHaptic() {
        hapticGenerator.impactOccurred()
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let faceAnchor = anchors.first as? ARFaceAnchor else {
            DispatchQueue.main.async { self.isFaceVisible = false }
            return
        }
        
        DispatchQueue.main.async {
            self.isFaceVisible = faceAnchor.isTracked
            // Convert to String keys here to avoid rawValue errors in other files
            for (key, value) in faceAnchor.blendShapes {
                self.currentExpressionData[key.rawValue] = value.floatValue
            }
        }
    }
    
    func verifyExpression(against savedKey: [String: Float]) -> Bool {
        guard !savedKey.isEmpty else { return false }
        var matchScore = 0
        let threshold: Float = 0.18 // Tuned for better reliability
        
        for (shapeName, savedValue) in savedKey {
            let currentValue = currentExpressionData[shapeName] ?? 0.0
            if abs(currentValue - savedValue) < threshold {
                matchScore += 1
            }
        }
        return Float(matchScore) / Float(savedKey.count) >= 0.8
    }
}

extension UserDefaults {
    var savedBioKey: [String: Float]? {
        get { return dictionary(forKey: "saved_bio_key") as? [String: Float] }
        set { set(newValue, forKey: "saved_bio_key") }
    }
}
