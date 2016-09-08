//
//  StatusMenuController.swift
//  Nyxtheia
//
//  Created by Jacob Gaffney on 8/09/2016.
//  Copyright © 2016 Jacob Gaffney. All rights reserved.
//

import Cocoa
import LIFXHTTPKit

// There's probably a better solution than having this be global
let DEFAULT_TOKEN = ""

class StatusMenuController: NSObject, PreferencesWindowDelegate {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var toggleMenuItem: NSMenuItem!
    @IBOutlet weak var sliderView: SliderView!
    var sliderMenuItem: NSMenuItem!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    var preferencesWindow: PreferencesWindow!
    
    // Important
    var client = Client(accessToken: DEFAULT_TOKEN)
    
    
    // This is our setup
    override func awakeFromNib() {
        statusItem.title = "🦄"
        statusItem.menu = statusMenu
        preferencesWindow = PreferencesWindow()
        
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
        
        sliderMenuItem = statusMenu.itemWithTitle("Slider")
        sliderMenuItem.view = sliderView
        
        updateToken()
    }
    
    // These functions are variations on turning our bulb/s on or off
    @IBAction func toggleLightNow(sender: NSMenuItem) {
        toggleLightWithDuration(0.5)
    }
    @IBAction func toggleLight30sec(sender: NSMenuItem) {
        toggleLightWithDuration(30.0)
    }
    @IBAction func toggleLight1min(sender: NSMenuItem) {
        toggleLightWithDuration(60.0)
    }
    @IBAction func toggleLight2min(sender: NSMenuItem) {
        toggleLightWithDuration(120.0)
    }
    @IBAction func toggleLight5min(sender: NSMenuItem) {
        toggleLightWithDuration(300.0)
    }
    @IBAction func toggleLight10min(sender: NSMenuItem) {
        toggleLightWithDuration(600.0)
    }
    @IBAction func toggleLight30min(sender: NSMenuItem) {
        toggleLightWithDuration(1800.0)
    }
    
    // Check the status of the bulb, then switch it on or off with a specified duration
    func toggleLightWithDuration(duration: Float) {
        print("trying toggle switch")
        
        let all = client.allLightTarget()
        
        print(all.power)
        
        if all.power == false {
            print("Turn all lights on")
            all.setPower(true, duration: duration)
            toggleMenuItem.title = "Turn Off"
        }
        else {
            print("Turn all lights off")
            all.setPower(false, duration: duration)
            toggleMenuItem.title = "Turn On"
        }
    }
    
    // What is the status of our bulbs and how does that change our menus
    func updateToggle() {
        let all = client.allLightTarget()
        let observer = all.addObserver {
            if all.power {
                self.toggleMenuItem.title = "Turn Off"
            } else {
                self.toggleMenuItem.title = "Turn On"
            }
        }
        all.removeObserver(observer)
    }
    
    
    // Relates to pulling our access token from the preferences
    func updateToken() {
        let defaults = NSUserDefaults.standardUserDefaults()
        client = Client(accessToken: defaults.stringForKey("token") ?? DEFAULT_TOKEN)
        client.fetch()
        updateToggle()
    }
    
    
    // These three functions are fairly straight forward
    @IBAction func updateColorSlide(sender: NSSlider) {
        let colour = Color.color(round(sender.doubleValue), saturation: 1.0)
        let all = client.allLightTarget()
        all.setColor(colour)
    }
    
    @IBAction func updateBrightnessSlide(sender: NSSlider) {
        var brightness: Double = sender.doubleValue
        brightness = brightness / 100
        brightness = round(100*brightness)/100
        
        let all = client.allLightTarget()
        all.setBrightness(brightness)
    }
    
    @IBAction func updateKelvinSlide(sender: NSSlider) {
        let kelvin = Color.white(Int(sender.doubleValue))
        let all = client.allLightTarget()
        all.setColor(kelvin)
    }
    
    
    // Check if our preferences changed and update our access token
    func preferencesDidUpdate() {
        updateToken()
    }
    
    // Show the preferences window
    @IBAction func preferencesClicked(sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
    }
    
    // Quit our application
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }

    
}
