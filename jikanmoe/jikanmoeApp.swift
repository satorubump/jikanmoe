//
//  jikanmoeApp.swift
//  jikanmoe
//
//  Created by Satoru Ishii on 5/6/21.
//

import SwiftUI

@main
struct jikanmoeApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = SearchListViewModel()
            SearchListView(viewModel: viewModel)
        }
    }
}
