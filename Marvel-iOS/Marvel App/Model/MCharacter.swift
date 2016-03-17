//
//  MCharacter.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

import UIKit

@objc class MCharacter: NSObject {
    internal var characterName : String?
    internal var characterId : Int?
    internal var characterUrlImage : String?
    internal var characterUrlImageExtension : String?
    internal var characterDescription : String?
    
    init(characterName : String, characterUrlImage : String, characterUrlImageExtension : String, characterDescription : String, characterId : Int) {
        super.init()
        self.characterName = characterName;
        self.characterUrlImage = characterUrlImage
        self.characterUrlImageExtension = characterUrlImageExtension
        self.characterDescription = characterDescription
        self.characterId = characterId
    }
}
