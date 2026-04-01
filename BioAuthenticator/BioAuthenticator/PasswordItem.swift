import Foundation
import SwiftData

@Model
class PasswordItem {
    var serviceName: String
    var username: String
    var encryptedPassword: String // We will store this as a string for now
    var category: String
    
    init(serviceName: String, username: String, encryptedPassword: String, category: String = "General") {
        self.serviceName = serviceName
        self.username = username
        self.encryptedPassword = encryptedPassword
        self.category = category
    }
}
