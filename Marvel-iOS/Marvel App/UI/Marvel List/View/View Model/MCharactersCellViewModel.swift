//
//  MCharactersCellViewModel.swift
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//  Copyright © 2016 My Own Company. All rights reserved.
//

class MCharactersCellViewModel: NSObject, DVATableViewModelProtocol {
    internal var characterName : String?
    internal var characterDescription : String?
    internal var characterUrlImage : String?
    internal var characterUrlImageExtension : String?
    internal var characterId : Int?
    
    init(characterName : String, characterUrlImage : String, characterUrlImageExtension : String, characterDescription : String, characterId : Int) {
        super.init()
        self.characterName = characterName;
        self.characterUrlImage = characterUrlImage
        self.characterUrlImageExtension = characterUrlImageExtension
        self.characterDescription = characterDescription
        self.characterId = characterId
    }
    
    //__ Generate the characters objects to use un UI
    internal class func generateCharactersObjects(characters : [MCharacter]) -> Array<MCharactersCellViewModel> {
        var items: [MCharactersCellViewModel] = []
        
        for character in characters {
            let item = MCharactersCellViewModel(characterName: character.characterName!, characterUrlImage: character.characterUrlImage!, characterUrlImageExtension: character.characterUrlImageExtension!, characterDescription: character.characterDescription!, characterId: character.characterId!)
            items.append(item)
        }
        
        return items
    }
    
    //__ Generate  custom demo objects (JUST FOR TESTING. NOT USE THIS IN PRODUCTION)
    internal class func generateCustomObjects() -> Array<MCharactersCellViewModel> {
        var items: [MCharactersCellViewModel] = []
        
        for var i=0 ; i<15 ; i++ {
            let item = MCharactersCellViewModel(characterName: "Wolverine", characterUrlImage: "http://cde.cinescape.com.pe/ima/0/0/1/2/3/123312", characterUrlImageExtension: "jpg", characterDescription: "Test", characterId: 123456)
            items.append(item)
        }
        
        return items
    }
    
    //__ Set the cell identifier
    func dva_cellIdentifier() -> String! {
        return MCharacterTableViewCell.description()
    }
}
