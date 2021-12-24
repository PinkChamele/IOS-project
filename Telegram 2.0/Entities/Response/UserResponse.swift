struct UserResponse: Codable {
    let id: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
    }
}
