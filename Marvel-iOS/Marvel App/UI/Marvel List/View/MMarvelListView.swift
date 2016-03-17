//
//  MMarverListView.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 16/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

import UIKit

class MMarvelListView: MBaseView, DVATableViewModelDatasourceDelegate, UITableViewDelegate {
    //__ IBOutlets
    @IBOutlet weak private var marvelCharactersTableView : UITableView?
    @IBOutlet weak private var searchView : UIView?
    @IBOutlet weak private var searchTopSpaceConstraint : NSLayoutConstraint?
    @IBOutlet weak private var searchTextField : UITextField?
    @IBOutlet weak private var searchButton : UIButton?
    @IBOutlet weak private var charactersNoResultsLabel : UILabel?
    //__ Private section
    private var datasource : DVAProtocolDataSourceForTableView?;
    private let threshold = 50.0 // threshold from bottom of tableView
    private var isLoadingMore = false // flag
    //__ Internal section
    internal var delegate:MMarvelListViewDelegate?
    internal var viewModel:MMarvelListViewModel? {
        didSet {
            if (viewModel?.showCollectionOnTop == true) {
                self.marvelCharactersTableView!.setContentOffset(CGPoint.zero, animated:false)
            }
            self.isLoadingMore = !viewModel!.allowLoadMoreCharacters
            if viewModel?.reloadItems == true {
                self.datasource?.viewModelDataSource = viewModel!.characters
                self.marvelCharactersTableView?.hidden = viewModel?.characters.count == 0;
                self.charactersNoResultsLabel?.hidden = !viewModel!.showNoResultsMessage || viewModel?.characters.count > 0
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.marvelCharactersTableView?.reloadData()
                }
            }
            showSearchView((self.viewModel?.showSearch)!, animated: true)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //__ Configure view
        setupView()
    }
    
    private func setupView() {
        //__ Configure UI
        self.backgroundColor = UIColor.backgroundColor()
        self.searchView?.backgroundColor = UIColor.backgroundColor()
        self.searchButton?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.searchButton?.setTitle(NSLocalizedString("Search", comment: "Search"), forState: UIControlState.Normal)
        self.charactersNoResultsLabel?.text = NSLocalizedString("Characters no results", comment: "no results message")
        //__ Hide 'search' container
        showSearchView(false, animated: false)
        //__ Setup the data source
        setupDataSource()
    }
    
    private func setupDataSource() {
        //__ The delegate is self
        self.marvelCharactersTableView?.delegate = self
        //__ Register the cell
        self.marvelCharactersTableView?.registerNib(UINib(nibName: "MCharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "MCharacterTableViewCell")
        //__ Remove empty separator lines
        let tableView =  UIView(frame: CGRectZero)
        self.marvelCharactersTableView!.tableFooterView = tableView
        self.marvelCharactersTableView!.tableFooterView!.hidden = true
        //__ Init the data source
        self.datasource = DVAProtocolDataSourceForTableView()
        self.datasource?.delegate = self
        //__ Assign the data source
        self.marvelCharactersTableView?.dataSource = self.datasource
    }
    
    private func showSearchView(show:Bool, animated:Bool) {
        //__ Show? -> the top is zero -> otherwise, move the container up
        self.searchTopSpaceConstraint?.constant = show ? 0.00 : -80.00
        let animateDuration: NSTimeInterval = animated ? 0.50 : 0.00
        UIView.animateWithDuration(animateDuration) { () -> Void in
            self.layoutIfNeeded()
        }
    }
    
    @IBAction func searchButtonPressed(sender: UIButton) {
        self.searchTextField?.resignFirstResponder()
        showSearchView(false, animated: true)
        delegate?.listViewDelegateSearchWithString((self.searchTextField?.text)!)
        self.searchTextField?.text = ""
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.listViewDelegateDidSelectedCharacterAtIndex(indexPath.row)
    }
    
    //__ Use this function in order to determinate the moment to load more items
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if !isLoadingMore && (maximumOffset - contentOffset <= CGFloat(threshold)) {
            delegate?.listViewDelegateLoadMoreCharacters()
            self.isLoadingMore = true
        }
    }
}

//__ View model class
class MMarvelListViewModel: NSObject {
    var characters:[MCharactersCellViewModel] = [] //__ characters
    var reloadItems:Bool = true //__ reload or not the tableview
    var showSearch:Bool = false //__ show or hide the search container
    var showNoResultsMessage:Bool = false //__ show or hide 'no results' message
    var allowLoadMoreCharacters:Bool = true //__ allow load more items (activate)
    var showCollectionOnTop:Bool = true //__ show the collection items on top
}

//__ Delegate method class
protocol MMarvelListViewDelegate {
    //__ Load more characters
    func listViewDelegateLoadMoreCharacters()
    //__ Search with filter pressed
    func listViewDelegateSearchWithString(searchString:String)
    //__ Tableview selected at index
    func listViewDelegateDidSelectedCharacterAtIndex(index:Int)
}
