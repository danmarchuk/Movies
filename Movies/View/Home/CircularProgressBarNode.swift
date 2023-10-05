//
//  CircularProgressBarNode.swift
//  Movies
//
//  Created by Данік on 29/09/2023.
//

import AsyncDisplayKit
import MBCircularProgressBar

class CircularProgressBarNode: ASDisplayNode {
    
    init(value: CGFloat = 50) {
        super.init()
        backgroundColor = .white
        self.setViewBlock {
            let progressBar = MBCircularProgressBarView()
            progressBar.value = value
            progressBar.showValueString = false
            progressBar.progressCapType = 1
            progressBar.progressAngle = 100
            progressBar.progressLineWidth = 1
            progressBar.progressRotationAngle = 50
            progressBar.contentMode = .scaleAspectFill
            progressBar.clipsToBounds = true
            return progressBar
        }
        
        // Directly configure the progress bar after its creation
        if let progressBar = self.view as? MBCircularProgressBarView {
            Self.configureProgressBar(progressBar, withRating: Double(value / 10))
        }
    }
    
    var progressBarView: MBCircularProgressBarView? {
        return self.view as? MBCircularProgressBarView
    }
    
    func updateValue(to value: CGFloat) {
        if let progressBar = progressBarView {
            Self.configureProgressBar(progressBar, withRating: value )
        }
    }
    
    static func configureProgressBar(_ progressBar: MBCircularProgressBarView, withRating rating: Double) {
        if rating >= 7.0 {
            progressBar.progressColor = .green
            progressBar.progressStrokeColor = .green
            progressBar.emptyLineColor = K.lightGreenProgresColor
            progressBar.emptyLineStrokeColor = K.lightGreenProgresColor
        } else if rating >= 5.0 {
            progressBar.progressColor = .orange
            progressBar.progressStrokeColor = .orange
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
}

