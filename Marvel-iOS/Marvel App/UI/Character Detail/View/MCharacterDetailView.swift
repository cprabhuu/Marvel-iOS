//
//  MCharacterDetailView.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

import UIKit

class MCharacterDetailView: MBaseView, DVATableViewModelDatasourceDelegate, UITableViewDelegate {
    //__ IBOutlets
    @IBOutlet weak private var comicsTableView : UITableView?
    @IBOutlet weak private var characterImageView : UIImageView?
    @IBOutlet weak private var characterNameLabel : UILabel?
    @IBOutlet weak private var characterDescriptionLabel : UILabel?
    @IBOutlet weak private var comicsTitleLabel : UILabel?
    @IBOutlet weak private var comicsNoResultsLabel : UILabel?
    //__ Private section
    private let threshold = 50.0 // threshold from bottom of tableView
    private var isLoadingMore = false // flag
    //__ Internal section
    internal var datasource : DVAProtocolDataSourceForTableView?;
    internal var viewModel:MCharacterDetailViewModel? {
        didSet {
            if let characterNameLabel = self.characterNameLabel {
                characterNameLabel.text = viewModel!.characterName
            }
            
            if let characterDescriptionLabel = self.characterDescriptionLabel {
                characterDescriptionLabel.text = viewModel!.characterDescription
            }
            
            let URL = NSURL(string:viewModel!.characterUrlImage! + "/portrait_incredible." + viewModel!.characterUrlImageExtension!)
            characterImageView?.hnk_setImageFromURL(URL!)
            
            if viewModel?.reloadItems == true {
                self.datasource?.viewModelDataSource = viewModel!.comics
                self.comicsTableView?.hidden = viewModel?.comics.count == 0;
                self.comicsNoResultsLabel?.hidden = !viewModel!.showNoResultsMessage || viewModel?.comics.count > 0
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.comicsTableView?.reloadData()
                    self.isLoadingMore = false
                }
            }
        }
    }
    internal var delegate:MCharacterDetailViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        self.characterImageView?.contentMode = UIViewContentMode.ScaleAspectFill;
        self.characterImageView?.clipsToBounds = true;
        self.comicsTitleLabel?.text = NSLocalizedString("Comics related", comment: "comics related title")
        self.comicsNoResultsLabel?.text = NSLocalizedString("Comics no results", comment: "no results message")
        self.comicsNoResultsLabel?.hidden = true
        setupDataSource()
    }
    
    private func setupDataSource() {
        self.comicsTableView?.delegate = self
        self.comicsTableView?.registerNib(UINib(nibName: "MComicTableViewCell", bundle: nil), forCellReuseIdentifier: "MComicTableViewCell")
        let tableView =  UIView(frame: CGRectZero)
        self.comicsTableView!.tableFooterView = tableView
        self.comicsTableView!.tableFooterView!.hidden = true
        self.datasource = DVAProtocolDataSourceForTableView()
        self.datasource?.delegate = self
        self.comicsTableView?.dataSource = self.datasource
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130.0
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if !isLoadingMore && (maximumOffset - contentOffset <= CGFloat(threshold)) {
            delegate?.listViewDelegateLoadMoreComics()
            self.isLoadingMore = true
        }
    }
}

//__ View model class
class MCharacterDetailViewModel: NSObject {
    var comics:[MComicCellViewModel] = [] //__ comics list
    var reloadItems:Bool = true //__ reload or not the tableview
    var characterUrlImage:String? //__ url image for the character
    var characterUrlImageExtension:String? //__ url image extension for the character
    var characterName:String? //__ character name
    var characterDescription:String? //__ character description
    var showNoResultsMessage:Bool = false //__ show or hide 'no results' message
}

//__ Delegate method class
protocol MCharacterDetailViewDelegate {
    //__ Load more comics
    func listViewDelegateLoadMoreComics()
}
