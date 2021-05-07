//
//  SearchLisrViewModel.swift
//  jikanmoe
//
//  Created by Satoru Ishii on 5/6/21.
//

import Foundation
import SwiftUI
import Combine

///
///  Anime Search Result's View Model
///
///    @Published:
///      animeSearchResponse : Search Result Data Array
///
class SearchListViewModel : ObservableObject {
    // Download anime data
    @Published var animeSearchResponse : AnimeSearchResponse?

    // Data download fetcher class
    let searchAnimeConnector = SearchAnimeConnector()
    //
    private var disposables = Set<AnyCancellable>()
    ///
    /// Get Anime List: Subscribe published data
    ///
    ///  - Parameters:
    ///    - parameA: title is key string for search query
    ///
    func getAnimeList(title: String) -> Void {
        searchAnimeConnector.fetchAnimeList(title: title)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { print("sink guard nil"); return }
                    switch value {
                    case .failure:
                        self.animeSearchResponse = nil
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] animeSearchResponse in
                    self!.animeSearchResponse = animeSearchResponse
                })
            .store(in: &disposables)
    }
}
