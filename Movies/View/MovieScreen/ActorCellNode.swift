//
//  ActorCellNode.swift
//  Movies
//
//  Created by Данік on 05/10/2023.
//

import AsyncDisplayKit

class ActorCellNode: ASCellNode {
    
    let photo = ASNetworkImageNode().apply {
        $0.placeholderColor = .lightGray
        $0.placeholderEnabled = true
    }
    
    let nameAndSurnameLabel = ASTextNode ()
    
    let characterNameLabel = ASTextNode()
    
    init(actor: ActorShortInfo) {
        super.init()
        
        self.configure(withActor: actor)
        
        self.automaticallyManagesSubnodes = true
    }
    
    func configure(withActor actor: ActorShortInfo) {
        photo.url = URL(string: actor.imageUrl)
        
        nameAndSurnameLabel.attributedText = NSAttributedString(string: actor.nameAndSurname,
                                                                attributes: [NSAttributedString.Key.font: UIFont(name: "OpenSans-Regular", size: 11)!, NSAttributedString.Key.foregroundColor: K.movieScreenDarkBlueTextColor])
        
        characterNameLabel.attributedText = NSAttributedString(string: actor.character,
                                                               attributes: [NSAttributedString.Key.font: UIFont(name: "OpenSans-Regular", size: 10)!, NSAttributedString.Key.foregroundColor: K.characterGrayTextColor])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        photo.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.height * 0.7)
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.children = [photo, nameAndSurnameLabel, characterNameLabel]
        verticalStack.spacing = 4.0
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let insetSpec = ASInsetLayoutSpec(insets: insets, child: verticalStack)
        
        return insetSpec
    }
}
