//
//  CustomSegmentedControlNode.swift
//  Movies
//
//  Created by Данік on 20/10/2023.
//

import AsyncDisplayKit
import TTSegmentedControl

final class CustomSegmentedControlNode: ASDisplayNode {
    let segmentedControl: TTSegmentedControl
    
    init(items: [String] =  []) {
        // Initialize the TTSegmentedControl
        segmentedControl = TTSegmentedControl(frame: CGRect.zero)
        super.init()
        
        guard let openSansRegular = UIFont(name: "OpenSans-Regular", size: 14) else {return}
        guard let openSansSemibold = UIFont(name: "OpenSans-Semibold", size: 14) else {return}
        let gradient = TTSegmentedControlGradient(
            startPoint: .init(x: 0, y: 0.5),
            endPoint: .init(x: 1, y: 0.5),
            colors: [K.gradientColorOne, K.gradientColorTwo]
        )
        
        // Configure the TTSegmentedControl
        segmentedControl.titles = items.map { text in
            return TTSegmentedControlTitle(
                text: text,
                defaultColor: .black,
                defaultFont: openSansRegular,
                selectedColor: .black,
                selectedFont: openSansSemibold
            )
        }
        segmentedControl.layer.borderColor = K.segmentedControlBorderColor
        segmentedControl.containerColorType  = .color(value: .clear)
        segmentedControl.selectionViewColorType = .gradient(value: gradient)
        segmentedControl.layer.borderWidth = 1
        segmentedControl.isSizeAdjustEnabled = true
        segmentedControl.selectionViewFillType = .fillSegment
        segmentedControl.cornerRadius = .constant(value: 25)
        segmentedControl.layer.cornerRadius = 25
        segmentedControl.cornerCurve = .circular
        segmentedControl.padding = .init(width: 0, height: 0)
        
        // Add the segmented control to the display node's view
        self.view.addSubview(segmentedControl)
    }
    
    func updateValues(withItems items: [String]) {
        guard let openSansRegular = UIFont(name: "OpenSans-Regular", size: 14) else {return}
        guard let openSansSemibold = UIFont(name: "OpenSans-Semibold", size: 14) else {return}
        segmentedControl.titles = items.map { text in
            return TTSegmentedControlTitle(
                text: text,
                defaultColor: .black,
                defaultFont: openSansRegular,
                selectedColor: .black,
                selectedFont: openSansSemibold
            )
        }
    }
    
    
    override func layout() {
        super.layout()
        // Update the frame of the segmented control to fit the node's bounds
        segmentedControl.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: self.bounds.height)
    }
}
