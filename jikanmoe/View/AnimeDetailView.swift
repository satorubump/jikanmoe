//
//  AnimeDetailView.swift
//  jikanmoe
//
//  Created by Satoru Ishii on 5/6/21.
//

import SwiftUI

struct AnimeDetailView: View {
    
    var anime : Anime
    
    init(anime: Anime) {
        self.anime = anime
    }
    var body: some View {
        VStack {
            AnimeWebView(url: anime.url)
        }
        .navigationBarTitle(anime.title, displayMode: .inline)
    }
}

/*
struct AnimeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeDetailView(anime: Anime())
    }
}
 */
