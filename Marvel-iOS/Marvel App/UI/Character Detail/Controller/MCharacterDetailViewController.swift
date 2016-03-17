//
//  MCharacterDetailViewController.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

import UIKit

class MCharacterDetailViewController: MBaseViewController, MCharacterDetailViewDelegate {
    //__ Private section
    private var characterDetailView : MCharacterDetailView {
        get {
            return (self.view as? MCharacterDetailView)!;
        }
    }
    private var comicProvider : MComicProvider?
    private var offset : Int?
    private var limit : Int?
    private var total : Int?
    private var listComics : [MComicCellViewModel] = []
    
    internal var characterUrlImage : String?
    internal var characterUrlImageExtension:String?
    internal var characterName:String?
    internal var characterId:Int?
    internal var characterDescription:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //__ Configure the view delegate
        self.characterDetailView.delegate = self
        //__ Init the offset and limit for API REST
        self.offset = 0;
        self.limit = 80;
        
        //__ Configure the view model
        viewModel()
        //__ Init the comic provider
        self.comicProvider = MComicProvider()
        //__ Load all marvel comics for character
        loadAllMarvelComicsForCharacterId(self.characterId!, firstSearch: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.characterDetailView.dissmissProgress()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewModel() {
        let viewModel = MCharacterDetailViewModel()
        viewModel.characterUrlImage = self.characterUrlImage
        viewModel.characterUrlImageExtension = self.characterUrlImageExtension
        viewModel.characterName = characterName
        viewModel.characterDescription = characterDescription
        self.characterDetailView.viewModel = viewModel;
    }
    
    func loadAllMarvelComicsForCharacterId(characterId:Int, firstSearch:Bool) {
        self.characterDetailView.showProgressViewWithTextAndAllowInteraction(NSLocalizedString("Loading comics", comment: "loading message"), allowInteraction: true)
        
        self.comicProvider?.comicProviderGetAllComicsForCharacterId(characterId, limit: self.limit!, offset: self.offset!, onCompletion: { (characters, total, alert, errorCode, errorMessage) -> Void in
            self.characterDetailView.dissmissProgress()
            
            if errorCode != DRErrorCode.EverythingOKCode {
                self.showAlertWithMessage(NSLocalizedString("The marvel server is not responding", comment: "error message"), title: NSLocalizedString("Error server title", comment: "error title"))
                return
            }
            
            self.offset = self.offset! + self.limit!
            self.total = total;
            
            let viewModel : MCharacterDetailViewModel = self.characterDetailView.viewModel!
            if firstSearch {
                viewModel.comics = []
            }
            self.listComics = viewModel.comics + MComicCellViewModel.generateComicsObjects(characters as! [MComic])
            viewModel.comics = self.listComics
            viewModel.reloadItems = true
            viewModel.showNoResultsMessage = self.listComics.count == 0
            self.characterDetailView.viewModel = viewModel
        })
    }
    
    func listViewDelegateLoadMoreComics() {
        if self.offset < self.total {
            loadAllMarvelComicsForCharacterId(self.characterId!, firstSearch: false)
        }
    }
}
