//
//  CustomControl.swift
//  Movies
//
//  Created by Данік on 25/10/2023.
//

import AsyncDisplayKit
import HMSegmentedControl

final class CustomControl: ASDisplayNode {
    let segmentedControl: HMSegmentedControl
    
    init(items: [String] =  []) {
        // Initialize the HMSegmentedControl
        segmentedControl = HMSegmentedControl(frame: CGRect.zero)
        super.init()
        guard let openSansRegular = UIFont(name: "OpenSans-Regular", size: 14) else {return}
        segmentedControl.sectionTitles  = items
        segmentedControl.selectionIndicatorLocation = .bottom
        segmentedControl.backgroundColor = .clear
        segmentedControl.titleFormatter = { (segmentedControl, title, index, selected) in
            let attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: K.movieScreenGray2,
                NSAttributedString.Key.font: openSansRegular
            ]
            return NSAttributedString(string: title, attributes: attributes)
        }
        // Add the segmented control to the display node's view
        self.view.addSubview(segmentedControl)
    }
    
    func updateValues(withItems items: [String]) {
        segmentedControl.sectionTitles  = items
    }
    
    override func layout() {
        super.layout()
        // Update the frame of the segmented control to fit the node's bounds
        segmentedControl.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: self.bounds.height)
    }
}

