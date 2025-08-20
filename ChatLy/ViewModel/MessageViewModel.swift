import Foundation

struct MessageViewModel {
    private let lastUser: LastUser
    init(lastUser: LastUser) {
        self.lastUser = lastUser
    }
    var profilePhoto: URL? {
        return URL(string: lastUser.user.profilePhotoUrl)
    }
    var timestampString: String {
        let date = lastUser.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
