//
//  MMarvelListViewController.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 16/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

import UIKit

class MMarvelListViewController: MBaseViewController, MMarvelListViewDelegate {
    //__ Private section
    private var marvelListView : MMarvelListView {
        get {
            return (self.view as? MMarvelListView)!;
        }
    }
    private var charactersProvider : MCharactersProvider?
    private var offset : Int?
    private var limit : Int?
    private var total : Int?
    private var isShowingSearch = false
    private var isSearching = false
    private var characterName : String?
    private var characterSelected : MCharactersCellViewModel?
    private var listCharacters : [MCharactersCellViewModel] = []
    private let kCharacterViewDetail = "characterViewDetail";
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //__ Configure the navigation bar
        configureNavigationBar()
        
        //__ Configure the view delegate
        self.marvelListView.delegate = self
        //__ Init the offset and limit for API REST
        self.offset = 0;
        self.limit = 80;

        //__ Configure the view model
        viewModel()
        self.charactersProvider = MCharactersProvider()
        loadAllMarvelCharacters(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func viewModel() {
        let viewModel = MMarvelListViewModel()
        viewModel.characters = []
        self.marvelListView.viewModel = viewModel;
    }
    
    private func configureNavigationBar() {
        var image = UIImage(named: "SearchIcon")
        image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "searchButtonPressed:")
    }
    
    //__ User actions
    internal func searchButtonPressed(sender: UIBarButtonItem) {
        self.isShowingSearch = !self.isShowingSearch
                
        if self.isSearching {
            self.isSearching = false
            self.offset = 0;
            self.loadAllMarvelCharacters(true)
            return
        }
        
        let viewModel : MMarvelListViewModel = self.marvelListView.viewModel!
        viewModel.showSearch = self.isShowingSearch
        viewModel.reloadItems = false
        self.marvelListView.viewModel = viewModel
    }
    
    private func loadAllMarvelCharacters(firstSearch:Bool) {
        self.marvelListView.showProgressViewWithText(NSLocalizedString("Loading characters", comment: "loading message"))
        
        self.charactersProvider?.charactersProviderGetAllCharactersWithLimit(self.limit!, offset: self.offset!, onCompletion: { (characters, total, alert, errorCode, errorMessage) -> Void in
            self.marvelListView.dissmissProgress()
            
            if errorCode != DRErrorCode.EverythingOKCode {
                let viewModel : MMarvelListViewModel = self.marvelListView.viewModel!
                viewModel.reloadItems = false
                viewModel.allowLoadMoreCharacters = true
                self.marvelListView.viewModel = viewModel
                
                self.showAlertWithMessage(NSLocalizedString("The marvel server is not responding", comment: "error message"), title: NSLocalizedString("Error server title", comment: "error title"))
                return
            }
            
            self.offset = self.offset! + self.limit!
            self.total = total;
            
            let viewModel : MMarvelListViewModel = self.marvelListView.viewModel!
            if firstSearch {
                viewModel.characters = []
            }
            self.listCharacters = viewModel.characters + MCharactersCellViewModel.generateCharactersObjects(characters as! [MCharacter])
            viewModel.characters = self.listCharacters
            viewModel.reloadItems = true
            viewModel.showNoResultsMessage = self.listCharacters.count == 0
            viewModel.showCollectionOnTop = firstSearch
            self.marvelListView.viewModel = viewModel
        })
    }
    
    private func loadCharacterWithName(firstSearch:Bool) {
        self.marvelListView.showProgressViewWithText(NSLocalizedString("Searching characters", comment: "searching message"))
        
        self.charactersProvider?.charactersProviderCharacterWithName(self.characterName, limit: self.limit!, offset: self.offset!, onCompletion: { (characters, total, alert, errorCode, errorMessage) -> Void in
            self.marvelListView.dissmissProgress()
            
            if errorCode != DRErrorCode.EverythingOKCode {
                let viewModel : MMarvelListViewModel = self.marvelListView.viewModel!
                viewModel.reloadItems = false
                viewModel.allowLoadMoreCharacters = true
                self.marvelListView.viewModel = viewModel
                
                self.showAlertWithMessage(NSLocalizedString("The marvel server is not responding", comment: "error message"), title: NSLocalizedString("Error server title", comment: "error title"))
                return
            }
            
            self.offset = self.offset! + self.limit!
            self.total = total;
            
            let viewModel : MMarvelListViewModel = self.marvelListView.viewModel!
            if firstSearch {
                viewModel.characters = []
            }
            self.listCharacters = viewModel.characters + MCharactersCellViewModel.generateCharactersObjects(characters as! [MCharacter])
            viewModel.characters = self.listCharacters
            viewModel.reloadItems = true
            viewModel.showSearch = false
            viewModel.showNoResultsMessage = self.listCharacters.count == 0
            viewModel.allowLoadMoreCharacters = true
            viewModel.showCollectionOnTop = firstSearch
            self.marvelListView.viewModel = viewModel
        })
    }
    
    //__ listViewDelegate methods
    func listViewDelegateLoadMoreCharacters() {        
        if self.offset < self.total {
            if self.isSearching {
                loadCharacterWithName(false)
            }
            else {
                loadAllMarvelCharacters(false)
            }
        }
    }
    
    func listViewDelegateSearchWithString(searchString: String) {
        if (searchString != "") {
            self.offset = 0;
            self.isSearching = true
            self.characterName = searchString
            loadCharacterWithName(true)
        }
    }
    
    func listViewDelegateDidSelectedCharacterAtIndex(index: Int) {
        self.characterSelected = self.listCharacters[index]
        if (self.characterSelected != nil) {
            self.performSegueWithIdentifier(self.kCharacterViewDetail, sender: self)
        }
    }
    
    //__ Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == self.kCharacterViewDetail {
            let viewController:MCharacterDetailViewController = segue.destinationViewController as! MCharacterDetailViewController
            viewController.characterUrlImage = self.characterSelected?.characterUrlImage
            viewController.characterUrlImageExtension = self.characterSelected?.characterUrlImageExtension
            viewController.characterName = self.characterSelected?.characterName
            viewController.characterDescription = self.characterSelected?.characterDescription
            viewController.characterId = self.characterSelected?.characterId
        }
    }
}
