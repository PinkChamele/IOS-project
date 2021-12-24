struct JoinRoomResponse: Codable {
    let n: Int
    let nModified: Int
    let ok: Int
    
    enum CodingKeys: String, CodingKey {
        case n
        case nModified
        case ok
    }
}
