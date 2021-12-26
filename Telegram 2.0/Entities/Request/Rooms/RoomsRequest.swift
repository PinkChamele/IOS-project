struct JoinRoomReques: Codable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "roomId"
    }
}
