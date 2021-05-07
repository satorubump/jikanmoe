//
//  ConstantsTable.swift
//  jikanmoe
//
//  Created by Satoru Ishii on 5/6/21.
//

import SwiftUI

struct ConstantsTable {
    static let Scheme = "https"
    static let Host = "api.jikan.moe"
    static let Path = "/v3"
    static let SearchReq = "/search/anime"
    static let DetailsReq = "/anime/"
    static let Q = "q"

    static let TitleFont : CGFloat = 20.0
    static let BodyFont : CGFloat = 18.0
    static let CaptionFont : CGFloat = 15.0
    static let SearchIconWidth : CGFloat = 50.0
    static let SearchIconHeight : CGFloat = 50.0
    
    static let SearchListViewTitle = "Anime List View"
    static let ImageSize : CGFloat = 100.0
    static let ImageAspectRacio : CGFloat = 0.88
}
