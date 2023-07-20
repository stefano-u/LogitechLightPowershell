# Logitech Litra/Beam Powershell Util (Windows)

## How to Run

- To turn on all Logitech Litra/Beam lights, run `.\LogiLight.ps1 -On`
  - If you omit the `-On` parameter, it does the same thing
- To turn off all Logitech Litra/Beam lights, run `.\LogiLight.ps1 -Off`

## Run on Windows startup

1. Open Task Scheduler
2. Click "Create Task..."
3. In the General tab:
    1. Provide a Name
    2. Select "Run whether user is logged on or not"
4. In the Triggers tab:
    1. Select "New..."
    2. In the "Begin the task:" dropdown, select "At startup"
5. In the Actions tab:
    1. Select "New..."
    2. In the "Action:" dropdown, select "Start a program"
    3. In the "Program/script:" input, type `powershell.exe`
    4. In the "Add arguments (optional):" input, type `-File <path-to-LogiLitraWindows-folder>\LogiLight.ps1`
       - Where `<path-to-LogiLitraWindows-folder>` is the absolute path to the LogiLitraWindows folder on your computer

## Credits

- Original [LogiLitra.ps1](https://gist.github.com/poiriersimon/eaee208ce8ea79f30b4cc7d3a078c3bc) script by [@poiriersimon](https://github.com/poiriersimon)
- Original [download-latest-release.ps1](https://gist.github.com/MarkTiedemann/c0adc1701f3f5c215fc2c2d5b1d5efd3) script by [@MarkTiedemann](https://github.com/MarkTiedemann)
