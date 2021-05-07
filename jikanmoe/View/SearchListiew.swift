//
//  ContentView.swift
//  jikanmoe
//
//  Created by Satoru Ishii on 5/6/21.
//

import SwiftUI

/// Search & Anime/Manga List
///
struct SearchListView: View {
    @ObservedObject var viewModel : SearchListViewModel
    @State var title : String = ""
    
    init(viewModel: SearchListViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Text Field for Input the Search Key of the Title
                findFieldSection
                // If Search download is donw or not
                if viewModel.animeSearchResponse != nil && viewModel.animeSearchResponse!.results != nil {
                    // Display Anime List of Search Result
                    animeListSection
                }
                Spacer()
            }
            //.edgesIgnoringSafeArea(.all)
            .navigationBarTitle(ConstantsTable.SearchListViewTitle, displayMode: .inline)
        }
        .onAppear {
            self.viewModel.getAnimeList(title: title)
        }
    }
}

//
// View Section of SearchListView
//
private extension SearchListView {

    //  Text Field for Search Title
    //
    var findFieldSection : some View {
        HStack {
            Image("iconfinder")
                .resizable()
                .frame(width: ConstantsTable.SearchIconWidth, height: ConstantsTable.SearchIconHeight)
                .aspectRatio(contentMode: .fit)
            TextField("type Title", text: $title, onCommit: {
                viewModel.getAnimeList(title: title)
            })
            .font(.system(size: ConstantsTable.TitleFont))
            .autocapitalization(.none)
        }
    }
    
    //
    //
    var animeListSection : some View {
        GeometryReader { _p in
            List {
                ForEach(self.viewModel.animeSearchResponse!.results!, id: \.mal_id) { anime in
                    NavigationLink(destination: AnimeDetailView(anime: anime)) {
                        HStack(alignment: .top) {
                            URLImage(url: anime.image_url)
                            VStack(alignment: .leading) {
                                Text(anime.title.prefix(25))
                                    .font(.system(size: ConstantsTable.TitleFont))
                                    .foregroundColor(Color.black)
                                Text(anime.type)
                                Text("Score " + String(anime.score))
                                Text(String(anime.members) + " members")
                            }
                            .font(.system(size: ConstantsTable.CaptionFont))
                            .foregroundColor(Color.gray)
                        }
                    }
                }
            .frame(width: _p.size.width)
            }
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView(viewModel: SearchListViewModel())
    }
}
