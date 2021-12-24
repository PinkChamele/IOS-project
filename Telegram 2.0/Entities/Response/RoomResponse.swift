struct RoomResponse: Codable {
    let id: String
    let users: [UserResponse]
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case users
        case name
    }
}

