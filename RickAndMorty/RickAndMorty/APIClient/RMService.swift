import Foundation

/// Primary API service object to get Rick and Morty data
final class RMService {
    /// Shared singleton instance
    static let share = RMService()
    
    /// Privitized constructor`
    private init() {}
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: request instance
    ///   - type: The type of the object we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
    }
}
