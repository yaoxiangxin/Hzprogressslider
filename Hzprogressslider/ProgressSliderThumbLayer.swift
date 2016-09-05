//
//  ProgressSliderThumbLayer.swift
//  Ringer
//
//  Created by Huanzhong Huang on 7/23/16.
//  Copyright © 2016 Huanzhong Huang. All rights reserved.
//

import QuartzCore
import UIKit

class ProgressSliderThumbLayer: CALayer {

    weak var progressSlider: ProgressSlider?
    
    var highlighted = false
    
    override func drawInContext(ctx: CGContext) {
        guard let progressSlider = progressSlider else { return }
        
        CGContextSetFillColorWithColor(ctx, UIColor.clearColor().CGColor)
        CGContextFillRect(ctx, bounds)
        
        CGContextSetFillColorWithColor(ctx, progressSlider.thumbTintColor.CGColor)
        let rect = bounds.insetBy(
            dx: (bounds.width - progressSlider.thumbSize.width) / 2,
            dy: (bounds.height - progressSlider.thumbSize.height) / 2
        )
        CGContextFillRect(ctx, rect)
    }
    
}
