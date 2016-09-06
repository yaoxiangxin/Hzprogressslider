//
//  ProgressSlider.swift
//  Ringer
//
//  Created by Huanzhong Huang on 7/23/16.
//  Copyright © 2016 Huanzhong Huang. All rights reserved.
//

import QuartzCore
import UIKit

class ProgressSlider: UIControl {

    let trackLayer = ProgressSliderTrackLayer()
    let thumbLayer = ProgressSliderThumbLayer()
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    override var highlighted: Bool {
        didSet {
            transform = highlighted ? CGAffineTransformMakeScale(1.0, 10.0) : CGAffineTransformIdentity
        }
    }
    
    var trackHeight: CGFloat = 5.0
    var minimumTrackTintColor = UIColor(red: 0.0, green: 175.0 / 255.0, blue: 29.0 / 255.0, alpha: 1.0)
    var maximumTrackTintColor = UIColor(red: 0.0, green: 108.0 / 255.0, blue: 18.0 / 255.0, alpha: 1.0) 
    var progressTintColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
    
    var thumbSize = CGSizeMake(2.0, 5.0)
    var thumbTintColor = UIColor.whiteColor()
    
    var minimumValue = 0.0 {
        didSet {
            value = max(minimumValue, value)
            progress = max(minimumValue, progress)
            updateLayerFrames()
        }
    }
    var maximumValue = 1.0 {
        didSet {
            value = min(value, maximumValue)
            progress = min(progress, maximumValue)
            updateLayerFrames()
        }
    }
    
    var value = 0.5 {
        didSet {
            value = min(max(value, minimumValue), maximumValue)
            updateLayerFrames()
        }
    }
    var valuePosition: CGFloat {
        return (bounds.width - thumbSize.width) * CGFloat((value - minimumValue) / (maximumValue - minimumValue)) + (thumbSize.width / 2)
    }
    
    var progress = 0.5 {
        didSet {
            progress = min(max(progress, minimumValue), maximumValue)
            updateLayerFrames()
        }
    }
    var progressPosition: CGFloat {
        return bounds.width * CGFloat((progress - minimumValue) / (maximumValue - minimumValue))
    }
    
    func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: (bounds.height - trackHeight) / 2)
        trackLayer.setNeedsDisplay()
        
        thumbLayer.frame = CGRectMake(valuePosition - 22.0, bounds.height / 2 - 22.0, 44.0, 44.0)
        thumbLayer.setNeedsDisplay()
        
        CATransaction.commit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.progressSlider = self
        trackLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(trackLayer)
        
        thumbLayer.progressSlider = self
        thumbLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(thumbLayer)
        
        updateLayerFrames()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Tracking touches
    private var previousLocation = CGPoint()
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        previousLocation = touch.locationInView(self)
        
        if thumbLayer.frame.contains(previousLocation) {
            thumbLayer.highlighted = true
        }
        
        return thumbLayer.highlighted
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        let deltaX = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaX / Double(bounds.width - thumbSize.width)
        previousLocation = location
        
        if thumbLayer.highlighted {
            value = value + deltaValue
        }
        
        sendActionsForControlEvents(.ValueChanged)
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        thumbLayer.highlighted = false
    }

}
