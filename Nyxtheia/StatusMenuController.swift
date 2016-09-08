//
//  StatusMenuController.swift
//  Nyxtheia
//
//  Created by Jacob Gaffney on 8/09/2016.
//  Copyright © 2016 Jacob Gaffney. All rights reserved.
//

import Cocoa
import LIFXHTTPKit

let DEFAULT_TOKEN = ""

class StatusMenuController: NSObject, PreferencesWindowDelegate {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var toggleMenuItem: NSMenuItem!
    @IBOutlet weak var sliderView: SliderView!
    var sliderMenuItem: NSMenuItem!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    var preferencesWindow: PreferencesWindow!
    
    var client = Client(accessToken: DEFAULT_TOKEN)
    
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
    
    @IBAction func toggleSwitch(sender: NSMenuItem) {
        print("trying toggle switch")
        
        let all = client.allLightTarget()
        
        print(all.power)
        
        if all.power == false {
            print("Turn all lights on")
            all.setPower(true, duration: 1.5)
            toggleMenuItem.title = "Turn Off"
        }
        else {
            print("Turn all lights off")
            all.setPower(false, duration: 3.0)
            toggleMenuItem.title = "Turn On"
        }

        /*
        if let lightTarget = all.toLightTargets().first {
            lightTarget.setPower(lightTarget.power)
        }*/
        
    }
    
    func updateToken() {
        let defaults = NSUserDefaults.standardUserDefaults()
        client = Client(accessToken: defaults.stringForKey("token") ?? DEFAULT_TOKEN)
        client.fetch()
        updateToggle()
    }
    
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
    
    func preferencesDidUpdate() {
        updateToken()
    }
    
    
    @IBAction func preferencesClicked(sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }

    
}
