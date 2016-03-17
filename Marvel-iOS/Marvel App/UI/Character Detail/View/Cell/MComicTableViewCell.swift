//
//  MComicTableViewCell.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 16/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

import UIKit
//__ Pods
import Haneke

class MComicTableViewCell: UITableViewCell, DVATableViewCellProtocol {
    //__ IBOutlets
    @IBOutlet weak private var comicNameLabel : UILabel?
    @IBOutlet weak private var comicDesciptionLabel : UILabel?
    @IBOutlet weak private var comicImageView : UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    override func prepareForReuse() {
        self.comicImageView?.image = nil;
        if let label = self.comicNameLabel {
            label.text = ""
        }
        if let label = self.comicDesciptionLabel {
            label.text = ""
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //__ DVATableViewModelProtocol method
    func bindWithModel(viewModel: DVATableViewModelProtocol!) {
        let model : MComicCellViewModel = (viewModel as? MComicCellViewModel)!
        if let label = self.comicNameLabel {
            label.text = model.comicName
        }
        
        if let label = self.comicDesciptionLabel {
            label.text = model.comicDescription
        }
        
        self.comicImageView?.contentMode = UIViewContentMode.ScaleAspectFill;
        self.comicImageView?.clipsToBounds = true;
        let URL = NSURL(string:model.comicUrlImage! + "/portrait_medium." + model.comicUrlImageExtension!)
        comicImageView?.hnk_setImageFromURL(URL!)
    }
}
