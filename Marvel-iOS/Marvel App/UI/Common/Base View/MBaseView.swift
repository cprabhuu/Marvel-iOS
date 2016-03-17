//
//  MBaseView.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

import UIKit
//__ Pods
import SVProgressHUD

class MBaseView: UIView {    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //__ Show progress and configure user interaction
    func showProgressViewWithTextAndAllowInteraction(text:String, allowInteraction:Bool) {
        if allowInteraction {
            SVProgressHUD.showWithStatus(text, maskType: SVProgressHUDMaskType.None)
        }
        else {
            SVProgressHUD.showWithStatus(text, maskType: SVProgressHUDMaskType.Clear)
        }
    }
    
    //__ Show error
    func showErrorViewWithText(text:String) {
        SVProgressHUD.showErrorWithStatus(text, maskType: SVProgressHUDMaskType.Clear)
    }
    
    //__ Show error alert
    func showErrorAlertViewWithText(text:String) {
        showErrorViewWithText(text)
    }
    
    //__ Show progress
    func showProgressViewWithText(text:String) {
        showProgressViewWithTextAndAllowInteraction(text, allowInteraction: false)
    }
    
    //__ Show success
    func showSuccessViewWithText(text:String) {
        SVProgressHUD.showSuccessWithStatus(text, maskType: SVProgressHUDMaskType.Clear)
    }
    
    //__ Dismiss progress
    func dissmissProgress() {
        SVProgressHUD.dismiss()
    }
}
