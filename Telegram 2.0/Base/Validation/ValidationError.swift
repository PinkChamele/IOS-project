struct ValidationError: Error {

    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}
