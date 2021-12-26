struct Room: Codable {
    let id: String
    let users: [User]
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case users
        case name
    }
}

