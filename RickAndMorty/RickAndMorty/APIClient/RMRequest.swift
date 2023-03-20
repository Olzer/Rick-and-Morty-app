import Foundation

/// Object represents a single API call
final class RMRequest {
    
    /// API Constants
    private struct Constants {
        static let basicURL = "https://rickandmortyapi.com/api"
    }
    
    /// Desire endpoint
    private let endpoint: RMEndpoin
    
    /// Path components for API, if any
    private let pathComponents: [String]
    
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    ///Constructed URL for API request in string format
    private var urlString: String {
        var string = Constants.basicURL
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumetString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumetString
        }
        return string
    }
    
    /// Desired http method
    public let httpMethod = "GET"
    
    //MARK: - Public
    
    /// Computed and Constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of path components
    ///   - queryParameters: Collection of query paramaters
    init(endpoint: RMEndpoin,
         pathComponents: [String] = [],
         queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
}

extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
}
