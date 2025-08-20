import UIKit

struct NewMessageViewModel {
    private let message: Message
    
    init(message: Message) {
        self.message = message
    }
    
    var messageBackgroundColor: UIColor {
        return message.currentUser ? .systemGreen.withAlphaComponent(0.7) : .black.withAlphaComponent(0.7)
    }
    
    var currentUserActive: Bool {
        return message.currentUser
    }
    
    var profilePhotoView: URL?{
        return URL(string: message.user?.profilePhotoUrl ?? "")
    }
    
}
