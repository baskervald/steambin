steambin
---
Utility script that build a "steam bin" to launch steam games from command line (or with rofi/dmenu, for my use case)

###How to use

Add $HOME/.steambin to your PATH, create the directory, and run the script. Voila~

You may need to tweak DIR in the script if your steamapps directory is different. This can also be used with steamCMD I believe.

###TODO

 * Make this into a daemon that constantly updates your steambin dir whenever a new game is installed or uninstalled. Maybe use `inotifywait`?
