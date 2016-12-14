//
//  Constants.swift
//  Flipt
//
//  Created by Johann Kerr on 8/14/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation
import BarcodeScanner

struct Constants{
    static let booksApiURL = "https://openlibrary.org/api/books?bibkeys=ISBN:"
    static let bookApiParams = "&jscmd=details&format=json"
    
    
    static let googleBooksApiUrl = "https://www.googleapis.com/books/v1/volumes?q=isbn:"
    static let googleApiKey = "&bookclub-1009"
    static let padding = 20.0

    
    struct Flipt{
        static let baseUrl = "https://fliptbooks.herokuapp.com/api"
        
    }
    
    struct UI{
        static let padding = 20
        static let textFieldHeight = 50
    }
       
        
}
