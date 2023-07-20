# Logitech Litra/Beam Powershell Util (Windows)

## How to Run

- To turn on all Logitech Litra/Beam lights, run `.\LogiLight.ps1 -On`
  - If you omit the `-On` parameter, it does the same thing
- To turn off all Logitech Litra/Beam lights, run `.\LogiLight.ps1 -Off`

## Run on Windows startup/shutdown

1. Open `gpedit.msc`
2. Go to Computer Configuration -> Windows Settings -> Scripts (Startup/Shutdown)
3. Click on "Startup" or "Shutdown"
4. In the "PowerShell Scripts" tab, click on the "Add..." button
5. Click on "Browse..." and search for the `LogiLight.ps1` script in your computer
6. For "Script Parameters":
   1. If it's for "Startup", use `-On`
   2. if it's for "Shutdown", use `-Off`

## Credits

- Original [LogiLitra.ps1](https://gist.github.com/poiriersimon/eaee208ce8ea79f30b4cc7d3a078c3bc) script by [@poiriersimon](https://github.com/poiriersimon)
- Original [download-latest-release.ps1](https://gist.github.com/MarkTiedemann/c0adc1701f3f5c215fc2c2d5b1d5efd3) script by [@MarkTiedemann](https://github.com/MarkTiedemann)
