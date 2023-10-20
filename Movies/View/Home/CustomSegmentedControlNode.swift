//
//  CustomSegmentedControlNode.swift
//  Movies
//
//  Created by Данік on 20/10/2023.
//

import AsyncDisplayKit
import TTSegmentedControl

class CustomSegmentedControlNode: ASDisplayNode {
    private let segmentedControl: TTSegmentedControl
    
    init(items: [String]) {
        // Initialize the TTSegmentedControl
        segmentedControl = TTSegmentedControl(frame: CGRect.zero)
        
        super.init()
        
        // Configure the TTSegmentedControl
        segmentedControl.titles = items.map { text in
            return TTSegmentedControlTitle(
                text: text,
                defaultColor: .black,
                defaultFont: UIFont(name: "OpenSans-Regular", size: 14),
                selectedColor: .black,
                selectedFont: UIFont(name: "OpenSans-Semibold", size: 14)
            )
        }
        // Other configuration settings for the segmented control go here

        // Add the segmented control to the display node's view
        self.view.addSubview(segmentedControl)
    }
    
    override func layout() {
        super.layout()
        // Update the frame of the segmented control to fit the node's bounds
        segmentedControl.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: self.bounds.height)
    }
}

