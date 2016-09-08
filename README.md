# Nyxtheia
![](https://github.com/jacquesCedric/Nyxtheia/blob/master/documentation/images/MainMenu.png?raw=true)

Nyxtheia is a MacOS menubar applet that controls your LIFX bulbs. It is still in its infancy, so it only does a few simple things at the moment:
  - Control colour through brightness and hue or temperature through kelvin
  - Toggle on or off over specified amount of time

## How to use
1. Download the app from the Releases page ([Releases page](https://github.com/jacquesCedric/Nyxtheia/releases))
2. unzip and open, and it should be sitting in your menubar (look for the unicorn)
3. Click on "Preferences" and enter in your LIFX access token ([LIFX cloud login](https://cloud.lifx.com/sign_in))
![](https://github.com/jacquesCedric/Nyxtheia/blob/master/documentation/images/AccessTokenWindow.png?raw=true)
4. Play around with your lights


At the moment it doesn't provide fine grain control over multiple lights, just the group associated with your access token. This will probably change in future releases

## Notes
GPLv2 Licensed

It wouldn't've been possible to build this without the excellent LIFX HTTP framework ([LIFXHTTPKit](https://github.com/tatey/LIFXHTTPKit))


