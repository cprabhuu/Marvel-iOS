//
//  MComicCellViewModel.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

class MComicCellViewModel: NSObject, DVATableViewModelProtocol {
    internal var comicName : String?
    internal var comicDescription : String?
    internal var comicUrlImage : String?
    internal var comicUrlImageExtension : String?
    
    init(comicName : String, comicUrlImage : String, comicUrlImageExtension : String, comicDescription : String) {
        super.init()
        self.comicName = comicName;
        self.comicUrlImage = comicUrlImage
        self.comicUrlImageExtension = comicUrlImageExtension
        self.comicDescription = comicDescription
    }
    
    //__ Generate the comic objects to use un UI
    class func generateComicsObjects(comics : [MComic]) -> Array<MComicCellViewModel> {
        var items: [MComicCellViewModel] = []
        
        for comic in comics {
            let item = MComicCellViewModel(comicName: comic.comicTitle!, comicUrlImage: comic.comicUrlImage!, comicUrlImageExtension: comic.comicUrlImageExtension!, comicDescription: comic.comicDescription!)
            items.append(item)
        }
        
        return items
    }
    
    //__ Generate custom demo objects (JUST FOR TESTING. NOT USE THIS IN PRODUCTION)
    class func generateCustomObjects() -> Array<MComicCellViewModel> {
        var items: [MComicCellViewModel] = []
        
        for var i=0 ; i<15 ; i++ {
            let item = MComicCellViewModel(comicName: "comic test", comicUrlImage: "", comicUrlImageExtension: "", comicDescription: "")
            items.append(item)
        }
        
        return items
    }
    
    //__ Set the cell identifier
    func dva_cellIdentifier() -> String! {
        return MComicTableViewCell.description()
    }
}
