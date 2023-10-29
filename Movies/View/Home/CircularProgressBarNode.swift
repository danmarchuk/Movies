//
//  CircularProgressBarNode.swift
//  Movies
//
//  Created by Данік on 29/09/2023.
//

import AsyncDisplayKit
import MBCircularProgressBar

final class CircularProgressBarNode: ASDisplayNode {
    let progressBar: MBCircularProgressBarView
    
    override init() {
        progressBar = MBCircularProgressBarView(frame: CGRect.zero)
        super.init()
        progressBar.backgroundColor = .clear
        backgroundColor = .clear
        progressBar.showValueString = false
        progressBar.progressCapType = 1
        progressBar.progressAngle = 100
        progressBar.progressLineWidth = 1
        progressBar.progressRotationAngle = 50
        progressBar.contentMode = .scaleAspectFill
        progressBar.clipsToBounds = true
        self.view.addSubview(progressBar)
    }
    
    func updateValue(to value: CGFloat) {
        configureProgressBar(progressBar, withRating: value)
    }
    
    private func configureProgressBar(_ progressBar: MBCircularProgressBarView, withRating rating: Double) {
        if rating >= 70.0 {
            progressBar.progressColor = K.darkGreenProgresColor
            progressBar.progressStrokeColor = K.darkGreenProgresColor
            progressBar.emptyLineColor = K.lightGreenProgresColor
            progressBar.emptyLineStrokeColor = K.lightGreenProgresColor
        } else if rating >= 50.0 {
            progressBar.progressColor = K.darkOrangeProgressColor
            progressBar.progressStrokeColor = K.darkOrangeProgressColor
            progressBar.emptyLineColor = K.lightOrangeProgressColor
            progressBar.emptyLineStrokeColor = K.lightOrangeProgressColor
        } else {
            progressBar.progressColor = .red
            progressBar.progressStrokeColor = .red
            progressBar.emptyLineColor = K.lightRedProgressColor
            progressBar.emptyLineStrokeColor = K.lightRedProgressColor
        }
        
        progressBar.value = CGFloat(rating)
    }
    override func layout() {
        super.layout()
        // Update the frame of the segmented control to fit the node's bounds
        progressBar.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: self.bounds.height)
    }
}

