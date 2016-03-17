//
//  MCharacterTableViewCell.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

import UIKit
//__ Pods
import Haneke

class MCharacterTableViewCell: UITableViewCell, DVATableViewCellProtocol {
    //__ IBOutlets
    @IBOutlet weak private var characterNameLabel : UILabel?
    @IBOutlet weak private var characterImageView : UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    override func prepareForReuse() {
        self.characterImageView?.image = nil;
        if let label = self.characterNameLabel {
            label.text = ""
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //__ DVATableViewModelProtocol method
    func bindWithModel(viewModel: DVATableViewModelProtocol!) {
        let model : MCharactersCellViewModel = (viewModel as? MCharactersCellViewModel)!
        if let label = self.characterNameLabel {
            label.text = model.characterName
        }
        
        self.characterImageView?.contentMode = UIViewContentMode.ScaleAspectFill;
        self.characterImageView?.clipsToBounds = true;
        let URL = NSURL(string:model.characterUrlImage! + "/portrait_incredible." + model.characterUrlImageExtension!)
        characterImageView?.hnk_setImageFromURL(URL!)
    }
}
