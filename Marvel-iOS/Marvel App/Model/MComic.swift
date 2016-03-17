//
//  MComic.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

import UIKit

@objc class MComic: NSObject {
    internal var comicTitle : String?
    internal var comicUrlImage : String?
    internal var comicUrlImageExtension : String?
    internal var comicDescription : String?
    
    init(comicTitle : String, comicUrlImage : String, comicUrlImageExtension : String, comicDescription : String) {
        super.init()
        self.comicTitle = comicTitle;
        self.comicUrlImage = comicUrlImage
        self.comicUrlImageExtension = comicUrlImageExtension
        self.comicDescription = comicDescription
    }
}