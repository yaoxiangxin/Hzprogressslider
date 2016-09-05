//
//  ProgressSliderTrackLayer.swift
//  Ringer
//
//  Created by Huanzhong Huang on 7/23/16.
//  Copyright © 2016 Huanzhong Huang. All rights reserved.
//

import QuartzCore
import UIKit

class ProgressSliderTrackLayer: CALayer {

    weak var progressSlider: ProgressSlider?
    
    override func drawInContext(ctx: CGContext) {
        guard let progressSlider = progressSlider else { return }
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.height / 2)
        CGContextAddPath(ctx, path.CGPath)
        CGContextClip(ctx)
        
        var rect = CGRectZero
        
        CGContextSetFillColorWithColor(ctx, progressSlider.maximumTrackTintColor.CGColor)
        rect = bounds
        CGContextFillRect(ctx, rect)
        
        CGContextSetFillColorWithColor(ctx, progressSlider.progressTintColor.CGColor)
        rect = CGRectMake(0.0, 0.0, progressSlider.progressPosition, bounds.height)
        CGContextFillRect(ctx, rect)
        
        CGContextSetFillColorWithColor(ctx, progressSlider.minimumTrackTintColor.CGColor)
        rect = CGRectMake(0.0, 0.0, progressSlider.valuePosition, bounds.height)
        CGContextFillRect(ctx, rect)
    }
    
}
