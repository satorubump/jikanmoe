//
//  SearchAnimeAPI.swift
//  jikanmoe
//
//  Created by Satoru Ishii on 5/6/21.
//

import Foundation
import Combine

///  API Error
///
enum APIError: Error {
    case network(description: String)
    case decoding(description: String)
}

///
/// SearchAnimeConnectable Protocol
///
/// - Functions:
///   - fetchAnimeList(title: String) return success; AnimeSearchResponse, fail: APIError
///
protocol SearchAnimeConnectable {
    func fetchAnimeList(title: String) -> AnyPublisher<AnimeSearchResponse, APIError>
}
///
///  Search Anime Fetcher
///
class SearchAnimeConnector : SearchAnimeConnectable {
    ///
    /// Fetch Anime Data from Name Key
    ///
    /// - Parameters:
    ///   - paramA: title is Name Key for search anime data
    ///
    /// - Returns: AnyPublisher Success: AnimeSearchResponse Publish, Falise: APIError
    ///
    func fetchAnimeList(title: String) -> AnyPublisher<AnimeSearchResponse, APIError> {
        let urlComponents = self.makeFetchAnimeListRequestUrl(title: title)
        return publishConnector(components: urlComponents)
    }
    ///
    /// Create the Search Anime request url
    ///
    /// - Parameters:
    ///   - paramA: Search Key - String
    /// - Returns: URLComponents -- URL Request
    ///
    private func makeFetchAnimeListRequestUrl(title: String) -> URLComponents {
        var urlComp = URLComponents()
        urlComp.scheme = ConstantsTable.Scheme
        urlComp.host = ConstantsTable.Host
        urlComp.path = ConstantsTable.Path + ConstantsTable.SearchReq
        
        urlComp.queryItems = [
            URLQueryItem(name: ConstantsTable.Q, value: title)
        ]
        return urlComp
    }
    
    ///
    /// Private Connect Service API, Downloading and Publish the data (Combine)
    ///
    /// - Parameters:
    ///  - paramA: URLRequest : URLCompnents
    ///
    /// - Returns:  Any Publisher Success: AnimeSearchResponse Publsh, Fail: APIError
    ///
    private func publishConnector(components: URLComponents) -> AnyPublisher<AnimeSearchResponse, APIError> {
        guard let url = components.url else {
            let error = APIError.network(description: "Can't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            .network(description: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { pair in
                self.decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
    
    ///
    /// Decode json data to AnimeSearchResponse codable struct data
    ///
    /// - Parameters:
    ///   - paramA: download json data
    /// - Returns: Decode success: AnimeSearchResponse Publish, fails: APIError
    ///
    private func decode(_ data: Data) -> AnyPublisher<AnimeSearchResponse, APIError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return Just(data)
            .decode(type: AnimeSearchResponse.self, decoder: decoder)
            .mapError { error in
                .decoding(description: error.localizedDescription)
            }
          .eraseToAnyPublisher()
    }
}
