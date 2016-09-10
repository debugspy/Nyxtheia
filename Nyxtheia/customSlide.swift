//
//  kelvinSlide.swift
//  Nyxtheia
//
//  Created by Jacob Gaffney on 10/09/2016.
//  Copyright © 2016 Jacob Gaffney. All rights reserved.
//

import Cocoa

class hueSlide: NSSliderCell {
    override func drawBarInside(aRect: NSRect, flipped: Bool) {
        var rect = aRect
        rect.size.height = CGFloat(3)
        let barRadius = CGFloat(1.5)
        let bg = NSBezierPath(roundedRect: rect, xRadius: barRadius, yRadius: barRadius)
        let gradient:NSGradient = NSGradient(colorsAndLocations:
                                             (NSColor(hue: 0.0, saturation: 1.0, brightness: 1.0, alpha: 1.0),0.0),
                                             (NSColor(hue: 0.1, saturation: 1.0, brightness: 1.0, alpha: 1.0),0.1),
                                             (NSColor(hue: 0.2, saturation: 1.0, brightness: 1.0, alpha: 1.0),0.2),
                                             (NSColor(hue: 0.3, saturation: 1.0, brightness: 1.0, alpha: 1.0),0.3),
                                             (NSColor(hue: 0.4, saturation: 1.0, brightness: 1.0, alpha: 1.0),0.4),
                                             (NSColor(hue: 0.5, saturation: 1.0, brightness: 1.0, alpha: 1.0),0.5),
                                             (NSColor(hue: 0.6, saturation: 1.0, brightness: 1.0, alpha: 1.0),0.6),
                                             (NSColor(hue: 0.7, saturation: 1.0, brightness: 1.0, alpha: 1.0),0.7),
                                             (NSColor(hue: 0.8, saturation: 1.0, brightness: 1.0, alpha: 1.0),0.8),
                                             (NSColor(hue: 0.9, saturation: 1.0, brightness: 1.0, alpha: 1.0),0.9),
                                             (NSColor(hue: 1.0, saturation: 1.0, brightness: 1.0, alpha: 1.0),1.0))!
        gradient.drawInBezierPath(bg, angle: 0.0)
    }
}

class saturationSlide: NSSliderCell {
    override func drawBarInside(aRect: NSRect, flipped: Bool) {
        var rect = aRect
        rect.size.height = CGFloat(3)
        let barRadius = CGFloat(1.5)
        let bg = NSBezierPath(roundedRect: rect, xRadius: barRadius, yRadius: barRadius)
        
        let currentConvertToHue: CGFloat = CGFloat( (1.0/360) * currentColour )
        
        let gradient:NSGradient = NSGradient(startingColor: NSColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0), endingColor: NSColor(hue: currentConvertToHue, saturation: 1.0, brightness: 1.0, alpha: 1.0))!
        gradient.drawInBezierPath(bg, angle: 0.0)
    }
}

class kelvinSlide: NSSliderCell {
    override func drawBarInside(aRect: NSRect, flipped: Bool) {
        var rect = aRect
        rect.size.height = CGFloat(3)
        let barRadius = CGFloat(1.5)
        let value = CGFloat((self.doubleValue - self.minValue) / (self.maxValue - self.minValue))
        let finalWidth = CGFloat(value * (self.controlView!.frame.size.width - 8))
        var leftRect = rect
        leftRect.size.width = finalWidth
        let bg = NSBezierPath(roundedRect: rect, xRadius: barRadius, yRadius: barRadius)
        //NSColor.whiteColor().setFill()
        //bg.fill()
        //let gradient:NSGradient = NSGradient(startingColor: NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), endingColor: NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))!
        
        let gradient:NSGradient = NSGradient(colorsAndLocations:
                                            (NSColor(red: 255.0, green: 208.0, blue: 0.0, alpha: 1.0),0.3),
                                            (NSColor(red: 255.0, green: 242.0, blue: 224.0, alpha: 1.0),0.5),
                                            (NSColor(red: 0.0, green: 157.0, blue: 255.0, alpha: 1.0),1.0))!
        
        gradient.drawInBezierPath(bg, angle: 0.0)
        
        
        
        //let active = NSBezierPath(roundedRect: leftRect, xRadius: barRadius, yRadius: barRadius)
        //NSColor.darkGrayColor().setFill()
        //active.fill()
    }
}

class brightnessSlide: NSSliderCell {
    override func drawBarInside(aRect: NSRect, flipped: Bool) {
        var rect = aRect
        rect.size.height = CGFloat(3)
        let barRadius = CGFloat(1.5)
        let bg = NSBezierPath(roundedRect: rect, xRadius: barRadius, yRadius: barRadius)
        let gradient:NSGradient = NSGradient(startingColor: NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), endingColor: NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))!
        gradient.drawInBezierPath(bg, angle: 0.0)
    }
}
